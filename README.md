# AI Prompt Repository

AI 코딩 어시스턴트에게 개발, 분석, 마이그레이션, 보안 점검, 음악 제작 작업을 맡길 때 사용하는 프롬프트 모음입니다.

## 저장소 목표

이 저장소의 목표는 AI를 더 잘 이해하고 활용하기 위해, 프롬프트·지시 구조·스킬·작업 흐름을 연구하고 축적하는 것입니다.

단순히 프롬프트 문장을 모으는 곳이 아니라, AI에게 어떤 일을 어떻게 맡기면 좋은지 실험하고, 반복 가능한 사용 방식으로 정리하는 개인 AI 활용 연구 폴더입니다.

## `E:\ai_test`와의 구분

`E:\ai_test`가 주로 실제 개인 도구 개발, 프로젝트 구조, 구현 방식, 테스트, 보안, 자동화 같은 개발 방법을 실험하는 공간이라면, `E:\ai_prompt`는 AI에게 어떻게 생각시키고 지시해야 원하는 결과를 안정적으로 얻을 수 있는지 연구하는 공간입니다.

즉, `E:\ai_test`의 중심 질문이 "AI로 개발을 어떻게 더 잘할까?"라면, `E:\ai_prompt`의 중심 질문은 "AI에게 어떻게 지시해야 더 좋은 결과가 나올까?"입니다.

핵심 원칙은 간단합니다.

```text
CLAUDE.md + 지금 필요한 프롬프트 파일 1개만 사용
```

## 빠른 시작

1. [CLAUDE.md](./CLAUDE.md)를 먼저 읽거나 AI에게 함께 제공합니다.
2. 아래 표에서 현재 작업에 맞는 프롬프트 파일 1개를 고릅니다.
3. 프롬프트 안의 `[대괄호]` 값을 실제 상황에 맞게 채운 뒤 AI에게 전달합니다.

새 프로젝트를 만들기 전이라면 먼저 [project_보안_초기설계_Prompts.md](./project_보안_초기설계_Prompts.md)를 사용하세요. 기능 구현 전에 API 키, 비밀번호, 고객 정보, 공개 불가 정보가 코드나 저장소에 섞이지 않게 점검하는 용도입니다.

## 공통 지침

- 모든 프롬프트는 [CLAUDE.md](./CLAUDE.md)를 최상위 원칙으로 따릅니다.
- 작업마다 필요한 프롬프트 1개만 추가로 사용합니다.
- 분석 작업은 대상 프로젝트 폴더를 AI가 읽을 수 있는 상태로 준비합니다.
- API 키, 토큰, 비밀번호, 고객 정보, 회사 내부 정보는 프롬프트나 코드에 넣지 않습니다.

## 상황별 선택 가이드

| 상황 | 사용할 파일 | 먼저 준비할 것 |
|------|-------------|----------------|
| 새 프로젝트 개발 전에 보안·공개 불가 정보·저장소 위험을 먼저 점검하고 싶다 | [project_보안_초기설계_Prompts.md](./project_보안_초기설계_Prompts.md) | 프로젝트 유형, 기술 스택, 외부 API/DB 사용 여부 |
| MFC 프로젝트 구조를 처음 파악하고 싶다 | [mfc_프로젝트_구조_Prompts.md](./mfc_프로젝트_구조_Prompts.md) | 프로젝트 폴더 경로 |
| MFC 프로젝트의 코드 품질과 이슈를 상세 분석하고 싶다 | [mfc_프로젝트_정밀분석_Prompts.md](./mfc_프로젝트_정밀분석_Prompts.md) | 프로젝트 폴더 경로 |
| 수정 후 잔존 이슈와 출시 가능 여부를 최종 점검하고 싶다 | [mfc_프로젝트_최종검수_Prompts.md](./mfc_프로젝트_최종검수_Prompts.md) | 프로젝트 폴더, 이전 분석 결과물 |
| MFC 특정 클래스를 집중 분석하고 싶다 | [mfc_클래스_심층분석_Prompts.md](./mfc_클래스_심층분석_Prompts.md) | 클래스명, 파일명 |
| 새 MFC 프로젝트를 처음부터 생성하고 싶다 | [mfc_프로젝트생성_Prompts.md](./mfc_프로젝트생성_Prompts.md) | 프로젝트 이름, 앱 유형, Visual Studio 버전, 플랫폼 |
| 새 Python 프로젝트를 처음부터 생성하고 싶다 | [python_프로젝트생성_Prompts.md](./python_프로젝트생성_Prompts.md) | 프로젝트 이름, 기능 명세, 기술 스택 |
| 코드 변경 후 아키텍처 문서를 업데이트하고 싶다 | [common_프로젝트_분석_Prompts.md](./common_프로젝트_분석_Prompts.md) | 변경 파일, 기존 분석 문서 |
| SVN 또는 로컬 폴더를 Git으로 옮길 계획을 세우고 싶다 | [common_git_마이그레이션_Prompts.md](./common_git_마이그레이션_Prompts.md) | 이관 대상 최상위 폴더 |
| Suno AI로 상업용 음악 제작 프롬프트를 만들고 싶다 | [sunoai_Prompts.md](./sunoai_Prompts.md) | 가사, 장르, 분위기, 제작 방향 |
| Multi-Agent 시스템을 Python부터 단계별로 구현하고 싶다 | [multi-agent-implementation-guide.md](./multi-agent-implementation-guide.md) | Agent 역할 목록, LLM API 키 |
| Claude Code 플러그인을 한 번에 설치하고 싶다 | [claude-plugins-setup.md](./claude-plugins-setup.md) | Claude Code 설치 완료 |
| VS Code에서 AI 코딩 세션 무한 루프·토큰 낭비를 방지하고 싶다 | [ai-workspace/_templates/VSCODE_AI_RULES.md](../ai-workspace/_templates/VSCODE_AI_RULES.md) | VS Code + Claude Code 또는 GitHub Copilot 설치 완료 |
| 웹 UI/컴포넌트/페이지 개발 시 디자인 품질을 높이고 싶다 | [antigravity_test/skills/frontend_design.md](./antigravity_test/skills/frontend_design.md) | 개발할 UI 목적, 기술 스택 |
| 모바일 앱(Flutter/SwiftUI/RN) UI 품질 체크리스트가 필요하다 | [antigravity_test/skills/ui_ux_pro_max.md](./antigravity_test/skills/ui_ux_pro_max.md) | 앱 유형, 플랫폼 |
| Hermes 판단 엔진 워크플로우·프롬프트가 필요하다 | [prompts/](./prompts/) | 작업 목적 |

