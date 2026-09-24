$ErrorActionPreference = 'Stop'
$validator = Join-Path $PSScriptRoot 'validate_behavior_contracts.ps1'
$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('behavior-contract-test-' + [guid]::NewGuid())

function Write-Fixture([string]$Root) {
    New-Item -ItemType Directory -Path (Join-Path $Root 'evaluations') -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $Root 'antigravity_test\skills') -Force | Out-Null
    Set-Content -LiteralPath (Join-Path $Root 'antigravity_test\skills\example.md') -Value '# example' -Encoding UTF8
    [ordered]@{version=1;evaluations=@(
        [ordered]@{id='positive';target='antigravity_test/skills/example.md';type='positive';userRequest='do it';expectedSkill='example';requiredBehavior=@('do');forbiddenBehavior=@('guess');humanReview=$false},
        [ordered]@{id='ambiguous';target='antigravity_test/skills/example.md';type='ambiguous';userRequest='maybe';expectedSkill='example';requiredBehavior=@('ask');forbiddenBehavior=@('assume');humanReview=$false},
        [ordered]@{id='negative';target='antigravity_test/skills/example.md';type='negative';userRequest='other';expectedSkill='not-example';requiredBehavior=@('route');forbiddenBehavior=@('run');humanReview=$true}
    )} | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $Root 'evaluations\behavior-contracts.json') -Encoding UTF8
    [ordered]@{version=1;defaultStatus='experimental';overrides=@([ordered]@{path='antigravity_test/skills/example.md';status='active';reason='fixture'})} | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $Root 'skill-catalog.json') -Encoding UTF8
    [ordered]@{version=1;candidates=@([ordered]@{source='antigravity_test/skills/example.md';targetRepository='skills';targetSkill='example';status='review-required';evaluationIds=@('positive','ambiguous','negative');decision='fixture'})} | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $Root 'promotion-manifest.json') -Encoding UTF8
}

function Invoke-Validator([string]$Root) {
    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        $output = & powershell.exe -NoProfile -File $validator -Root $Root 2>&1 | Out-String
        return @{ ExitCode = $LASTEXITCODE; Output = $output }
    } finally {
        $ErrorActionPreference = $previousPreference
    }
}

try {
    Write-Fixture $tempRoot
    $pass = Invoke-Validator $tempRoot
    if ($pass.ExitCode -ne 0 -or $pass.Output -notmatch 'PASS: 3 behavior contracts') { throw "valid fixture failed: $($pass.Output)" }
    $dataPath = Join-Path $tempRoot 'evaluations\behavior-contracts.json'
    $data = Get-Content -LiteralPath $dataPath -Raw | ConvertFrom-Json
    $data.evaluations[0].userRequest = ''
    $data | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $dataPath -Encoding UTF8
    $failure = Invoke-Validator $tempRoot
    if ($failure.ExitCode -eq 0 -or $failure.Output -notmatch 'EVAL-MISSING' -or $failure.Output -notmatch 'userRequest') { throw "missing-field fixture did not fail for the intended reason: $($failure.Output)" }
    Write-Output 'PASS: behavior-contract validator accepts a valid fixture and rejects a missing field for the intended reason.'
} finally {
    Remove-Item -LiteralPath $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
}
