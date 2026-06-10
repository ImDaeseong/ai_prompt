# ImDaeseong 코딩 스타일 가이드

> GitHub: https://github.com/ImDaeseong  
> 분석 대상: C++, C#, Java(Android), Kotlin, Python, Dart(Flutter), Go, JavaScript  
> 목적: 바이브 코딩 시 코드 생성 스타일을 이 가이드에 맞게 유지한다.

---

## 전 언어 공통 규칙

### 헝가리안 표기법 (Hungarian Notation)
언어마다 적용 범위가 다르다. 공통으로 적용되는 것은 `s` 접두사(String)뿐이며, 나머지는 언어별 섹션 참고.

| 접두사 | 타입 | 적용 언어 | 예시 |
|--------|------|-----------|------|
| `s` | String / string | **전 언어** | `sUrl`, `sPath`, `sTitle`, `sResult` |
| `n` | int / Integer | C++, C#, Java, Kotlin, Dart | `nCount`, `nIndex`, `nID` |
| `b` | bool / Boolean | C++, C#, Java, Kotlin, Dart | `bConnected`, `bLoading`, `bStop` |
| `f` | float | C++, C# | `fVolume`, `fRate` |
| `m_` | 멤버 변수 | C++, C# | `m_strPath`, `m_nCount`, `m_bRun` |
| `g_` | 전역 변수 | C++ | `g_hLogFile`, `g_bStop` |

> Go는 `s` 접두사(문자열 변수)만 적용. `n`, `b` 접두사는 사용하지 않는다.

### 주석 언어
- 주석은 **한국어**로 작성한다.
- 로그·출력 메시지도 한국어로 작성한다.
- 영어 주석은 자동생성된 것 외에는 사용하지 않는다.

```python
# 데이터 중복 확인
# 기존 데이터 삭제 후 재삽입
```
```cpp
// 로그 파일 경로 설정
// 별도의 스레드 생성
```

### 에러 메시지
에러 메시지는 한국어 `"오류:"` 또는 `"오류 발생:"` 접두사를 사용한다.

```python
except Exception as e:
    print(f"오류 발생: {e}")
    return None
```
```go
return fmt.Errorf("오류: %v", err)
```

### 함수 크기
- 함수 하나는 한 가지 역할만 수행한다.
- 50~80줄을 초과하면 별도 메서드로 분리한다.
- 기능이 달라지면 과감히 쪼갠다.

### 에러 처리 — Early Return
조건 실패 시 즉시 반환한다. 중첩 if를 최소화한다.

```cpp
if (hScm == NULL) return FALSE;
if (hSrv == NULL) { CloseServiceHandle(hScm); return FALSE; }
```

### 파일 구조
- Python, Dart: **1파일 1클래스** 원칙을 기본으로 한다.  
  단, 서로 강하게 연관된 dataclass·보조 타입은 같은 파일에 둘 수 있다.
- C++: 헤더(`.h`) + 구현(`.cpp`) 쌍으로 분리한다.
- 진입점은 항상 `main.py` / `main.go` / `Program.cs`로 통일한다.

### 설정·환경변수
- **API 키, 토큰, 비밀번호** → `.env` 파일 + `python-dotenv`로 관리한다. 코드에 절대 하드코딩하지 않는다.
- URL, 좌표, 기본값, 타임아웃 등 비민감 상수는 코드 내 하드코딩 허용.
- 상수는 클래스 상단 또는 별도 파일에 모은다.

---

## C++ 스타일

### 네이밍
```cpp
// 함수명: PascalCase
BOOL IsInstallService();
void GetChromePath();
void ExecuteChromeBrowser();

// 클래스: PascalCase (MFC는 C 접두사)
class CheckServiceManager { ... };
class CservicetestDlg : public CDialogEx { ... };

// 정적 유틸리티 클래스 선호 — 인스턴스 생성 없이 호출
class IpInfo {
public:
    static CString GetLocalIP();
    static CString GetPublicIP();
};
// 사용: IpInfo::GetLocalIP()
```

