# Antigravity 활용 가이드 — 워크플로우·스킬 분리 & 에이전트 우선 개발

> 참조 영상 9건 (2026-01 ~ 2026-07, 라핀 / Mikey Website / Code A Program / Nikhil's AI / AI Stack Engineer / The Metaverse Guy / Core2web AI / Income stream surfers / Teacher's Tech): 유튜브 설명란·AI 자동 요약 기준으로 정리한 것이며 [LOW-EVIDENCE] — 영상 원본을 직접 시청해 세부 UI 동작을 검증하지는 않았다. 스킬·워크플로우 개념은 이 저장소의 기존 패턴(`mv_story_workflow.md`, `skill_creator.md`)과 교차 확인해 정합성을 맞췄고, 제휴 마케팅 위주이거나 이미 반영된 내용과 중복되는 영상은 표에 출처만 남기고 본문에서 제외했다.

이 문서는 "Antigravity에서 스킬/워크플로우를 어떻게 설계하고, IDE 자체를 어떻게 더 잘 쓰는가"를 다룬다. 실제 스킬 파일 작성법은 `skill_creator.md`(공식 스킬 저작 가이드)와 `skill_writing_quality.md`(트리거 문장 다이어트)를 따르고, 이 문서는 그 위에 얹는 실전 운영 팁만 다룬다.

## 1. 워크플로우(관리자) vs 스킬(전문가) — 왜 나눠야 하는가

| | 워크플로우 (관리자) | 스킬 (전문가) |
|---|---|---|
| 역할 | 언제 무엇을 할지 순서·게이트 관리 | 어떻게 할지 — 실제 산출물 생성 |
| 책임 | 파이프라인 진행, 다음 단계 조건 확인 | 페르소나·문체·품질 기준 유지 |
| 변경 빈도 | 낮음 (프로세스는 안정적) | 높음 (표현·톤은 계속 다듬어짐) |

한 파일에 "언제"와 "어떻게"를 다 넣으면, 문체를 손볼 때마다 순서 로직까지 같이 흔들리고 반대도 마찬가지다. 이 저장소에서는 이미 `mv_story_workflow.md`(관리자, 7단계) ↔ `mv_director.md`(전문가, 연출)가 이 패턴을 쓰고 있고, 이번에 `story_scenario_workflow.md`(관리자) ↔ `story_scenario_writer.md`(전문가)로 같은 패턴을 사연 대본 도메인에 추가했다.

**적용 기준:** 산출물이 여러 단계를 거치고(예: 소재→개요→초고→감수→발행) 각 단계 결과물 형식이 다르면 분리한다. 단일 산출물(예: "이 텍스트에서 AI 티 제거")이면 스킬 하나로 충분하다 — `korean_ai_tell_remover.md`처럼.

## 1-1. 3단 구분 — 규칙 vs 워크플로우 vs 스킬

Code A Program 「Antigravity의 맞춤 설정 기능으로 코딩 속도를 10배 향상시키세요」(2026-01-29)는 위 1번의 2단 구분(워크플로우/스킬)에 **규칙(Rules)**을 더해 3단으로 나눈다. 이 구분이 이 워크스페이스의 실제 파일 구조와 정확히 겹치므로 표로 정리한다.

| 구분 | 정의 (영상 기준) | 실행 방식 | 이 워크스페이스의 대응물 |
|---|---|---|---|
| **규칙 (Rules)** | 코딩 표준을 한 번 설정하면 AI가 항상 따름 | 자동 적용 (매 생성마다) | `hermes-agents/CLAUDE.md`, `AGENTS.md` — 프로젝트 전역 규칙 |
| **워크플로 (Workflow)** | 반복적인 여러 단계 작업을 슬래시 명령 하나로 자동화 | 수동 실행 (`/명령어`) | `story_scenario_workflow.md`, `mv_story_workflow.md` 등 "관리자" 스킬 |
| **스킬 (Skill)** | 관련 상황일 때만 로드되는 전문 지식 | 관련성 판단 시 자동 로드 | `antigravity_test/skills/*.md` 전체 — description의 트리거 키워드로 자동 매칭 |

**핵심 차이는 "적용 시점"이다.** 규칙은 항상 켜져 있고, 워크플로는 사람이 명시적으로 부르며, 스킬은 문맥이 맞을 때 AI가 스스로 판단해서 불러온다. 이 저장소가 이미 "hermes-agents=규칙, ai_prompt=스킬"로 저장소를 분리해 관리해온 것이 우연히도 이 3단 구분과 정확히 일치한다 — 다만 "워크플로"에 해당하는 슬래시 명령 자동화는 이 저장소에서는 별도 계층이 아니라 관리자형 스킬 파일(`*_workflow.md`)로 흡수돼 있다는 점이 유일한 차이다.

