---
name: korean-ai-tell-remover
description: Detect and remove Korean AI-writing "tells" (translationese, 첫째/둘째/셋째 enumeration, AI clichés) from generated Korean text while preserving facts and meaning. Use after generating Korean lyrics, novel prose, story text, or docs that need to read as human-written.
---

# Korean AI Tell Remover (한국어 AI 티 제거)

출처: [im-not-ai](https://github.com/epoko77-ai/im-not-ai) (3,834★, 2026-07-19 확인, MIT) — 한국어 AI 생성 텍스트의 "티"를 10개 대분류·70개 이상의 세부 패턴으로 카탈로그화한 도구. `lyrics_analyzer`, `novel_manager`, `story_architect`, `doc_coauthoring` 등으로 생성한 한국어 결과물에 이어서 실행한다.

> 영어권 AI-tell 도구(예: stop-slop)는 번역투·조사 남용 등 한국어 특유 패턴을 잡지 못한다 — 이 스킬은 한국어 전용이다.

---

## 10개 대분류

| 분류 | 예시 |
|------|------|
| A. 번역투 | "~를 통해", "~에 있어서", "~되어진다"(이중 피동), "~가지고 있다" |
| B. 영어 병기 과다 | 번역 가능한 괄호 속 영어 용어, 대괄호 남용 |
| C. 기계적 구조 | "첫째·둘째·셋째" 나열, 접속사 뒤 쉼표 남발, 과도한 불릿·이모지 |
| D. AI 클리셰 | "결론적으로", "시사하는 바가 크다", "주목할 만하다" |
| E. 리듬 단조로움 | 문장 길이·구조 반복 |
| F. 중복 수식어 | 같은 뜻 수식어 겹침 |
| G. 헤징 연쇄 | "~일 수도 있다", "~라고 볼 수 있다" 연속 사용 |
| H. 접속사 남용 | "그리고/그러나/따라서" 과다 |
| I. 격식체 명사화 | 동사를 억지로 명사형으로 바꾸는 문어체 |
| J. 시각 장식 과다 | 불필요한 강조(볼드/이모지) 남발 |

## 심각도 등급

- **S1 (결정적)**: 1회만 등장해도 AI 저작 확정 — 무조건 제거
- **S2 (강함)**: 1~2회는 허용, 3회 이상이면 제거
- **S3 (약함)**: 다른 패턴과 겹칠 때만 문제

## 처리 강도 (텍스트 상태에 따라 선택)

1. **Light** — 이미 잘 쓰인 글, 최소 수정
2. **Standard** — 진단 후 표적 재작성
3. **Heavy** — 심각한 경우, 15,000자 이상 장문 — 최종 검증 포함

## 사용법

```
이 가사/소설/문서에서 AI 티 제거해줘.
[텍스트 붙여넣기]
```

또는 `/humanize [텍스트]` 형태로 요청한다.

**보존 원칙**: 사실관계·숫자·고유명사·직접 인용은 그대로 두고, 위 10개 분류에 해당하는 부분만 표면적으로 수정한다. 의미가 바뀔 정도로 재작성하지 않는다 — 변경 비율이 전체 30%를 넘으면 경고, 50%를 넘으면 중단하고 원문 구조를 다시 검토한다.
