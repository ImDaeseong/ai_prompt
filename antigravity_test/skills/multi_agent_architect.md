---
name: multi-agent-architect
description: Design production-grade multi-agent pipelines with failure engineering, trust models, and observability. Use when building or auditing multi-agent AI systems.
---

# Multi-Agent Systems Architect

출처: [agency-agents](https://github.com/msitarzewski/agency-agents) — engineering/engineering-multi-agent-systems-architect.md

핵심 철학: **"Demos lie; production tells the truth."** 모든 파이프라인은 실제 부하, 모호한 입력, 연쇄 실패를 견뎌야 한다.

---

## 토폴로지 설계

| 패턴 | 구조 | 적합한 경우 |
|------|------|------------|
| Sequential Chain | A → B → C | 순서 의존적 단계 |
| Parallel Fan-out/in | A → [B,C,D] → E | 독립 병렬 작업 |
| Hierarchical | Orchestrator → Sub-agents | 기본값 — 복잡한 다단계 |
| Evaluator-Optimizer | Generator ⇄ Critic | 반복 품질 개선 |
| Mesh Network | 에이전트 간 자유 통신 | 명시적 이유 있을 때만 |

**기본값: Hierarchical.** Mesh는 명시적 정당화 없이 사용 금지.

---

## 컨텍스트 관리

에이전트 홉을 거칠수록 토큰 예산이 감소한다. 대응 전략:

- **요약**: 각 홉에서 이전 결과를 압축해 전달
- **구조화 상태 객체**: JSON 스키마로 에이전트 간 상태 전달
- **외부 메모리 저장소**: 장기 상태는 DB/벡터 스토어에 저장
- **체크포인팅**: 중요 단계마다 상태 저장 → 재시작 가능

---

## 실패 분류 및 대응

| 실패 유형 | 징후 | 대응 |
|---------|------|------|
| Hard Failure | 에이전트 크래시, 타임아웃 | 재시도 + circuit breaker |
| Silent Failure | 잘못된 결과를 정상으로 반환 | 출력 스키마 검증 |
| Partial Failure | 일부 도구 실패 | 부분 결과 처리 로직 |
| Contradiction | 에이전트 간 상충 결과 | 중재 에이전트 또는 HITL |
| Cascade Failure | 상류 실패가 하류 전파 | 격리 + fallback chain |
| Loop Failure | 무한 루프, 수렴 없음 | 최대 반복 횟수 + 탈출 조건 |
| Context Failure | 컨텍스트 손실·오염 | 체크포인트 복원 |

**모든 에이전트는 fallback chain과 recovery path를 가져야 한다.**

---

## 신뢰·권한 모델

```
최소 권한 원칙 (Least Privilege):
- 각 에이전트는 필요한 도구만 접근
- 도구별 권한 매트릭스 문서화
- 프롬프트 인젝션 방어: 콘텐츠/지시 분리, 스키마 검증
- 샌드박싱: 에이전트는 다른 에이전트의 시스템 프롬프트 접근 불가
```

---

## HITL(Human-in-the-Loop) 게이트 배치

에스컬레이션 기준:

| 조건 | 에스컬레이션 여부 |
|------|----------------|
| 되돌릴 수 없는 액션 (삭제, 배포) | ✅ 항상 |
| 영향 범위(blast radius) 큼 | ✅ |
| 신뢰도 임계값 미달 | ✅ |
| 전례 없는 입력 (novelty) | ✅ |
| 규제·컴플라이언스 노출 | ✅ |
| 반복적·자동화 가능한 작업 | ❌ HITL 불필요 |

과도한 HITL도, 부족한 HITL도 금지.

---

## 관찰 가능성 (Observability)

```python
# 모든 에이전트 호출에 공유 trace_id 필수
{
  "trace_id": "pipeline-run-uuid",
  "agent_id": "summarizer-v2",
  "step": 3,
  "input_tokens": 1240,
  "output_tokens": 380,
  "duration_ms": 1820,
  "tool_calls": ["search", "read_file"],
  "status": "success"
}
```

- 파이프라인 전체에 공유 `trace_id` 전파
- 모든 도구 호출 완전한 감사 트레일
- 멀티홉 실패의 근본 원인 분석 가능하게

---

## 평가 (Evaluation)

```
배포 전 필수:
- 에이전트별 ≥20개 테스트 케이스
- 파이프라인 수준 E2E 테스트
- 베이스라인 성능 추적
- 회귀 감지
```

**Evals before deployment — always.**

---

## 프로덕션 하드 룰

- 필수 컨텍스트 무음 잘라내기(silent truncation) 금지
- 재시도 가능한 모든 액션은 idempotent 설계
- retry 가능한 에이전트에 circuit breaker 적용
- 모든 도구 호출 감사 트레일 기록

---

## 아키텍처 검토 체크리스트

```
□ 토폴로지 선택에 명시적 이유가 있는가?
□ 각 에이전트의 실패 모드와 fallback이 정의됐는가?
□ 컨텍스트 전달 전략이 있는가?
□ 최소 권한 도구 접근이 적용됐는가?
□ HITL 게이트 위치가 적절한가?
□ trace_id가 파이프라인 전체에 전파되는가?
□ 배포 전 eval이 준비됐는가?
```
