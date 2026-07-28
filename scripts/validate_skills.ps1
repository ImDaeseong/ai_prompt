param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

# Regression guard for two defect classes found by manual review on 2026-07-28:
# 1. A skill file that reuses substantial third-party content had no link to
#    NOTICE.md (MIT's "include the copyright/permission notice" requirement).
# 2. marketing_psychology.md's "관련 스킬"/"Related Skills" section pointed at
#    skills that don't exist in this collection; separately,
#    shipping_launch.md's same section pointed at a ui_ux_pro_max.md that was
#    never created (found while building this guard - an older typo, not
#    from that session's own work).
#
# Scope is deliberately narrow to avoid false positives: check 2 only scans
# inside a "## 관련 스킬" / "## Related Skills" heading section (not
# "References"/prose elsewhere, which legitimately name non-skill files or
# not-yet-written companion docs - see caio_advisor.md/vpe_advisor.md).
# Check 3 only requires a NOTICE.md link for files NOTICE.md itself already
# claims to cover, rather than retroactively demanding it from every older
# skill with an unrelated "Source:" mention whose license/reuse-substantiality
# was never verified.

$errors = [System.Collections.Generic.List[string]]::new()
$skillsDir = Join-Path $Root 'antigravity_test\skills'
$noticePath = Join-Path $Root 'NOTICE.md'

$skillFiles = Get-ChildItem -LiteralPath $skillsDir -File -Filter '*.md'
$skillNames = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($f in $skillFiles) { [void]$skillNames.Add($f.Name) }

$noticeText = if (Test-Path -LiteralPath $noticePath) { Get-Content -LiteralPath $noticePath -Raw -Encoding UTF8 } else { $null }

# --- Check 1: frontmatter + unique `name:` field ---
$frontmatterNames = @{}
foreach ($file in $skillFiles) {
    $text = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    if ($text -notmatch '(?s)^---\r?\n(.*?)\r?\n---') {
        $errors.Add("$($file.Name): missing frontmatter block")
        continue
    }
    $fm = $Matches[1]
    if ($fm -notmatch '(?m)^name:') { $errors.Add("$($file.Name): frontmatter missing name:") }
    if ($fm -notmatch '(?m)^description:') { $errors.Add("$($file.Name): frontmatter missing description:") }
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

# --- Check 3: if NOTICE.md claims to cover a skill file, that file must link back to NOTICE.md ---
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

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "PASS: $($skillFiles.Count) skills; frontmatter, unique names, 관련 스킬/Related Skills cross-references, and NOTICE.md back-links all valid."
