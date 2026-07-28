---
name: llm-evaluation
description: Implement comprehensive evaluation strategies for LLM applications using automated metrics, human feedback, and benchmarking. Use when testing LLM performance, measuring AI application quality, or establishing evaluation frameworks.
---

# LLM Evaluation

> ID: SKILL-LLM-EVAL-001 | Source: wshobson/agents (38.3k★, MIT, 확인일 2026-07-28) | Last Updated: 2026-07-28

Master comprehensive evaluation strategies for LLM applications, from automated metrics to human evaluation and A/B testing.

## When to Use This Skill

- Measuring LLM application performance systematically
- Comparing different models or prompts
- Detecting performance regressions before deployment
- Validating improvements from prompt changes
- Building confidence in production systems
- Establishing baselines and tracking progress over time
- Debugging unexpected model behavior

## Core Evaluation Types

### 1. Automated Metrics

Fast, repeatable, scalable evaluation using computed scores.

**Text Generation:**

- **BLEU**: N-gram overlap (translation)
- **ROUGE**: Recall-oriented (summarization)
- **METEOR**: Semantic similarity
- **BERTScore**: Embedding-based similarity
- **Perplexity**: Language model confidence

**Classification:**

- **Accuracy**: Percentage correct
- **Precision/Recall/F1**: Class-specific performance
- **Confusion Matrix**: Error patterns
- **AUC-ROC**: Ranking quality

**Retrieval (RAG)** — see also `rag_implementation`:

- **MRR**: Mean Reciprocal Rank
- **NDCG**: Normalized Discounted Cumulative Gain
- **Precision@K**: Relevant in top K
- **Recall@K**: Coverage in top K

### 2. Human Evaluation

Manual assessment for quality aspects difficult to automate.

**Dimensions:** Accuracy(사실 정확성) · Coherence(논리적 흐름) · Relevance(질문에 답하는가) · Fluency(자연스러움) · Safety(유해 콘텐츠 없음) · Helpfulness(실사용자에게 유용한가)

### 3. LLM-as-Judge

Use stronger LLMs to evaluate weaker model outputs.

- **Pointwise**: Score individual responses
- **Pairwise**: Compare two responses
- **Reference-based**: Compare to gold standard
- **Reference-free**: Judge without ground truth

노이즈 주의: 단일 judge 호출은 편차가 크다 — 고위험 판단일수록 temperature를 바꿔가며 여러 번 돌려 집계하고, 가능하면 평가 대상과 다른 provider/모델을 judge로 쓴다(같은 모델의 self-review는 같은 맹점을 공유하는 경향이 있다).

## Quick Start

```python
from dataclasses import dataclass
from typing import Callable
import numpy as np

@dataclass
class Metric:
    name: str
    fn: Callable

    @staticmethod
    def accuracy():
        return Metric("accuracy", calculate_accuracy)

    @staticmethod
    def bleu():
        return Metric("bleu", calculate_bleu)

    @staticmethod
    def bertscore():
        return Metric("bertscore", calculate_bertscore)

    @staticmethod
    def custom(name: str, fn: Callable):
        return Metric(name, fn)

class EvaluationSuite:
    def __init__(self, metrics: list[Metric]):
        self.metrics = metrics

    async def evaluate(self, model, test_cases: list[dict]) -> dict:
        results = {m.name: [] for m in self.metrics}

        for test in test_cases:
            prediction = await model.predict(test["input"])

            for metric in self.metrics:
                score = metric.fn(
                    prediction=prediction,
                    reference=test.get("expected"),
                    context=test.get("context")
                )
                results[metric.name].append(score)

        return {
            "metrics": {k: np.mean(v) for k, v in results.items()},
            "raw_scores": results
        }

# Usage
suite = EvaluationSuite([
    Metric.accuracy(),
    Metric.bleu(),
    Metric.bertscore(),
    Metric.custom("groundedness", check_groundedness)
])

test_cases = [
    {
        "input": "What is the capital of France?",
        "expected": "Paris",
        "context": "France is a country in Europe. Paris is its capital."
    },
]

results = await suite.evaluate(model=your_model, test_cases=test_cases)
```

## Going Deeper

이 파일은 소스 저장소의 상위 요약본이다. 더 깊은 워크드 예제가 필요하면 `wshobson/agents`의 `plugins/llm-application-dev/skills/llm-evaluation/references/details.md`를 직접 참고한다(이 워크스페이스엔 벤더링하지 않음 — `ai_prompt`는 개별 skill.md 단일 파일 규칙을 따르므로 하위 references/ 폴더를 두지 않는다).

## Related Skills

- `rag_implementation`: 검색 파이프라인 자체를 만들 때
- `skill_creator`: 스킬 성능을 benchmark/variance analysis로 측정할 때
