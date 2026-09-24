param([string]$Root = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = 'Stop'
$errors = [System.Collections.Generic.List[string]]::new()
$allowedTypes = @('positive', 'ambiguous', 'negative')
$allowedStatuses = @('active', 'experimental', 'reference-only', 'candidate-for-public', 'retired')
$allowedPromotionStatuses = @('review-required', 'approved', 'rejected', 'retired')

function Read-JsonFile([string]$RelativePath) {
    $path = Join-Path $Root $RelativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $errors.Add("[MISSING-FILE] $RelativePath")
        return $null
    }
    try { return Get-Content -LiteralPath $path -Raw -Encoding UTF8 | ConvertFrom-Json }
    catch { $errors.Add("[INVALID-JSON] ${RelativePath}: $($_.Exception.Message)"); return $null }
}

$contracts = Read-JsonFile 'evaluations\behavior-contracts.json'
$catalog = Read-JsonFile 'skill-catalog.json'
$promotion = Read-JsonFile 'promotion-manifest.json'
$evaluationIds = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$targetTypes = @{}

if ($contracts) {
    foreach ($evaluation in @($contracts.evaluations)) {
        foreach ($field in @('id', 'target', 'type', 'userRequest', 'expectedSkill')) {
            if ([string]::IsNullOrWhiteSpace([string]$evaluation.$field)) { $errors.Add("[EVAL-MISSING-FIELD] evaluation '$($evaluation.id)' is missing '$field'") }
        }
        if (-not $evaluationIds.Add([string]$evaluation.id)) { $errors.Add("[EVAL-DUPLICATE-ID] $($evaluation.id)") }
        if ($evaluation.type -notin $allowedTypes) { $errors.Add("[EVAL-BAD-TYPE] $($evaluation.id): $($evaluation.type)") }
        if (@($evaluation.requiredBehavior).Count -eq 0 -or @($evaluation.forbiddenBehavior).Count -eq 0) { $errors.Add("[EVAL-MISSING-ASSERTION] $($evaluation.id)") }
        if (-not (Test-Path -LiteralPath (Join-Path $Root ([string]$evaluation.target)) -PathType Leaf)) { $errors.Add("[EVAL-MISSING-TARGET] $($evaluation.id): $($evaluation.target)") }
        if (-not $targetTypes.ContainsKey([string]$evaluation.target)) { $targetTypes[[string]$evaluation.target] = [System.Collections.Generic.HashSet[string]]::new() }
        [void]$targetTypes[[string]$evaluation.target].Add([string]$evaluation.type)
    }
    foreach ($target in $targetTypes.Keys) {
        foreach ($type in $allowedTypes) {
            if (-not $targetTypes[$target].Contains($type)) { $errors.Add("[EVAL-MISSING-TYPE] ${target}: $type") }
        }
    }
}

if ($catalog) {
    if ($catalog.defaultStatus -notin $allowedStatuses) { $errors.Add("[CATALOG-BAD-DEFAULT] $($catalog.defaultStatus)") }
    $catalogPaths = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($entry in @($catalog.overrides)) {
        if (-not $catalogPaths.Add([string]$entry.path)) { $errors.Add("[CATALOG-DUPLICATE-PATH] $($entry.path)") }
        if ($entry.status -notin $allowedStatuses) { $errors.Add("[CATALOG-BAD-STATUS] $($entry.path): $($entry.status)") }
        if (-not (Test-Path -LiteralPath (Join-Path $Root ([string]$entry.path)) -PathType Leaf)) { $errors.Add("[CATALOG-MISSING-SKILL] $($entry.path)") }
    }
}

if ($promotion) {
    foreach ($candidate in @($promotion.candidates)) {
        if ($candidate.status -notin $allowedPromotionStatuses) { $errors.Add("[PROMOTION-BAD-STATUS] $($candidate.source): $($candidate.status)") }
        if (-not (Test-Path -LiteralPath (Join-Path $Root ([string]$candidate.source)) -PathType Leaf)) { $errors.Add("[PROMOTION-MISSING-SOURCE] $($candidate.source)") }
        foreach ($id in @($candidate.evaluationIds)) {
            if (-not $evaluationIds.Contains([string]$id)) { $errors.Add("[PROMOTION-MISSING-EVALUATION] $($candidate.source): $id") }
        }
    }
}

if ($errors.Count -gt 0) { $errors | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Output "PASS: $($evaluationIds.Count) behavior contracts; catalog and promotion manifest are valid."
