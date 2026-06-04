# MCP Setup Guide: Creative Writing Tools

이 문서는 외부 MCP(Model Context Protocol) 서버를 사용자님의 AI 클라이언트(Claude Desktop, Cursor, Windsurf 등)에 연결하는 방법을 안내합니다.

## 1. 개요
MCP 서버를 연결하면 AI가 운율 검색, 설정집 조회, AI 음악 서비스 연동 같은 외부 도구를 사용할 수 있습니다. 서버 이름과 패키지는 시간이 지나면 바뀔 수 있으므로 설치 전 공식 문서를 확인하십시오.

> 보안 주의: 아래 JSON의 키 값은 예시입니다. 실제 API 키는 문서에 적지 말고 환경 변수나 비밀 관리 도구로 관리하십시오.

## 2. 추천 MCP 서버 설정

아래 설정 내용을 클라이언트의 MCP 구성 파일(예: `claude_desktop_config.json`)에 추가하세요.

### A. Fiction-Forge (소설 설정 관리)
대규모 소설 프로젝트의 설정을 관리합니다.
```json
"fiction-forge": {
  "command": "npx",
  "args": ["-y", "fiction-forge-mcp"]
}
```

### B. Poetry MCP (가사 및 운율 분석)
정교한 음절 계산과 운율 검색을 지원합니다.
```json
"poetry-mcp": {
  "command": "npx",
  "args": ["-y", "poetry-mcp-server"]
}
```

### C. PiAPI (Suno/Udio 연동)
AI 음악 생성을 직접 명령할 수 있습니다. (API 키 필요)
```json
"piapi": {
  "command": "npx",
  "args": ["-y", "piapi-mcp-server"],
  "env": {
    "PIAPI_KEY": "<set-in-environment>"
  }
}
```

### D. Genius (가사 검색 및 영감)
실제 노래 가사 데이터를 조회합니다.
```json
"genius": {
  "command": "npx",
  "args": ["-y", "mcp-server-genius"],
  "env": {
    "GENIUS_API_ACCESS_TOKEN": "YOUR_ACCESS_TOKEN_HERE"
  }
}
```

### E. Video Gen (Runway & Luma AI 연동)
텍스트/이미지를 고화질 영상으로 변환합니다.
```json
"video-gen": {
  "command": "npx",
  "args": ["-y", "mcp-video-gen"],
  "env": {
    "RUNWAY_API_KEY": "<set-in-environment>",
    "LUMA_API_KEY": "<set-in-environment>"
  }
}
```

### F. ComfyUI (로컬 영상 생성 제어)
로컬 PC의 ComfyUI 워크플로우를 직접 실행합니다.
```json
"comfyui": {
  "command": "npx",
  "args": ["-y", "comfyui-mcp-server"],
  "env": {
    "COMFYUI_BASE_URL": "http://127.0.0.1:8188"
  }
}
```

### G. Prompt Optimizer (프롬프트 최적화)
사용자의 입력을 분석하여 최적의 프롬프트 구조로 변환합니다.
```json
"prompt-optimizer": {
  "command": "npx",
  "args": ["-y", "mcp-prompt-optimizer"]
}
```

### H. Finance (주식 및 경제 데이터)
주가 및 기업 재무 데이터를 가져옵니다.
```json
"finance": {
  "command": "npx",
  "args": ["-y", "mcp-server-alphavantage"],
  "env": {
    "ALPHAVANTAGE_API_KEY": "<set-in-environment>"
  }
}
```

### I. Job Search (채용 정보 검색)
전 세계 채용 공고 및 기업 기술 스택을 검색합니다.
```json
"job-search": {
  "command": "npx",
  "args": ["-y", "@theirstack/mcp-server"],
  "env": {
    "THEIRSTACK_API_KEY": "<set-in-environment>"
  }
}
```

### J. News & Search (뉴스 및 웹 검색)
뉴스 및 웹 정보를 조회합니다.
```json
"web-search": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-brave-search"],
  "env": {
    "BRAVE_SEARCH_API_KEY": "<set-in-environment>"
  }
}
```

### K. Productivity (일정 및 업무 자동화)
Notion, Google Calendar 등을 통해 삶을 시스템화합니다.
```json
"google-calendar": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-google-calendar"]
}
```

### L. Academic & Knowledge (전문 지식 학습)
최신 논문 및 기술 문서를 검색하여 전문성을 높입니다.
```json
"arxiv": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-arxiv"]
}
```

### M. Automation Hub (Zapier 연동)
7,000개 이상의 앱과 연동하여 실제 업무를 수행합니다.
```json
"zapier": {
  "command": "npx",
  "args": ["-y", "@zapier/mcp-server"],
  "env": {
    "ZAPIER_API_KEY": "<set-in-environment>"
  }
}
```

### N. Communication (Slack 연동)
슬랙 메시지 검색 및 채널 포스팅을 수행합니다.
```json
"slack": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-slack"],
  "env": {
    "SLACK_BOT_TOKEN": "YOUR_TOKEN"
  }
}
```

### O. Global Search (Google Search)
구글 검색 엔진의 강력한 데이터를 직접 활용합니다.
```json
"google-search": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-google-search"],
  "env": {
    "GOOGLE_API_KEY": "<set-in-environment>",
    "GOOGLE_CSE_ID": "<set-in-environment>"
  }
}
```

## 3. 설정 파일 위치
- **Claude Desktop:** `%APPDATA%\Claude\claude_desktop_config.json`
- **Cursor:** Settings > Features > MCP 에서 추가 가능

## 4. 설치 및 확인
1. 위 JSON 내용을 설정 파일에 추가하고 저장합니다.
2. 클라이언트를 재시작합니다.
3. 채팅창에 "사용 가능한 도구 목록을 보여줘"라고 입력하여 서버가 정상적으로 연결되었는지 확인합니다.
