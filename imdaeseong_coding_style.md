# ImDaeseong Vibe Coding Rules v2

> GitHub: https://github.com/ImDaeseong  
> 대상 언어: C++, C#, Java(Android), Kotlin, Python, Dart(Flutter), Go, JavaScript
> 적용 대상: AI를 이용해 새로 작성하거나 유지보수하는 코드

## 문서 목적

이 문서의 목적은 변수명과 중괄호 모양만 통일하는 것이 아니다.

AI가 생성한 코드를 내가 직접 작성한 코드처럼 쉽게 읽을 수 있고, 6개월 뒤에도 수정하기 쉬운 구조로 만드는 것이 목적이다. 코드 생성 시 **문법 스타일보다 설계와 유지보수 규칙을 우선한다.**

우선순위는 다음과 같다.

1. 동작의 정확성 및 데이터 안전
2. 책임 분리와 명확한 구조
3. 읽기 쉬운 흐름과 구체적인 이름
4. 테스트 및 변경 용이성
5. 보안과 예외 처리
6. 언어별 문법 및 네이밍 취향

규칙이 서로 충돌하면 위 순위가 높은 규칙을 따른다. 기존 프로젝트를 수정할 때는 이 문서를 기계적으로 강요하지 말고, 현재 구조와 일관성을 유지하면서 점진적으로 개선한다.

---

# Part 1. AI 필수 설계 규칙

## 1. 한 클래스는 하나의 책임만 가진다

클래스 이름으로 책임을 한 문장 안에 설명할 수 있어야 한다.

금지:

```text
YoutubeManager
├── 다운로드
├── 응답 파싱
├── DB 저장
├── 파일 저장
└── UI 갱신
```

권장:

```text
YoutubeDownloader   # 영상 다운로드
YoutubeParser       # 응답 데이터 변환
YoutubeDatabase     # 영상 정보 저장 및 조회
YoutubeUploader     # 영상 업로드
```

- `Manager`, `Helper`, `Util`, `Common` 같은 포괄적 이름에 기능을 계속 추가하지 않는다.
- 클래스가 DB, API, 파일, UI 중 둘 이상을 직접 다루면 책임 분리를 검토한다.
- 단순한 기능까지 무조건 클래스로 만들지는 않는다. 상태가 없고 재사용이 불필요하면 작은 함수로 충분하다.
- 클래스를 나누기 위한 클래스, 인터페이스 하나만 가진 불필요한 계층은 만들지 않는다.

## 2. UI와 비즈니스 로직을 분리한다

UI 클래스는 화면 표시, 입력 수집, 이벤트 전달만 담당한다. 저장, 계산, API 호출, 파일 처리 같은 로직은 별도 클래스나 서비스에 둔다.

금지:

```csharp
private void btnSave_Click(object sender, EventArgs e)
{
    // 입력 검증, DB 저장, API 호출, 파일 저장, 메시지 표시를 모두 처리
}
```

권장:

```csharp
private void btnSave_Click(object sender, EventArgs e)
{
    SaveVideo();
}

private void SaveVideo()
{
    VideoInfo videoInfo = ReadVideoInput();
    SaveResult result = m_videoService.SaveVideo(videoInfo);
    ShowSaveResult(result);
}
```

- 이벤트 핸들러는 가능하면 5~10줄 이내로 유지한다.
- UI 컨트롤 값을 비즈니스 계층에 직접 넘기지 않고 명확한 데이터 객체로 변환한다.
- 비즈니스 클래스가 MessageBox, Widget, View, Form 같은 UI 타입을 직접 참조하지 않게 한다.
- UI 스레드와 작업 스레드의 경계를 명확히 한다.

## 3. DB, API, File, UI 경계를 분리한다

외부 시스템마다 변경 이유와 실패 방식이 다르므로 접근 코드를 분리한다.

```text
UI / Entry Point
       ↓
Application Service
       ↓
Domain / Data Model
       ↓
Database | API Client | File Storage
```

- DB 쿼리는 Repository 또는 Database 클래스에 둔다.
- HTTP 요청과 응답 처리는 API Client에 둔다.
- 파일 읽기와 쓰기는 File Storage 또는 구체적인 파일 처리 클래스에 둔다.
- 상위 로직은 구체적인 저장 방식보다 기능 중심 메서드를 호출한다.
- 작은 프로젝트에서는 폴더와 인터페이스를 과도하게 늘리지 말고, 최소한 클래스 책임만 분리한다.

