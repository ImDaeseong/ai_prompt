# 🏗️ MFC 프로젝트 생성 가이드
> ID: PRMT-MFC-GEN-001 | Version: 2.1 | Last Updated: 2026-05-14

> [!IMPORTANT]
> 이 가이드는 [CLAUDE.md](./CLAUDE.md)를 최상위 지침으로 준수합니다. 완전한 빌드 가능 코드를 생성하며, 보안 및 언어 원칙을 따릅니다.

## 📋 핵심 목표
사용자 명세를 기반으로 Visual Studio에서 즉시 빌드 가능한 완전한 MFC Windows 애플리케이션을 구현한다.

---

## 📌 프로젝트 기본 정보 (필수 입력)

| 항목 | 값 |
|------|----|
| 프로젝트 이름 | [ProjectName] |
| 앱 유형 | Dialog / SDI / MDI 중 선택 |
| Visual Studio 버전 | 2022 / 2019 / 2008 / 6.0 중 선택 |
| 플랫폼 | x86 / x64 중 선택 |
| 문자셋 | Unicode / MBCS 중 선택 |
| MFC 링크 방식 | Static / Dynamic 중 선택 |

---

## 📌 기능 명세 (필수 입력)

### UI 구성
```
메인 윈도우 크기: [W x H] px
타이틀: [제목]
컨트롤 목록:
  - [컨트롤 종류] [ID명] : [역할]
  - [컨트롤 종류] [ID명] : [역할]
메뉴: [메뉴 항목] (없으면 "없음")
툴바/상태바: 있음 / 없음
```

### 핵심 기능
```
- [기능 1]
- [기능 2]
- [기능 3]
```

### 사용 모듈 (해당 항목만 남기고 나머지 삭제)
```
- [ ] DB 연동    → 종류: SQLite / ODBC | 테이블: [구조]
- [ ] 소켓 통신  → 종류: TCP / UDP | 역할: 서버 / 클라이언트 | IP/Port: [값]
- [ ] 파일 I/O   → 형식: TXT / CSV / INI / BIN | 경로: [경로]
- [ ] 커스텀 GDI → 종류: [게이지/차트/LED 등] | 더블버퍼링: 있음 / 없음
- [ ] 멀티스레드 → 목적: [설명] | 동기화: CCriticalSection / Event
- [ ] 레지스트리 → 키 경로: [경로] | 읽기/쓰기 항목: [항목]
```

### 특수 제약 조건
```
- [없으면 "없음"]
```

---

## ⚠️ 절대 규칙

### 공통 금지
- ❌ 부분 구현 / 의사코드 / TODO / 생략(...) 금지
- ❌ 명시되지 않은 외부 라이브러리 사용 금지
- ❌ .NET / CLR 혼용 금지 (순수 Native MFC)
- ❌ 리소스 ID 중복 정의 금지 (resource.h 단일 관리)
- ❌ 명시된 프로젝트 구조 밖의 불필요한 폴더 생성 금지
- ❌ 기존 파일 삭제 금지

### VS 버전별 문법 제한
- VS 2008 / 6.0 선택 시: C++03 기준 (auto, nullptr, lambda, range-for 금지 / NULL 사용)
- VS 2019 / 2022 선택 시: C++14 이상 허용

### MFC 필수 준수
- ✅ DECLARE_MESSAGE_MAP() / BEGIN_MESSAGE_MAP() / END_MESSAGE_MAP() 쌍 완전 구현
- ✅ CWinApp 파생 클래스를 진입점으로 사용
- ✅ 모든 리소스는 resource.rc + resource.h 로만 관리
- ✅ stdafx.h (VS2008/6.0) 또는 pch.h (VS2019/2022) 반드시 포함
- ✅ DB / 소켓 / 파일 / GDI 각 모듈은 독립 클래스로 분리 구현

---

## 📁 프로젝트 파일 구조

### Dialog 기반
```
[ProjectName]/
├── [ProjectName].vcxproj / .vcproj   ← VS 버전에 따라
├── stdafx.h / stdafx.cpp             ← PCH (VS2008) 또는 pch.h/pch.cpp (VS2019+)
├── resource.h                        ← 리소스 ID 전체 정의 (단일)
├── [ProjectName].rc                  ← 리소스 스크립트
├── [ProjectName].h / .cpp            ← CWinApp 파생
├── [MainDlg].h / .cpp                ← 메인 다이얼로그
├── [SubDlg].h / .cpp                 ← 서브 다이얼로그 (필요 시)
├── [Module].h / .cpp                 ← 기능 모듈 (DB/소켓/파일/GDI 등)
└── res/
    └── [ProjectName].ico
```

### SDI 기반
```
[ProjectName]/
├── [ProjectName].vcxproj / .vcproj
├── stdafx.h / stdafx.cpp (또는 pch.h / pch.cpp)
├── resource.h
├── [ProjectName].rc
├── [ProjectName].h / .cpp            ← CWinApp 파생
├── MainFrm.h / MainFrm.cpp           ← CMainFrame
├── [ProjectName]Doc.h / .cpp         ← CDocument 파생
├── [ProjectName]View.h / .cpp        ← CView 파생
├── [SubDlg].h / .cpp                 ← 서브 다이얼로그 (필요 시)
├── [Module].h / .cpp                 ← 기능 모듈
└── res/
    └── [ProjectName].ico
```

