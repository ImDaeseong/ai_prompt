param(
    [switch]$SideEffectSelfTest
)

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

function Get-RepoState([string]$Root) {
    # A porcelain status line only reports a file's status letter (e.g. " M"),
    # which stays identical if an already-modified/untracked file is edited
    # again with different content - masking a real mutation. Fold in the
    # actual diff content (tracked) and content hashes (untracked) so a
    # content-only re-edit changes the snapshot too.
    $state = & git -C $Root status --porcelain=v1 --untracked-files=all
    if ($LASTEXITCODE -ne 0) { throw "git status failed for $Root" }
    $diff = & git -C $Root diff --no-color
    if ($LASTEXITCODE -ne 0) { throw "git diff failed for $Root" }
    $diffCached = & git -C $Root diff --no-color --cached
    if ($LASTEXITCODE -ne 0) { throw "git diff --cached failed for $Root" }
    # Porcelain v1's normal (newline) output quotes/escapes a filename that
    # has a space or non-ASCII byte (e.g. "space name.txt", "\355\225\234.txt"),
    # which Join-Path/Test-Path then choke on as a literal path. -z output is
    # NUL-separated and never quotes filenames, so use it just for path
    # extraction.
    $untrackedRaw = & git -C $Root status --porcelain=v1 -z --untracked-files=all | Out-String
    if ($LASTEXITCODE -ne 0) { throw "git status -z failed for $Root" }
    $untrackedHashes = foreach ($entry in ($untrackedRaw -split "`0")) {
        if ($entry -match '^\?\?\s(.+)$') {
            $rel = $Matches[1]
            $full = Join-Path $Root $rel
            if (Test-Path -LiteralPath $full -PathType Leaf) {
                (Get-FileHash -LiteralPath $full -Algorithm SHA256).Hash + " " + $rel
            }
        }
    }
    return ($state -join "`n") + "`n--diff--`n" + ($diff -join "`n") + "`n--cached--`n" + ($diffCached -join "`n") + "`n--untracked--`n" + ($untrackedHashes -join "`n")
}

function Invoke-Checked([string]$Label, [scriptblock]$Command) {
    & $Command
    if ($LASTEXITCODE -ne 0) { throw "$Label failed with exit code $LASTEXITCODE" }
}

if ($SideEffectSelfTest) {
    $tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("verify-side-effect-" + [guid]::NewGuid())
    try {
        New-Item -ItemType Directory -Path $tempRoot | Out-Null
        & git -C $tempRoot init --quiet
        Set-Content -LiteralPath (Join-Path $tempRoot "tracked.txt") -Value "baseline" -Encoding ascii
        & git -C $tempRoot add tracked.txt
        $before = Get-RepoState $tempRoot
        Set-Content -LiteralPath (Join-Path $tempRoot "unexpected.txt") -Value "side effect" -Encoding ascii
        $after = Get-RepoState $tempRoot
        if ($before -eq $after) { throw "side-effect guard did not detect a newly-created untracked file" }

        # Regression case: a tracked file that is ALREADY modified (porcelain
        # status " M") gets edited again with different content. The status
        # letter alone can't distinguish this from "no further change".
        & git -C $tempRoot commit --quiet -m "init"
        Set-Content -LiteralPath (Join-Path $tempRoot "tracked.txt") -Value "first edit" -Encoding ascii
        $beforeReEdit = Get-RepoState $tempRoot
        Set-Content -LiteralPath (Join-Path $tempRoot "tracked.txt") -Value "second edit" -Encoding ascii
        $afterReEdit = Get-RepoState $tempRoot
        if ($beforeReEdit -eq $afterReEdit) { throw "side-effect guard did not detect a content-only re-edit of an already-modified tracked file" }

        # Regression case: an untracked file whose name needs porcelain
        # quoting (a space, or a non-ASCII byte under core.quotePath) must
        # not make Get-RepoState throw, and a content-only re-edit of it
        # must still be detected.
        & git -C $tempRoot config core.quotePath true
        $nonAsciiName = [string][char]0xD55C + ".txt" # avoid a literal non-ASCII char in this source file
        Set-Content -LiteralPath (Join-Path $tempRoot "space name.txt") -Value "v1" -Encoding UTF8
        Set-Content -LiteralPath (Join-Path $tempRoot $nonAsciiName) -Value "v1" -Encoding UTF8
        $beforeUnicode = Get-RepoState $tempRoot
        Set-Content -LiteralPath (Join-Path $tempRoot "space name.txt") -Value "v2" -Encoding UTF8
        Set-Content -LiteralPath (Join-Path $tempRoot $nonAsciiName) -Value "v2" -Encoding UTF8
        $afterUnicode = Get-RepoState $tempRoot
        if ($beforeUnicode -eq $afterUnicode) { throw "side-effect guard did not detect a content-only re-edit of a space/non-ASCII-named untracked file" }
        Write-Output "PASS: verification side-effect guard detects repository state changes."
    } finally {
        Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
    exit 0
}

$before = Get-RepoState $repoRoot
$failure = $null
Push-Location $repoRoot
try {
    Invoke-Checked "validate_skills.ps1" {
        & powershell.exe -NoProfile -File (Join-Path $repoRoot "scripts\validate_skills.ps1")
    }
    Invoke-Checked "test_validate_skills.ps1" {
        & powershell.exe -NoProfile -File (Join-Path $repoRoot "scripts\test_validate_skills.ps1")
    }
    Invoke-Checked "validate_links.ps1" {
        & powershell.exe -NoProfile -File (Join-Path $repoRoot "scripts\validate_links.ps1")
    }
    Invoke-Checked "test_install_git_hooks.ps1" {
        & powershell.exe -NoProfile -File (Join-Path $repoRoot "scripts\test_install_git_hooks.ps1")
    }
} catch {
    $failure = $_
} finally {
    Pop-Location
}

$after = Get-RepoState $repoRoot
if ($after -ne $before) {
    Write-Error "Verification changed the repository state.`nBEFORE:`n$before`nAFTER:`n$after"
    exit 1
}
if ($failure) {
    Write-Error $failure
    exit 1
}

Write-Output "PASS: ai_prompt validation completed without repository side effects."