## 4. 함수명만 보고 역할을 알 수 있어야 한다

함수명은 `동사 + 대상` 형태로 구체적으로 작성한다.

선호:

```text
download_video()
parse_video_response()
save_video_info()
load_settings()
create_video_table()
validate_login_input()
```

지양:

```text
run()
process()
execute()
work()
handle()
do_task()
```

`run`, `process`, `execute`는 진입점, 프레임워크 규약, 실행 흐름 전체를 대표하는 경우에만 허용한다. 이름이 길어지더라도 역할을 정확히 드러내는 이름을 우선한다.

## 5. 함수는 한 가지 작업만 수행한다

- 함수는 하나의 추상화 수준을 유지한다.
- 50줄을 넘으면 분리를 검토한다. 줄 수는 강제 기준이 아니라 책임 혼합을 찾기 위한 경고 기준이다.
- DB, API, 파일, UI 처리가 한 함수에 함께 있으면 반드시 분리를 검토한다.
- 긴 함수 안의 의미 있는 작업은 구체적인 이름의 함수로 추출한다.
- 단순히 줄 수를 줄이기 위해 의미 없는 `step1()`, `step2()` 함수로 나누지 않는다.

권장:

```python
def synchronize_video(s_url: str) -> VideoInfo:
    response = download_video_metadata(s_url)
    video_info = parse_video_metadata(response)
    save_video_info(video_info)
    return video_info
```

## 6. main은 오케스트레이션만 담당한다

`main.py`, `main.go`, `Program.cs`와 앱 진입점은 다음 작업만 담당한다.

1. 설정 로드
2. 의존 객체 생성 및 연결
3. 애플리케이션 실행
4. 최상위 오류 기록 및 정상 종료

진입점에 비즈니스 규칙, SQL, HTTP 요청, 파일 파싱을 작성하지 않는다.

```python
def main() -> None:
    settings = load_settings()
    database = YoutubeDatabase(settings.database_path)
    downloader = YoutubeDownloader(settings.download_path)
    application = YoutubeApplication(database, downloader)
    application.start()


if __name__ == "__main__":
    main()
```

## 7. 데이터 구조를 명확히 정의한다

필드 의미가 정해진 데이터는 Dictionary, Map, Tuple로 전달하지 않는다.

금지:

```python
return {
    "title": title,
    "url": s_url,
    "count": n_count,
}
```

권장:

```python
from dataclasses import dataclass


@dataclass
class VideoInfo:
    title: str
    url: str
    count: int
```

언어별 권장 타입:

| 언어 | 데이터 타입 |
|---|---|
| Python | `dataclass` |
| C# | 목적이 분명한 class 또는 record |
| Java/Kotlin | DTO 또는 data class |
| Go | struct |
| Dart | 명시적인 model class |
| C++ | 값 객체 class 또는 struct |

Dictionary와 Map은 키가 동적이거나 외부 JSON을 파싱하는 경계에서만 사용한다. 경계를 통과한 뒤에는 명시적인 데이터 타입으로 변환한다.

## 8. 의존성과 상태를 명시적으로 관리한다

- 전역 변수는 최소화한다.
- 변경 가능한 전역 상태는 사용하지 않는다.
- 설정값은 설정 객체로 모아 전달한다.
- 클래스가 필요한 DB, API Client, File Storage는 생성자에서 받는 방식을 우선한다.
- 숨겨진 싱글톤 접근보다 객체의 의존 관계가 코드에 보이도록 작성한다.
- 테스트에서 교체해야 하는 외부 의존성은 주입 가능하게 만든다.

레거시 프레임워크 때문에 전역 변수나 싱글톤이 필요한 경우 사용 범위와 변경 위치를 제한한다.

## 9. 오류는 숨기지 말고 의미 있는 위치에서 처리한다

오류는 복구하거나 사용자에게 의미를 추가할 수 있는 계층에서 처리한다.

- 조건 실패는 Early Return으로 빠르게 종료한다.
- 빈 `catch` 또는 원인을 버리는 예외 처리를 금지한다.
- 예외를 기록한 뒤 계속 진행해도 데이터가 안전한지 확인한다.
- 하위 계층은 원인과 작업 정보를 포함해 오류를 반환하거나 다시 발생시킨다.
- 최상위 계층은 사용자 메시지, 종료, 재시도 여부를 결정한다.
- 로그에는 작업 대상과 실패 원인을 포함하되 비밀번호, 토큰, 개인정보는 남기지 않는다.

