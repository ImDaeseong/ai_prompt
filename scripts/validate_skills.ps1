param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

# Regression guard for defect classes found by manual review on 2026-07-28:
# 1. A skill file that reuses substantial third-party content had no link to
#    NOTICE.md (MIT's "include the copyright/permission notice" requirement).
# 2. marketing_psychology.md's "관련 스킬"/"Related Skills" section pointed at
#    skills that don't exist in this collection; separately,
#    shipping_launch.md's same section pointed at a ui_ux_pro_max.md that was
#    never created (found while building this guard - an older typo, not
#    from that session's own work).
# 3. marketing_psychology.md's frontmatter `description:` routed to nonexistent
#    local `cro`/`pricing` skills by bare prose word - found by a follow-up
#    audit that showed check 2 alone (Related Skills section only) missed
#    this, since the defect was in the frontmatter, not that section.
#
# Scope is deliberately narrow to avoid false positives: check 2 only scans
# inside a "## 관련 스킬" / "## Related Skills" heading section (not
# "References"/prose elsewhere, which legitimately name non-skill files or
# not-yet-written companion docs - see caio_advisor.md/vpe_advisor.md).
# Check 4 only requires a NOTICE.md link for files NOTICE.md itself already
# claims to cover, rather than retroactively demanding it from every older
# skill with an unrelated "Source:" mention whose license/reuse-substantiality
# was never verified. Check 3 covers the case NOTICE.md is deleted outright
# (found by a follow-up audit: check 4 alone silently no-ops when NOTICE.md
# doesn't exist, since it's gated on $noticeText).
#
# 2026-07-28 update: the 4 skills that originally required NOTICE.md
# (copywriting/marketing_psychology/rag_implementation/llm_evaluation) were
# rewritten from scratch in this repo's own voice/structure and no longer
# reuse third-party text, so NOTICE.md was removed. Checks 3/4 are now
# no-ops (nothing links to NOTICE.md, NOTICE.md doesn't exist) but stay in
# place as a dormant guard in case a future skill reuses licensed content again.

$errors = [System.Collections.Generic.List[string]]::new()
$skillsDir = Join-Path $Root 'antigravity_test\skills'
$noticePath = Join-Path $Root 'NOTICE.md'

if (-not (Test-Path -LiteralPath $skillsDir -PathType Container)) {
    Write-Error "skills directory not found: $skillsDir"
    exit 1
}
$skillFiles = Get-ChildItem -LiteralPath $skillsDir -File -Filter '*.md'
if ($skillFiles.Count -eq 0) {
    Write-Error "no skill files found under: $skillsDir"
    exit 1
}
$skillNames = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($f in $skillFiles) { [void]$skillNames.Add($f.Name) }

$noticeText = if (Test-Path -LiteralPath $noticePath) { Get-Content -LiteralPath $noticePath -Raw -Encoding UTF8 } else { $null }

# Returns $true if frontmatter key `$key` is missing or has an empty value.
# A same-line non-whitespace check alone isn't enough: `name: ""` and
# `description: |-` (an empty block scalar) both have a non-whitespace
# character on the key's line while carrying no actual value.
function Test-FrontmatterKeyEmpty([string]$fm, [string]$key) {
    $fmLines = $fm -split "`r?`n"
    $keyLineIndex = -1
    $rawValue = $null
    for ($i = 0; $i -lt $fmLines.Count; $i++) {
        if ($fmLines[$i] -match "^${key}:(.*)`$") {
            $keyLineIndex = $i
            $rawValue = $Matches[1].Trim()
            break
        }
    }
    if ($keyLineIndex -lt 0) { return $true }
    if ($rawValue -match '^"([^"]*)"$') { return ($Matches[1].Trim() -eq '') }
    if ($rawValue -match "^'([^']*)'$") { return ($Matches[1].Trim() -eq '') }
    if ($rawValue -match '^[|>][+\-]?\d*$') {
        for ($j = $keyLineIndex + 1; $j -lt $fmLines.Count; $j++) {
            $line = $fmLines[$j]
            if ($line -match '^\S') { break }
            if ($line.Trim() -ne '') { return $false }
        }
        return $true
    }
    return ($rawValue -eq '')
}

