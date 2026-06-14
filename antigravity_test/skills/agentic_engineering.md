---
name: agentic-engineering
description: "Establishes eval-first workflows where AI implements features while humans manage quality and risk."
---

# Skill: Agentic Engineering (에이전트 엔지니어링)

> ID: SKILL-AGENTIC-ENG-001 | Version: 1.0 | Source: affaan-m/ECC | Last Updated: 2026-06-11

AI 에이전트가 구현의 대부분을 수행하고 사람이 품질·위험을 관리하는 개발 워크플로우.

---

## 운영 원칙

1. 실행 전에 완료 기준을 먼저 정의한다.
2. 작업을 에이전트 단위로 분해한다.
3. 작업 복잡도에 따라 모델 티어를 라우팅한다.
4. eval과 회귀 체크로 측정한다.

---

## Eval-First 루프

1. 기능 eval과 회귀 eval을 정의한다.
2. 베이스라인을 실행하고 실패 시그니처를 캡처한다.
3. 구현을 실행한다.
4. eval을 재실행하고 델타를 비교한다.

---

## 15분 단위 분해 원칙

각 단위는 다음 조건을 충족해야 한다:
- 독립적으로 검증 가능
- 단일 주요 위험
- 명확한 완료 조건

---

## 모델 라우팅

| 모델 | 적합한 작업 |
|------|------------|
| Haiku | 분류, 보일러플레이트 변환, 좁은 수정 |
| Sonnet | 구현, 리팩터 |
| Opus | 아키텍처, 근본 원인 분석, 다파일 불변성 검증 |

---

## 세션 전략

- 긴밀하게 연결된 단위들은 세션을 유지한다.
- 주요 단계 전환 후에는 새 세션을 시작한다.
- 컴팩트(compress)는 마일스톤 완료 후에 한다 — 활성 디버깅 중에는 금지.

---

## AI 생성 코드 리뷰 포커스

우선순위:
- 불변성과 엣지 케이스
- 에러 경계
- 보안·인증 가정
- 숨겨진 결합과 롤아웃 위험

스타일만의 불일치에 리뷰 사이클 낭비 금지 (린트/포맷으로 이미 강제되는 부분).

---

## 비용 규율

작업별 추적:
- 사용 모델
- 토큰 추정치
- 재시도 횟수
- 실행 시간
- 성공/실패

명확한 추론 격차가 확인된 경우에만 상위 모델 티어로 에스컬레이션한다.

---

*관련: `systematic_debugging.md` (디버깅), `autonomous_loops.md` (루프 패턴), `agentic_orchestrator.md` (멀티에이전트)*
