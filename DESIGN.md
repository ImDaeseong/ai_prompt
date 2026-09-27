# AI Prompt Library Design

Updated: 2026-09-27

## Purpose

Maintain reusable prompt and skill assets with documented behavior, examples, and deterministic structural checks.

## Stakeholders, concerns, and scenarios

- Prompt author: preserve intent, tone, and reusable structure.
- User: know when a prompt applies and what data it may transmit.
- Reviewer: compare claimed behavior with contracts and representative outputs.
- Representative scenario: select a prompt, inspect its data/tool boundary, run representative cases, and promote it only after structural and human review.

## Boundaries

- Stores prompts, examples, and usage documentation, not runtime credentials or private company data.
- Personal prompt assets remain separate from the public `skills` repository.
- A structural PASS does not prove model-output quality; behavior still needs representative evaluation.

## Main components

- `antigravity_test/skills/`: reusable prompt and skill definitions.
- `antigravity_test/docs/`: usage and maintenance guidance.
- Behavior contracts and verification scripts: required and forbidden behavior checks.

## Detailed structure and views

### Content lifecycle view

```text
candidate prompt or skill
  -> repository rules and provenance review
  -> evaluations/ fixtures and rubric checks
  -> promotion-manifest.json
  -> skill-catalog.json / approved prompt assets
  -> downstream manual adoption
```

- Root Markdown files are maintained prompt assets; `antigravity_test/` isolates experimental material.
- `evaluations/` stores reproducible cases and judgments; `scripts/` checks catalog, promotion, links, and repository contracts.
- `promotion-manifest.json` records what may be promoted. Catalog membership is discovery metadata, not proof that a prompt is safe or effective in every runtime.

### Trust and change view

External examples and generated text enter as untrusted candidates. Promotion requires provenance, evaluation evidence, and review; downstream repositories copy or reference only explicitly promoted versions and remain responsible for their own runtime verification.

## Key decisions and tradeoffs

- Keep prompt assets separate from runtime code and public skills. This clarifies ownership but creates an explicit promotion step.
- Use deterministic contracts for observable behavior while retaining human review for semantic quality.

## Verification and human review

Run `powershell.exe -NoProfile -File scripts/verify_repo.ps1`. Human review remains required for tone, factual adequacy, sensitive-data exposure, and suitability for a target audience.

## Evidence basis and limits

The document organization is informed by [IEEE 1016-2009](https://standards.ieee.org/ieee/1016/4502/), stakeholder-specific views and scenarios from [Kruchten](https://www.cs.ubc.ca/~gregor/teaching/papers/4%2B1view-architecture.pdf), change isolation from [Parnas (1972)](https://doi.org/10.1145/361598.361623), quality objectives from [ISO/IEC 25010:2023](https://www.iso.org/standard/78176.html), and lifecycle security from [NIST SSDF 1.1](https://doi.org/10.6028/NIST.SP.800-218). These are design references, not compliance certifications.

The choice of detailed views is also guided by [ISO/IEC/IEEE 42010:2022](https://www.iso.org/standard/74393.html), whose public abstract specifies architecture descriptions, viewpoints, and model kinds, and the [SEI Views and Beyond approach](https://www.sei.cmu.edu/library/views-and-beyond-the-sei-approach-for-architecture-documentation/), which organizes documentation around views selected for stakeholder use. Only views supported by current repository evidence are included; omitted views are not implied.
