# AI Prompt Repository

AI에게 개발·분석·창작 작업을 맡기는 방법을 실험하고 정리하는 개인 프롬프트 저장소입니다. 직접 작성한 자료와 외부 자료를 참고·보완한 스킬을 함께 관리합니다.

## 사용하기

1. 작업 대상 프로젝트의 지침을 확인합니다. 이 저장소를 수정할 때는 `AGENTS.md`와 `CLAUDE.md`를 따릅니다.
2. [스킬 색인](antigravity_test/README.md)에서 주 스킬을 고르고, 파일과 필요한 참조 자료를 AI에게 제공합니다.
3. 목적·입력·원하는 결과를 적고, 실제 실행한 항목과 미검증 항목을 구분해 확인합니다.

코딩 스타일은 [ImDaeseong Vibe Coding Rules](imdaeseong_coding_style.md)를 필요할 때 함께 제공합니다. 비밀값·고객 정보·회사 내부 자료는 예시에 넣지 않습니다.

## 저장 위치

- `antigravity_test/skills/`: 프롬프트·스킬 본문
- `antigravity_test/docs/`: 활용 가이드·페르소나·설계 템플릿
- MCP·환경 설정은 별도 `hermes-agents`, 운영 기록·핸드오프는 별도 `ai-workspace` 저장소에서 관리합니다.

## 검증

저장소 루트에서 실행합니다. Git과 Windows PowerShell이 필요합니다.

```powershell
powershell.exe -NoProfile -File scripts/verify_repo.ps1
```

스킬 구조·참조·로컬 링크·훅 설치기 회귀와 검증 부작용을 검사합니다. 프롬프트의 성능이나 외부 도구 실행 성공을 보장하는 검사는 아닙니다. 변경 이력은 `git log`를 참고하세요.
