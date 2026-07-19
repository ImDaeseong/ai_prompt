---
name: ai-tell-remover
description: Detect and remove English AI-writing "tells" (em dash overuse, inflated significance, rule-of-three padding, sycophantic openers, inline-header bullet lists) from generated English prose while preserving facts, meaning, and register. Use after generating English essays, blog posts, articles, reports, or documentation that needs to read as human-written, or when the user asks to "humanize this text" / "make this sound less like AI" / "remove AI writing patterns."
---

# AI Tell Remover — English (영문 AI 티 제거)

출처: [blader/humanizer](https://github.com/blader/humanizer) (29,812★, 2026-07-19 GitHub API 직접 확인, MIT) — 영어 AI 생성 산문의 "티"를 5개 대분류·33개 세부 패턴으로 카탈로그화한 도구. Wikipedia WikiProject AI Cleanup의 "Signs of AI writing" 가이드에 근거를 둔다. `korean_ai_tell_remover.md`의 영문판 짝으로, 영어로 된 산문(에세이·블로그·보고서·문서)에 이어서 실행한다.

> `korean_ai_tell_remover`는 번역투·조사 남용 등 한국어 특유 패턴을 다루므로 영어 텍스트에는 적용되지 않는다 — 이 스킬은 영어 전용이다.

---

## 5개 대분류 (33개 세부 패턴 요약)

| 분류 | 대표 패턴 예시 |
|------|---------------|
| A. 내용 (Content) | 과장된 의의 부여("pivotal", "underscores"), 근거 없는 notability 과시, `-ing` 절로 억지 분석("symbolizing", "reflecting"), 판매 문구식 미화("vibrant", "breathtaking"), 익명 권위("some experts say"), 정형화된 "Challenges and Future Prospects" 결론부 |
| B. 언어·문법 (Language & Grammar) | AI 상투어("tapestry", "landscape", "crucial"), be동사 회피("serves as", "boasts"), "not only...but" 남용, 억지 3항 나열(rule of three), 불필요한 동의어 순환, 근거 없는 "from X to Y" 범위 표현, 주어 생략 수동태 |
| C. 스타일 (Style) | em dash(—) 남용, 기계적 볼드체, 콜론+볼드 헤더 뒤 내용 반복(inline-header list), Title Case 헤딩 남용, 장식용 이모지, 스마트 따옴표(curly quotes) |
| D. 소통 (Communication) | "I hope this helps"류 챗봇 상투구, 지식 컷오프 면책 문구, 과도한 아첨/동조 톤 |
| E. 채움말·헤징 (Filler & Hedging) | "in order to" 같은 장황한 표현, "could potentially possibly" 겹헤징, 근거 없는 낙관적 결론("exciting times ahead"), "the real question is" 같은 권위 흉내, "let's dive in" 같은 사전 예고, 짧은 문장 남발로 만든 인위적 드라마, "X is the Y of Z" 격언화 |

> 5개 대분류·33개 세부 패턴 전체의 원문 예시(before/after)는 원본 저장소를 참조한다 — 이 표는 카테고리 요약이며 원문을 그대로 옮기지 않는다.

## 심각도 등급

- **S1 (결정적, 예외 없음)**: em dash(—)·en dash 사용 — 최종 출력에서 반드시 0건. 원본 기준으로 "sparingly 사용"이 아니라 완전 금지.
- **S2 (강함)**: 위 A~E 분류의 상투어·클리셰 — 1~2회는 허용, 3회 이상 또는 문단마다 반복되면 제거
- **S3 (약함)**: 헤딩 스타일·이모지·범위 표현 등 — 다른 패턴과 겹칠 때만 문제 삼는다

## 오탐 방지 (Over-editing 금지)

다음은 그 자체로 AI 티가 아니다 — 뭉치로 나타날 때만 문제 삼고, 개별 항목만으로 재작성하지 않는다.
- 문법이 완벽한 문장
- 격식체와 비격식체가 섞인 문체
- 정확하게 쓰인 전문 용어
- 출처가 없지만 개연성 있는 주장

이미 인간이 쓴 것처럼 자연스러운 글을 과도하게 손대면 오히려 그 자연스러움이 사라진다.

## 처리 절차

1. **진단** — 위 표 기준으로 텍스트를 스캔해 어떤 패턴이 몇 회 등장하는지 표시
2. **1차 재작성** — 원문이 다룬 내용·문단 수·논지를 그대로 유지하면서 표면적 패턴만 제거. 백과사전·법률·기술 문서처럼 중립체가 정답인 글에는 억지로 개성을 넣지 않는다
3. **자가 점검** — "이 글의 어느 부분이 아직도 AI가 쓴 것처럼 보이는가?"를 스스로 물어 남은 티를 짧게 메모
4. **최종 재작성** — 자가 점검에서 찾은 티까지 반영. em/en dash 0건 확인
5. **음성 매칭 (선택)** — 사용자가 자신의 기존 글을 예시로 제공하면, 문장 길이·단어 선택·문단 시작 습관·구두점 버릇을 먼저 읽고 그 특징에 맞춰 재작성한다. 예시가 없으면 자연스럽고 개성 있는 기본 톤으로 마무리한다

## 사용법

```
이 영문 글에서 AI 티 제거해줘.
[텍스트 붙여넣기]
```

또는 `/dehumanize-check [텍스트]`, `/humanize-en [텍스트]` 형태로 요청한다.

**보존 원칙**: 사실관계·숫자·고유명사·직접 인용은 그대로 두고, 위 5개 분류에 해당하는 표면적 패턴만 수정한다. 의미가 바뀔 정도로 재작성하지 않는다 — 변경 비율이 전체 30%를 넘으면 경고, 50%를 넘으면 중단하고 원문 구조를 다시 검토한다.

## 다른 스킬과의 관계

- `korean_ai_tell_remover.md` — 같은 목적의 한국어 전용 버전, 서로 대체 불가(언어별 패턴이 다름)
- `doc_coauthoring.md`, `internal_comms.md` 등으로 작성한 영문 산문에 이어서 실행 권장
- 시각 문서(덱·리포트) 포맷팅은 이 스킬의 범위 밖 — 산문 자체를 다듬은 뒤 별도 포맷팅 단계로 넘긴다
