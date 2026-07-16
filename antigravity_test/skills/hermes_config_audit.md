---
name: hermes-config-audit
description: "Audits hermes-agents/ai_prompt/ai-workspace config health across 6 weighted dimensions (AGENTS.md/CLAUDE.md consistency, permission hygiene, MCP ecosystem, cross-tool reference integrity, 3-repo structure, freshness). Reports only; asks before any fix."
---

# Skill: Hermes Config Audit (설정 상태 감사)

> Source: adapted from FlorianBruniaux/claude-code-ultimate-guide `tools/audit-prompt.md` (8-dimension generic Claude Code audit), rebuilt for hermes-agents' actual structure — no `.claude/rules/`, no `~/.claude.json` project-keyed MCP, no macOS-only cache-bug checks. Added: 2026-07-17.

사람이 매번 "여기 이상한 거 없나 봐줘"라고 물어야만 나오던 감사를, 정기적으로 셀프 실행할 수 있게 만든 스킬. **파일을 고치지 않고 보고만 한다** — 수정은 항상 사용자 승인 후.

---

## 활성화 조건

- "설정 점검해줘", "AGENTS.md/CLAUDE.md 괜찮은지 봐줘", "permission 정리됐는지 확인" 같은 요청
- 새 MCP 서버 추가, AGENTS.md/CLAUDE.md 수정, 큰 커밋 이후 정기 점검
- 한동안(2주+) 설정 파일을 안 건드렸을 때 — hygiene은 일회성 설치가 아니라 반복 작업

---

## Phase 1 — Inventory (bash, ~10초)

```bash
cd C:/Users/cs930/Desktop/hermes-agents
echo "=== 핵심 파일 존재 ===" 
for f in AGENTS.md CLAUDE.md .mcp.json .claude/settings.json ai_prompt/CLAUDE.md ai-workspace/CLAUDE.md ai-workspace/AGENTS.md; do
  [ -f "$f" ] && echo "OK  $f" || echo "MISSING  $f"
done

echo; echo "=== 3저장소 존재 (환경 자동 감지) ==="
[ -d ai_prompt ] && echo "집 PC 환경 (ai_prompt/ 내부 존재)" || echo "회사 PC 환경 (../ai_prompt/ 확인 필요)"
[ -d ai-workspace ] && echo "ai-workspace 존재" || echo "ai-workspace 없음"

echo; echo "=== Codex/Cursor 참조 ===" 
grep -c "hermes-agents.*AGENTS.md" ~/.codex/AGENTS.md 2>/dev/null || echo "0 (~/.codex/AGENTS.md 없음 또는 참조 없음)"
[ -f .cursor/rules/hermes-guidelines.mdc ] && echo "OK  .cursor/rules/hermes-guidelines.mdc" || echo "MISSING  .cursor/rules/*.mdc"

echo; echo "=== git 상태 ==="
git status --short
git log --oneline -1 --format="마지막 커밋: %ar (%h)"
```

---

## Phase 2 — Dimension Audit (100pt)

### 1. AGENTS.md/CLAUDE.md Consistency (20pt)

```bash
# v1/v2 철학 혼재 여부 (과거 실제 발견된 회귀 패턴)
grep -n "State assumptions in one line\|not to double-check something reversible" AGENTS.md && echo "FAIL: v2 잔존 문구" || echo "PASS"
# MCP 서버 수 문서-실제 일치
actual=$(python -c "import json; d=json.load(open('.mcp.json',encoding='utf-8')); print(len([k for k in d.get('mcpServers',{}) if not k.startswith('_comment')]))" 2>/dev/null)
documented=$(grep -oP '현재 \K[0-9]+(?=개 유지)' CLAUDE.md)
[ "$actual" = "$documented" ] && echo "PASS: MCP $actual=$documented" || echo "FAIL: MCP 실제 $actual / 문서 $documented"
```

배점: v1/v2 혼재 없음 8pt, MCP 수치 일치 6pt, 나머지 6pt는 AGENTS.md 필수 섹션(Simplicity First, Surgical Changes, Verification Loop Rule) 존재 여부 확인 후 각 2pt.

### 2. Permission Hygiene (20pt)

```bash
python scripts/check_claude_settings.py
python -c "
import json, re
d = json.load(open('.claude/settings.json', encoding='utf-8'))
allow = d['permissions']['allow']
uuid = re.compile(r'[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}')
dead = [e for e in allow if uuid.search(e) or re.search(r'Stop-Process -Id [0-9]+', e)]
print('총', len(allow), '개 /', '죽은 항목(세션 UUID·하드코딩 PID):', len(dead))
for d_ in dead: print(' -', d_[:100])
"
```

배점: 스캐너 통과 10pt, 죽은 항목 0개 6pt(1개당 -1pt, 최대 -6), allow-list가 지난 점검 대비 늘기만 하고 줄지 않았으면(git log로 추세 확인) -4pt.

