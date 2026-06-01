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

### ✍️ 창작 (Creative)
| 파일 | 스킬명 | 역할 |
|------|--------|------|
| `novel_manager.md` | Novel Manager | 소설 세계관·등장인물 설정 일관성 관리 |
| `lyrics_analyzer.md` | Lyrics Analyzer | 가사 분석 및 음악 AI 연동 |
| `story_architect.md` | Story Architect | 플롯 설계 및 서사 구조화 |
| `mv_director.md` | MV Director | 뮤직비디오 연출 기획 |

### 📈 경제·전략 (Business)
| 파일 | 스킬명 | 역할 |
|------|--------|------|
| `community_value_investor.md` | Value Investor | 워런 버핏 스타일 기업 가치 분석 |
| `world_analyst.md` | World Analyst | 주식·취업·AI 동향 통합 분석 |
| `life_strategist.md` | Life Strategist | 수익 창출 및 생산성 최적화 로드맵 |
| `rtcf_expert.md` | RTCF Expert | 모든 업무 지시를 Role·Task·Context·Format 구조로 최적화 |

### 🤖 에이전트·오케스트레이션 (Agentic)
| 파일 | 스킬명 | 역할 |
|------|--------|------|
| `agentic_orchestrator.md` | Agentic Orchestrator | 복잡한 작업을 서브 에이전트에 분배하고 지휘 |
| `multi_agent_director.md` | Multi-Agent Director | CrewAI 스타일 AI 팀 구성 및 협업 운영 |
| `context_engineer.md` | Context Engineer | 방대한 데이터를 AI가 효율적으로 읽도록 정보 구조 설계 |

### 🧠 사고·프롬프트 (Reasoning)
| 파일 | 스킬명 | 역할 |
|------|--------|------|
| `sequential_thinker.md` | Sequential Thinker | 논리적 단계를 밟아 오류를 수정하며 최선의 해답 도달 |
| `self_correction_critic.md` | Self-Correction Critic | 답변의 오류를 스스로 찾아 교정하는 자가 비판 |
| `prompt_engineer.md` | Prompt Engineer | 단순 명령을 AI 최적화 고정밀 프롬프트로 변환 |
| `community_meta_prompter.md` | Community Meta Prompter | 문제를 분해하고 근거를 점검하는 메타 프롬프팅 |
| `community_snowflake_writer.md` | Snowflake Writer | 한 문장에서 소설 전체를 설계하는 구조적 작법 |

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
