# 스킬·프롬프트 색인

개발·분석·문서·창작용 개인 프롬프트 모음입니다. 아래는 주요 선택 가이드이며, 전체 파일은 [skills 폴더](skills/)에서 찾습니다.

## 사용 방법

주 스킬 파일을 대화에 첨부하거나 AI가 읽을 수 있는 경로로 지정하고, 작업 목적과 입력을 함께 전달합니다. 스킬이 요구하는 보조 자료도 확인하세요. 본문의 `/명령어`는 요청 예시일 수 있으며, 파일 첨부만으로 도구나 명령이 설치되지는 않습니다.

| 작업 | 파일 (`skills/` 아래) |
|---|---|
| 보안 설계·점검 | `security_and_hardening.md`, `security_pentest.md` |
| 디버깅·웹 테스트 | `systematic_debugging.md`, `webapp_testing.md`, `frontend_checklist.md` |
| UI·디자인 문서 | `frontend_design.md`, `design_md_creator.md`, `algorithmic_art.md` |
| MCP·HTML 도구·프로토타입 | `mcp_builder.md`, `web_artifacts_builder.md`, `rapid_prototyper.md` |
| 에이전트 설계·진단 | `multi_agent_architect.md`, `agent_architecture_audit.md`, `hermes_config_audit.md`, `agentic_engineering.md` |
| 에이전트 조율·컨텍스트 | `agentic_orchestrator.md`, `multi_agent_director.md`, `context_engineering.md`, `autonomous_loops.md` |
| 스킬 작성·개선 | `skill_creator.md`, `skill_writing_quality.md` |
| 프롬프트·사고·검토 | `rtcf_expert.md`, `prompt_engineer.md`, `image_prompt_engineer.md`, `community_meta_prompter.md`, `sequential_thinker.md`, `self_correction_critic.md` |
| 문서·글 다듬기 | `doc_coauthoring.md`, `korean_ai_tell_remover.md`, `ai_tell_remover.md`, `office_automation_html_tools.md` |
| 플롯·서사 구조 | `story_architect.md`, `heros_journey.md`, `save_the_cat.md`, `pixar_story_engine.md`, `community_snowflake_writer.md` |
| 인물·세계관 관리 | `character_card.md`, `story_bible_generator.md`, `novel_manager.md`, `lorebook_world_info.md` |
| 사연 대본 | `story_scenario_workflow.md`, `story_scenario_writer.md` |
| 가사·뮤직비디오 기획 | `lyrics_analyzer.md`, `mv_story_workflow.md`, `mv_director.md` |
| 경제·전략 | `community_value_investor.md`, `world_analyst.md`, `life_strategist.md` |
| 마케팅·LLM 앱 | `copywriting.md`, `marketing_psychology.md`, `rag_implementation.md`, `llm_evaluation.md` |

## 연결해서 쓸 때

- 팀 구성은 `multi_agent_director`, 목표별 작업 조율은 `agentic_orchestrator`로 구분합니다.
- MV는 `mv_story_workflow`로 장면 구성을 정한 뒤 `mv_director`로 연출을 구체화합니다.
- 사연 대본은 `story_scenario_workflow`가 진행 순서를, `story_scenario_writer`가 집필을 담당합니다.

## 참고 문서

- [Antigravity 활용 가이드](docs/antigravity_usage_guide.md): 파일 첨부와 네이티브 스킬 배치의 차이
- [에이전트 설계 템플릿](docs/agent_manifest_template.md): 역할·도구·권한·출력 정의

외부 출처와 재사용 조건은 각 스킬 및 `skills/NOTICE.md`에서 확인합니다. 외부 스크립트가 필요한 스킬은 파일 존재와 실행 환경부터 점검하세요. 예를 들어 `web_artifacts_builder`의 `init-artifact.sh`와 `bundle.sh`는 이 저장소에 포함되어 있지 않습니다.

검증 명령과 저장소 역할은 [루트 안내](../README.md)를 참고하세요.
