# Skill: Autonomous Loops (자율 에이전트 루프)

> ID: SKILL-AUTO-LOOP-001 | Version: 1.0 | Source: affaan-m/ECC | Last Updated: 2026-06-11

자율 Claude Code 루프 패턴 — 단순 순차 파이프라인부터 RFC 기반 멀티에이전트 DAG까지.

**비용 경고**: 무한 루프 패턴은 반드시 `max-runs`, `max-cost`, `max-duration` 중 하나를 설정한다.

---

## 패턴 스펙트럼

| 패턴 | 복잡도 | 최적 사용 상황 |
|------|--------|--------------|
| Sequential Pipeline | 낮음 | 일상 개발 단계, 스크립트 워크플로우 |
| Infinite Agentic Loop | 중간 | 스펙 기반 병렬 콘텐츠 생성 |
| Continuous Claude PR Loop | 중간 | CI 게이트가 있는 다일 반복 프로젝트 |
| De-Sloppify Pattern | 추가 패턴 | 구현 단계 후 품질 정리 |
| RFC-Driven DAG | 높음 | 대형 기능, 병렬 멀티유닛 + 머지 큐 |

---

## 패턴 1: Sequential Pipeline (`claude -p`)

가장 단순한 루프. 일상 개발을 비대화형 `claude -p` 순차 호출로 분해한다.

```bash
#!/bin/bash
set -e
# Step 1: 구현
claude -p "specs/auth-spec.md를 읽고 src/auth/에 OAuth2 로그인을 TDD로 구현하라."
# Step 2: 정리 (De-sloppify)
claude -p "이전 커밋에서 변경된 파일을 검토하고 불필요한 타입 테스트, 과방어 체크를 제거하라."
# Step 3: 검증
claude -p "전체 빌드·린트·타입체크·테스트를 실행하고 실패를 수정하라."
# Step 4: 커밋
claude -p "변경사항에 대한 conventional commit을 생성하라."
```

**핵심 원칙:**
- 각 `claude -p` 호출은 독립 컨텍스트 창 — 단계 간 컨텍스트 누출 없음
- `set -e`로 실패 시 파이프라인 중단
- 모델 라우팅: `--model opus`(분석/리뷰), `--model haiku`(단순 변환)

---

## 패턴 2: Infinite Agentic Loop

스펙 기반 병렬 서브에이전트 생성 시스템.

**2프롬프트 구조:**
1. **오케스트레이터**: 스펙 파싱 → 출력 디렉터리 스캔 → 반복 계획 → 서브에이전트 N개 배포
2. **서브에이전트**: 전체 스펙 + 고유 창의 방향 + 고유 반복 번호 수신 → 출력 생성

**유의사항**: 에이전트에게 자기 차별화를 맡기지 않는다. 오케스트레이터가 각 에이전트에 구체적인 방향과 번호를 **직접 할당**한다.

```bash
# 5개 변형 병렬 생성
/project:infinite specs/component-spec.md src/ 5
# 무한 모드 (context 소진까지)
/project:infinite specs/component-spec.md src/ infinite
```

---

## 패턴 3: Continuous Claude PR Loop

CI 게이트가 있는 자동 PR 생성·병합 루프.

**루프 흐름:**
```
브랜치 생성 → claude -p 실행 → 커밋 → PR 생성
→ CI 대기 → 실패시 자동 수정 패스 → 머지 → 반복
```

**제한 플래그** (항상 하나 이상 설정):
| 플래그 | 용도 |
|--------|------|
| `--max-runs N` | N회 반복 후 중단 |
| `--max-cost $X` | $X 지출 후 중단 |
| `--max-duration 2h` | 시간 초과 후 중단 |

**SHARED_TASK_NOTES.md**: 반복 간 컨텍스트 브리지. Claude가 시작 시 읽고 종료 시 업데이트한다.

**완료 신호**: Claude가 매직 문구를 출력하면 루프 중단 (`--completion-signal`).

---

## 패턴 4: De-Sloppify (정리 패스)

구현 단계 후 별도 컨텍스트에서 실행하는 정리 전용 패스.

**왜 부정 지시 대신 별도 패스인가?**
- "타입 시스템 테스트 금지"를 구현 프롬프트에 추가하면 정당한 엣지 케이스 테스트도 건너뜀
- 제약된 에이전트 1개 < 집중된 에이전트 2개

```bash
# 구현 (철저하게)
claude -p "전체 TDD로 기능을 구현하라."
# 정리 (별도 컨텍스트)
claude -p "변경 사항을 검토하고 제거하라:
- 언어/프레임워크 동작 검증 테스트
- 타입 시스템이 이미 강제하는 중복 타입 체크
- 불가능한 상태에 대한 과방어 에러 처리
- console.log, 주석 처리된 코드
비즈니스 로직 테스트는 유지. 정리 후 테스트 스위트 실행."
```

---

## 패턴 5: RFC-Driven DAG (고급)

RFC/PRD를 의존성 DAG로 분해해 병렬 실행하고 머지 큐로 통합.

**복잡도 티어별 파이프라인:**

| 티어 | 단계 |
|------|------|
| trivial | 구현 → 테스트 |
| small | 구현 → 테스트 → 코드리뷰 |
| medium | 리서치 → 계획 → 구현 → 테스트 → PRD리뷰+코드리뷰 → 수정 |
| large | + 최종리뷰 추가 |

**핵심 설계 원칙:**
- 각 단계는 별도 컨텍스트 창 (리뷰어가 작성자와 다름 → 저자 편향 제거)
- 머지 충돌 시 전체 컨텍스트 캡처 후 다음 패스에 피드백
- 단순 변경은 trivial 티어 → 비싼 연산 불필요

**사용 조건**: 여러 상호의존 작업 단위, 병렬 구현 필요, 머지 충돌 예상, 다일 프로젝트.

---

## 패턴 선택 결정 트리

```
단일 집중 변경인가?
├─→ Yes → Sequential Pipeline
└─→ No  → 작성된 스펙/RFC가 있는가?
   ├─→ Yes → 병렬 구현이 필요한가?
   │  ├─→ Yes → RFC-Driven DAG
   │  └─→ No  → Continuous Claude PR Loop
   └─→ No  → 같은 것의 변형이 많이 필요한가?
      ├─→ Yes → Infinite Agentic Loop
      └─→ No  → Sequential Pipeline + De-Sloppify
```

---

## 안티패턴

1. **종료 조건 없는 무한 루프** — `max-runs`, `max-cost`, `max-duration`, 완료 신호 중 항상 하나.
2. **반복 간 컨텍스트 브리지 없음** — `SHARED_TASK_NOTES.md` 또는 파일시스템 상태로 연결.
3. **같은 실패 재시도** — 에러 컨텍스트를 캡처해 다음 시도에 전달.
4. **부정 지시 대신 정리 패스 없음** — De-Sloppify 패스 추가.
5. **한 컨텍스트에 모든 에이전트** — 복잡한 워크플로우는 단계별 별도 에이전트 프로세스.
6. **병렬 작업의 파일 중복 무시** — 같은 파일을 편집할 수 있는 경우 머지 전략 필요.

---

*관련: `agentic_engineering.md` (에이전트 엔지니어링 원칙), `agentic_orchestrator.md` (멀티에이전트 오케스트레이터)*