```python
def load_video_info(file_path: str) -> VideoInfo:
    if not file_path:
        raise ValueError("영상 정보 파일 경로가 비어 있습니다.")

    try:
        return read_video_info(file_path)
    except OSError as ex:
        logger.error(f"영상 정보 파일 읽기 실패 | 경로={file_path} | 오류={ex}")
        raise
```

## 10. 중복 코드를 발견하면 통합한다

- 동일하거나 거의 같은 로직이 2회 이상 등장하면 공통화 여부를 검토한다.
- 문자열만 조금 다른 복사 코드는 파라미터로 통합한다.
- 중복 제거로 호출 관계가 더 어려워진다면 억지로 추상화하지 않는다.
- AI가 방금 생성한 코드도 예외 없이 중복 여부를 확인한다.
- 기존 공통 함수가 있으면 새 함수를 만들기 전에 재사용 가능성을 확인한다.

## 11. 변경 범위를 작고 명확하게 유지한다

- 요청한 기능과 관련 없는 파일을 함께 리팩터링하지 않는다.
- 기존 공개 API와 데이터 형식을 바꿀 때는 영향 범위를 먼저 확인한다.
- 새 기능은 기존 동작을 깨지 않는 작은 단위로 구현한다.
- 임시 호환 코드에는 제거 조건을 주석이나 이슈로 남긴다.
- 현재 프로젝트의 구조가 합리적이면 새 아키텍처를 강제로 도입하지 않는다.

## 12. 유지보수성과 정확성을 우선한다

- 미세한 성능 향상보다 읽고 수정하기 쉬운 코드를 우선한다.
- 단, 데이터 손실, 보안, 심각한 성능 저하는 단순성보다 먼저 해결한다.
- 복잡한 한 줄 표현보다 단계가 드러나는 코드를 선호한다.
- 주석으로 복잡한 코드를 설명하기 전에 코드를 단순하게 만든다.
- 주석은 "무엇"보다 이유, 제약, 주의점을 설명한다.

---

# Part 2. AI 작업 절차

## 새 기능 구현 전

AI는 단순하지 않은 기능을 바로 작성하지 말고 다음 항목을 짧게 정리한 후 구현한다.

1. 변경 목적과 기존 동작
2. 필요한 클래스와 각 책임
3. 입력 및 출력 데이터 타입
4. DB, API, File, UI 경계
5. 오류 처리 방식
6. 수정할 파일과 테스트 범위

작은 버그 수정이나 단일 함수 변경은 불필요한 설계 문서를 만들지 않고 바로 수정할 수 있다.

## 구현 순서

1. 관련 기존 코드와 테스트를 먼저 읽는다.
2. 기존에 재사용할 클래스와 함수가 있는지 찾는다.
3. 데이터 모델과 책임 경계를 정한다.
4. 최소 변경으로 기능을 구현한다.
5. 예외 처리와 로그를 추가한다.
6. 테스트 또는 재현 절차로 검증한다.
7. 중복 코드와 불필요한 복잡성을 마지막으로 확인한다.

## AI 응답 규칙

- 큰 변경은 구현 전에 파일별 역할을 간단히 알린다.
- 구현 후 변경 파일, 핵심 동작, 검증 결과를 요약한다.
- 실행하지 못한 테스트가 있으면 숨기지 않고 명시한다.
- 확실하지 않은 요구사항을 임의로 크게 확대하지 않는다.
- 라이브러리나 프레임워크를 추가하기 전에 기존 도구로 해결 가능한지 확인한다.

---

# Part 3. 프로젝트 구조 원칙

프로젝트 규모에 맞는 가장 단순한 구조를 사용한다.

## 소규모 프로젝트

```text
project/
├── README.md
├── main.py
├── settings.py
├── models.py
├── youtube_downloader.py
├── youtube_database.py
├── requirements.txt
├── .env.example
└── run_local.bat
```

## 기능이 커진 프로젝트

```text
project/
├── README.md
├── main.py
├── config/
│   └── settings.py
├── models/
│   └── video_info.py
├── services/
│   └── youtube_service.py
├── infrastructure/
│   ├── youtube_api_client.py
│   ├── youtube_database.py
│   └── video_file_storage.py
├── ui/
│   └── main_window.py
└── tests/
```

