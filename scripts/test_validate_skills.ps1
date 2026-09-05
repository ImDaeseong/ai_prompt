# Regression test for validate_skills.ps1's independently-found defects (2026-09-05):
# a missing/empty skills directory printed "PASS: 0 skills" (Get-ChildItem's
# non-terminating error on a bad path was swallowed), and a frontmatter `name:`/
# `description:` key with no real value -- bare empty, a quoted empty string, or
# an empty `|`/`>` block scalar -- passed because the check only looked for ANY
# non-whitespace character on the key's line. Runs entirely inside throwaway
# temp directories -- never touches this repo's own real skill collection.

$ErrorActionPreference = "Stop"
$failures = [System.Collections.Generic.List[string]]::new()

$repoRoot = git rev-parse --show-toplevel
$validatorAbs = Join-Path $repoRoot "scripts/validate_skills.ps1"
$q = '"'  # a literal double-quote character, kept out of string literals below

function New-Fixture([string]$frontmatterAndBody) {
    $root = Join-Path ([System.IO.Path]::GetTempPath()) ("validate-skills-test-" + [System.Guid]::NewGuid())
    New-Item -ItemType Directory -Path (Join-Path $root "antigravity_test\skills") -Force | Out-Null
    Set-Content -LiteralPath (Join-Path $root "antigravity_test\skills\example.md") -Value $frontmatterAndBody -Encoding UTF8
    return $root
}

function Invoke-Validator([string]$root) {
    powershell.exe -NoProfile -File $validatorAbs -Root $root | Out-Null
    return $LASTEXITCODE
}

# Test 1: nonexistent root -- must fail, not report "PASS: 0 skills".
$missingRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("validate-skills-test-missing-" + [System.Guid]::NewGuid())
$exit1 = Invoke-Validator $missingRoot
if ($exit1 -eq 0) {
    $failures.Add("Test 1 (nonexistent root): exited 0 instead of failing on a missing skills directory.")
}

# Test 2: root exists but has zero skill files -- must fail, not silently pass.
$emptyRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("validate-skills-test-empty-" + [System.Guid]::NewGuid())
New-Item -ItemType Directory -Path (Join-Path $emptyRoot "antigravity_test\skills") -Force | Out-Null
$exit2 = Invoke-Validator $emptyRoot
if ($exit2 -eq 0) {
    $failures.Add("Test 2 (empty skills directory): exited 0 instead of failing when zero skill files are found.")
}
Remove-Item $emptyRoot -Recurse -Force -ErrorAction SilentlyContinue

# Negative cases: each of these must fail (exit 1).
$negativeCases = @(
    @{ Label = "bare empty name"; Content = "---`nname:`ndescription: example`n---`n" }
    @{ Label = "quoted empty name"; Content = "---`nname: $q$q`ndescription: example`n---`n" }
    @{ Label = "bare empty description"; Content = "---`nname: example`ndescription:`n---`n" }
    @{ Label = "quoted empty description"; Content = "---`nname: example`ndescription: $q$q`n---`n" }
    @{ Label = "empty block-scalar description"; Content = "---`nname: example`ndescription: |-`n---`n" }
)
foreach ($case in $negativeCases) {
    $root = New-Fixture $case.Content
    $exit = Invoke-Validator $root
    if ($exit -eq 0) {
        $failures.Add("Negative case '$($case.Label)': exited 0 instead of failing on an empty required value.")
    }
    Remove-Item $root -Recurse -Force -ErrorAction SilentlyContinue
}

# Positive cases: each of these must pass (exit 0) -- guards against the empty-value
# fix over-matching and rejecting legitimate frontmatter shapes used in this collection.
$positiveCases = @(
    @{ Label = "plain unquoted values"; Content = "---`nname: example`ndescription: A normal one-line description.`n---`n" }
    @{ Label = "quoted values"; Content = "---`nname: ${q}example${q}`ndescription: ${q}A normal quoted description.${q}`n---`n" }
    @{ Label = "nonempty block-scalar description"; Content = "---`nname: example`ndescription: |-`n  Real multi-line description content here.`n  Second line of real content.`n---`n" }
)
foreach ($case in $positiveCases) {
    $root = New-Fixture $case.Content
    $exit = Invoke-Validator $root
    if ($exit -ne 0) {
        $failures.Add("Positive case '$($case.Label)': exited non-zero on a legitimate frontmatter shape.")
    }
    Remove-Item $root -Recurse -Force -ErrorAction SilentlyContinue
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "PASS: validate_skills.ps1 rejects missing/empty skill collections and empty required frontmatter values, and still accepts legitimate quoted/block-scalar frontmatter."
