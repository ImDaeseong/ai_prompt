---
name: skill-writing-quality
description: Tighten a SKILL.md's prose for trigger cost, structure, and length before shipping it, or when an existing skill keeps mis-triggering or its body has grown long. Run this after drafting a skill and again after it has seen real use.
---

# Skill Writing Quality

Source: Matt Pocock, `writing-great-skills` (github.com/mattpocock/skills). This is a prose-quality pass, not a creation workflow — pair it with `skill_creator.md`, which covers drafting, testing, and iterating a skill end to end.

## Four checks

### 1. Trigger cost

A model-invoked skill's description sits in context every turn, whether or not the skill fires. Before adding a phrase to the description, ask: does this cover a genuinely different trigger, or restate one already covered? Keep one phrase per distinct trigger and drop synonyms. Lead with the skill's own first word so the description reads as a recognizable concept rather than a sentence to parse.

Note: `skill_creator.md` in this same folder advises the opposite for the same reason it names — under-triggering. It tells you to write "pushy," deliberately redundant descriptions so the skill doesn't get skipped. Don't resolve this by philosophy — resolve it by measurement. Default to lean (this repo carries 100+ skill descriptions in context every turn, so the tax on verbosity is real). Then run `skill_creator.md`'s own Description Optimization loop — the should-trigger / should-not-trigger eval queries — and only add redundant phrasing back in for the specific branch an eval run actually shows getting missed. Verbosity earns its place per branch, not by default.

### 2. Structure

The body should read as ordered steps, each with a clear sign that it's done. A definition, rule, or fact you'd only consult on demand isn't a step — give it its own heading near the bottom instead of inlining it mid-procedure. If that reference material grows past a screen or needs its own table of contents, split it into a separate file (see `skill_creator.md`'s Progressive Disclosure section) rather than letting SKILL.md keep growing.

### 3. Leading words

Reuse the same compact, already-pretrained term everywhere a concept appears — in the description and every place the body refers back to it. A label the model hasn't seen before is a definition it now has to learn; a term it already knows is a behavior it can just run.

### 4. Deletion test

For each line in the body, ask: if this were deleted, would the agent's output actually change? If not, delete it. Run this pass last, after the skill has handled a few real tasks — that's when it's clear which lines never earned their keep.

## When to run this

Once right after drafting, before first use. Once more after a handful of real runs, once you can see which lines never mattered and which triggers actually fired.