## 2. 스킬 description에 트리거 키워드 넣기

description은 스킬이 자동으로 트리거되는 유일한 근거다. 애매하게 "글쓰기를 도와줍니다" 대신, 실제 사용자가 칠 법한 구체적 표현 3~5개를 명시한다.

**나쁜 예:** `설명: 사연 대본을 작성합니다.`
**좋은 예:** `설명: ... Use when the user asks for 사연 대본, 사연 라디오 대본, 썰 대본, 감동/반전 스토리 대본, or mentions writing a script for a 사연 유튜브 채널.`

이 저장소의 트리거 문장 품질 기준(leading word, 삭제 테스트 등)은 `skill_writing_quality.md`를 그대로 따른다 — 이 가이드는 새 규칙을 만들지 않는다.

## 3. 트러블슈팅 — AI가 말을 안 들을 때

영상 1이 제시한 3가지 방향을 이 저장소 규칙(`hermes_config_audit.md` 및 `AGENTS.md` 에스컬레이션 규칙)과 맞춰 정리하면:

1. **description을 더 구체화한다.** 트리거가 안 되면 대개 키워드 부족이다 — 1번 항목부터 다시 점검.
2. **역할을 쪼갠다.** 관리자 스킬이 문체까지 지시하려 하면 지시가 매번 흔들린다 — 위 1번 원칙대로 전문가 스킬로 위임한다.
3. **같은 수정을 3번 반복하지 않는다.** `AGENTS.md`의 에스컬레이션 규칙과 동일 — 2번 실패하면 접근法을 바꾸고, 3번째도 실패하면 HOLD 후 사용자에게 알린다.

## 4. Antigravity IDE 자체를 잘 쓰는 법 (영상 2 요약)

영상 2는 스킬/워크플로우 설계가 아니라 **Antigravity 에디터 사용 습관**을 다룬다. 핵심만 추리면:

- **에이전트 우선(Agent-First) 개발.** 한 줄씩 직접 편집하기보다, 작업 단위(Task Group)를 에이전트에게 맡기고 결과물(Artifact)을 검증하는 방식으로 전환한다. 이 저장소의 `subagent_driven_development.md`, `dispatching_parallel_agents.md`와 같은 방향이다.
- **병렬 실행(Agent Manager).** 독립적인 작업은 여러 에이전트에 동시에 맡긴다 — `dispatching_parallel_agents.md` 참조.
- **워크스페이스 권한 설정.** 어떤 파일/폴더를 에이전트가 건드릴 수 있는지 미리 범위를 정해둔다. 이 저장소 기준으로는 `hermes_config_audit.md`가 다루는 permission hygiene과 같은 맥락.
- **Task Group·Subtask·Artifact 검증.** 큰 작업을 하위 작업으로 쪼개고, 각 산출물(Artifact)을 사람이 확인한 뒤 다음 단계로 넘긴다 — `planning_task_breakdown.md`, `verification_before_completion.md`와 동일한 원칙.
- **멀티 서페이스 실행 (에디터/터미널/브라우저).** 코드 편집뿐 아니라 터미널 명령·브라우저 자동화까지 에이전트가 직접 수행하도록 맡긴다. 브라우저 자동화는 `webapp_testing.md`(Playwright) 패턴을 그대로 적용할 수 있다.
- **재구축 대신 피드백 루프.** 결과가 마음에 안 들면 처음부터 다시 만들게 하지 말고, 구체적 피드백으로 다듬는다 — `receiving_code_review.md` / `requesting_code_review.md`의 반복 개선 원칙과 같다.
- **글로벌 룰 + 커스텀 스킬 설정.** 프로젝트 전역 규칙(이 저장소에서는 `AGENTS.md`/`CLAUDE.md`)과 개별 스킬을 나눠 관리한다 — 이미 이 워크스페이스가 채택 중인 구조(hermes-agents=규칙, ai_prompt=스킬)와 정확히 일치한다.
- **MCP 서버 연동.** 외부 DB/API는 MCP로 연결한다 — 서버 목록·연결 상태는 `hermes-agents/MCP_SERVERS.md` 참조.
- **터미널 명령 자동 실행 설정.** 반복적인 안전한 명령(빌드, 테스트)은 자동 실행을 허용하되, 파괴적 명령(삭제, force push)은 항상 확인을 받도록 범위를 좁힌다 — `AGENTS.md`의 "실행 시 주의" 원칙과 동일.
- **지식 관리/문서화 습관.** 프로젝트 진행 중 결정 사항을 그때그때 문서화해 다음 세션이 이어받을 수 있게 한다 — 이 저장소 체계에서는 `ai-workspace/HANDOFF.md`가 그 역할.

