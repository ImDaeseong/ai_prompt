# Creative Writing AI System (Novels, Lyrics, Stories)

이 저장소는 AI를 활용한 창의적 글쓰기(소설, 가사, 스토리)를 극대화하기 위해 설계된 MCP 연동 및 Skill 시스템입니다.

## 📂 폴더 구조
- **`skills/`**: AI의 페르소나와 작업 로직을 정의한 스킬 파일들.
- **`docs/`**: 가이드 및 데이터 저장 공간.
  - `mcp_setup_guide.md`: 외부 MCP 서버 연결 방법.
  - `famous_mcp_and_skills.md`: 주요 MCP 서버 및 스킬 카탈로그.
  - `agent_manifest_template.md`: 에이전트 매니페스트 템플릿.
  - `mcp_apps_guide.md`: MCP 앱 가이드.

## 🛠 스킬 목록

> 모든 스킬은 표준 헤더(ID/Version/Date), 핵심 기능, 사용 명령어, **실전 예시(Before→After)** 를 포함합니다.
> `rtcf_expert`는 기반 스킬로, 다른 스킬에 내릴 지시를 먼저 RTCF 구조로 정제할 때 사용합니다.

### ✍️ 창작 — 기존 (Creative)
| 파일 | 스킬명 | 역할 | 핵심 명령어 |
|------|--------|------|------------|
| `novel_manager.md` | Novel Manager | 소설 세계관·등장인물 설정 일관성 관리 | `/char`, `/check`, `/suggest` |
| `lyrics_analyzer.md` | Lyrics Analyzer | 가사 운율·음절 분석 및 Suno 프롬프트 생성 | `/lyric`, `/rhyme`, `/music-gen` |
| `story_architect.md` | Story Architect | 플롯 설계 및 서사 구조화 | `/plot`, `/beat`, `/twist` |
| `mv_director.md` | MV Director | 뮤직비디오 연출 기획 및 영상 AI 프롬프트 생성 | `/storyboard`, `/scene`, `/style` |

### 📖 스토리 생성 프레임워크 — 업계 표준 (Story Generation)
> 실제 AI 플랫폼·GitHub 프로젝트에서 널리 사용되는 유명 프레임워크를 스킬화

| 파일 | 스킬명 | 출처 | 핵심 명령어 |
|------|--------|------|------------|
| `heros_journey.md` | Hero's Journey | Joseph Campbell + Vogler "The Writer's Journey" | `/journey`, `/stage`, `/shadow` |
| `save_the_cat.md` | Save the Cat | Blake Snyder 15 Beats — 할리우드 표준 시나리오 구조 | `/beats`, `/beat`, `/short` |
| `story_bible_generator.md` | Story Bible Generator | Sudowrite / ProseWeave AI 표준 — AI 기억 일관성 해결 | `/bible`, `/bible-check`, `/bible-export` |
| `character_card.md` | Character Card | SillyTavern + NovelAI 캐릭터 카드 표준 | `/card`, `/card-voice`, `/card-react` |
| `lorebook_world_info.md` | Lorebook / World Info | SillyTavern World Info 공식 형식 — 키워드 기반 동적 설정 | `/lore-add`, `/lore-find`, `/lore-check` |
| `pixar_story_engine.md` | Pixar Story Engine | Writers Room Story Engine (GitHub) + Pixar 22 Rules + Story Spine | `/spine`, `/btf`, `/pixar-check` |
| `mv_story_workflow.md` | MV Story Workflow | AI Content Labs MV Workflow — 노래→MV 7단계 자동화 | `/mv-all`, `/mv-step`, `/mv-short` |

### 📈 경제·전략 (Business)
| 파일 | 스킬명 | 역할 | 핵심 명령어 |
|------|--------|------|------------|
| `community_value_investor.md` | Value Investor | 워런 버핏 스타일 기업 내재 가치 분석 | `/analyze`, `/moat`, `/risk-audit` |
| `world_analyst.md` | World Analyst | 주식·취업·AI 동향 통합 분석 | `/ai-trend`, `/stock`, `/job` |
| `life_strategist.md` | Life Strategist | AI 활용 수익 창출 및 생산성 최적화 로드맵 | `/money`, `/automate`, `/roadmap` |
| `rtcf_expert.md` | RTCF Expert ⭐ | 모든 지시를 Role·Task·Context·Format 구조로 최적화 | `/rtcf`, `/audit`, `/format` |

### 🤖 에이전트·오케스트레이션 (Agentic)
| 파일 | 스킬명 | 역할 | 핵심 명령어 |
|------|--------|------|------------|
| `agentic_orchestrator.md` | Agentic Orchestrator | 목표를 받는 즉시 서브 에이전트를 판단·지휘 (즉흥형) | `/orchestrate`, `/delegate` |
| `multi_agent_director.md` | Multi-Agent Director | 팀 구성 먼저 설계 후 협업 구조 운영 (팀 설계형) | `/team-up`, `/review`, `/execute-all` |
| `context_engineer.md` | Context Engineer | 방대한 데이터를 AI가 효율적으로 읽도록 정보 구조 설계 | `/structure`, `/prune`, `/anchor` |
| `autonomous_loops.md` | Autonomous Loops | Sequential Pipeline·Infinite·Continuous PR·DAG 5가지 자율 루프 패턴 | 패턴 선택 결정 트리 사용 |

