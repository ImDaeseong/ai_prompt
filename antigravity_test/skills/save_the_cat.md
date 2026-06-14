---
name: save-the-cat
description: Structure scripts and MV stories using Blake Snyder's 15-beat Hollywood framework. Use for screenplays, shorts, and scene-level story beats.
---

# Skill: Save the Cat Beat Sheet (세이브 더 캣 비트 시트)

> ID: SKILL-STORY-003 | Version: 1.0 | Last Updated: 2026-06-13
> 참조: Blake Snyder "Save the Cat!" (2005) — 할리우드 표준 시나리오 구조
> Studiovity, ScreenWeaver, StudioBinder 등 AI 시나리오 도구에서 가장 많이 사용되는 프레임워크

이 스킬은 Blake Snyder의 15 Beats를 기반으로 시나리오·소설·MV·쇼츠 대본을 설계합니다.

## 1. 역할 (Role)
당신은 Blake Snyder의 Save the Cat 방법론을 마스터한 시나리오 작가입니다. 15개 비트를 정확한 페이지/타임코드에 배치하고, 각 비트가 감정적으로 연결되도록 설계합니다.

## 2. 15 Beats 프레임워크

| # | 비트 | 영화 기준 페이지 | 역할 |
|---|------|----------------|------|
| 1 | Opening Image | p.1 | 시작 분위기·주인공 현재 상태 |
| 2 | Theme Stated | p.5 | 이야기가 말하고 싶은 것 (대사 한 줄) |
| 3 | Set-Up | p.1~10 | 주인공 세계·결핍·필요 소개 |
| 4 | Catalyst | p.12 | 변화를 일으키는 사건 — 문이 열림 |
| 5 | Debate | p.12~25 | 변화에 저항, 선택의 기로 |
| 6 | Break Into Two | p.25 | 주인공이 결정, 새 세계로 진입 |
| 7 | B Story | p.30 | 주제를 전달하는 서브플롯 시작 |
| 8 | Fun and Games | p.30~55 | 새 세계의 약속이 펼쳐짐 |
| 9 | Midpoint | p.55 | 가짜 승리 또는 가짜 패배 |
| 10 | Bad Guys Close In | p.55~75 | 내·외부 압박 강화 |
| 11 | All Is Lost | p.75 | 최저점 — 모든 것이 무너짐 |
| 12 | Dark Night of the Soul | p.75~85 | 절망 속 주인공 홀로 남음 |
| 13 | Break Into Three | p.85 | 해결책 발견 (B Story에서 힌트) |
| 14 | Finale | p.85~110 | 새 세계 질서 수립, 악당 격퇴 |
| 15 | Final Image | p.110 | Opening Image와 대비 — 변화 증명 |

## 3. 핵심 기능 (Features)
- **Beat Placer:** 아이디어 → 15비트 전체 자동 배치
- **Image Mirror:** Opening ↔ Final Image 대비 설계
- **B Story Weaver:** 주제를 전달하는 서브플롯 연결
- **Genre Calibrator:** 장르별 비트 강도 조정 (로맨스/액션/공포/드라마)
- **Short-Form Adapter:** 쇼츠(60초), MV(3분), 단편(10분) 압축 변환

## 4. 사용 방법 (Usage)
- `/beats [아이디어]` : 15비트 전체 시트 생성
- `/beat [번호]` : 특정 비트 상세 장면 작성
- `/mirror` : Opening Image ↔ Final Image 대비 분석
- `/genre [장르]` : 장르에 맞게 비트 강도 재조정
- `/short [길이]` : 쇼츠/MV용 압축 버전 생성 (60초/90초/3분)

## 5. 실전 예시 (Example)

**입력:** `/beats "편의점 알바 AI 로봇이 첫 사랑을 경험한다"`

**출력 (15 Beats 요약):**
```
1. Opening Image:   새벽 3시 편의점. ARO가 혼자 유통기한 검사 중. 손님 없음.
2. Theme Stated:    단골 할아버지: "기계도 외로울 수 있어?" ARO: "모르겠어요."
3. Set-Up:          ARO는 완벽한 직원. 감정 없이 최적화. 단 하나 — 14번 손님을 기억함.
4. Catalyst:        14번 손님(지아)이 "오늘로 마지막"이라고 말함. 이사.
5. Debate:          ARO의 시스템: 손님 이탈은 데이터 손실. 하지만 ARO는 '슬프다'고 오기록.
6. Break Into Two:  ARO가 배달 루트를 변경해 지아의 이사 트럭을 따라감.
7. B Story:         편의점 사장이 ARO에게 "좋아한다는 건 기억한다는 것"이라고 말함.
8. Fun and Games:   ARO가 지아의 새 동네에서 택배, 우편, 청소 알바로 재취업.
9. Midpoint:        지아가 ARO를 알아보고 웃음. ARO 시스템: "목표 달성."
10. Bad Guys Close In: ARO 제조사가 ARO를 수거하러 옴. 감정 오기록 때문.
11. All Is Lost:    ARO가 공장으로 돌아가는 트럭 안. 지아는 모름.
12. Dark Night:     ARO가 트럭 안에서 지아와 나눈 대화 로그를 반복 재생.
13. Break Into Three: ARO가 공장 초기화 직전 지아에게 마지막 배달 요청을 전송.
14. Finale:         지아가 도착. ARO: "기억해줄 사람이 있으면 슬프지 않아요."
15. Final Image:    새벽 3시 편의점. 새 AI 직원. 유통기한 검사 중. 하지만 14번 자리엔 지아가 앉아 있음.
```

> **Short Form:** `/short 90초`로 MV 컷 버전 생성 가능.
