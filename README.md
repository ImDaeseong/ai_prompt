# AI Prompt Repository

AI 코딩 어시스턴트에게 개발, 분석, 마이그레이션, 보안 점검, 음악 제작 작업을 맡길 때 사용하는 프롬프트 모음입니다.

## 저장소 목표

이 저장소의 목표는 AI를 더 잘 이해하고 활용하기 위해, 프롬프트·지시 구조·스킬·작업 흐름을 연구하고 축적하는 것입니다.

단순히 프롬프트 문장을 모으는 곳이 아니라, AI에게 어떤 일을 어떻게 맡기면 좋은지 실험하고, 반복 가능한 사용 방식으로 정리하는 개인 AI 활용 연구 폴더입니다.

## 파일 포함 원칙

이 저장소에는 **프롬프트·스킬·페르소나·작업 흐름 문서**만 포함한다.

| 포함 ✅ | 제외 ❌ |
|--------|--------|
| 스킬 파일 (antigravity_test/skills/) | AI 행동 규칙·MCP 설정 → `../hermes-agents/` |
| 페르소나 문서 (antigravity_test/docs/) | 운영 기록·일지·핸드오프 → `../ai-workspace/` |
| 워크플로우 프롬프트 (prompts/) | 실제 프로젝트 소스코드 |
| 분야별 특화 프롬프트 (MFC, Python, Git 등) | API 키·비밀값 |
| AI 활용 가이드 문서 | |

> **주의:** `hermes-agents/`, `ai-workspace/` 폴더를 이 저장소 안에 두지 않는다.

## `E:\ai_test`와의 구분

`E:\ai_test`의 중심 질문이 "AI로 개발을 어떻게 더 잘할까?"라면, `E:\ai_prompt`의 중심 질문은 "AI에게 어떻게 지시해야 더 좋은 결과가 나올까?"입니다.

```text
핵심 원칙: CLAUDE.md + 지금 필요한 프롬프트 파일 1개만 사용
```

## 빠른 시작

1. [CLAUDE.md](./CLAUDE.md)를 먼저 읽거나 AI에게 함께 제공합니다.
2. 아래 표에서 현재 작업에 맞는 프롬프트 파일 1개를 고릅니다.
3. 프롬프트 안의 `[대괄호]` 값을 실제 상황에 맞게 채운 뒤 AI에게 전달합니다.

새 프로젝트를 만들기 전 보안 점검이 필요하면 [antigravity_test/skills/security_and_hardening.md](./antigravity_test/skills/security_and_hardening.md)를 사용하세요. 기능 구현 전에 API 키, 비밀번호, 고객 정보, 공개 불가 정보가 코드나 저장소에 섞이지 않게 점검하는 용도입니다.

## 공통 지침

- 모든 프롬프트는 [CLAUDE.md](./CLAUDE.md)를 최상위 원칙으로 따릅니다.
- 작업마다 필요한 프롬프트 1개만 추가로 사용합니다.
- 분석 작업은 대상 프로젝트 폴더를 AI가 읽을 수 있는 상태로 준비합니다.
- API 키, 토큰, 비밀번호, 고객 정보, 회사 내부 정보는 프롬프트나 코드에 넣지 않습니다.
- 문서와 규칙 변경은 로컬 수정 및 검증까지만 수행하며, 서버 반영은 수동으로 진행합니다.

## Quick Pick — 가장 자주 쓰는 5가지

| 상황 | 파일 |
|------|------|
| 새 프로젝트 시작 전 보안 점검 | [antigravity_test/skills/security_and_hardening.md](./antigravity_test/skills/security_and_hardening.md) |
| 멀티 에이전트 시스템 설계 | [antigravity_test/skills/multi_agent_architect.md](./antigravity_test/skills/multi_agent_architect.md) |
| 최근 30일 트렌드·인물·도구 리서치 | `/last30days <topic>` (설치: `/plugin marketplace add mvanhorn/last30days-skill`) |
| LLM 앱 에이전트 아키텍처 진단 | [antigravity_test/skills/agent_architecture_audit.md](./antigravity_test/skills/agent_architecture_audit.md) |
| 자율 에이전트 루프 패턴 선택 | [antigravity_test/skills/autonomous_loops.md](./antigravity_test/skills/autonomous_loops.md) |
| 바이브 코딩 시 내 코딩 스타일 적용 | [imdaeseong_coding_style.md](./imdaeseong_coding_style.md) |

