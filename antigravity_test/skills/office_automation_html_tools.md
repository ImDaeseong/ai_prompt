---
name: office-automation-html-tools
description: Generate single-file HTML office tools (budget allocator, quote/invoice generator, margin calculator, VAT calculator, approval-document generator) via Claude Code with zero hand-written code, or chain Claude Code output into a Claude Design proposal plus a Google Drive/Gmail automation chain, or set up a recurring daily inbox/calendar briefing. Use when the user wants a small internal business tool built quickly as a standalone HTML file, or wants to hand off a finished document into Drive+Gmail, or wants a scheduled morning briefing.
---

# 사무자동화 HTML 도구 생성 (No-Code)

출처: 라이즈젠 유튜브 "[초보자를 위한 클로드 심화편] 코딩 1줄 없이 사무자동화 프로그램 만들기"(2026-07-24). 영상이 다룬 Anthropic 기능(Cowork 채팅 홈 통합, Claude Design 베타, 원격 세션 Max→Pro 순차 오픈)은 2026-07-29 WebSearch로 실제 확인됨 — Cowork 웹/모바일 확장은 2026-07-07 Anthropic 공식 발표, Claude Design은 2026-04-17 Pro/Max/Team/Enterprise 연구 프리뷰로 출시, 원격 세션(Remote Control)은 2026-02-25 Max 우선 출시 후 Pro 순차 확대 — 영상의 설명과 일치.

## 전제 조건

- **데스크탑 앱 설치 필수** — 커넥터, Claude Code, 예약 작업(Scheduled Tasks) 전부 데스크탑 앱 기준
- 자동화 체인·Claude Code 원활한 사용은 **Pro 플랜 이상** 권장
- Claude Design은 베타라 화면이 달라질 수 있음
- 원격 세션은 Max 플랜부터 순차 오픈, Pro는 뒤이어 확대 중(고정 일정 없음)

## Claude Code용 프롬프트 5종 (HTML 파일 1개, 코드 직접 안 씀)

각 프롬프트는 대괄호 부분만 실제 상황에 맞게 바꿔서 그대로 사용한다. 결과물은 지정한 폴더(예: 바탕화면)에 HTML 파일로 저장되고, "이 내용 그대로 엑셀 파일로 옮겨줘"라고 이어서 요청하면 엑셀로도 뽑을 수 있다.

### 1. 예산 계산기
```
예산을 입력하면 [인건비/재료비/운영비/예비비] 항목별로 [40/30/20/10]% 비율로 자동 분배해주는 계산기를 HTML 파일 하나로 만들어줘. 비율은 내가 화면에서 직접 고칠 수 있게 하고, 합계랑 남은 금액이 바로바로 표시되게 해줘. 남은 금액이 마이너스면 빨간색으로 경고해줘.
```

### 2. 견적서 작성기
```
품목, 수량, 단가를 입력하면 공급가액이랑 부가세 10%, 합계가 자동으로 계산되는 견적서 작성기를 HTML 파일 하나로 만들어줘. 회사명 [회사명]이랑 담당자 [이름/연락처]는 고정으로 넣어주고, 행 추가/삭제 버튼이랑 A4 인쇄 버튼도 넣어줘.
```

### 3. 마진 계산기
```
매입가랑 판매가를 입력하면 마진액이랑 마진율을 계산해주는 계산기를 HTML 파일 하나로 만들어줘. [카드 수수료 %, 배송비 원] 같은 비용 항목도 추가할 수 있게 하고, 목표 마진율 [30]%를 맞추려면 판매가를 얼마로 해야 하는지 거꾸로 계산해주는 기능도 넣어줘.
```

### 4. 부가세 계산기
```
공급가액이랑 합계금액을 서로 바꿔서 계산해주는 부가세 계산기를 HTML 파일 하나로 만들어줘. 여러 건 입력하면 월 합계도 표로 정리되게 해줘.
```

### 5. 결재 서식 만들기
```
[기안서] 서식 프로그램을 HTML 파일 하나로 만들어줘. 제목, 날짜, 작성자, 내용만 입력하면 우리 회사 형식([문서번호/수신/참조/결재란 등])대로 채워진 문서가 나오게 하고, 인쇄랑 PDF 저장이 되게 해줘.
```

## Claude Design용 프롬프트

```
[제안서] 초안 내용을 첨부한 양식 디자인에 맞춰서 넣어줘. A4 세로 기준이고, 메인 컬러는 [#컬러코드], 폰트는 [맑은 고딕], 표지-목차-본문-마무리 순서로 만들어줘. 가볍게 작업할 수 있게 HTML로 작업해줘.
```
양식 파일이 없으면: `"우리 회사는 [업종]이고 [깔끔한] 느낌을 원해"`처럼 스타일만 설명해도 된다.

## 자동화 체인 (Cowork, Gmail·Drive 커넥터 필요)

```
방금 만든 문서를 PDF로 저장해서 Google Drive [폴더명] 폴더에 넣고, Gmail로 [받는 사람]한테 [초안 검토 요청] 메일 초안을 임시보관함에 써줘.
```
**메일은 반드시 내용을 직접 확인한 뒤 보내기 버튼을 눌러야 한다 — 초안까지만 자동화, 발송은 사람이 확인.**

## 예약 브리핑 (Scheduled Tasks, Gmail 커넥터 필요)

```
매일 오전 [7]시에 캘린더랑 받은 편지함 요약해서 아침 브리핑으로 보고해줘.
```

## 이 스킬의 범위

- 코드를 직접 짜지 않고 Claude Code/Claude Design에게 완성된 산출물을 요청하는 "프롬프트 뼈대" 모음이다 — 각 항목의 대괄호를 실제 값으로 바꿔 쓰는 것이 핵심이고, 그대로 복사해도 되고 필요에 맞게 문구를 조정해도 된다.
- Gmail/Drive 커넥터 연결, Cowork 자동화 체인, Scheduled Tasks 설정 자체는 Claude 데스크탑 앱의 UI 조작이 필요하며 이 스킬 밖의 영역이다.

## 관련 스킬

- `doc_coauthoring.md` — 제안서(Claude Design 프롬프트) 본문을 먼저 다듬어야 할 때, 이 스킬로 초안을 공동 작성한 뒤 위 Claude Design 프롬프트로 넘긴다