# --- Check 1: frontmatter + unique `name:` field ---
$frontmatterNames = @{}
foreach ($file in $skillFiles) {
    $text = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    if ($text -notmatch '(?s)^---\r?\n(.*?)\r?\n---') {
        $errors.Add("$($file.Name): missing frontmatter block")
        continue
    }
    $fm = $Matches[1]
    if (Test-FrontmatterKeyEmpty $fm 'name') { $errors.Add("$($file.Name): frontmatter missing or empty name:") }
    if (Test-FrontmatterKeyEmpty $fm 'description') { $errors.Add("$($file.Name): frontmatter missing or empty description:") }
    $nameMatch = [regex]::Match($fm, '(?m)^name:\s*"?([a-z0-9-]+)"?')
    if ($nameMatch.Success) {
        $n = $nameMatch.Groups[1].Value
        if ($frontmatterNames.ContainsKey($n)) {
            $errors.Add("duplicate frontmatter name '$n': $($frontmatterNames[$n]) and $($file.Name)")
        }
        $frontmatterNames[$n] = $file.Name
    }
}

# --- Check 2: "관련 스킬"/"Related Skills" section only - every `xxx.md` there must be a real skill file ---
foreach ($file in $skillFiles) {
    $text = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    $sectionMatch = [regex]::Match(
        $text,
        '(?ms)^##\s*(?:관련\s*스킬[^\r\n]*|Related Skills)\s*\r?\n(.*?)(?=\r?\n##\s|\z)'
    )
    if (-not $sectionMatch.Success) { continue }
    $section = $sectionMatch.Groups[1].Value
    $refMatches = [regex]::Matches($section, '`([a-zA-Z0-9_-]+\.md)`')
    foreach ($m in $refMatches) {
        $ref = $m.Groups[1].Value
        if ($ref -eq $file.Name) { continue }
        if (-not $skillNames.Contains($ref)) {
            $errors.Add("$($file.Name): '관련 스킬/Related Skills' section references nonexistent skill '$ref'")
        }
    }
}

# --- Check 3: any skill file that links to NOTICE.md requires NOTICE.md to actually exist ---
# (driven by the skill file side, not gated on $noticeText, so deleting NOTICE.md
# entirely is still caught instead of silently skipping this whole check)
foreach ($file in $skillFiles) {
    $text = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    if ($text -match 'NOTICE\.md' -and -not $noticeText) {
        $errors.Add("$($file.Name): links to NOTICE.md, but NOTICE.md does not exist")
    }
}

# --- Check 4: if NOTICE.md claims to cover a skill file, that file must link back to NOTICE.md ---
if ($noticeText) {
    foreach ($file in $skillFiles) {
        if ($noticeText -notmatch [regex]::Escape($file.Name)) { continue }
        $text = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
        if ($text -notmatch 'NOTICE\.md') {
            $errors.Add("$($file.Name): NOTICE.md claims to cover this file, but it does not link back to NOTICE.md")
        }
    }
    if ($noticeText -notmatch 'Copyright \(c\)') {
        $errors.Add("NOTICE.md: exists but has no 'Copyright (c) ...' line at all")
    }
}

# --- Check 5: frontmatter `description:` must not mention "<bare-word> 스킬" outside
# backticks - e.g. "...카피는 copywriting 스킬 참고" instead of "`copywriting.md` 참고"
# or "`cro` 참고" (external, no local file, still checkable-as-intentional via backticks).
# Backtick-quoted spans are stripped before matching, so `copywriting.md` 참고 and `cro`
# 참고 are both fine; only a truly bare ASCII word immediately before 스킬 is flagged.
# Confirmed zero false positives across all 113 current skills' description fields
# before adding this check (grep for the bare pattern found only marketing_psychology.md).
foreach ($file in $skillFiles) {
    $text = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    if ($text -notmatch '(?s)^---\r?\n(.*?)\r?\n---') { continue }
    $fm = $Matches[1]
    $fmNoBackticks = [regex]::Replace($fm, '`[^`]*`', '')
    $bareMatches = [regex]::Matches($fmNoBackticks, '([a-zA-Z][a-zA-Z0-9_-]{1,40})\s*스킬')
    foreach ($bm in $bareMatches) {
        $word = $bm.Groups[1].Value
        $errors.Add("$($file.Name): frontmatter mentions '$word 스킬' without backticks - use ``$word.md`` (local) or ``$word`` (external/non-local)")
    }
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "PASS: $($skillFiles.Count) skills; frontmatter, unique names, 관련 스킬/Related Skills cross-references, and NOTICE.md back-links all valid."
