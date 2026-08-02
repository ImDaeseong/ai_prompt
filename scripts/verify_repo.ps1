param(
    [switch]$SideEffectSelfTest
)

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

function Get-RepoState([string]$Root) {
    $state = & git -C $Root status --porcelain=v1 --untracked-files=all
    if ($LASTEXITCODE -ne 0) { throw "git status failed for $Root" }
    return ($state -join "`n")
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