전체 목록은 아래 상황별 선택 가이드를 참고하세요.

---

## 상황별 선택 가이드

| 상황 | 사용할 파일 | 먼저 준비할 것 |
|------|-------------|----------------|
| 새 프로젝트 개발 전에 보안·공개 불가 정보·저장소 위험을 먼저 점검하고 싶다 | [antigravity_test/skills/security_and_hardening.md](./antigravity_test/skills/security_and_hardening.md) | 프로젝트 유형, 기술 스택, 외부 API/DB 사용 여부 |
| VS Code에서 AI 코딩 세션 무한 루프·토큰 낭비를 방지하고 싶다 | [ai-workspace/_templates/VSCODE_AI_RULES.md](../ai-workspace/_templates/VSCODE_AI_RULES.md) | VS Code + Claude Code 또는 GitHub Copilot 설치 완료 |
| 웹 UI/컴포넌트/페이지 개발 시 디자인 품질을 높이고 싶다 | [antigravity_test/skills/frontend_design.md](./antigravity_test/skills/frontend_design.md) | 개발할 UI 목적, 기술 스택 |
| MCP 서버를 직접 만들고 싶다 | [antigravity_test/skills/mcp_builder.md](./antigravity_test/skills/mcp_builder.md) | 연동할 서비스 API 문서 |
| 로컬 웹앱을 Playwright로 자동 테스트하고 싶다 | [antigravity_test/skills/webapp_testing.md](./antigravity_test/skills/webapp_testing.md) | 실행 중인 로컬 서버 URL |
| React 앱을 단일 HTML로 번들해 공유하고 싶다 | [antigravity_test/skills/web_artifacts_builder.md](./antigravity_test/skills/web_artifacts_builder.md) | 구현할 UI 목적 |
| 기술 문서·스펙을 체계적으로 함께 작성하고 싶다 | [antigravity_test/skills/doc_coauthoring.md](./antigravity_test/skills/doc_coauthoring.md) | 문서 유형, 독자, 목적 |
| p5.js로 생성 예술·인터랙티브 아트를 만들고 싶다 | [antigravity_test/skills/algorithmic_art.md](./antigravity_test/skills/algorithmic_art.md) | 작품 컨셉, 스타일 방향 |
| 웹 페이지를 HTML/CSS/JS/성능/접근성/SEO/보안 기준으로 감사하고 싶다 | [antigravity_test/skills/frontend_checklist.md](./antigravity_test/skills/frontend_checklist.md) | 점검할 페이지 URL 또는 코드 |
| AI 에이전트가 일관된 UI를 생성하도록 DESIGN.md를 만들고 싶다 | [antigravity_test/skills/design_md_creator.md](./antigravity_test/skills/design_md_creator.md) | 브랜드 무드, 주요 색상 |
| 프로덕션급 멀티 에이전트 파이프라인을 설계·검토하고 싶다 | [antigravity_test/skills/multi_agent_architect.md](./antigravity_test/skills/multi_agent_architect.md) | 에이전트 역할, 파이프라인 목적 |
| 아이디어를 3일 내 작동하는 프로토타입으로 빠르게 검증하고 싶다 | [antigravity_test/skills/rapid_prototyper.md](./antigravity_test/skills/rapid_prototyper.md) | 검증할 가설, 핵심 기능 |
| 인가된 환경에서 보안 침투 테스트를 체계적으로 진행하고 싶다 | [antigravity_test/skills/security_pentest.md](./antigravity_test/skills/security_pentest.md) | 서면 승인 문서, 테스트 범위 |
| 생성한 한국어 가사·소설·문서에서 AI가 쓴 티(번역투·기계적 나열·클리셰)를 없애고 싶다 | [antigravity_test/skills/korean_ai_tell_remover.md](./antigravity_test/skills/korean_ai_tell_remover.md) | 원문 텍스트 |
| 생성한 영문 에세이·블로그·문서에서 AI가 쓴 티(em dash 남용·rule of three·클리셰)를 없애고 싶다 | [antigravity_test/skills/ai_tell_remover.md](./antigravity_test/skills/ai_tell_remover.md) | 원문 텍스트 |
| Hermes 판단 엔진 워크플로우·프롬프트가 필요하다 | antigravity_test/skills/ 참조 (prompts/ 폴더는 2026-06-16 제거 — skills/ 포맷으로 대체됨) | 작업 목적 |