> **[ASSUMPTION - unverified, confirm with user]** 영상 2는 Google Antigravity IDE의 UI 기능(Agent Manager, Task Group 화면 등)을 직접 시연하는 것으로 보이나, 이 문서는 유튜브 설명란·AI 요약만 근거로 작성되어 정확한 메뉴명·클릭 경로는 검증하지 못했다. 실제 UI 조작이 필요하면 영상을 직접 확인할 것.

## 5. 참고 영상 — 추가로 반영할 신규 원칙은 없었던 것들

아래는 확인은 했으나 위 1~4번에 이미 흡수됐거나, 이 저장소 소관이 아니거나(MCP 설정 등), 제휴 마케팅 위주라 신뢰도가 낮아 본문에 반영하지 않은 영상이다. 출처만 남긴다.

| 영상 | 핵심 주장 | 처리 |
|---|---|---|
| Nikhil's AI 「Antigravity + Opencode」(2026-04-17) | Antigravity(계획)+OpenCode(실행) 역할 분담 | 1번의 관리자/전문가 분리와 동일 패턴, 설명란 대부분 제휴 링크라 [LOW-EVIDENCE] |
| AI Stack Engineer 「Antigravity + Graphify」(2026-04-28) | 코드베이스 지식 그래프로 토큰 절약 (GitHub: `safishamsi/graphify`) | 이 환경엔 이미 `codebase-memory-mcp`가 같은 역할 수행 중 — 신규 도입 불필요. [LICENSE-UNCONFIRMED] |
| Income stream surfers 「Google AntiGravity 스킬 세트」(2026-01-20) | GitHub `nextlevelbuilder/...`의 UI/UX 스킬 소개 | 2026-06-05에 `ui_ux_pro_max.md`로 이식했었으나 2026-06-14 커밋(`b153844`)에서 삭제됨 — 두 README는 여전히 이 파일을 참조 중인 깨진 링크 상태, 별도 정리 필요 |
| The Metaverse Guy 「Google AntiGravity 에이전트 스킬」(2026-01-17) | `.agent/skills.md` 네이티브 파일 구조 | 이 저장소의 frontmatter+마크다운 형식과 동일, 배포 시 경로만 `.agent/skills/`로 복사 |
| Core2web AI 「IDE vs CLI vs Antigravity 2.0」(2026-07-07) | CLI·예약 작업(Scheduled Tasks) 소개 | 이 워크스페이스의 `schedule`/`loop` 스킬로 이미 대응, 비영어 자막 기반이라 [LOW-EVIDENCE] |
| Teacher's Tech 「초보자 튜토리얼: 첫 앱 만들기」(2026-01-05) | 포모도로 타이머를 자연어 프롬프트로 만들고 Netlify Drop으로 배포 | 신규 UI 조작법 튜토리얼로, 스킬/워크플로우 설계 원칙과 무관 — 이 가이드의 다룰 범위 밖 |

> **반복 관찰:** 위 영상 중 다수(Mikey Website, Code A Program, The Metaverse Guy)가 동일한 제휴 링크(TestSprite)를 스폰서로 언급한다. 도구 자체의 유용성과 무관하게 같은 제휴 네트워크의 반복 노출일 가능성이 있어, 이 가이드에는 도구 추천으로 반영하지 않았다.

## 6. 이 저장소에서 대응되는 스킬 매핑

| 영상에서 다룬 개념 | 이 저장소의 대응 스킬/문서 |
|---|---|
| 워크플로우(관리자) 만들기 | `mv_story_workflow.md`, `story_scenario_workflow.md` |
| 스킬(전문가) 만들기 | `mv_director.md`, `story_scenario_writer.md`, `skill_creator.md` |
| 트리거 키워드 최적화 | `skill_writing_quality.md` |
| 병렬 에이전트 실행 | `dispatching_parallel_agents.md`, `agentic_orchestrator.md`, `multi_agent_director.md` |
| Task 분해·검증 | `planning_task_breakdown.md`, `verification_before_completion.md` |
| 브라우저 서브에이전트 테스트 | `webapp_testing.md`, `browser_testing_with_devtools.md` |
| 글로벌 룰 vs 개별 스킬 | hermes-agents `CLAUDE.md`/`AGENTS.md` (규칙) vs ai_prompt `skills/` (스킬) |
| MCP 연동 | hermes-agents `MCP_SERVERS.md` |
| 디자인 전문 MCP 연동 (예: Stitch) | 신규 MCP 서버 추가는 이 저장소(ai_prompt) 소관이 아니라 `hermes-agents/.mcp.json` + `MCP_SERVERS.md` 소관 — 도입 전 Context Confusion 방지 원칙(`hermes-agents/CLAUDE.md` "컨텍스트 엔지니어링 원칙")에 따라 필요성부터 검토 |