- 폴더는 기술 이름보다 역할이 드러나게 구성한다.
- 파일은 기본적으로 대표 클래스 하나를 가진다.
- 작은 DTO, enum, 해당 클래스 전용 보조 타입은 같은 파일에 둘 수 있다.
- 순환 참조가 생기면 책임과 의존 방향을 다시 검토한다.
- `common`, `utils`, `helpers` 폴더를 잡다한 코드 보관소로 사용하지 않는다.

---

# Part 4. 공통 코딩 스타일

## 이름

- 클래스명은 역할을 나타내는 명사로 작성한다.
- 함수명은 구체적인 동사와 대상으로 작성한다.
- Boolean 이름은 상태나 조건이 드러나게 작성한다.
- 의미 없는 번호 이름(`data1`, `temp2`, `button3`)은 UI 디자이너 생성 코드 외에는 지양한다.
- 약어는 프로젝트에서 널리 쓰이고 의미가 명확할 때만 사용한다.

헝가리안 표기법은 개인 코드 인지성을 위한 보조 규칙일 뿐, 책임 분리보다 우선하지 않는다.

| 접두사 | 타입 | 주 적용 언어 | 예시 |
|---|---|---|---|
| `s` | String / string | 기존 프로젝트에서 사용하는 언어 | `sUrl`, `sPath` |
| `n` | int / Integer | C++, C#, Java, Kotlin, Dart | `nCount`, `nIndex` |
| `b` | bool / Boolean | C++, C#, Java, Kotlin, Dart | `bConnected`, `bLoading` |
| `f` | float | C++, C# | `fVolume`, `fRate` |
| `m_` | 멤버 변수 | C++, C# | `m_strPath`, `m_nCount` |

신규 코드에서는 언어 표준과 기존 프로젝트 규칙을 함께 고려한다. 타입 접두사 때문에 이름의 의미가 약해지면 `sValue`보다 `video_title` 또는 `strVideoTitle`처럼 역할이 드러나는 이름을 사용한다.

## 주석과 로그

- 직접 작성하는 주석과 사용자 대상 로그는 한국어를 기본으로 한다.
- 라이브러리 규약, 공개 API, 협업 환경에서 영어가 필요한 경우 영어를 허용한다.
- 코드로 알 수 있는 내용을 그대로 설명하는 주석은 작성하지 않는다.
- 로그는 `작업 | 대상=값 | 결과=값`처럼 검색하기 쉬운 형식을 선호한다.
- 오류 로그에는 작업, 대상, 원인을 포함한다.

```python
logger.info(f"영상 정보 저장 완료 | 영상ID={video_info.video_id}")
logger.error(f"영상 다운로드 실패 | URL={s_url} | 오류={ex}")
```

## 설정과 비밀정보

- API 키, 토큰, 비밀번호는 코드에 하드코딩하지 않는다.
- 비밀정보는 환경변수 또는 플랫폼의 보안 저장소에서 읽는다.
- `.env`는 로컬 개발용으로만 사용하고 Git에 커밋하지 않는다.
- `.env.example`에는 키 이름과 안전한 예시만 제공한다.
- URL, 타임아웃, 경로도 환경별로 달라지면 설정 객체로 이동한다.

## 테스트

- 버그 수정 시 가능하면 실패를 재현하는 테스트를 먼저 추가한다.
- 비즈니스 로직은 UI 없이 테스트 가능해야 한다.
- DB, API, 파일 경계는 실제 연동 테스트 또는 교체 가능한 테스트 대역으로 검증한다.
- 정상 경로뿐 아니라 빈 값, 잘못된 값, 타임아웃, 외부 시스템 실패를 확인한다.
- 테스트 이름은 조건과 기대 결과가 드러나게 작성한다.

---

# Part 5. 금지 및 지양 패턴

## 금지

- 하나의 클래스에 UI, DB, API, 파일 처리를 모두 구현
- UI 이벤트 핸들러 안에 비즈니스 로직 직접 구현
- 빈 `catch` 또는 예외를 기록 없이 무시
- API 키, 토큰, 비밀번호 하드코딩
- 의미가 고정된 데이터를 Dictionary 또는 Map으로 계속 전달
- 변경 가능한 전역 상태 남용
- 기존 공통 기능을 확인하지 않은 복사 및 붙여넣기
- 테스트나 확인 없이 "완료"라고 보고

## 지양

