# CLAUDE.md — ai_prompt

이 저장소는 **스킬·프롬프트 라이브러리**다. AI 행동 규칙이나 일지가 아닌 재사용 가능한 프롬프트 자산만 보관한다.

## 이 저장소에 저장하는 것

| 저장 ✅ | 저장하지 않음 ❌ |
|--------|----------------|
| 스킬 파일 (`antigravity_test/skills/*.md`) | MCP 설정 → `hermes-agents/.mcp.json` |
| 프롬프트 템플릿 (`*.md` 루트 또는 프로젝트별) | 일지·위클리 → `ai-workspace/daily-log/` |
| 페르소나·문서 (`antigravity_test/docs/`) | 비즈니스 전략 → `ai-workspace/business/` |
| 코딩 스타일 가이드 | Claude Code 행동 규칙 → `hermes-agents/CLAUDE.md` |
| 이미지·영상 프롬프트 생성기 | API 키·비밀값 |

## 스킬 추가 규칙

1. 파일 위치: `antigravity_test/skills/snake_case.md`
2. 파일 형식:
   ```
   ---
   name: skill-name
   description: 한 줄 설명 (언제 이 스킬을 쓸지)
   ---
   # 스킬 제목
   ...
   ```
3. README 2곳 동시 업데이트: `antigravity_test/README.md` + `ai_prompt/README.md`

## 관련 저장소

- `hermes-agents/` — MCP 설정, Claude Code 행동 규칙, 환경 설정, 봇 코드
- `ai-workspace/` — 일지, 비즈니스 전략, 채널 전략, 사용자 프로필, 컨텍스트 규칙