### 🔧 개발·진단 (Dev & Diagnosis)
| 파일 | 스킬명 | 역할 | 핵심 명령어 |
|------|--------|------|------------|
| `systematic_debugging.md` | Systematic Debugging | 4단계 근본 원인 디버깅 — 증상 수정 금지, 원인 먼저 | `/debug`, `/root-cause` |
| `agent_architecture_audit.md` | Agent Architecture Audit | 12레이어 LLM 앱 진단 — 래퍼 회귀·메모리 오염·도구 실패 | 심각도 기반 수정 계획 |
| `agentic_engineering.md` | Agentic Engineering | Eval-first·15분 단위 분해·모델 라우팅 AI-first 개발 운영 | 15분 단위 분해 원칙 사용 |

### 🧠 사고·프롬프트 (Reasoning)
| 파일 | 스킬명 | 역할 | 핵심 명령어 |
|------|--------|------|------------|
| `sequential_thinker.md` | Sequential Thinker | 5단계 논리 사고로 오류를 수정하며 최선의 해답 도달 | `/think`, `/verify`, `/step-by-step` |
| `self_correction_critic.md` | Self-Correction Critic | 답변 출력 전 5가지 체크리스트로 자가 교정 | `/critique`, `/perfect`, `/hallucination-check` |
| `prompt_engineer.md` | Prompt Engineer | 단순 명령을 모델별 최적화 고정밀 프롬프트로 변환 | `/refine`, `/image`, `/video`, `/music` |
| `community_meta_prompter.md` | Community Meta Prompter | 문제를 분해하고 근거를 점검하는 5단계 메타 프롬프팅 | `/meta-think`, `/blueprint`, `/optimize` |
| `community_snowflake_writer.md` | Snowflake Writer | 한 문장에서 소설 전체를 9단계로 확장하는 구조적 작법 | `/step`, `/expand`, `/check-structure` |

---

## 🗺 스킬 선택 가이드

### 스토리 설계 — 어느 스킬을 쓸까?

| 상황 | 추천 스킬 |
|------|---------|
| 장르·구조 무관, 범용 플롯 설계 | `story_architect` — `/plot`, `/beat-scene`, `/twist` |
| 성장·모험 서사, 신화적 구조 필요 | `heros_journey` — `/journey`, `/stage` |
| 시나리오·쇼츠·MV 15개 비트로 쪼개기 | `save_the_cat` — `/beats`, `/beat [번호]`, `/short` |
| 단편·MV, Pixar식 Story Spine + 인과관계 | `pixar_story_engine` — `/spine`, `/btf`, `/pixar-check` |

### 설정 관리 — 계층 순서대로 사용

```
STEP 1  character_card       → 인물 한 명씩 정의 (/card)
STEP 2  story_bible_generator→ 전체 세계관·규칙 통합 문서화 (/bible)
STEP 3  novel_manager        → 집필 중 설정 충돌 실시간 감지 (/check)
STEP 4  lorebook_world_info  → 키워드 기반 동적 설정 주입, 토큰 절약 (/lore-add)
```

### MV 제작 — 순서대로 두 스킬 연계

```
STEP 1  mv_story_workflow  → 노래 분석 → 세계관/캐릭터/장면 목록/이미지 프롬프트 생성 ("무엇을")
STEP 2  mv_director        → 생성된 장면 목록 → 카메라·조명·컷 타이밍 결정 ("어떻게")
```

### 프롬프트 최적화 — 목적별 구분

| 목적 | 추천 스킬 |
|------|---------|
| 텍스트 프롬프트 구조 개선 (모달리티 무관) | `prompt_engineer` — `/refine` |
| 문제 분해 → 근거 점검 → 5단계 메타 최적화 | `community_meta_prompter` — `/meta-think` |
| 이미지 생성 전용 프롬프트 | `image_prompt_engineer` |

---

## 🚀 시작하기
1. **MCP 연결:** [docs/mcp_setup_guide.md](docs/mcp_setup_guide.md)를 참고하여 외부 도구를 연결하세요.
2. **Skill 활용:** 원하는 스킬 파일을 대화창에 첨부하거나 "@파일명"으로 참조하여 적용하세요.
   - 예: "novel_manager 스킬을 적용해서 이 챕터를 검토해줘"
3. **데이터 축적:** 집필이 진행됨에 따라 `docs/` 폴더 내에 설정집과 플롯 블루프린트가 업데이트됩니다.

## 🛠 주요 명령어 (예시)
- `/char`: 캐릭터 추가/조회
- `/plot`: 플롯 확장 및 설계
- `/lyric`: 가사 분석 및 수정
- `/music-gen`: AI 음악 생성용 프롬프트 추출
- `/rtcf [요청]`: 업무 지시를 RTCF 구조로 변환
- `/orchestrate [목표]`: 멀티 에이전트 작업 설계 및 실행
- `/think [문제]`: 논리적 단계별 사고 과정 수행
- `/critique [답변]`: 답변 약점 분석 및 개선안 제시

---
**Antigravity AI** - 엘리트 아키텍트와 함께하는 창작의 여정
