---
name: mcp-builder
description: Guide for creating high-quality MCP (Model Context Protocol) servers that enable LLMs to interact with external services through well-designed tools. Use when building MCP servers to integrate external APIs or services, whether in Python (FastMCP) or Node/TypeScript (MCP SDK).
---

# MCP Server Development Guide

## Overview

Create MCP servers that enable LLMs to interact with external services through well-designed tools. Quality is measured by how well the server enables LLMs to accomplish real-world tasks.

---

## Process: 4 Phases

### Phase 1: Deep Research and Planning

#### API Coverage vs. Workflow Tools
Balance comprehensive API coverage with specialized workflow tools. When uncertain, prioritize comprehensive API coverage — agents need flexibility to compose operations.

#### Tool Naming and Discoverability
Use consistent prefixes and action-oriented naming:
- `github_create_issue`, `github_list_repos`
- Clear, descriptive names help agents find the right tool quickly

#### Context Management
Design tools that return focused, relevant data. Include filtering and pagination support. Concise tool descriptions outperform verbose ones.

#### Actionable Error Messages
Error messages must guide agents toward solutions with specific suggestions and next steps.

#### Recommended Stack
- **Language**: TypeScript (recommended) — broad usage, static typing, good LLM code generation
- **Transport**: Streamable HTTP for remote servers (stateless JSON), stdio for local servers
- **Python alternative**: FastMCP framework

---

### Phase 2: Implementation

#### Core Infrastructure
- API client with authentication
- Error handling helpers
- Response formatting (JSON/Markdown)
- Pagination support

#### Tool Implementation Checklist
For each tool:

**Input Schema** (Zod for TS, Pydantic for Python):
- Include constraints and clear field descriptions
- Add examples in field descriptions

**Output**:
- Define `outputSchema` for structured data
- Use `structuredContent` in tool responses (TypeScript SDK)
- Return both text content and structured data

**Annotations**:
- `readOnlyHint`: true/false
- `destructiveHint`: true/false
- `idempotentHint`: true/false
- `openWorldHint`: true/false

---

### Phase 3: Review and Test

#### Code Quality
- No duplicated code (DRY)
- Consistent error handling
- Full type coverage
- Clear tool descriptions

#### Testing
```bash
# TypeScript
npm run build
npx @modelcontextprotocol/inspector

# Python
python -m py_compile your_server.py
npx @modelcontextprotocol/inspector
```

---

### Phase 4: Create Evaluations

Create 10 evaluation questions to test LLM effectiveness with your server.

Each question must be:
- **Independent**: Not dependent on other questions
- **Read-only**: Only non-destructive operations
- **Complex**: Requires multiple tool calls
- **Realistic**: Based on real use cases
- **Verifiable**: Single, clear answer

```xml
<evaluation>
  <qa_pair>
    <question>Your complex question here</question>
    <answer>Expected answer</answer>
  </qa_pair>
</evaluation>
```

---

## MCP Protocol Reference

- Spec: `https://modelcontextprotocol.io/sitemap.xml`
- TypeScript SDK: `https://raw.githubusercontent.com/modelcontextprotocol/typescript-sdk/main/README.md`
- Python SDK: `https://raw.githubusercontent.com/modelcontextprotocol/python-sdk/main/README.md`

## Anti-Patterns

| Anti-Pattern | Fix |
|---|---|
| Vague tool names | Use `service_action_object` convention |
| Missing pagination | Always support page/cursor for list operations |
| Silent errors | Return actionable error messages with next steps |
| Monolithic tools | Split into focused, composable operations |
| No type annotations | Full type coverage required |