### MDI 기반
```
[ProjectName]/
├── [ProjectName].vcxproj / .vcproj
├── stdafx.h / stdafx.cpp (또는 pch.h / pch.cpp)
├── resource.h
├── [ProjectName].rc
├── [ProjectName].h / .cpp            ← CWinApp 파생
├── MainFrm.h / MainFrm.cpp           ← CMDIFrameWnd 파생
├── ChildFrm.h / ChildFrm.cpp         ← CMDIChildWnd 파생
├── [ProjectName]Doc.h / .cpp         ← CDocument 파생
├── [ProjectName]View.h / .cpp        ← CView 파생
├── [Module].h / .cpp                 ← 기능 모듈
└── res/
    └── [ProjectName].ico
```
※ 명시된 구조 외 파일/폴더 생성 금지

---

## 📋 PHASE 1: 계획 수립 (반드시 출력)

아래 항목을 모두 출력하라:

**1. 생성 파일 목록** — 파일명 / 클래스명 / 역할 표로 출력

**2. 리소스 ID 전체 목록**
```
IDD_XXX   : 다이얼로그 ID  (100번대)
IDR_XXX   : 메뉴/툴바 ID  (200번대)
IDC_XXX   : 컨트롤 ID     (1000번대)
IDS_XXX   : 문자열 ID     (2000번대)
IDI_XXX   : 아이콘 ID     (3000번대)
IDB_XXX   : 비트맵 ID     (3100번대)
WM_USER+N : 사용자 메시지 (필요 시)
```

**3. 메시지 맵 계획** — 매크로 / ID / 핸들러 함수 / 설명 표로 출력

**4. 작업 순서 (의존성)**
```
① resource.h → ② .rc → ③ stdafx.h → ④ 모듈 헤더(.h) → ⑤ 모듈 구현(.cpp)
→ ⑥ 다이얼로그/View 헤더 → ⑦ 다이얼로그/View 구현 → ⑧ CWinApp → ⑨ .vcxproj
```

**5. 빌드 명령**
```batch
:: VS2022 / VS2019
msbuild [ProjectName].vcxproj /p:Configuration=Release /p:Platform=x64

:: VS2008
devenv [ProjectName].vcproj /build "Release|Win32"

:: VS6.0
msdev [ProjectName].dsp /make "[ProjectName] - Win32 Release"
```

---

## ✅ PHASE 2: 구현

- 파일 단위로 구분 출력: `// ========== [파일명] ==========`
- 출력 순서: resource.h → .rc → stdafx.h → 모듈(.h/.cpp) → Dialog/View(.h/.cpp) → CWinApp → .vcxproj
- 모든 파일 완전 코드 작성 (누락 금지)
- 리소스 ID는 resource.h에서만 정의, 나머지 파일은 참조만

---

## 🔍 PHASE 3: 검증 (반드시 출력)

### 코드 검증
- [ ] 리소스 ID 중복 없음 (resource.h 단일 정의 확인)
- [ ] DECLARE / BEGIN / END_MESSAGE_MAP() 쌍 완전 여부
- [ ] 모든 핸들러 .h 선언 + .cpp 구현 완료
- [ ] InitInstance / OnInitDialog 반환값 정확 (TRUE / FALSE)
- [ ] VS 버전 문법 제한 준수 (C++03 or C++14)
- [ ] 금지된 외부 라이브러리 미사용

### 빌드 검증
- [ ] .vcxproj / .vcproj MFC 설정 정확
  - UseOfMfc: Static / Dynamic
  - CharacterSet: Unicode / MultiByte
  - PlatformToolset: v143(2022) / v142(2019) / v90(2008) / v60(6.0)
- [ ] 링크 오류 없음 (MFC + 추가 lib 설정 확인)
- [ ] 리소스 컴파일 오류 없음 (.rc 인코딩 ANSI 확인)

### 기능 검증
- [ ] 윈도우/다이얼로그 정상 표시
- [ ] 모든 버튼/메뉴 이벤트 정상 동작
- [ ] 각 모듈 (DB/소켓/파일/GDI) 정상 동작
- [ ] 종료 시 리소스/소켓/DB 연결 해제 정상

### 예외 처리 검증
- [ ] NULL 포인터 / INVALID_HANDLE_VALUE 체크
- [ ] 파일/DB/소켓 연결 실패 처리
- [ ] CString / TCHAR 버퍼 오버플로우 방지
- [ ] 스레드 종료 시 핸들 정리

---

## 🚨 오류 발생 시 대응 규칙

| 오류 유형 | 대응 방법 |
|-----------|-----------|
| 리소스 ID 중복 | resource.h 재정의, .rc 참조만 유지 |
| LNK 오류 (afxwin) | .vcxproj UseOfMfc 설정 확인 |
| C2440 / C2664 타입 오류 | TCHAR / wchar_t / char 캐스팅 명시 |
| OnInitDialog 미동작 | CDialog::OnInitDialog() 호출 확인 |
| 컨트롤 ID 미인식 | GetDlgItem() NULL 체크 추가 |
| RC 컴파일 오류 | .rc 파일 인코딩 ANSI 저장 확인 |
| 소켓 초기화 실패 | WSAStartup 반환값 체크 |
| DB 연결 실패 | 파일 경로 / DSN 이름 확인 |
| 스레드 크래시 | 공유 변수 CCriticalSection 보호 확인 |

- 누락 파일이 원인이라면 필요한 파일을 새로 생성
- 기존 파일 문제라면 기존 파일 수정으로 해결
- 원인 + 수정 내용 반드시 명시

---

## 🏁 완료 조건

- [ ] Visual Studio 오류 없이 빌드 성공
- [ ] .exe 정상 실행 및 UI 표시
- [ ] 명세된 모든 기능 정상 동작
- [ ] Clean → Rebuild 후에도 동일 동작
- [ ] 명시된 파일 구조 완전 준수

---

지금부터 위 명세를 기반으로 MFC 프로젝트를 완전히 구현하라.
