---
name: doc-coauthoring
description: Structured 3-stage workflow for co-authoring technical documents, specs, proposals, and decision documents. Use when writing a doc, drafting a proposal, or creating a technical spec collaboratively.
---

# Doc Co-Authoring Workflow

## Overview

A structured three-stage process for creating documents that actually work for readers. Prioritizes catching blind spots before the document circulates widely.

---

## Stage 1: Context Gathering

Close knowledge gaps before writing anything.

### Meta-Questions to Ask
- What type of document? (spec, proposal, decision doc, FAQ, status report)
- Who is the primary audience? What do they already know?
- What action should readers take after reading?
- What constraints exist? (length, tone, deadline, format)
- What's the key tension or decision this document resolves?

### Info Dump
Ask the author to dump everything relevant:
- Background context
- Stakeholder concerns
- Prior decisions and why they were made
- Known objections
- Data or evidence available

**Do NOT start writing until this stage is complete.**

---

## Stage 2: Refinement & Structure

Build the document section by section using this loop:

```
For each section:
1. Clarifying questions (what specific info is needed?)
2. Brainstorm 5-20 options for structure/framing
3. Curate to the best 2-3 options
4. Draft the section
5. Iterate with targeted edits (not full rewrites)
```

### Editing Rules
- Use `str_replace` for targeted edits — never reprint the full document
- Provide artifact link after each change
- One section at a time — don't jump ahead
- Preserve the author's voice and intent

### Common Section Types

| Section | Purpose |
|---------|---------|
| Problem Statement | What pain does this solve? Why now? |
| Proposal / Solution | What are we doing? |
| Alternatives Considered | What else was evaluated and why rejected? |
| Success Criteria | How do we know it worked? |
| Risks & Mitigations | What could go wrong? |
| Open Questions | What's still unresolved? |
| Timeline | When does each piece happen? |

---

## Stage 3: Reader Testing

Test the document before sharing widely.

### Predict Reader Questions
For each major section, ask:
- "What will a reader unfamiliar with the background think here?"
- "What assumption am I making that I haven't stated?"
- "Where will readers disagree — and have I addressed it?"

### Fresh Eyes Test
If possible, share with a Claude instance that has no conversation history:
- Give only the document (no context)
- Ask: "What questions do you have after reading this?"
- Ask: "What is the main action the author wants you to take?"
- Gaps in comprehension = gaps in the document

### Quality Bar
The document passes when:
- [ ] A reader with only domain knowledge (not project context) can understand it
- [ ] The key decision or action is clear by the end
- [ ] Objections are acknowledged, not ignored
- [ ] No internal jargon without definition
- [ ] Length matches audience patience

---

## When to Skip Stages

Users can opt out of any stage:
- Short docs: Skip Stage 1, go straight to drafting
- Known audience: Skip parts of Stage 3
- Time pressure: Compress Stage 2 to one pass

The workflow adapts to what the document actually needs — not every doc needs all three stages at full depth.

---

## Anti-Patterns

| Anti-Pattern | Fix |
|---|---|
| Writing before understanding the audience | Always ask Stage 1 questions first |
| Reprinting full document for every edit | Use targeted `str_replace` edits |
| Skipping reader testing | At minimum, do the "predict reader questions" exercise |
| Using internal jargon without definition | Define every term the audience may not know |
| Optimizing for author satisfaction | Optimize for reader comprehension |