## 권장 작업 흐름

### 신규 프로젝트 전체 흐름

```text
1. project_보안_초기설계_Prompts.md
        ↓
2. [ai-workspace] PROJECT_START.md + TESTING_DONE_CRITERIA.md 작성
        ↓
3. mfc/python 프로젝트생성 (AI 코딩 중 VSCODE_AI_RULES.md 적용)
        ↓
4. [ai-workspace] AI_CODING_REVIEW.md (머지 전)
        ↓
5. mfc_최종검수 또는 common_프로젝트_분석
        ↓
6. [ai-workspace] PRE_DEPLOY.md (배포 전)
```

### 기존 MFC 프로젝트 분석

```text
mfc_프로젝트_구조_Prompts.md
        ↓
mfc_프로젝트_정밀분석_Prompts.md  →  결과: MFC_CONTEXT.md + docs/ISSUES.md
        ↓
이슈 수정
        ↓
mfc_프로젝트_최종검수_Prompts.md  (MFC_CONTEXT.md + docs/ISSUES.md 첨부)
```

### 특정 클래스만 깊게 볼 때

```text
mfc_클래스_심층분석_Prompts.md
```

## 주요 입력 예시

### 보안 초기 설계

```text
프로젝트 유형: 웹 서비스
주요 사용자: 불특정 다수
사용 기술 스택: React + Node.js
외부 API 사용 여부: 있음
데이터 저장 여부: DB 사용
로그인·인증 필요 여부: 있음
```

### Python 프로젝트 생성

```text
[프로젝트 이름] image_converter
[기능 명세] PNG를 WebP로 일괄 변환, 변환 진행률 표시
[프로젝트 구조] 표준
[사용 기술 스택] Python 3.11, Pillow
[특수 제약 조건] 외부 API 사용 금지
```

### MFC 프로젝트 생성

```text
프로젝트 이름: MyApp
앱 유형: Dialog
Visual Studio 버전: 2022
플랫폼: x64
문자셋: Unicode
사용 모듈: 파일 I/O, 스레드
```

## 보안 주의

이 저장소는 프롬프트 자산 저장소입니다. 다음 정보는 저장하거나 프롬프트에 넣지 마세요.

- API 키, Secret Key, Token, Password
- DB 접속 정보
- 회사 내부 문서, 고객 정보, 사내 URL
- 개인 식별 정보와 민감한 개인정보
- 공개하면 안 되는 제품, 정책, 계약 정보

## 스킬 시스템 (antigravity_test)

[antigravity_test](./antigravity_test/README.md) 폴더는 창의적 글쓰기, 에이전트 스킬, 프롬프트 엔지니어링 실험 모음입니다.
모든 스킬은 표준 헤더(ID/Version), 핵심 기능, 사용 명령어, 실전 예시(Before→After)를 포함합니다.

### 스킬 카테고리 및 주요 명령어

