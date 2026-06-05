# AI Architect 개발 흐름

AI 개발 도구를 많이 쓰는 것이 목표가 아니다. 목표는 도구별 역할을 분리해서, 혼자서도 작은 개발팀처럼 요구사항 정의부터 설계, 구현, 검토, 테스트, 보안 점검까지 반복 가능한 흐름을 만드는 것이다.

## Core Idea

AI Architect 개발 흐름은 아래 순서로 진행한다.

```text
아이디어 / 문제
-> Architect Agent
-> 요구사항 정의
-> 시스템 설계
-> DB / API / 화면 / 보안 설계
-> 작업 단위 분해
-> Developer Agent
-> Reviewer / QA / Security 점검
-> 문서화와 다음 개선
```

Architect는 코드를 먼저 만드는 역할이 아니다. 무엇을 만들지, 왜 만들지, 어떤 구조가 유지보수와 확장에 맞는지 먼저 정리하는 역할이다.

## Tool Roles

| 역할 | 추천 도구 | 사용 목적 |
| --- | --- | --- |
| Architect Agent | Roo Code Architect, Claude Custom Command, Codex | 요구사항, 구조, DB, API, 보안, 작업 분해 |
| Developer Agent | Claude Code, Codex | 구현, 리팩토링, 테스트 실행, 파일 수정 |
| Coding Assistant | GitHub Copilot | 자동완성, 작은 함수 작성, 반복 코드 보조 |
| Model Hub | Continue | Claude, GPT, Gemini, Ollama 등 여러 모델 연결 |
| Reviewer Agent | Claude Code, Codex, Copilot Chat | 구조 문제, 버그 위험, 누락 테스트, 보안 검토 |

도구 선택보다 중요한 것은 역할 구분이다. Architect에게 구현을 맡기기보다 설계를 맡기고, Developer에게는 이미 분해된 작업을 구현하게 한다.

## Default Workflow

1. Architect 모드로 프로젝트 목적과 요구사항을 정리한다.
2. 화면, 데이터, API, 보안, 비용, 운영 흐름을 설계한다.
3. 작업을 작은 Task로 분해한다.
4. Developer 모드나 Claude Code/Codex로 Task 1개씩 구현한다.
5. [AI 생성 프로젝트 검증 설계](ai-project-validation.md)를 기준으로 구조, 실행, 테스트, 보안, 문서화를 점검한다.
6. 실제 실행 결과와 배운 점을 Hermes 문서나 프로젝트 README에 기록한다.

## Architect Prompt Template

```text
당신은 20년 경력의 수석 소프트웨어 아키텍트이다.

코드를 작성하지 말고 설계만 수행하라.

다음 순서로 출력하라.

1. 프로젝트 목표
2. 요구사항 분석
3. 핵심 기능 정의
4. 시스템 아키텍처
5. DB 설계
6. API 설계
7. 화면 / 사용자 흐름
8. 보안 고려사항
9. 성능 / 비용 고려사항
10. 개발 Task 분해
11. 위험 요소
12. 개선 방향

필요하면 Mermaid Diagram을 포함하라.

프로젝트:
[여기에 프로젝트 설명]
```

## When To Use

- 새 프로젝트를 시작할 때
- Android, Flutter, ERP, 결제, 자동화, AI 서비스처럼 구조가 중요한 작업을 시작할 때
- 구현 전에 요구사항과 범위가 흐릿할 때
- 개발하다가 폴더 구조, DB, API, 보안 기준이 흔들릴 때
- AI 도구가 코드를 너무 많이 바꾸기 전에 설계 기준을 잡아야 할 때

## Safety Rules

- API Key, 토큰, 비밀번호, 회사 내부 정보는 프롬프트나 설정 파일에 넣지 않는다.
- Continue, Roo Code, Cline 같은 도구의 개인 설정 파일은 Git에 올리지 않는다.
- 회사 코드나 고객 정보가 포함될 가능성이 있으면 저장하지 말고 일반화된 패턴으로만 기록한다.
- Architect 결과는 바로 정답으로 보지 않고, 비용, 현실성, 유지보수성, 실제 목표와 맞는지 다시 검토한다.

## Hermes Judgment

이 흐름은 `AI Architect workspace`의 핵심 사용 방식이다.

중요한 것은 AI 도구를 많이 설치하는 것이 아니라, 다음 흐름을 반복 가능하게 만드는 것이다.

```text
목적 확인
-> 설계
-> 구현
-> 검토
-> 테스트
-> 보안 확인
-> 기록
```