## 신규 프로젝트 권장 흐름

```text
1. antigravity_test/skills/security_and_hardening.md (보안 초기 점검)
        ↓
2. [ai-workspace] PROJECT_START.md + TESTING_DONE_CRITERIA.md 작성
        ↓
3. 개발 (AI 코딩 중 VSCODE_AI_RULES.md 적용)
        ↓
4. [ai-workspace] AI_CODING_REVIEW.md (머지 전)
        ↓
5. [ai-workspace] PRE_DEPLOY.md (배포 전)
```

> MFC/Python 프로젝트 생성·분석용 특화 프롬프트(`mfc_*`, `python_프로젝트생성` 등)는 2026-06-16 커밋(`a1e23b7`)에서 제거되었다. 필요하면 `antigravity_test/skills/` 포맷으로 다시 작성해 추가할 것.

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
| **프롬프트 기반** | `rtcf_expert` | `/rtcf`, `/audit` |
| **프롬프트 기반** | `prompt_engineer` | `/refine`, `/image`, `/music` |
| **에이전트 조율** | `agentic_orchestrator` | `/orchestrate`, `/delegate` |
| **에이전트 조율** | `multi_agent_director` | `/team-up`, `/review` |
| **사고/검증** | `sequential_thinker` | `/think`, `/verify` |
| **사고/검증** | `self_correction_critic` | `/critique`, `/perfect` |
| **사고/검증** | `context_engineering` | 세션 시작·품질 저하 시 컨텍스트 정리 (슬래시 명령 없음) |
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
| 공통 지침 | 2 | CLAUDE.md, imdaeseong_coding_style.md |
| antigravity_test 스킬 | 109 | skills/ 폴더 — 실제 파일 수 기준 (2026-07-19 확인) |
| antigravity_test 문서 | 5 | docs/ 폴더 내 가이드 문서 |
| MFC/Python/공통/보안/음악/아키텍처 특화 프롬프트 | 0 | 2026-06-16 커밋(`a1e23b7`)에서 전부 제거 — antigravity_test/skills/ 포맷으로 대체 예정, 현재 미이관 |
| Hermes 워크플로우 프롬프트 | — | prompts/ 폴더 2026-06-16 제거 — antigravity_test/skills/ 포맷으로 대체 완료 |

### 최근 변경 이력

상세 변경 내용과 전체 이력은 `git log`를 참고하세요. 요약만 남깁니다.

| 날짜 | 변경 내용 |
|------|-----------|
| 2026-07-19 | 신규 스킬 3개: `ai_tell_remover`(영문 AI 티 제거, blader/humanizer 기반), `story_scenario_writer`/`story_scenario_workflow`(사연 대본 전문가/관리자 쌍). 가이드 `antigravity_usage_guide.md` 추가. 두 README의 삭제 파일 참조(깨진 링크) 전수 정리 |
| 2026-07-17 | `hermes_config_audit` 스킬 추가 — hermes-agents 설정 6영역 감사 |
| 2026-07-12 | `skill_writing_quality` 스킬 추가 — 트리거 문장 품질 체크리스트 |
| 2026-06-14 | 신규 스킬 10개 (GitHub 검토 5개 + anthropics/skills 공식 5개), 스킬 저장 규칙을 hermes-agents `CLAUDE.md`에 명시 |
| 2026-06-05 | `frontend_design.md` 추가, GLOBAL_RULES.md/VSCODE_AI_RULES.md 정리·통합 |
| 2026-05-30 | README 최초 정비 |

---

Last Updated: 2026-07-19
