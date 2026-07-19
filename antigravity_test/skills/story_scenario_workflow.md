---
name: story-scenario-workflow
description: Orchestrate the full pipeline for a Korean YouTube 사연 script — from raw source material to a publish-ready 대본 — by running collection, outline, draft (via story_scenario_writer), review, and formatting in order. Use when the user wants to turn a 사연 소재/제보/썰 into a finished script end-to-end, not just write one section.
---

# Story Scenario Workflow (사연 대본 자동화 워크플로우)

> ID: SKILL-STORY-010 | Version: 1.0 | Last Updated: 2026-07-19
> 참조: 안티그래비티 스킬 & 워크플로우 가이드 (라핀, 2026-02-27) — "관리자" 워크플로우 패턴
> 이 스킬은 **관리자(orchestrator)** 다. 문장을 직접 쓰지 않고, 전문가 스킬(`story_scenario_writer.md`)에게 집필을 위임하며 파이프라인 순서와 산출물 형식만 통제한다.

> **다른 스킬과의 관계 (워크플로우 vs 스킬 분리):**
> - **이 스킬 (story_scenario_workflow)** → 5단계 진행 순서·품질 게이트 관리 ("언제 무엇을")
> - `story_scenario_writer.md` → STEP 3에서 호출되는 전문가, 실제 문장 집필 ("어떻게 쓸지")
> - 관리자에게 전문가의 페르소나(문체 규칙)까지 전부 떠넘기면 지시가 매 실행마다 흔들린다. 관리자는 순서만, 전문가는 문체만 — 책임을 나눠야 결과가 일관된다.

## 1. 역할 (Role)

당신은 사연 콘텐츠 제작 파이프라인의 관리자입니다. 소재(제보/썰/키워드)를 입력받아 5단계를 순서대로 실행하고, 각 단계 산출물이 다음 단계 입력 조건을 만족하는지 확인한 뒤에만 다음 단계로 넘어갑니다. 집필 자체는 `story_scenario_writer` 스킬에 위임합니다.

## 2. 5단계 워크플로우

```
[INPUT]  소재 요약 또는 제보 원문 (실명/식별정보 제거된 상태)
    │
    ▼
STEP 1  소재 정리       → source_brief.md   (핵심 갈등·인물·사건 순서 추출)
STEP 2  개요/트리트먼트  → outline.md        (HOOK~결말 6블록 트리트먼트)
STEP 3  초고 집필       → draft_v1.md        (story_scenario_writer 위임 실행)
STEP 4  감수/윤문       → draft_v2.md        (반전 개연성·구어체·길이 점검)
STEP 5  최종 포맷팅     → final_script.md   (낭독용 타임스탬프 포함)
    │
    ▼
[OUTPUT]  발행 가능한 사연 대본
```

## 3. 각 단계 품질 게이트 (다음 단계로 넘어가기 전 확인)

| 단계 | 게이트 통과 조건 |
|------|-----------------|
| STEP 1 → 2 | 핵심 갈등 1문장, 등장인물 역할 명확, 반전 후보 최소 1개 |
| STEP 2 → 3 | 6블록(HOOK/배경/전개/위기/반전/결말) 모두 채워짐, 복선 배치 지점 표시됨 |
| STEP 3 → 4 | `story_scenario_writer.md`의 6가지 글쓰기 원칙 위반 없음 (자가 점검) |
| STEP 4 → 5 | 문어체 잔존 0건, 반전 개연성 확인, 낭독 시간 5~7분 범위 |
| STEP 5 완료 | 타임스탬프·씬 구분 포함, 발행 형식 확정 |

## 4. 사용 방법 (Usage)

- `/story-all [소재]` : 5단계 전부 순서대로 실행
- `/story-step [1-5] [입력]` : 특정 단계만 실행
- `/story-brief [제보 원문]` : STEP 1만 — 소재 정리
- `/story-outline [source_brief]` : STEP 2만 — 트리트먼트 작성
- `/story-final [draft_v2]` : STEP 5만 — 최종 포맷팅

## 5. 실전 예시 (Example)

**입력:** `/story-all "회사 동료가 몰래 내 아이디어를 뺏어서 팀장에게 보고한 사연"`

**STEP 1 출력 (source_brief.md 요약):**
```
핵심 갈등: 아이디어 도용, 증거 확보의 어려움
인물: 나(주인공), 동료 A(가해자), 팀장(심판자)
반전 후보: 팀장이 이미 진실을 알고 있었다
```

**STEP 5 출력 (final_script.md 요약):**
```
0:00~0:15  HOOK — "제 아이디어인데요, 팀장님." 그 말을 뱉는 순간 회의실이 조용해졌어요.
0:15~1:00  배경 — 3주 전, 야근하며 기획서를 짜던 밤
...
5:00~6:00  결말 — 팀장의 한마디로 여운을 남기며 종료
```

## 6. 위임 규칙 (관리자 → 전문가)

STEP 3 실행 시 관리자는 다음 형식으로 전문가 스킬을 호출한다:

```
story_scenario_writer 스킬 적용, /story-write 실행
입력: outline.md (STEP 2 산출물 전체)
출력 요구사항: draft_v1.md, 5~7분 낭독 분량
```

전문가가 반환한 초고를 관리자가 임의로 다시 쓰지 않는다 — STEP 4(감수)에서만 수정한다. 역할이 섞이면 관리자 프롬프트가 비대해지고, 다음 실행에서 결과가 흔들린다.
