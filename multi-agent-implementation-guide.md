# Multi-Agent 구현 가이드

Agent 시스템을 실제로 만드는 방법을 단계별로 정리한 구현 기준 문서다.

구현 단계에서 이 문서를 참고한다. 설계 단계가 필요하다면 별도 아키텍처 설계 문서를 먼저 작성한다.

---

## 1. Agent란 무엇인가

```
Agent = 역할 프롬프트 + 목표 + 사용 가능한 도구 + 기억/상태 + 실행 규칙
```

**Agent 한 명 = 특정 역할을 가진 AI 직원 한 명**

가장 기본적인 형태:

```python
pm_agent_prompt = """
너는 PM Agent다.
사용자의 요구사항을 분석해서 기능 목록, 화면 구성, 개발 순서를 정리한다.
코드는 작성하지 말고 설계만 한다.
결과는 단계별 체크리스트로 출력한다.
"""

response = call_llm(system=pm_agent_prompt, user=user_request)
```

단순 프롬프트와 Agent의 차이:

| 항목 | 단순 프롬프트 | Agent |
|---|---|---|
| 역할 | 없음 | 명확한 역할 정의 |
| 목표 | 없음 | 달성해야 할 목표 |
| 도구 | 없음 | 파일 읽기, API 호출 등 |
| 기억 | 없음 | 이전 결과 기억 |
| 실행 규칙 | 없음 | 출력 형식, 제약 조건 |

---

## 2. Agent 연결 3패턴

### 패턴 1 — 순차 연결 (가장 쉬움, 먼저 시작)

앞 Agent의 결과가 다음 Agent의 입력이 된다.

```
사용자 요청
 ↓
PM Agent
 ↓
Architect Agent
 ↓
Coder Agent
 ↓
Reviewer Agent
 ↓
최종 결과
```

```python
pm_result       = pm_agent.run(user_input)
design_result   = architect_agent.run(pm_result)
code_result     = coder_agent.run(design_result)
final_result    = reviewer_agent.run(code_result)
```

언제 쓰나: 단계가 명확하고, 순서가 고정된 작업.
예: 가사 → 장면 구성 → 이미지 프롬프트 → 영상 프롬프트

### 패턴 2 — 병렬 연결

여러 Agent가 같은 입력을 동시에 처리하고, 결과를 합친다.

```
사용자 요청
 ├─ 시장조사 Agent
 ├─ 기술설계 Agent
 └─ 비용분석 Agent
 ↓
종합 Agent → 최종 결과
```

```python
import asyncio

async def run_parallel(user_input):
    research, tech, cost = await asyncio.gather(
        research_agent.run(user_input),
        tech_agent.run(user_input),
        cost_agent.run(user_input)
    )
    return manager_agent.run(research + tech + cost)
```

언제 쓰나: 독립적으로 분석 가능한 항목이 여러 개일 때.
예: 음악 분위기 분석 + 시각 스타일 분석 + 감정 분석 → 통합 프롬프트 생성

### 패턴 3 — 관리자 Agent 방식 (가장 실제 프로젝트에 가까움)

Manager Agent가 상황에 따라 어떤 Agent를 호출할지 결정한다.

```
사용자
 ↓
Manager Agent (의사결정)
 ├─ PM Agent 호출
 ├─ Coder Agent 호출
 ├─ QA Agent 호출
 └─ Writer Agent 호출
 ↓
최종 결과
```

언제 쓰나: 작업 흐름이 조건에 따라 달라질 때.
복잡도가 높으므로 순차 연결이 한계에 부딪혔을 때 전환한다.

---

## 3. 구현 4단계 진행 순서

### 1단계 — Python 스크립트 (지금 시작할 수 있음)

```
Agent 프롬프트 파일들 + main.py
```

```
agents/
  pm_agent.txt
  script_agent.txt
  prompt_agent.txt
  reviewer_agent.txt

main.py
```

```python
def run_agent(system_prompt_file, input_text):
    system = open(f"agents/{system_prompt_file}").read()
    return call_llm(system=system, user=input_text)

# 순차 실행
user_input  = "사이버펑크 해골 밴드 뮤직비디오 만들어줘"
script      = run_agent("script_agent.txt", user_input)
mv_prompt   = run_agent("prompt_agent.txt", script)
review      = run_agent("reviewer_agent.txt", mv_prompt)
print(review)
```

목표: 콘솔에서 입력 → Agent 실행 → 결과 출력이 되면 1단계 완료.