- `Manager`, `Helper`, `Util`, `Common`에 기능 집중
- 의미 없는 `run`, `process`, `execute`, `handle` 함수명
- 50줄 이상의 다중 책임 함수
- 호출 위치가 한 곳뿐인 과도한 인터페이스와 추상화
- 소규모 프로젝트에 대규모 아키텍처 강제 적용
- 사용하지 않는 import, 의존성, 설정 파일 유지
- 주석으로만 보완된 복잡한 코드

---

# Appendix A. 언어별 스타일 가이드

아래 규칙은 Part 1의 설계 규칙보다 우선하지 않는다. 신규 프로젝트에서는 언어 표준과 최신 안전 관례를 기본으로 하고, 기존 프로젝트 수정 시 해당 프로젝트 스타일을 유지한다.

## C++

- 클래스와 함수는 `PascalCase`를 사용한다.
- MFC 클래스는 프레임워크 관례에 따라 `C` 접두사를 허용한다.
- Allman 중괄호 스타일을 사용한다.
- 헤더는 `#pragma once`를 사용하고 구현은 `.cpp`로 분리한다.
- Win32/MFC 코드에서는 `CString`, `DWORD`, `HANDLE` 등의 기존 접두사 관례를 유지할 수 있다.
- 자원은 RAII를 기본으로 관리한다. 기존 수동 `new/delete` 코드를 수정할 때는 소유권과 해제 위치를 명확히 한다.
- 새 코드에서는 가능한 경우 표준 컨테이너와 스마트 포인터를 사용한다.
- Win32 API 반환값은 API 규약에 맞게 명시적으로 확인한다.

```cpp
class YoutubeDownloader
{
public:
    DownloadResult DownloadVideo(const CString& strUrl);
};
```

## C#

- 클래스와 메서드는 `PascalCase`를 사용한다.
- WinForms 이벤트 핸들러는 `컨트롤명_이벤트명` 형식을 유지한다.
- Allman 중괄호 스타일을 사용한다.
- 기존 프로젝트가 `m_`, `str`, `n`, `b` 접두사를 사용하면 일관되게 유지한다.
- 신규 데이터 모델은 의미 있는 class 또는 record로 정의한다.
- 속성은 캡슐화가 필요한 공개 데이터에 사용하고, 내부 상태는 private 필드로 둔다.
- 싱글톤은 전역 접근이 반드시 필요한 경우에만 사용한다.
- 빈 `catch`는 허용하지 않는다.

```csharp
private void btnSave_Click(object sender, EventArgs e)
{
    SaveVideo();
}
```

## Java / Android

- 클래스는 `PascalCase`, 메서드는 `camelCase`를 사용한다.
- Activity, Fragment 등 Android 구성 요소는 역할 suffix를 사용한다.
- K&R 중괄호 스타일을 사용한다.
- UI 이벤트에서는 서비스 메서드만 호출한다.
- DTO는 명시적인 클래스로 작성한다.
- 신규 프로젝트는 현재 프로젝트가 사용하는 ViewBinding, Compose, `findViewById` 방식 중 기존 방식을 따른다.
- 로그 레벨은 의미에 맞게 사용하고 오류는 원인 예외를 함께 기록한다.
- 스트림과 자원은 try-with-resources로 정리한다.

## Kotlin

- 클래스는 `PascalCase`, 함수와 변수는 `camelCase`를 사용한다.
- 클래스 이름을 소문자로 시작하지 않는다.
- 비동기는 Coroutine과 구조화된 동시성을 우선한다.
- 데이터 전달에는 `data class`를 사용한다.
- Android UI 접근 방식은 기존 프로젝트의 ViewBinding, Compose, `findViewById` 규칙을 따른다.
- nullable 처리는 `let`, Early Return, 명시적 기본값을 상황에 맞게 사용한다.
- 임의의 `CoroutineScope`를 만들기보다 생명주기에 맞는 scope를 사용한다.

## Python

- 클래스는 `PascalCase`, 함수와 변수는 `snake_case`를 사용한다.
- 신규 서비스, 봇, 자동화 프로젝트는 타입 힌트를 사용한다.
- 데이터 전달에는 `dataclass`를 적극 사용한다.
- 신규 프로젝트 로깅은 `loguru`를 기본으로 한다.
- 작은 일회성 분석 스크립트는 `print()`를 허용한다.
- `main.py`는 오케스트레이션만 담당한다.
- 모든 실행형 파일은 `if __name__ == "__main__":` 가드를 둔다.
- Windows 중심 Python 프로젝트는 필요할 때 `run_local.bat`을 제공한다.