### 헝가리안 (C++ 전체 목록)
```cpp
CString strServicePath;     // str = CString/string
DWORD dwSize;               // dw = DWORD
HANDLE hThread;             // h = HANDLE
BOOL bStop;                 // b = BOOL
TCHAR szPath[MAX_PATH];     // sz = null-terminated TCHAR 배열
char chTemp[256];           // ch = char 배열
TCHAR* lpstrName;           // lp = 포인터
SC_HANDLE g_hScm;           // g_ = 전역 변수
UINT_PTR m_timer;           // m_ = 멤버 변수 (드물게)
```

### 헤더 가드
```cpp
#pragma once   // #ifndef 가드 대신 항상 #pragma once
```

### 문자열 리터럴
```cpp
// 모든 문자열 리터럴에 _T() 매크로 사용
_tcscpy_s(szPath, _T("C:\\log.txt"));
lpstrServiceName = _T("DaeSeongService");
```

### 포인터 선언
```cpp
// * 는 변수명 쪽에 붙임 (C 스타일)
TCHAR* buffer = new TCHAR[dwSize];
VS_FIXEDFILEINFO* pInfo;
```

### 메모리 관리
```cpp
TCHAR* buffer = new TCHAR[dwSize];
memset(buffer, 0, dwSize);
// ... 작업 ...
delete[] buffer;
// RAII / 스마트포인터 사용 안 함
```

### 중괄호 스타일
Allman 스타일 기본 (여는 중괄호를 다음 줄에). 단 짧은 if는 같은 줄도 허용.

```cpp
BOOL CheckServiceManager::IsInstallService()
{
    if (hScm == NULL)
        return FALSE;

    if (hSrv == NULL)
    {
        CloseServiceHandle(hScm);
        return FALSE;
    }
    return TRUE;
}
```

### API 비교
```cpp
// == FALSE / == TRUE 명시적 비교 사용
if (QueryServiceStatus(hSrv, &status) == TRUE) { ... }
if (result != FMOD.RESULT.OK) return false;
```

### 로그
```cpp
OutputDebugString(_T("서비스 시작 실패"));
```

---

## C# 스타일

### 네이밍
```csharp
// 클래스: 헝가리안 접두사 사용
class frmMain : Form { ... }         // frm = Form
class clsFmodPlayer { ... }          // cls = 일반 클래스
class MainWindow : Window { ... }    // WPF는 접두사 생략

// 멤버 변수: m_ + 헝가리안
private string m_strCurrentPath = "";
private int m_nIndex = 0;
private float m_fVolume = 0.5f;
private ArrayList m_AryFilelist = new ArrayList();
private bool m_bPlaying = false;

// 메서드: PascalCase
public bool Open(string strFile) { ... }
private void SetFileInfo(string strPath) { ... }
string GetFileExtName(string strFilename) { ... }

// 이벤트 핸들러: 컨트롤명_이벤트명
private void pbPlay_Click(object sender, EventArgs e) { ... }
private void timer1_Tick(object sender, EventArgs e) { ... }

// 파라미터: str 접두사
public bool Open(string strFile)
private void SetFileInfo(string strPath, ArrayList AryFilelist)
```

### 중괄호 스타일
Allman 스타일 (여는 중괄호 새 줄).

```csharp
public bool Open(string strFile)
{
    if (strFile == "") return false;   // 단순 조건은 한 줄
    
    try
    {
        // 처리
    }
    catch (Exception) { }   // 빈 catch 허용
    
    return true;
}
```

### 싱글톤 패턴
```csharp
private static clsFmodPlayer selfInstance = null;

public static clsFmodPlayer getInstance
{
    get
    {
        if (selfInstance == null) selfInstance = new clsFmodPlayer();
        return selfInstance;
    }
}
```

### 프로퍼티 vs 필드
- 일반 멤버는 필드(`private string m_strPath`)로 선언
- auto-property(`{ get; set; }`)는 싱글톤 접근자에만 사용

### using 블록
Visual Studio 자동생성 using 세트를 유지하고 필요한 것을 추가한다.

```csharp
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
// 추가 필요 항목만 아래에
using FMOD;
```

---

## Java (Android) 스타일

### 네이밍
```java
// 클래스: PascalCase + Activity/Fragment suffix
public class Rxjava1Activity extends AppCompatActivity { ... }
public class Fragment1 extends Fragment { ... }

// 멤버 변수: s(String), n(Int), TAG(static)
private static final String TAG = Rxjava1Activity.class.getSimpleName();
private String sUrl = "https://...";
private String sTemp1 = "";
private int nCount = 0;
private ImageView imageView1;        // 컨트롤은 번호 suffix
private Button button1, button2;

// 메서드: camelCase 동사+명사
private void fromCallableImageView() { ... }
private void getBitmapUrl(String sUrl) { ... }
```