### 3. MCP Ecosystem (15pt)

```bash
python -c "
import json
d = json.load(open('.mcp.json', encoding='utf-8'))
servers = {k:v for k,v in d.get('mcpServers',{}).items() if not k.startswith('_comment')}
print('서버 수:', len(servers))
for name, cfg in servers.items():
    env = cfg.get('env', {})
    has_key_ref = any('API_KEY' in k or 'TOKEN' in k for k in env)
    print(f'  {name}: env keys={list(env.keys())}')
"
```

배점: 30개 미만(Context Confusion 임계치 이하) 8pt, 문서(`MCP_SERVERS.md`)에 전체 서버 등재 확인 4pt, 키 노출 없음(env에 실제 값 대신 참조/플레이스홀더만) 3pt.

### 4. Cross-Tool Reference Integrity (15pt)

```bash
echo "=== Codex ===" 
grep -n "hermes-agents.*AGENTS.md" ~/.codex/AGENTS.md 2>/dev/null
echo "=== Cursor ==="
cat .cursor/rules/hermes-guidelines.mdc 2>/dev/null | head -3
echo "=== 중복 내용 검색 (있으면 안 됨) ==="
grep -c "Simplicity First\|Surgical Changes" ~/.codex/AGENTS.md .cursor/rules/hermes-guidelines.mdc 2>/dev/null
```

배점: Codex가 프로젝트 AGENTS.md를 참조(복제 아님) 8pt, Cursor `.mdc`가 참조 방식(내용 미복제) 7pt. 두 파일에 원문 규칙 텍스트(Simplicity First 등)가 그대로 박혀 있으면 드리프트 위험 → 감점.

### 5. 3-Repo Structure Integrity (15pt)

```bash
echo "=== 역할 위반 스캔 (ai_prompt 형식 스킬(frontmatter name:/description:)이 ai-workspace에 잘못 들어갔는지) ==="
# 주의: 경로에 "skills/"만 있다고 위반이 아니다. ai-workspace/dev/*/skills/ 는 디버깅
# 교훈·ADR 메모(frontmatter 없음)를 정당하게 저장하는 곳이라 오탐 대상이다.
# name:/description: frontmatter가 실제로 있는 파일만 위반으로 센다.
for f in $(find ai-workspace -path "*/skills/*.md" -not -name "README.md" 2>/dev/null); do
  head -5 "$f" | grep -q "^name:" && echo "위반: $f"
done
echo "(위 결과 없으면 위반 없음 — frontmatter 없는 dev 메모는 정상)"
echo "=== 프롬프트가 hermes-agents에 잘못 들어갔는지 ==="
find . -maxdepth 1 -iname "*prompt*.md" -not -path "./ai_prompt/*"
```

배점: 스킬 파일이 `ai_prompt/antigravity_test/skills/`에만 존재 8pt, hermes-agents 루트에 프롬프트/일지 성격 파일 없음 7pt.

### 6. Freshness (15pt)

```bash
echo "=== 저장소 루트 임시 파일 잔존 ===" 
find . -maxdepth 1 \( -iname "_tmp*" -o -iname "*.tmp" \) 2>/dev/null
echo "=== 최근 커밋 활동 ==="
git log --oneline --since="90 days ago" | wc -l
```

배점: 임시 파일 0개 8pt, 90일 내 커밋 활동 있음 7pt.

---

## Phase 3 — Unified Report

```
## Hermes Config Audit — X/100

| # | Dimension | Score | Max | 비고 |
|---|---|---|---|---|
| 1 | AGENTS.md/CLAUDE.md Consistency | X | 20 | |
| 2 | Permission Hygiene | X | 20 | |
| 3 | MCP Ecosystem | X | 15 | |
| 4 | Cross-Tool Reference Integrity | X | 15 | |
| 5 | 3-Repo Structure Integrity | X | 15 | |
| 6 | Freshness | X | 15 | |
| | **합계** | **X** | **100** | |

**등급**: 80+ Optimized / 60-79 Established / 40-59 Growing / <40 Starter

**발견 사항** (❌/⚠️ 항목만, 항목별로):
Gap: [무엇이 문제인지]
Impact: [방치하면 무슨 일이 생기는지]
Fix: [구체적 조치 + 파일 경로]
```

---

## Phase 4 — Validation Request (수정 전 반드시 확인)

보고 후 반드시 이렇게 묻는다:

"위 발견 사항 중 고칠까요? 답변:
- **전체** → 전부 수정
- **N번만** → 발견 사항 번호 지정
- **아니오** → 리포트만 남기고 수정 안 함"

**사용자의 명시적 답변 없이는 어떤 파일도 수정하지 않는다.** (AGENTS.md의 "broad structural change 전 위험 설명" 규칙과 동일 원칙)

---

*관련: `agent_architecture_audit.md`(이건 LLM 애플리케이션 아키텍처 진단용 — 이 스킬과 목적이 다름, 혼동 금지)*
