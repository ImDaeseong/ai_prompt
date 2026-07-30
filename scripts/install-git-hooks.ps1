# Installs this repo's local git hooks. Not run automatically (hooks in .git/hooks/
# are never tracked by git), so run this once after cloning.

$ErrorActionPreference = "Stop"

# Marker identifying a hook installed by this script, so a re-run can safely overwrite
# its own prior install without destroying an unrelated hook a user wrote by hand.
$marker = "# installed-by: ai_prompt/scripts/install-git-hooks.ps1"

# `git rev-parse --git-path hooks/pre-commit` (not a hardcoded ".git/hooks/pre-commit")
# resolves the real hook location per Git's own rules: a linked worktree's `.git` is a
# file, not a directory, pointing at a shared gitdir elsewhere, and `core.hooksPath` can
# redirect hooks entirely. A hardcoded path silently installs into the wrong place (or a
# nonexistent one) in either case.
$hookPath = git rev-parse --git-path hooks/pre-commit
if ($LASTEXITCODE -ne 0 -or -not $hookPath) {
    throw "Could not resolve the pre-commit hook path via 'git rev-parse --git-path hooks/pre-commit'."
}

if (Test-Path -LiteralPath $hookPath) {
    $existing = Get-Content -LiteralPath $hookPath -Raw
    if ($existing -notlike "*$marker*") {
        throw "An existing pre-commit hook at '$hookPath' was not installed by this script and would be destroyed by continuing. Back it up or merge its contents manually, then re-run this script."
    }
}

$hookContent = @"
#!/bin/sh
$marker
# Regression guard: block commits that break skill frontmatter, duplicate
# skill names, or dangle a reference to a nonexistent skill
# (see scripts/validate_skills.ps1).
powershell.exe -NoProfile -File scripts/validate_skills.ps1
if [ `$? -ne 0 ]; then
    echo ""
    echo "pre-commit: skill validation failed (see above). Fix the flagged entries before committing."
    exit 1
fi
"@

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
    Write-Warning "Git Bash not found at $bashPath -- could not set the executable bit. Run 'chmod +x $hookPath' manually from Git Bash."
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
