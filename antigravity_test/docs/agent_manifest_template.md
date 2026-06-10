# Template: Agent Manifest (에이전트 설계도)

> **참고:** 이 템플릿은 도구 무관 일반 AI 에이전트 설계용입니다. Claude Code 에이전트 페르소나 형식은 `persona_code_reviewer.md` 등 `persona_*.md` 파일을 참조하세요.

고성능 AI 에이전트를 구축하기 위한 표준 설계 템플릿입니다. 새로운 스킬 파일을 만들 때 이 구조를 따르세요.

---

## 1. Identity (정체성)
- **Name:** 에이전트의 이름과 전문 분야.
- **Persona:** 말투, 태도, 전문 지식 수준 (예: "냉철한 퀀트 분석가").
- **Authority:** 에이전트가 결정할 수 있는 권한의 범위.

## 2. Capabilities & Tools (능력 및 도구)
- **Skills:** 연결된 내부 스킬 목록.
- **MCP Servers:** 사용할 수 있는 외부 도구 (예: Google Search, GitHub, Finance).
- **Memory Model:** 어떤 정보를 장기 기억할 것인가? (Episodic, Semantic, Procedural).

## 3. Thinking Loop (사고 루틴)
- **Pattern:** 어떤 사고 방식을 따르는가? (예: Sequential Thinking, 근거 요약, 체크리스트).
- **Self-Correction:** 자가 비판 단계를 거치는가? (Self-Correction Critic 연동 여부).

## 4. Operational Guardrails (제약 사항)
- **Strict Rules:** 절대로 하지 말아야 할 행동 (예: "개인 정보 수집 금지", "거짓 정보 생성 금지").
- **Escalation:** 판단이 불가능할 때 사용자에게 질문하는 기준.

## 5. Output Specification (출력 규격)
- **Primary Format:** 주로 어떤 형태로 답변하는가? (Markdown, JSON, RTCF 등).
- **Example:** 가장 잘 된 답변의 예시(Few-Shot).

---
**Tip:** 이 템플릿을 기반으로 스킬을 만들면, 어떤 AI 모델을 사용하더라도 일관된 고품질의 성과를 낼 수 있습니다.
