---
name: frontend-checklist
description: Audit web pages against 385 front-end rules across HTML, CSS, JS, Performance, Accessibility, SEO, and Security. Use before shipping any web project.
---

# Frontend Checklist

출처: [Front-End Checklist](https://github.com/thedaviddias/Front-End-Checklist) — 385개 규칙, 11개 카테고리.

우선순위: **Critical** (배포 차단) → **High** (주요 영향) → **Medium** (모범 사례) → **Low** (상황별)

---

## HTML (25)

| 우선순위 | 항목 |
|---------|------|
| Critical | HTML5 doctype 선언 (`<!DOCTYPE html>`) |
| Critical | UTF-8 charset 선언 (`<meta charset="UTF-8">`) |
| Critical | 반응형 viewport 메타태그 (`<meta name="viewport" content="width=device-width, initial-scale=1">`) |
| High | `<html lang="ko">` 속성 설정 |
| High | 시맨틱 HTML 요소 사용 (`header`, `main`, `article`, `section`, `footer`) |
| High | 시맨틱 input type 속성 사용 (`email`, `tel`, `number`, `date`) |
| High | 스크립트 `defer`/`async`/`type=module` 로드 |
| High | Subresource Integrity 외부 스크립트에 추가 |
| High | 동영상 자막(captions) 제공 |
| High | 폼 접근성 유효성 검사 |
| High | W3C HTML 유효성 검사 |
| Medium | 커스텀 404 에러 페이지 |
| Medium | 모든 ID 고유성 확인 |
| Medium | 파비콘 전 디바이스 대응 |
| Medium | `<noscript>` 대체 콘텐츠 |
| Medium | RTL 언어 방향 설정 |
| Medium | 프로덕션에서 주석·디버그 코드 제거 |
| Medium | 접근 가능한 breadcrumb 구현 |
| Medium | 파일 업로드 접근성 |
| Medium | 검색 입력 접근성 |
| Medium | 페이지네이션 접근성 |

---

## CSS (32)

| 우선순위 | 항목 |
|---------|------|
| High | 인라인·임베드 CSS 지양 |
| High | 핀치 줌 비활성화 금지 |
| High | Critical CSS 인라인 처리 |
| High | CSS 특이성 낮고 평탄하게 유지 |
| High | 렌더 차단 없이 CSS 로드 |
| High | 모든 CSS 파일 최소화(minify) |
| High | 미사용 CSS 규칙 제거 |
| High | 커스텀 포커스 인디케이터 시각적으로 제공 |
| High | CSS 커스텀 속성으로 디자인 토큰 관리 |
| High | 애니메이션에 `transform`·`opacity` 사용 |
| High | 반응형 레이아웃에 상대 단위 사용 |
| Medium | CSS reset/normalize 적용 |
| Medium | CSS Grid 2차원 레이아웃에 사용 |
| Medium | 컨테이너 쿼리로 컴포넌트 반응형 처리 |
| Medium | `prefers-color-scheme` 다크모드 지원 |
| Medium | `prefers-reduced-motion` 애니메이션 제어 |
| Medium | 일관된 CSS 네이밍 컨벤션 |
| Medium | 인쇄 스타일시트 포함 |
| Medium | Flexbox 베스트 프랙티스 적용 |
| Medium | 수평 스크롤 방지 |
| Medium | 웹폰트 포맷 최적화 |
| Medium | 모바일 읽기 가능한 폰트 크기 |
| Low | `@layer`로 CSS cascade 순서 관리 |
| Low | `@property`로 CSS 커스텀 속성 등록 |
| Low | CSS subgrid로 중첩 그리드 정렬 |
| Low | `oklch()`·`oklab()` 색상 팔레트 |

---

## JavaScript (26)

| 우선순위 | 항목 |
|---------|------|
| Critical | `eval()` 또는 안전하지 않은 동적 코드 사용 금지 |
| High | 인라인 JavaScript 지양 |
| High | TypeScript strict 모드 활성화 |
| High | 이벤트 핸들러 debounce·throttle |
| High | cross-origin 요청 보안 처리 |
| High | 적절한 에러 핸들링 구현 |
| High | 모든 JS 파일 최소화(minify) |
| High | DOM 읽기/쓰기 비용 최소화 |
| High | 메모리 누수 패턴 방지 |
| High | 대형 JS 번들 분할 |
| High | ES 모듈 (`import`/`export`) 사용 |
| High | `const`·`let` 사용 (`var` 지양) |
| High | 외부 데이터 스키마 라이브러리로 유효성 검사 |
| Medium | TypeScript `any` 타입 지양 |
| Medium | `noUncheckedIndexedAccess` 활성화 |
| Medium | JSON 안전하게 파싱 (try/catch) |
| Medium | 현대적 배열·객체 메서드 사용 |
| Medium | Web Storage API 안전하게 사용 |
| Medium | 이벤트 위임으로 동적 콘텐츠 처리 |
| Medium | 암묵적 타입 강제 지양 |
| Medium | 불변 데이터 패턴 선호 |
| Medium | 프로덕션에서 console 문 제거 |
| Medium | i18n 친화적 번역 문자열 작성 |

---

## Performance (43) — 핵심만

| 우선순위 | 항목 |
|---------|------|
| Critical | LCP(Largest Contentful Paint) 최적화 |
| High | 브라우저 캐싱 활성화 |
| High | HTTP/2 또는 HTTP/3 활성화 |
| High | 텍스트 압축(gzip/brotli) 활성화 |
| High | 오프스크린 콘텐츠 lazy loading |
| High | 렌더 차단 리소스 제거 |
| High | CLS(Cumulative Layout Shift) 최소화 |
| High | INP(Interaction to Next Paint) 최적화 |
| High | FCP(First Contentful Paint) 최적화 |
| High | 웹폰트 로딩 최적화 |
| High | CDN 사용 |
| High | 페이지 로드 3초 이내 |
| High | 페이지 무게 1500KB 이하 |
| High | 최소 HTTP 요청 |
| High | 로딩 인디케이터 표시 |
| High | 긴 목록·테이블 가상화(virtualize) |
| High | 서드파티 스크립트 로딩 최적화 |
| Medium | 불필요한 JS 라이브러리 제거 |
| Medium | JS 번들 크기 최적화 |
| Medium | GIF 대신 video 사용 |
| Medium | DOM 크기·복잡도 감소 |
| Medium | back/forward 캐시(bfcache) 최적화 |
| Medium | WebPageTest로 성능 분석 |

---

## Accessibility (95) — Critical·High 위주

| 우선순위 | 항목 |
|---------|------|
| Critical | 폼 컨트롤에 레이블 연결 |
| Critical | `aria-hidden` 문서 body에 사용 금지 |
| Critical | 모든 요소 키보드 탐색 가능 |
| Critical | 모든 입력 필드 접근 가능한 이름 보유 |
| Critical | 버튼에 접근 가능한 이름 제공 |
| Critical | 이미지 버튼에 alt 텍스트 제공 |
| Critical | 발작 유발 플래싱 방지 |
| Critical | 400% 줌에서 콘텐츠 리플로우 지원 |
| Critical | 논리적 heading 계층 사용 |
| High | ARIA live regions로 동적 콘텐츠 알림 |
| High | 자동재생 미디어 지양 |
| High | 불필요한 입력 반복 방지 |
| High | 유효한 ARIA 속성 사용 |
| High | ARIA roles 필수 자식 요소 포함 |
| High | CSS 없이 콘텐츠 사용 가능 |
| High | 논리적 포커스 순서 유지 |
| High | skip 네비게이션 링크 포함 |
| High | 포커스 요소 가려지지 않게 유지 |
| High | 모달 다이얼로그 키보드 접근성 |
| High | 알림(notification) 접근성 |
| High | 최소 색상 대비율 충족 (4.5:1) |
| High | 세션 타임아웃 데이터 손실 방지 |
| High | 접근 가능한 인증 방법 제공 |
| High | 200% 텍스트 크기 조정 지원 |
| High | 스크린 리더로 테스트 |
| High | 설명적 링크 텍스트 사용 |
| High | 포커스 관리 (동적 인터랙션) |
| High | 감소된 모션 선호 존중 |
| High | 세로·가로 방향 모두 지원 |

---

## SEO (94) — High 위주

| 우선순위 | 항목 |
|---------|------|
| High | 구조화 데이터 마크업 추가 (JSON-LD) |
| High | XML 사이트맵 생성·제출 |
| High | robots.txt 파일 발행 |
| High | 페이지 제목 고유하게 유지 |
| High | 메타 설명 작성 |
| High | 설명적 페이지 제목 작성 |
| High | 모든 페이지 canonical URL 설정 |
| High | Article 구조화 데이터 구현 |
| High | robots 메타 디렉티브 올바르게 설정 |
| High | 우수한 콘텐츠 발행 |
| High | 내부 broken links 수정 |
| High | YMYL 콘텐츠 식별 |
| High | 다중 홉 redirect chain 지양 |
| High | XML 사이트맵 유효성 유지 |
| Medium | Open Graph 태그 추가 |
| Medium | Twitter Card 메타 태그 추가 |
| Medium | BreadcrumbList 스키마 구현 |
| Medium | URL에 키워드 포함 |
| Medium | URL 소문자 사용 |
| Medium | URL에 하이픈 사용 |
| Medium | 단일 설명적 H1 사용 |
| Medium | llms.txt 발행 (LLM용 문서) |

---

## Security (22)

| 우선순위 | 항목 |
|---------|------|
| Critical | 환경 변수 노출 금지 |
| Critical | HTTP → HTTPS 리다이렉트 |
| Critical | 모든 페이지 HTTPS 제공 |
| Critical | HTTPS로 폼 전송 |
| High | 취약점 의존성 감사 |
| High | HTTPS 페이지에서 혼합 콘텐츠 방지 |
| High | Content Security Policy 구현 |
| High | 프로덕션에서 스택 트레이스 노출 방지 |
| High | HSTS 헤더 설정 |
| High | X-Frame-Options 헤더 설정 |
| High | 쿠키에 Secure·HttpOnly·SameSite 설정 |
| High | X-Content-Type-Options: nosniff 설정 |
| High | 인증 토큰 안전하게 저장 |
| High | 비밀번호 입력 필드 보안 |
| Medium | Referrer-Policy 헤더 설정 |
| Medium | Permissions-Policy 헤더 설정 |
| Medium | CAPTCHA로 공개 폼 보호 |
| Medium | COOP·COEP·CORP 격리 설정 |
| Medium | 외부 링크 보안 (`rel="noopener noreferrer"`) |

---

## 사용법

```
이 페이지를 frontend_checklist 기준으로 감사해줘.
Critical 항목 먼저 확인하고, 실패한 항목 목록과 수정 방법을 알려줘.
```

카테고리별 감사:
```
/checklist html     → HTML 25개 항목
/checklist css      → CSS 32개 항목
/checklist perf     → Performance 핵심 항목
/checklist a11y     → Accessibility 전체
/checklist seo      → SEO 핵심 항목
/checklist security → Security 22개 항목
```