| 카테고리 | 스킬 | 핵심 명령어 |
|---|---|---|
| **UI/디자인** | `frontend_design` | 웹 UI 개발 시 필수 참조 — 타이포그래피, 컬러, 모션 |
| **UI/디자인** | `ui_ux_pro_max` | 모바일 앱 UI 규칙, Pre-Delivery 체크리스트, 접근성 |
| **프롬프트 기반** | `rtcf_expert` | `/rtcf`, `/audit` |
| **프롬프트 기반** | `prompt_engineer` | `/refine`, `/image`, `/music` |
| **에이전트 조율** | `agentic_orchestrator` | `/orchestrate`, `/delegate` |
| **에이전트 조율** | `multi_agent_director` | `/team-up`, `/review` |
| **사고/검증** | `sequential_thinker` | `/think`, `/verify` |
| **사고/검증** | `self_correction_critic` | `/critique`, `/perfect` |
| **사고/검증** | `context_engineer` | `/prune`, `/structure` |
| **사고/검증** | `community_meta_prompter` | `/meta-think`, `/blueprint` |
| **창작** | `story_architect` | `/plot`, `/beat`, `/twist` |
| **창작** | `novel_manager` | `/char`, `/check`, `/suggest` |
| **창작** | `community_snowflake_writer` | `/step`, `/expand` |
| **음악/영상** | `lyrics_analyzer` | `/lyric`, `/music-gen` |
| **음악/영상** | `mv_director` | `/storyboard`, `/scene`, `/style` |
| **분석/전략** | `world_analyst` | `/ai-trend`, `/stock`, `/job` |
| **분석/전략** | `life_strategist` | `/money`, `/automate`, `/roadmap` |
| **분석/전략** | `community_value_investor` | `/analyze`, `/moat`, `/risk-audit` |

> **rtcf_expert는 기반 스킬입니다.** 다른 스킬에 내릴 지시를 먼저 RTCF로 구조화하면 결과 품질이 높아집니다.

> **agentic_orchestrator vs multi_agent_director:**
> `agentic_orchestrator` = 목표를 받는 즉시 필요한 에이전트를 판단·지휘 (즉흥형)
> `multi_agent_director` = 먼저 팀을 설계하고 역할·검토 구조를 수립 (팀 설계형)

스킬 사용 방법은 [antigravity_test/README.md](./antigravity_test/README.md)를 참고하세요.

---

## 분석 결과 요약

### 파일 구성 현황

| 카테고리 | 파일 수 | 파일 목록 |
|----------|---------|-----------|
| 공통 지침 | 1 | CLAUDE.md |
| MFC 프롬프트 | 5 | 프로젝트생성, 구조, 정밀분석, 최종검수, 클래스심층분석 |
| Python/공통 프롬프트 | 3 | python_프로젝트생성, common_프로젝트_분석, common_git_마이그레이션 |
| 보안/설계 | 1 | project_보안_초기설계 |
| 음악/미디어 | 1 | sunoai |
| 아키텍처/도구 참고 | 2 | multi-agent-implementation-guide, claude-plugins-setup |
| antigravity_test 스킬 | 18 | skills/ 폴더 — UI/디자인 2개 포함 (frontend_design, ui_ux_pro_max) |
| antigravity_test 문서 | 4 | docs/ 폴더 내 가이드 문서 |
| Hermes 워크플로우 프롬프트 | 7 | prompts/ 폴더 (ai-architect, validation, quality-gate 등) |

### 주요 변경 이력

| 날짜 | 변경 내용 |
|------|-----------|
| 2026-06-05 | GLOBAL_RULES.md 삭제 (DEPRECATED — CLAUDE.md로 대체 완료) |
| 2026-06-05 | VSCODE_AI_RULES.md 삭제 (ai-workspace/_templates/ 단일 관리로 통합) |
| 2026-06-05 | llm-service-market-strategy.md → ai-workspace/business/ 이동 (전략 문서) |
| 2026-06-05 | prompts/ 폴더 추가 — ai-workspace에서 이전 (Hermes 워크플로우 프롬프트 7개) |
| 2026-06-05 | frontend_design.md 스킬 추가 (Anthropic 공식 — 웹 UI 디자인 철학) |
| 2026-06-05 | ui_ux_pro_max.md 스킬 추가 (NextLevelBuilder — 전문 UI 규칙·체크리스트) |
| 2026-06-05 | CLAUDE.md에 UI 개발 필수 참조 규칙 추가 (섹션 7) |
| 2026-06-04 | scenario_writer_hermes_Prompts.md 참조 제거 (파일 미존재) |
| 2026-06-04 | 전체 프롬프트 파일의 GLOBAL_RULES.md 참조를 CLAUDE.md로 통일 (7개 파일) |
| 2026-06-04 | MFC 분석 결과물 파일명 충돌 수정: mfc_정밀분석·최종검수의 [CLAUDE.md] 출력 → [MFC_CONTEXT.md] |
| 2026-06-04 | antigravity_test 스킬 15개 전면 보완 (표준 헤더, 실전 예시, 경로 수정, 스킬 구분 명확화) |
| 2026-06-04 | rtcf_expert.md 완전 재작성 (18줄 → 변환 프로세스 + 예시 3개 + 조합 가이드) |
| 2026-05-30 | README 최초 정비 |

---

Last Updated: 2026-06-05
