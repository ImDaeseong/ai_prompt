# Installs this repo's local git hooks. Not run automatically (hooks in .git/hooks/
# are never tracked by git), so run this once after cloning.

$ErrorActionPreference = "Stop"
$repoRoot = git rev-parse --show-toplevel
$hookPath = Join-Path $repoRoot ".git/hooks/pre-commit"

$hookContent = @'
#!/bin/sh
# Regression guard: block commits that break skill frontmatter, duplicate
# skill names, or dangle a reference to a nonexistent skill
# (see scripts/validate_skills.ps1).
powershell.exe -NoProfile -File scripts/validate_skills.ps1
if [ $? -ne 0 ]; then
    echo ""
    echo "pre-commit: skill validation failed (see above). Fix the flagged entries before committing."
    exit 1
fi
'@

# -Encoding utf8 (Windows PowerShell 5.1) writes a UTF-8 BOM by default. A BOM before the
# "#!/bin/sh" shebang breaks it -- git then fails with a misleading "cannot spawn ... No such
# file or directory" that looks like a missing-executable-bit problem but isn't. Use ascii (the
# hook content is pure ASCII) to guarantee no BOM.
Set-Content -Path $hookPath -Value $hookContent -Encoding ascii -NoNewline

# Git for Windows spawns hooks via its bundled sh, which refuses to run a script without the
# POSIX executable bit -- Set-Content alone does not set it. Resolve Git's own bash instead of
# PATH's bash.exe, which may be the Windows WSL launcher.
$git = Get-Command git.exe -ErrorAction Stop
$bashPath = Join-Path (Split-Path (Split-Path $git.Source)) "bin\bash.exe"
if (-not (Test-Path -LiteralPath $bashPath)) {
    Write-Warning "Git Bash not found at $bashPath -- could not set the executable bit. Run 'chmod +x .git/hooks/pre-commit' manually from Git Bash."
} else {
    & $bashPath -c "chmod +x '$($hookPath -replace '\\','/')'"
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to set the executable bit on $hookPath."
    }
}

git hook run pre-commit
if ($LASTEXITCODE -ne 0) {
    throw "Installed pre-commit hook failed its validation run."
}

Write-Host "Installed pre-commit hook at $hookPath"
Write-Host "Verify: powershell.exe -NoProfile -File scripts/validate_skills.ps1"
