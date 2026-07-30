# Regression test for install-git-hooks.ps1's two independently-found defects
# (2026-07-30): it used to overwrite an existing pre-commit hook unconditionally, and
# hardcoded ".git/hooks/pre-commit" instead of resolving the real hook path, which
# breaks under a linked worktree (whose .git is a file, not a directory) or a repo with
# core.hooksPath set. Runs entirely inside a throwaway temp git repo -- never touches
# this repo's own real .git/hooks.

$ErrorActionPreference = "Stop"
$failures = [System.Collections.Generic.List[string]]::new()

$repoRoot = git rev-parse --show-toplevel
$installerRel = "scripts/install-git-hooks.ps1"
$installerAbs = Join-Path $repoRoot $installerRel

$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("install-hooks-test-" + [System.Guid]::NewGuid())
New-Item -ItemType Directory -Path $tempRoot | Out-Null

try {
    # A minimal fake repo the installer can run against, with its own copy of the
    # installer and a stub validate_skills.ps1 (real one is specific to this repo's
    # skill collection; the test only cares whether the hook gets installed correctly).
    $fakeRepo = Join-Path $tempRoot "repo"
    New-Item -ItemType Directory -Path $fakeRepo | Out-Null
    Push-Location $fakeRepo
    git init --quiet | Out-Null
    git config user.email "test@example.com"
    git config user.name "Test"
    New-Item -ItemType Directory -Path "scripts" | Out-Null
    Copy-Item -Path $installerAbs -Destination "scripts/install-git-hooks.ps1"
    Set-Content -Path "scripts/validate_skills.ps1" -Value "exit 0" -Encoding ascii
    "placeholder" | Out-File "readme.txt" -Encoding ascii
    git add -A | Out-Null
    git commit -m "init" --quiet | Out-Null

    # Test 1: normal case -- installs cleanly into a fresh repo with no existing hook.
    powershell.exe -NoProfile -File "scripts/install-git-hooks.ps1" | Out-Null
    if ($LASTEXITCODE -ne 0) {
        $failures.Add("Test 1 (fresh install): installer exited non-zero on a repo with no existing hook.")
    } elseif (-not (Test-Path ".git/hooks/pre-commit")) {
        $failures.Add("Test 1 (fresh install): hook file was not created.")
    }

    # Test 2: idempotent reinstall -- running again over its own prior install must not fail.
    powershell.exe -NoProfile -File "scripts/install-git-hooks.ps1" | Out-Null
    if ($LASTEXITCODE -ne 0) {
        $failures.Add("Test 2 (idempotent reinstall): installer exited non-zero when reinstalling over its own marker.")
    }

    # Test 3: foreign-hook protection -- a hook not installed by this script must survive.
    $foreignContent = "#!/bin/sh`necho this is someone else's hook`n"
    Set-Content -Path ".git/hooks/pre-commit" -Value $foreignContent -Encoding ascii -NoNewline
    powershell.exe -NoProfile -File "scripts/install-git-hooks.ps1" | Out-Null
    $exitAfterForeign = $LASTEXITCODE
    $survivedContent = Get-Content -LiteralPath ".git/hooks/pre-commit" -Raw
    if ($exitAfterForeign -eq 0) {
        $failures.Add("Test 3 (foreign-hook protection): installer exited 0 instead of refusing to overwrite an unrecognized existing hook.")
    }
    if ($survivedContent -notlike "*someone else's hook*") {
        $failures.Add("Test 3 (foreign-hook protection): the pre-existing foreign hook was overwritten/destroyed instead of preserved.")
    }
    Remove-Item ".git/hooks/pre-commit" -Force

    # Test 4: linked worktree -- git rev-parse --git-path must resolve to the shared
    # hooks dir even when run from inside a worktree whose own .git is a file.
    powershell.exe -NoProfile -File "scripts/install-git-hooks.ps1" | Out-Null
    # `git rev-parse --git-path` returns a path relative to cwd when possible (true when
    # cwd is the repo root) but must fall back to absolute when the target lies outside
    # cwd's tree (true from inside a worktree) -- resolve both sides to absolute before
    # comparing, or a correct answer in two different forms reads as a false mismatch.
    $mainRepoHookPath = (Resolve-Path -LiteralPath (git rev-parse --git-path hooks/pre-commit)).Path
    $worktreePath = Join-Path $tempRoot "worktree"
    git worktree add --quiet $worktreePath HEAD | Out-Null
    Push-Location $worktreePath
    try {
        if (-not (Test-Path -LiteralPath ".git" -PathType Leaf)) {
            $failures.Add("Test 4 (linked worktree): test setup assumption failed -- .git is not a file in the worktree, cannot validate the fix meaningfully.")
        }
        $resolvedFromWorktree = (Resolve-Path -LiteralPath (git rev-parse --git-path hooks/pre-commit)).Path
        if ($resolvedFromWorktree -ne $mainRepoHookPath) {
            $failures.Add("Test 4 (linked worktree): 'git rev-parse --git-path hooks/pre-commit' resolved to '$resolvedFromWorktree' from inside the worktree, expected the shared main-repo path '$mainRepoHookPath'.")
        }
    } finally {
        Pop-Location
    }
    git worktree remove $worktreePath --force | Out-Null

    Pop-Location
} finally {
    if ((Get-Location).Path -eq $fakeRepo) { Pop-Location }
    Remove-Item -Recurse -Force $tempRoot -ErrorAction SilentlyContinue
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "PASS: install-git-hooks.ps1 handles fresh install, idempotent reinstall, foreign-hook protection, and linked-worktree path resolution correctly."
