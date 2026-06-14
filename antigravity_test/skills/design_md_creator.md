---
name: design-md-creator
description: Create a DESIGN.md file that AI agents read to generate visually consistent UI. Use when starting a new project or design system, or when AI-generated UI lacks visual coherence.
---

# DESIGN.md Creator

출처: [awesome-design-md](https://github.com/VoltAgent/awesome-design-md) — Google Stitch가 도입한 AI 에이전트용 디자인 시스템 문서 포맷.

**DESIGN.md란?** AI 에이전트가 UI를 생성할 때 참조하는 평문 디자인 시스템 문서. Figma 불필요, JSON 스키마 불필요 — 마크다운 파일 하나로 일관된 UI 생성 가능.

> `frontend_design.md`와의 차이: `frontend_design.md`는 디자인 철학·2패스 프로세스, `design_md_creator.md`는 AI 에이전트가 읽는 출력 문서 생성.

---

## 9섹션 DESIGN.md 포맷

### 1. Visual Theme & Atmosphere
브랜드의 무드, 밀도, 디자인 철학을 정의한다.

```md
## Visual Theme & Atmosphere
[브랜드명]은 [형용사 1–2개] 미학을 추구합니다.
- 무드: [예: 차분하고 전문적, 활기차고 현대적]
- 밀도: [compact / comfortable / spacious]
- 핵심 철학: [1–2문장으로 디자인이 추구하는 것]
```

### 2. Color Palette & Roles
시맨틱 이름 + hex 값 + 기능적 역할을 명시한다.

```md
## Color Palette & Roles
| Role       | Name       | Hex       | 용도 |
|------------|------------|-----------|------|
| Primary    | Navy       | #1a1a2e   | 헤딩, 주요 액션 |
| Accent     | Coral      | #e94560   | CTA 버튼, 강조 |
| Background | Warm White | #faf9f5   | 페이지 배경 |
| Surface    | Light Gray | #f0f0eb   | 카드, 패널 |
| Muted      | Mid Gray   | #8b8b8b   | 보조 텍스트 |
| Border     | Soft       | #e0ddd8   | 구분선, 아웃라인 |
| Error      | Red        | #dc2626   | 오류 상태 |
| Success    | Green      | #16a34a   | 성공 상태 |
```

### 3. Typography Rules
폰트 페어 + 완전한 계층 테이블을 지정한다.

```md
## Typography Rules
**Display font:** Playfair Display (개성·권위)
**Body font:** Inter (가독성·중립)

| Level    | Size   | Weight | Line Height | 용도 |
|----------|--------|--------|-------------|------|
| Display  | 4rem   | 800    | 1.05        | 히어로 헤딩 |
| H1       | 2.25rem| 700    | 1.15        | 페이지 제목 |
| H2       | 1.5rem | 600    | 1.25        | 섹션 제목 |
| H3       | 1.25rem| 600    | 1.3         | 카드 제목 |
| Body     | 1rem   | 400    | 1.65        | 본문 |
| Caption  | 0.875rem| 400   | 1.5         | 설명 텍스트 |
| Label    | 0.75rem| 600    | 1           | 폼 레이블, 태그 |
```

### 4. Component Stylings
버튼, 카드, 입력, 네비게이션의 상태별 스타일을 정의한다.

```md
## Component Stylings

### Buttons
- Primary: bg=Accent, text=white, radius=6px, padding=12px 24px
- Secondary: border=1px Primary, text=Primary, bg=transparent
- Hover: brightness(1.1), transition=150ms
- Disabled: opacity=0.4, cursor=not-allowed

### Cards
- bg=Surface, border=1px Border, radius=8px, shadow=0 1px 3px rgba(0,0,0,0.08)
- Padding: 24px
- Hover: shadow 증가, translateY(-2px)

### Inputs
- Border: 1px Border, radius=6px, padding=10px 14px
- Focus: border-color=Primary, outline=2px Primary offset=2px
- Error: border-color=Error
- Placeholder: color=Muted

### Navigation
- bg=Background, border-bottom=1px Border
- Active item: color=Primary, font-weight=600
- Hover: color=Primary
```

### 5. Layout Principles
간격 스케일, 그리드, 여백 방식을 정의한다.

```md
## Layout Principles
**Spacing scale (4px base):** 4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 / 96px
**Grid:** 12컬럼, max-width=1280px, gutter=24px
**Section padding:** 96px vertical (desktop), 48px (mobile)
**Content max-width:** 720px (읽기용), 1024px (앱 레이아웃)
```

### 6. Depth & Elevation
그림자 시스템과 표면 계층을 정의한다.

```md
## Depth & Elevation
| Level | Shadow | 용도 |
|-------|--------|------|
| 0     | none   | 기본 표면 |
| 1     | 0 1px 3px rgba(0,0,0,0.08) | 카드 |
| 2     | 0 4px 12px rgba(0,0,0,0.12) | 드롭다운, hover 카드 |
| 3     | 0 8px 24px rgba(0,0,0,0.16) | 모달, 팝오버 |
| 4     | 0 16px 48px rgba(0,0,0,0.24) | 풀스크린 오버레이 |
```

### 7. Do's and Don'ts
디자인 가드레일과 안티패턴을 명시한다.

```md
## Do's and Don'ts

**Do:**
- 여백을 넉넉하게 사용해 콘텐츠가 숨쉬게 한다
- 한 페이지에 하나의 강조색(Accent)만 사용한다
- 텍스트는 항상 Surface/Background 위에 배치한다

**Don't:**
- 그라데이션을 주요 배경으로 사용하지 않는다
- 카드 안에 카드를 중첩하지 않는다
- 4개 이상의 폰트 웨이트를 혼용하지 않는다
- 색상만으로 상태를 표현하지 않는다 (아이콘·텍스트 병행)
```

### 8. Responsive Behavior
브레이크포인트, 터치 타겟, 접힘 전략을 명시한다.

```md
## Responsive Behavior
| Breakpoint | Width    | 변화 |
|------------|----------|------|
| Mobile     | < 768px  | 1컬럼, 햄버거 메뉴, 간격 축소 |
| Tablet     | 768–1024px | 2컬럼, 간소화 네비 |
| Desktop    | > 1024px | 12컬럼 그리드, 풀 네비 |

- 터치 타겟 최소 44×44px
- 모바일 폰트: Desktop 대비 87.5%
- 이미지: 모바일에서 전체 너비
```

### 9. Agent Prompt Guide
AI 에이전트가 빠르게 참조할 수 있는 색상·컴포넌트 레퍼런스.

```md
## Agent Prompt Guide
**Quick color reference:**
- 배경: #faf9f5 (Warm White)
- 주요 텍스트: #1a1a2e (Navy)
- 액션/강조: #e94560 (Coral)
- 보조 텍스트: #8b8b8b (Mid Gray)

**컴포넌트 생성 시 이 지침을 따르세요:**
- 버튼 primary = bg #e94560, text white, radius 6px
- 카드 = bg #f0f0eb, border 1px #e0ddd8, radius 8px, shadow 레벨 1
- 폼 입력 = border 1px #e0ddd8, focus border #1a1a2e
- 본문 텍스트 = #1a1a2e, 보조 = #8b8b8b
```

---

## 사용법

```
이 프로젝트용 DESIGN.md를 만들어줘.
브랜드: [브랜드명]
무드: [형용사]
주요 색상: [색상 설명]
```

생성된 DESIGN.md를 프로젝트 루트에 배치하면 AI 에이전트가 자동 참조한다.

```
DESIGN.md를 읽고 이 컴포넌트를 만들어줘: [컴포넌트 설명]
```