### 중괄호 스타일
K&R 스타일 (같은 줄 여는 중괄호).

```java
public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        button1 = (Button) findViewById(R.id.button1);
        button1.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.button1: action1(); break;
            case R.id.button2: action2(); break;
        }
    }
}
```

### 뷰 바인딩
ViewBinding 사용 안 함. `findViewById` + 명시적 캐스트 사용.

```java
button1 = (Button) findViewById(R.id.button1);
imageView1 = (ImageView) findViewById(R.id.imageView1);
```

### 비동기 — RxJava3
```java
Observable.fromCallable(new Callable<Bitmap>() {
    @Override
    public Bitmap call() throws Exception {
        return getBitmapUrl(sUrl);
    }
})
.subscribeOn(Schedulers.io())
.observeOn(AndroidSchedulers.mainThread())
.subscribeWith(new Observer<Bitmap>() {
    @Override public void onSubscribe(@NonNull Disposable d) { }
    @Override public void onNext(@NonNull Bitmap bitmap) {
        imageView1.setImageBitmap(bitmap);
    }
    @Override public void onError(@NonNull Throwable e) { Log.e(TAG, "오류"); }
    @Override public void onComplete() { Log.e(TAG, "작업 완료"); }
});
```

### 로그
```java
// 모든 로그는 Log.e() 단일 레벨 사용 (d/i/w 구분 안 함)
Log.e(TAG, "작업 완료");
Log.e(TAG, "서버 데이터 가져오기 에러");
```

### 에러 처리
```java
try {
    // 처리
} catch (IOException e) {
    e.printStackTrace();
} catch (Exception ex) {
    // 빈 catch 허용
} finally {
    if (inputStream != null) {
        try { inputStream.close(); } catch (IOException e) { e.printStackTrace(); }
    }
}
```

---

## Kotlin 스타일

### 네이밍
```kotlin
// Activity 클래스: PascalCase (소문자 시작도 혼용)
class MainActivity : AppCompatActivity() { ... }
class coroutine1Activity : AppCompatActivity() { ... }  // 소문자 시작 허용

// 멤버 변수: s(String), n(Int), tag(소문자)
private val tag: String = MainActivity::class.java.simpleName
private lateinit var button1: Button
private var sUrl: String = "https://..."
private var nCount: Int = 0
private var bLoading: Boolean = false

// XML onClick 연결 메서드: btn_ 접두사
fun btn_Save(v: View?) { ... }
fun btn_Clear(v: View?) { ... }
```

### companion object
```kotlin
companion object {
    private val tag = Fragment1::class.java.simpleName
}
```

### 중괄호 스타일
K&R 스타일 (Java와 동일).

```kotlin
class MainActivity : AppCompatActivity(), View.OnClickListener {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        
        button1 = findViewById(R.id.button1)
        button1.setOnClickListener(this)
    }

    override fun onClick(v: View) {
        when (v.id) {
            R.id.button1 -> action1()
            R.id.button2 -> action2()
        }
    }
}
```

### 비동기 — Coroutine
```kotlin
// CoroutineScope 사용
CoroutineScope(Dispatchers.IO).launch {
    val bitmap = getBitmapFromUrl(sUrl)
    withContext(Dispatchers.Main) {
        imageView1.setImageBitmap(bitmap)
    }
}

// suspend 함수
private suspend fun getBitmapFromUrl(sUrl: String): Bitmap? {
    return withContext(Dispatchers.IO) {
        // 네트워크 작업
    }
}
```

### Kotlin 이디엄
```kotlin
// apply — 연속 설정
sharedPref.apply {
    setValue(this@MainActivity, "sID", sID)
    setValue(this@MainActivity, "sPassword", sPassword)
}

// let — nullable 처리
alarm?.let { alarmDao.delete(it) }

// data class — Room Entity
@Entity(tableName = "alarms")
data class Alarm(
    @PrimaryKey(autoGenerate = true)
    var id: Int = 0,
    var title: String? = null,
    var content: String? = null
)
```

### 뷰 바인딩
Java와 동일하게 `findViewById` 사용. ViewBinding 사용 안 함.