### 2단계 — FastAPI 서버

Python 스크립트를 API로 감싼다.

```python
from fastapi import FastAPI

app = FastAPI()

@app.post("/run-pipeline")
async def run_pipeline(request: dict):
    user_input = request["input"]
    script   = run_agent("script_agent.txt", user_input)
    mv       = run_agent("prompt_agent.txt", script)
    review   = run_agent("reviewer_agent.txt", mv)
    return {"result": review}
```

목표: 웹이나 앱에서 API 호출로 Agent 실행 가능.

### 3단계 — 웹사이트 / 앱 UI

FastAPI 서버 앞에 화면을 붙인다.

```
Flutter Web / React / Next.js
  ↓
FastAPI 서버
  ↓
Agent 파이프라인
  ↓
결과 화면 출력
```

본인 경우 Flutter Web 또는 Android 앱이 자연스러운 선택.

### 4단계 — 자동화 서비스

```
DB 저장 + 로그인 + 작업 이력 + 예약 실행
  ↓
Celery / Redis (비동기 처리)
  ↓
Agent 파이프라인
  ↓
결과 저장 + 알림
```

---

## 4. 프레임워크 선택 기준

| 상황 | 선택 |
|---|---|
| 처음 시작, 테스트 단계 | 직접 Python 구현 |
| 역할 기반 팀 구성 필요 | CrewAI |
| 복잡한 조건, 분기, 반복 | LangGraph |

**지금 당장 CrewAI/LangGraph 설치하지 않아도 된다.**
직접 Python으로 순차 연결부터 시작하고, 실제 한계에 부딪혔을 때 프레임워크로 전환한다.

---

## 5. YouTube MV 자동화 Agent 구성 예시

본인 프로젝트에 바로 적용 가능한 구조.

```
agents/
  script_agent.txt     — 뮤직비디오 대본 + 장면 구성
  suno_agent.txt       — Suno 음악 프롬프트 생성
  kling_image_agent.txt — Kling 이미지 프롬프트 (캐릭터 일관성 포함)
  kling_video_agent.txt — Kling 영상 프롬프트
  capcut_agent.txt     — CapCut 편집표 생성
  upload_agent.txt     — 유튜브 제목, 설명, 태그 생성

main.py
```

순차 실행 흐름:

```
사용자 입력 (곡 정보 + 캐릭터 설정 + 세계관)
 ↓
script_agent      → 장면 구성 (30컷)
 ↓
kling_image_agent → 컷별 이미지 프롬프트
 ↓
kling_video_agent → 컷별 영상 프롬프트
 ↓
capcut_agent      → 편집표
 ↓
upload_agent      → 유튜브 패키지
 ↓
결과 파일 저장
```

각 Agent 프롬프트 핵심 원칙:
- 역할을 한 줄로 정의한다
- 입력 형식을 명시한다
- 출력 형식을 강제한다 (JSON, 체크리스트, 마크다운 등)
- 이전 Agent 결과를 어떻게 사용하는지 명시한다

---

## 6. Agent 프롬프트 작성 템플릿

```text
너는 [역할 이름] Agent다.

입력:
[이전 Agent 결과 또는 사용자 입력의 형태]

목표:
[이 Agent가 달성해야 할 결과]

제약:
- [하지 말아야 할 것]
- [출력 형식 제한]
- [캐릭터/세계관 고정 조건 등]

출력 형식:
[JSON / 마크다운 / 번호 목록 / 표 등]
```

---

## 7. 현재 상태와 연결

AI MV 자동화 도구(곡 설명 txt → 프롬프트 파일 생성)는 이미 순차 Agent 파이프라인의 시작점이다.

```
현재: 곡 설명 txt → Python 처리 → 프롬프트 파일 생성
다음: txt 입력 → script_agent → kling_agent → capcut_agent → 파일 저장
```

현재 도구에 Agent 프롬프트 구조를 추가하면 1단계 구현이 된다.

---

## Hermes Judgment

```text
지금 할 것:
1단계 Python 스크립트 방식으로 시작
Agent 프롬프트 파일 먼저 작성 (코드 전에)
현재 ai_img_video_prompt 도구와 연결

지금 하지 말 것:
CrewAI / LangGraph 먼저 설치
웹사이트 UI 먼저 만들기
4단계 자동화 서비스 설계부터 시작
```

이 문서는 `ai_prompt` 저장소로 이동한다. Hermes 코어 파일이 아니므로 ai_prompt에 저장 가능하다.
