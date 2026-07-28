---
name: rag-implementation
description: Build Retrieval-Augmented Generation (RAG) systems for LLM applications with vector databases and semantic search. Use when implementing knowledge-grounded AI, building document Q&A systems, or integrating LLMs with external knowledge bases.
---

# RAG Implementation

Design and build a Retrieval-Augmented Generation pipeline that grounds LLM answers in an external knowledge source instead of relying on the model's parametric memory alone.

## When to Reach for This

- The answer must come from documents you control, not from what the model happened to memorize
- Users need current information the model's training cutoff can't have
- Hallucination on factual questions is unacceptable
- You need natural-language search over a knowledge base, not keyword search
- Answers should cite where they came from

## The Four Building Blocks

### 1. Storage — Vector Database

Stores document chunks as embeddings and returns the nearest ones to a query vector.

| Option | Pick it when |
|-------|----------|
| Pinecone | You want managed infra and don't want to run anything yourself |
| Weaviate | You need hybrid (keyword + vector) search out of the box |
| Milvus | Scale and self-hosting matter more than setup convenience |
| Chroma | You're prototyping locally and want zero infra |
| Qdrant | Filtered search performance matters, Rust-based |
| pgvector | You already run Postgres and don't want a separate system |

### 2. Encoding — Embeddings

Converts text into vectors so semantic similarity becomes a distance calculation.

Model choice depends on which LLM provider you're already paired with and whether accuracy or cost matters more — check current pricing/availability before committing, since this table dates quickly:

| Model | Dimensions | Fit |
|-------|------------|----------|
| voyage-3-large | 1024 | Paired with Claude |
| voyage-code-3 | 1024 | Code search specifically |
| text-embedding-3-large | 3072 | Paired with OpenAI models, accuracy-first |
| text-embedding-3-small | 1536 | Paired with OpenAI models, cost-first |
| bge-large-en-v1.5 | 1024 | Open-source, self-hosted |
| multilingual-e5-large | 1024 | Multi-language corpora |

### 3. Finding candidates — Retrieval strategy

- **Dense**: embedding similarity — good for meaning, weak on exact terms/codes
- **Sparse (BM25/TF-IDF)**: keyword matching — good for exact terms, weak on paraphrase
- **Hybrid**: fuse dense + sparse scores — covers both weaknesses, more to tune
- **Multi-query**: generate several phrasings of the same question, retrieve for each, merge
- **HyDE**: have the LLM write a hypothetical answer first, embed that instead of the raw question — the hypothetical answer often sits closer to the real answer in vector space than the question does

### 4. Filtering candidates — Reranking

Retrieval optimizes for recall over a large candidate set; reranking narrows that set down to what actually gets passed to the LLM.

- Cross-encoder models (e.g. ms-marco-MiniLM) — score query+document pairs jointly, more accurate than embedding similarity alone
- Hosted rerank APIs (e.g. Cohere) — same idea without running your own model
- MMR — trades off relevance against diversity so results aren't near-duplicates of each other
- LLM-as-reranker — ask the LLM itself to score relevance, most expensive, most flexible

## A Minimal Working Pipeline

The shape below is deliberately framework-agnostic — swap in whatever vector store/embedding client you picked above.

```python
from dataclasses import dataclass
from typing import Protocol

class Retriever(Protocol):
    def search(self, query: str, k: int) -> list[str]: ...

class LLM(Protocol):
    def complete(self, prompt: str) -> str: ...

@dataclass
class RAGPipeline:
    retriever: Retriever
    llm: LLM
    top_k: int = 4

    def answer(self, question: str) -> dict:
        docs = self.retriever.search(question, k=self.top_k)
        if not docs:
            return {"answer": "관련 문서를 찾지 못했습니다.", "sources": []}

        context = "\n\n".join(docs)
        prompt = (
            "아래 컨텍스트만 근거로 답하라. 컨텍스트에 답이 없으면 "
            "모른다고 말하라.\n\n"
            f"컨텍스트:\n{context}\n\n질문: {question}\n답변:"
        )
        return {"answer": self.llm.complete(prompt), "sources": docs}
```

핵심은 "컨텍스트에 없으면 모른다고 말하라"는 지시를 프롬프트에서 빼먹지 않는 것 — 이 한 줄이 빠지면 검색이 실패했을 때 모델이 답을 지어낸다.

## Where This Breaks in Practice

- **청킹 크기**: 너무 잘게 자르면 문맥이 끊기고, 너무 크게 자르면 관련 없는 내용이 섞여 노이즈가 된다. 문서 구조(제목/문단)를 따라 자르는 게 고정 길이 자르기보다 대체로 낫다.
- **임베딩-질문 불일치**: 질문 문장과 문서 문장의 스타일이 다르면(짧은 질문 vs 긴 설명문) 임베딩 거리가 실제 관련성을 제대로 반영하지 못한다 — HyDE가 이 문제를 완화하는 이유다.
- **검색 품질을 눈으로만 판단하지 않기**: "그럴듯해 보이는 답"과 "실제로 맞는 답"은 다르다 — `llm_evaluation.md`의 MRR/NDCG/Precision@K로 정량 측정한다.

## Related Skills

- `llm_evaluation.md`: RAG 파이프라인의 검색 품질(MRR, NDCG, Precision@K)을 평가할 때
