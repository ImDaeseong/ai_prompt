---
name: frontend-design
description: Create visually distinctive web interfaces grounded in subject matter rather than generic templates. Use when designing UI, building design systems, or creating frontend layouts that need to feel intentional and unique.
---

# Frontend Design

## Core Philosophy

Design from the subject outward — not from templates inward. Every visual choice should feel specific to this product, this audience, this content.

---

## Two-Pass Process

### Pass 1: Build the Token System

Before writing any code, define a compact design system:

**Palette (4–6 named colors)**
```
--color-primary:   #1a1a2e   /* Deep navy — authority */
--color-accent:    #e94560   /* Coral red — action */
--color-surface:   #f5f5f0   /* Warm off-white — base */
--color-muted:     #8b8b8b   /* Mid-gray — secondary text */
--color-border:    #e0ddd8   /* Subtle separator */
```

**Typography Pair**
```css
/* Display: personality */
font-family: 'Playfair Display', Georgia, serif;

/* Body: legibility */
font-family: 'Inter', system-ui, sans-serif;
```

**Layout Concept** (pick one)
- Editorial: asymmetric grid, strong vertical rhythm
- Dashboard: data density, consistent spacing units
- Landing: progressive disclosure, z-axis depth
- Tool: functional clarity, keyboard-first

**Signature Element** — one distinctive choice:
- Unusual grid (7 columns, not 12)
- Exposed structure (visible grid lines)
- Monospaced type for data
- Strong typographic scale (8:1 ratio)

### Pass 2: Review Against the Brief

Before coding, verify each choice:
- Does the palette reflect the content domain?
- Does the typography pair communicate the right tone?
- Does the layout serve the primary user action?
- Is there one bold choice and everything else disciplined?

---

## Avoiding AI Design Defaults

These combinations are overused — avoid as primary aesthetic:

| Avoid | Because |
|-------|---------|
| Cream (#faf9f5) + serif display + terracotta | Ubiquitous in AI outputs |
| Near-black + acid-green (#00ff88) | Developer-aesthetic cliché |
| Full-bleed broadsheet layout | Newspaper pastiche |
| Purple/violet gradients | Startup template default |
| Inter font + gray-100 background + rounded-2xl | Tailwind starter default |

---

## Typographic Hierarchy

```css
/* Scale with intention — not uniform steps */
.display    { font-size: 4rem;    line-height: 1.05; font-weight: 800; }
.heading-1  { font-size: 2.25rem; line-height: 1.15; font-weight: 700; }
.heading-2  { font-size: 1.5rem;  line-height: 1.25; font-weight: 600; }
.body       { font-size: 1rem;    line-height: 1.65; font-weight: 400; }
.caption    { font-size: 0.875rem;line-height: 1.5;  font-weight: 400; }
.label      { font-size: 0.75rem; line-height: 1;    font-weight: 600; letter-spacing: 0.08em; text-transform: uppercase; }
```

---

## Structure as Information

Only use structural elements when they carry meaning:
- Numbered lists: order genuinely matters
- Borders: separation is functionally meaningful
- Color: encodes a specific data dimension
- Size: represents hierarchy or importance

**If you can remove a structural element and lose no information, remove it.**

---

## Writing in Design

Words appear in a design for one reason: to make it easier to understand.

```
❌ "Leverage our platform to optimize your workflow"
✅ "Save 2 hours per week on reporting"

❌ "Click here to get started"
✅ "Create your first project"

❌ "An error occurred"
✅ "Couldn't save — check your internet connection"
```

---

## Motion Principles

- **Purposeful**: Motion serves navigation, not decoration
- **Fast**: 150–250ms for micro-interactions, 300–400ms for page transitions
- **Respect preference**: `prefers-reduced-motion: reduce` must disable all animation

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

---

## Quality Fundamentals

- [ ] Responsive at 320px, 768px, 1280px, 1920px
- [ ] Keyboard navigable (Tab order logical, focus states visible)
- [ ] Color contrast ≥ 4.5:1 for body text, ≥ 3:1 for large text
- [ ] Motion respects `prefers-reduced-motion`
- [ ] One bold choice — everything else disciplined
