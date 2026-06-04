# Claude Code 플러그인 설치 가이드

집 PC 또는 새 환경에서 Claude Code 플러그인을 설치할 때 참고하는 문서입니다.

---

## 설치 우선순위

| 순서 | 플러그인 | 용도 | 설치 난이도 |
|------|---------|------|------------|
| 1 | andrej-karpathy-skills | 코딩 행동 가이드라인 (전역 적용) | ★☆☆ |
| 2 | superpowers | TDD·디버깅·브레인스토밍 개발 방법론 | ★☆☆ |
| 3 | Understand-Anything | 코드베이스 시각화·아키텍처 분석 | ★★☆ |
| 4 | claude-video | 영상 분석 (별도 의존성 필요) | ★★☆ |

---

## 1. andrej-karpathy-skills

Andrej Karpathy의 LLM 코딩 실수 방지 가이드라인을 전역 스킬로 적용합니다.
모든 프로젝트에 자동으로 적용되어 이 저장소의 CLAUDE.md와 시너지를 냅니다.

- 저장소: https://github.com/multica-ai/andrej-karpathy-skills

```
/plugin marketplace add multica-ai/andrej-karpathy-skills
```

**핵심 원칙:**
- 구현 전에 가정을 명시하고 먼저 질문
- 요청한 것만, 최소한으로
- 요청 범위 밖 코드는 건드리지 않음
- 성공 기준을 먼저 정의하고 루프

---

## 2. superpowers

Claude Code 공식 마켓플레이스 등록 플러그인. TDD, 브레인스토밍, 서브에이전트 개발 방법론을 스킬로 제공합니다.

- 저장소: https://github.com/obra/superpowers
- 버전: 5.1.0

```
/plugin install superpowers@claude-plugins-official
```

**제공 스킬:**
- `/brainstorm` — 요구사항 정제, 설계 검토
- `/tdd` — RED-GREEN-REFACTOR 사이클 강제
- `/debug` — 체계적 디버깅
- `/plan` — 2-5분 단위 작업 분해
- `/subagent` — 병렬 에이전트 디스패치
- `/review` — 코드 리뷰 요청·수신

---

## 3. Understand-Anything

코드베이스를 지식 그래프로 분석하고 시각화합니다. 대형 MFC 프로젝트나 처음 접하는 코드베이스 파악에 유용합니다.

- 저장소: https://github.com/Lum1104/Understand-Anything
- 버전: 2.7.5

```
/plugin marketplace add Lum1104/Understand-Anything
```

**주요 명령:**
```
/understand          # 코드베이스 스캔 및 지식 그래프 생성
/understand-chat     # 코드베이스에 대한 자연어 질의
```

**지원 기능:**
- 40개 이상 언어 분석 (C++/MFC 포함)
- 아키텍처 계층 시각화 (API·Service·Data·UI)
- 변경 영향 범위 분석
- 의존성 순서로 정렬된 아키텍처 투어 자동 생성

---

## 4. claude-video

영상 URL을 Claude에게 넘기면 다운로드 → 프레임 추출 → 자막 변환 → 분석까지 처리합니다.
```
/plugin marketplace add bradautomates/claude-video
```

**의존성 (Windows):**
```bash
winget install ffmpeg
pip install yt-dlp
```

**선택: Whisper API 키** (`~/.config/watch/.env`)
```
GROQ_API_KEY=gsk_...    # 추천 — 무료 (console.groq.com/keys)
OPENAI_API_KEY=sk-...   # 대안
```

---

## 전체 한 번에 설치

새 PC 세팅 시 Claude Code 터미널에서 순서대로 실행:

```
/plugin marketplace add multica-ai/andrej-karpathy-skills
/plugin install superpowers@claude-plugins-official
/plugin marketplace add Lum1104/Understand-Anything
/plugin marketplace add bradautomates/claude-video
```

---

*Last Updated: 2026-06-01*