```python
@dataclass
class VideoInfo:
    video_id: str
    title: str
    url: str


class YoutubeDatabase:
    def save_video_info(self, video_info: VideoInfo) -> None:
        ...
```

## Dart / Flutter

- 클래스는 `PascalCase`, 변수와 함수는 `camelCase`를 사용한다.
- 화면 클래스는 필요할 때 `Screen` suffix를 사용한다.
- UI 위젯은 표시와 이벤트 전달에 집중한다.
- 네트워크, 저장, 데이터 변환은 별도 서비스 및 모델로 분리한다.
- 단순한 지역 상태는 `setState()`를 사용해도 된다.
- 상태 공유와 화면 간 의존성이 커지면 프로젝트의 기존 상태관리 방식을 따른다.
- 네트워크 요청에는 명시적인 타임아웃과 오류 처리를 둔다.
- 사용하지 않는 import는 추가하지 않는다.

## Go

- Go 표준 네이밍과 `gofmt`를 따른다.
- 문자열이라는 이유만으로 모든 변수에 `s` 접두사를 강제하지 않는다.
- 함수명은 `downloadVideo`처럼 역할을 구체적으로 표현한다.
- 데이터는 명시적인 struct로 정의한다.
- 오류는 발생 작업의 문맥을 추가해 `%w`로 감싼다.
- `main.go`는 설정, 객체 연결, 실행만 담당한다.

```go
videoInfo, err := client.downloadVideoInfo(sURL)
if err != nil {
    return fmt.Errorf("영상 정보 다운로드 실패: %w", err)
}
```

## JavaScript

- 기존 프로젝트가 TypeScript를 사용하면 타입과 interface를 적극 활용한다.
- API 응답을 그대로 전체 애플리케이션에 전달하지 않고 모델 또는 변환 함수를 둔다.
- UI 컴포넌트와 API 호출, 데이터 변환 로직을 분리한다.
- 함수명은 `loadSettings`, `saveVideoInfo`처럼 역할을 구체적으로 작성한다.
- `any`, 변경 가능한 전역 객체, 깊은 callback 중첩을 지양한다.

---

# Appendix B. 레거시 코드 적용 원칙

과거 코드에서 발견된 스타일이 모두 신규 코드의 권장 규칙은 아니다.

| 레거시 패턴 | 신규 코드 원칙 |
|---|---|
| 빈 `catch` | 오류 기록, 복구 또는 상위 전달 |
| 수동 `new/delete` 강제 | RAII 및 명확한 소유권 우선 |
| 모든 로그를 오류 레벨로 기록 | 상황에 맞는 로그 레벨 사용 |
| 무조건 `findViewById` | 현재 프로젝트의 UI 바인딩 방식 유지 |
| 무조건 `setState()` | 단순 상태는 허용, 복잡하면 기존 상태관리 사용 |
| 모든 문자열에 타입 접두사 | 프로젝트 일관성과 의미 전달을 우선 |
| 1파일 1클래스 절대 적용 | 대표 책임 기준, 밀접한 보조 타입은 허용 |
| `Manager`에 기능 집중 | 구체적인 책임 클래스 분리 |

레거시 코드를 수정할 때는 요청 범위 밖의 전면 개편을 하지 않는다. 새 기능을 추가하는 지점부터 오류 처리, 데이터 타입, 책임 분리를 개선한다.

---

# 최종 체크리스트

코드 작성 또는 수정 후 다음 항목을 확인한다.

- [ ] 클래스마다 책임을 한 문장으로 설명할 수 있는가?
- [ ] UI 이벤트에 비즈니스 로직이 들어가 있지 않은가?
- [ ] DB, API, File, UI 경계가 분리되어 있는가?
- [ ] 함수명이 작업과 대상을 구체적으로 나타내는가?
- [ ] 긴 함수에 여러 책임이 섞여 있지 않은가?
- [ ] main이 오케스트레이션만 담당하는가?
- [ ] Dictionary 대신 명시적인 데이터 타입이 필요한 곳은 없는가?
- [ ] 전역 상태와 싱글톤 사용이 꼭 필요한가?
- [ ] 오류를 숨기거나 원인을 잃지 않는가?
- [ ] 중복 코드가 새로 생기지 않았는가?
- [ ] 비밀정보가 코드와 로그에 포함되지 않았는가?
- [ ] 기존 테스트와 새 동작을 검증했는가?
- [ ] 언어별 문법 취향보다 유지보수성을 우선했는가?
