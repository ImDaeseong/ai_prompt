---
name: llm-evaluation
description: Implement comprehensive evaluation strategies for LLM applications using automated metrics, human feedback, and benchmarking. Use when testing LLM performance, measuring AI application quality, or establishing evaluation frameworks.
---

# LLM Evaluation

Build a way to know whether an LLM application actually got better or worse — before shipping a prompt/model change, not after users notice.

## When to Reach for This

- You changed a prompt or swapped models and need to know if quality moved
- You want a regression check before deploying, not a vibe check
- You're comparing two candidate approaches and need a number, not an impression
- Production behavior looks off and you need to isolate where

## Three Layers of Evaluation

### 1. Automated Metrics — fast, cheap, repeatable

Good for catching regressions at scale; bad at judging whether an answer is actually *helpful*.

**Text generation**
- BLEU — n-gram overlap, built for translation, weak signal for open-ended generation
- ROUGE — recall-oriented, common for summarization
- METEOR — closer to semantic similarity than raw n-gram matching
- BERTScore — embedding-based similarity, catches paraphrases BLEU/ROUGE miss
- Perplexity — measures model confidence, not correctness

**Classification tasks**
- Accuracy, Precision/Recall/F1, confusion matrix, AUC-ROC — standard ML metrics, nothing LLM-specific here

**Retrieval quality** (relevant when evaluating a RAG pipeline — see `rag_implementation.md`)
- MRR — how high up the first correct result lands, averaged
- NDCG — rewards correct results near the top more than further down
- Precision@K / Recall@K — of the top K results, how many are relevant / how much of the relevant set got covered

### 2. Human Evaluation — slow, expensive, catches what automation can't

Necessary when the failure mode is subjective: tone, safety, whether an answer actually *helps* rather than merely matching a reference string.

Dimensions worth rating separately rather than one blended score: factual accuracy, logical coherence, relevance to the actual question, fluency, safety (no harmful content), and real-world helpfulness. Blending these into one number hides which dimension is actually failing.

### 3. LLM-as-Judge — a middle ground

Use a stronger model to score a weaker model's output. Cheaper than human eval, more nuanced than automated metrics, but has its own failure modes.

- Pointwise: score one response in isolation
- Pairwise: compare two responses head-to-head (generally more reliable than pointwise for close calls)
- Reference-based: compare against a known-good answer
- Reference-free: judge quality without ground truth

**The catch**: a single judge call has real variance. For anything high-stakes, run it multiple times at different temperatures and aggregate, and where possible use a judge from a different provider/model than the one being evaluated — a model scoring its own generated output tends to rate it higher than an independent judge would (self-preference bias), so self-review alone isn't a reliable signal.

## A Minimal Evaluation Harness

```python
from dataclasses import dataclass, field
from typing import Callable, Awaitable
import statistics

@dataclass
class Metric:
    name: str
    score: Callable[..., float]

@dataclass
class EvalResult:
    scores: dict[str, list[float]] = field(default_factory=dict)

    def summary(self) -> dict[str, float]:
        return {name: statistics.mean(vals) for name, vals in self.scores.items()}

async def run_eval(
    model: Callable[[str], Awaitable[str]],
    test_cases: list[dict],
    metrics: list[Metric],
) -> EvalResult:
    result = EvalResult(scores={m.name: [] for m in metrics})

    for case in test_cases:
        prediction = await model(case["input"])
        for metric in metrics:
            score = metric.score(
                prediction=prediction,
                reference=case.get("expected"),
                context=case.get("context"),
            )
            result.scores[metric.name].append(score)

    return result

# 사용 예
test_cases = [
    {"input": "프랑스의 수도는?", "expected": "파리",
     "context": "프랑스는 유럽에 있는 나라이며 수도는 파리다."},
]
metrics = [Metric("accuracy", accuracy_fn), Metric("groundedness", groundedness_fn)]
result = await run_eval(model=your_model, test_cases=test_cases, metrics=metrics)
print(result.summary())
```

## Building a Real Evaluation Set

숫자 하나로는 아무것도 증명하지 못한다 — 다음이 갖춰져야 실제로 쓸모 있다.

- **베이스라인 고정**: 변경 전 점수를 먼저 기록해두지 않으면 "좋아졌다"를 주장할 근거가 없다.
- **엣지 케이스 포함**: 잘 되는 사례만 넣은 테스트셋은 회귀를 못 잡는다 — 과거에 실패했던 입력을 의도적으로 포함시킨다.
- **한 지표에 의존하지 않기**: 자동 지표가 오르면서 실사용 만족도는 떨어지는 경우가 흔하다 — 자동 지표는 사람 평가를 대체하지 않고 사람 평가 빈도를 줄여준다.
- **재현성**: temperature, 시드, 프롬프트 버전을 기록해두지 않으면 다음 사람이 같은 결과를 재현할 수 없다.

## Related Skills

- `rag_implementation.md`: RAG 파이프라인 자체를 만들 때
- `skill_creator.md`: 스킬 성능을 benchmark/variance analysis로 측정할 때