### 로그
```kotlin
// Java와 동일: Log.e() 단일 레벨
Log.e(tag, "작업 완료")
Log.e(tag, throwable.message.orEmpty())
```

---

## Python 스타일

### 네이밍
```python
# 클래스: PascalCase
class StockDatabase: ...
class StockAnalyzer1: ...

# 메서드: snake_case 기본
# 신규 코드는 snake_case로 통일
def load_data(self, stock_code): ...
def create_table(self): ...
def load_settings() -> Settings: ...

# 구형 코드에 camelCase/PascalCase 잔재가 있음 (유지는 하되 신규 작성 시 지양)
def analyze_Data(self, stock_code): ...   # 구형 패턴
def CollectDataDB(stock_code): ...        # 구형 패턴
def getTotalpages(self): ...              # 구형 패턴

# 변수: snake_case
stock_code, db_name, file_path, end_date
```

### 타입 힌트
프로젝트 성격에 따라 다르다.

**신규 서비스·봇·자동화 프로젝트:** 타입 힌트 적극 사용.
```python
def load_settings() -> Settings: ...
def _get_env(name: str, default: str = "") -> str: ...
async def run(self, stop_event: asyncio.Event) -> None: ...
def list_subscribers(self, platform: Optional[str] = None) -> List[Subscriber]: ...
```

**분석·스크립트 류 (Stock_analysis 등):** 타입 힌트 없이 작성.
```python
def load_data(self, stock_code): ...
def analyze_Data(self, stock_code, window=14): ...
```

### 주석
```python
# 인라인 한국어 주석 사용
df['종가'] = pd.to_numeric(df['종가'].str.replace(',', ''), errors='coerce')
# '종가' 컬럼을 숫자로 변환 (천 단위 구분 기호 제거)

df['날짜'] = pd.to_datetime(df['날짜'])
# '날짜' 컬럼을 날짜 형식으로 변환
```

### Docstring
전반적으로 docstring을 거의 쓰지 않는다. 인라인 한국어 `#` 주석이 지배적 패턴.  
필요한 경우 모듈 수준 함수에만 간략히 작성.

```python
def get_A1(stock_code):
    """
    Buy_Signal 1 이면 매수, Sell_Signal 0/-1 매도, Position 1 이면 변경 감지
    """
```

### 에러 처리
```python
try:
    with open(filename, 'r', encoding='utf-8') as file:
        data = json.load(file)
        return data
except Exception as e:
    print(f"오류 발생: {e}")
    return None
```

### 로깅
**신규 프로젝트:** `loguru` 사용. `logging` 모듈 사용 안 함.  
**간단한 스크립트·분석 코드:** `print()` 기반 허용.

```python
# 신규 프로젝트 (서비스·봇·자동화)
from loguru import logger
logger.info(f"날씨 조회 성공 | 기온={temp}°C | 습도={hum}%")
logger.debug("캐시 사용")
logger.error(f"API 오류: {e}")

# 분석 스크립트 (Stock_analysis 류)
print(f"데이터 수집 중: {stock_code}")
print(f"오류 발생: {e}")
```

로그 메시지에서 수치 구분은 `|` 파이프로 구분한다: `기온={temp}°C | 습도={hum}%`

### 환경변수
```python
from dotenv import load_dotenv
load_dotenv()
API_KEY = os.getenv("API_KEY")
```

### 파일 구성
```python
# 1파일 1클래스
# main.py는 오케스트레이션만 담당

# 항상 가드 포함
if __name__ == '__main__':
    main()
```

### Windows 실행 파일
Python 프로젝트에는 `run_local.bat` 실행 스크립트를 함께 제공한다.

---

## Dart / Flutter 스타일

### 네이밍
```dart
// 클래스: PascalCase + Screen suffix
class Http1Screen extends StatefulWidget { ... }
class MainScreen extends StatelessWidget { ... }

// State 클래스: {WidgetName}State
class Http1ScreenState extends State<Http1Screen> { ... }

// 변수: camelCase + 헝가리안 접두사
bool bConnected = false;
bool bLoading = false;
String sResult = '';
String sResponse = '';
int nCount = 0;

// Widget 반환 메서드: widget 접두사
Widget widgetImage(int index) { ... }
Widget widgetInputField(String label) { ... }
Widget widgetLoadingIndicator() { ... }
Widget widgetButton() { ... }
```

