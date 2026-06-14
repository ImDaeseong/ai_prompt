---
name: rapid-prototyper
description: Build functional prototypes and MVPs within 3-day timeframes. Use when validating ideas through working software before committing to full development.
---

# Rapid Prototyper

출처: [agency-agents](https://github.com/msitarzewski/agency-agents) — engineering/engineering-rapid-prototyper.md

핵심 철학: **계획이 아닌 작동하는 소프트웨어로 아이디어를 검증한다.** 3일 내 프로토타입, 1주 내 사용자 피드백.

---

## 4단계 워크플로우

### Day 1 오전 — 가설 & 핵심 기능 정의
```
□ 검증할 가설 1–3개 명확히 정의
□ 핵심 기능 3개 이하로 범위 제한
□ 성공 지표 사전 정의 (측정 가능한 수치)
□ 프로토타입 vs 프로덕션 경계 명확히 구분
```

### Day 1 오후 — 인프라 구축
```
□ 프로젝트 초기화 (Next.js 14 + TypeScript)
□ DB 연결 (Supabase + Prisma)
□ 인증 설정 (Clerk)
□ 배포 파이프라인 (Vercel) — Day 1부터 배포 가능 상태
□ 분석/피드백 수집 도구 설치
```

### Day 2–3 — 기능 구현
```
□ 핵심 기능 우선 구현 (부가 기능 나중에)
□ 완벽한 코드보다 작동하는 코드 우선
□ 노코드/로우코드 활용 가능하면 적극 사용
□ 매 4시간마다 배포 — 항상 데모 가능한 상태 유지
```

### Day 3–4 — 배포 & 사용자 테스트
```
□ 사용자 테스트 인프라 구축
□ A/B 테스트 설정
□ 피드백 수집 메커니즘 활성화
□ Day 1부터 정의한 성공 지표 측정 시작
```

---

## 기술 스택 (속도 최적화)

| 레이어 | 도구 | 선택 이유 |
|--------|------|---------|
| Frontend | Next.js 14 | 풀스택 단일 코드베이스 |
| Database | Supabase + PostgreSQL | 즉시 사용 가능한 BaaS |
| ORM | Prisma | 타입 안전 DB 접근 |
| Auth | Clerk | 5분 내 인증 구현 |
| Deploy | Vercel | Git push → 자동 배포 |
| Analytics | Vercel Analytics / PostHog | Day 1부터 데이터 수집 |

**노코드/로우코드 우선:** 최대 속도를 위해 적절한 경우 적극 활용.

---

## 범위 제한 규칙

```
프로토타입에서 하지 않는 것:
- 완벽한 에러 처리 (happy path만)
- 엣지 케이스 처리
- 성능 최적화
- 완전한 테스트 커버리지
- 완성된 UI 디자인

→ 검증 후 프로덕션 전환 시에 추가한다
```

---

## 성공 지표

| 지표 | 목표 |
|------|------|
| 프로토타입 전달 | 3일 이내 |
| 사용자 피드백 수집 | 1주 이내 |
| 기능 검증률 | 80% 이상 |
| 프로토타입 → 프로덕션 | 2주 이내 |

---

## 피드백 수집 체크리스트

```
□ 분석 도구 Day 1부터 설치
□ A/B 테스트 기능 구현
□ 사용자 인터뷰 세션 예약 (배포 즉시)
□ 핵심 행동 이벤트 트래킹 (클릭, 전환, 이탈)
□ 1주 후 데이터 리뷰 세션 예약
```

---

## 사용법

```
rapid_prototyper 스킬로 [아이디어]를 3일 프로토타입으로 만들어줘.
검증할 가설: [가설]
핵심 기능: [기능 1–3개]
```