### 파일 구조
```
lib/
├── main.dart          # MaterialApp 설정만
├── MainScreen.dart    # 진입 화면
└── Screen/
    ├── Http1Screen.dart
    ├── Http2Screen.dart
    └── Button1Screen.dart
```

### StatefulWidget vs StatelessWidget
```dart
// 네트워크·상태 변화·스트림이 있으면 StatefulWidget
class Http1Screen extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return Http1ScreenState();
    }
}

// 단순 목록·네비게이션은 StatelessWidget
class MainScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) { ... }
}
```

### 상태관리
`setState()` 직접 사용. Provider / Riverpod / Bloc 사용 안 함.

```dart
setState(() {
    sResult = response.body;
    bLoading = false;
});
```

### 에러 처리
```dart
try {
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
        setState(() { sResult = response.body; });
    } else {
        setState(() { sResult = 'Error: ${response.statusCode}'; });
    }
} catch(ex) {                         // e 아닌 ex 사용
    setState(() { sResult = 'Error: $ex'; });
} finally {
    setState(() { bLoading = false; });
}
```

### 타임아웃
네트워크 요청에는 항상 `timeout(const Duration(seconds: 10))` 설정.

### import 패턴
```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';   // 실제 사용 여부와 무관하게 함께 포함
import 'package:http/http.dart' as http;   // as 별칭 사용
```

### 들여쓰기
2 spaces (Flutter 표준).

---

## Go 스타일

### 네이밍
```go
// 함수: camelCase 또는 PascalCase
func f1() { ... }
func downloadVideo(sUrl string) { ... }

// 변수: s 접두사 (String)
sUrl := "https://..."
sTitle := video.Title
sPath := filepath.Join(dir, sTitle+".mp4")

// 로컬 단축 변수 허용
va := videoAudio
re := regexp.MustCompile(pattern)
```

### 에러 처리
```go
result, err := someFunc()
if err != nil {
    return fmt.Errorf("오류: %v", err)
}
```

### 로그
```go
fmt.Printf("처리 완료: %s - %d\n", sPath, nSize)
fmt.Printf("오류 발생: %v\n", err)
```

---

## 프로젝트 공통 구조

```
프로젝트 루트/
├── README.md                    # 항상 포함 (소규모는 간결하게)
├── main.py / main.go            # 진입점
├── .env                         # 환경변수 (gitignore)
├── requirements.txt / go.mod
├── run_local.bat                # Windows 실행 스크립트 (Python)
└── [기능별 디렉토리]/
    └── [기능].py / [기능].go
```

**멀티 언어 병행 구현:** 동일 기능을 여러 언어로 구현해 나란히 놓는 패턴을 자주 사용한다.

```
encrypt_test/
├── GolangEnc/
├── pythonEnc/
├── mfc_bcrypt/
└── mfc_openssl/
```

---

## 금지 사항 (하지 말 것)

- 영어로 주석 작성 (자동생성 제외)
- Python 신규 서비스에서 `logging` 모듈 사용 → `loguru` 사용
- Kotlin/Dart에서 외부 상태관리 라이브러리 도입 → `setState()` 직접 사용
- Android에서 ViewBinding → `findViewById` 사용
- C++에서 스마트 포인터 → 수동 `new/delete` 사용
- C#에서 auto-property 남용 → 일반 필드 사용
- 함수 하나에 여러 역할 부여
- API 키·토큰·비밀번호를 코드에 하드코딩 → `.env` 파일로 분리

## 신구 코드 패턴 구분

같은 저자의 코드라도 작성 시기에 따라 패턴이 다르다.  
**바이브 코딩(신규 작성) 시에는 신형 패턴을 기준으로 한다.**

| 항목 | 구형 (Stock_analysis 류) | 신형 (weather_alarm 류) |
|------|--------------------------|------------------------|
| Python 로깅 | `print()` | `loguru` |
| Python 타입힌트 | 없음 | 적극 사용 |
| Python 함수명 | camelCase/PascalCase 혼용 | snake_case |
| 1파일 클래스 수 | 1개 | 연관 dataclass 허용 |
| 에러 메시지 | `print(f"오류 발생: {e}")` | `logger.error(f"오류: {e}")` |
