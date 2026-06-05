---
name: ui-ux-pro-max
description: AI-powered design intelligence for professional UI/UX systems. Use when building any UI — provides design system generation, style/color/font/UX guidelines. Works as reference guidelines even without CLI installation. For full database search (67 styles, 161 palettes, 57 fonts), install via `npm install -g uipro-cli`.
source: https://github.com/nextlevelbuilder/ui-ux-pro-max-skill
license: MIT
---

## How to Use This Skill

Use when the user requests any of the following:

| Scenario | Trigger Examples |
|----------|-----------------|
| **New project / page** | "Build a landing page", "Build a dashboard" |
| **New component** | "Create a pricing card", "Add a modal" |
| **Choose style / color / font** | "What style fits a fintech app?", "Recommend a color palette" |
| **Review existing UI** | "Review this page for UX issues", "Check accessibility" |
| **Fix a UI bug** | "Button hover is broken", "Layout shifts on load" |
| **Improve / optimize** | "Improve mobile experience" |
| **Implement dark mode** | "Add dark mode support" |
| **Add charts / data viz** | "Add an analytics dashboard chart" |

## Step 1: Analyze User Requirements

Extract key information from the user request:
- **Product type**: Entertainment, Tool, Productivity, E-commerce, SaaS, Healthcare, etc.
- **Target audience**: Consumer vs professional, age group, usage context
- **Style keywords**: playful, vibrant, minimal, dark mode, content-first, immersive, etc.
- **Tech stack**: React, Vue, Next.js, Flutter, SwiftUI, HTML+Tailwind, etc.

## Step 2: Design System (if CLI installed)

If `uipro-cli` is installed, generate a complete design system:

```bash
python3 skills/ui-ux-pro-max/scripts/search.py "<product_type> <industry> <keywords>" --design-system [-p "Project Name"]
```

This returns: pattern, style, colors, typography, effects, and anti-patterns to avoid.

**Domain searches:**
```bash
python3 skills/ui-ux-pro-max/scripts/search.py "<keyword>" --domain <domain>
```

| Domain | Use For |
|--------|---------|
| `product` | Product type recommendations |
| `style` | UI styles (glassmorphism, minimalism, brutalism) |
| `typography` | Font pairings |
| `color` | Color palettes by product type |
| `landing` | Page structure and CTA strategies |
| `chart` | Chart types and library recommendations |
| `ux` | Best practices and anti-patterns |

**Install CLI:**
```bash
npm install -g uipro-cli
uipro init --ai claude
```

---

## Professional UI Rules (Always Apply)

### Icons & Visual Elements

| Rule | Standard | Avoid |
|------|----------|--------|
| **No Emoji as Icons** | Use vector icons (Phosphor, Heroicons, etc.) | Emojis (🎨 🚀 ⚙️) for navigation or system controls |
| **Vector-Only Assets** | SVG or platform vector icons | Raster PNG icons that blur |
| **Consistent Icon Sizing** | Design tokens (icon-sm, icon-md=24pt, icon-lg) | Mixing arbitrary sizes randomly |
| **Stroke Consistency** | Consistent stroke width per layer (1.5px or 2px) | Mixing thick and thin stroke styles |
| **Filled vs Outline Discipline** | One icon style per hierarchy level | Mixing filled and outline at same level |
| **Touch Target Minimum** | ≥44×44pt interactive area | Small icons without expanded tap area |
| **Icon Contrast** | WCAG 4.5:1 for small, 3:1 minimum for large | Low-contrast icons blending into background |

### Interaction

| Rule | Do | Don't |
|------|----|----- |
| **Tap feedback** | Clear pressed feedback within 80-150ms | No visual response on tap |
| **Animation timing** | 150-300ms with platform-native easing | Instant or slow animations (>500ms) |
| **Touch target minimum** | ≥44×44pt (iOS) or ≥48×48dp (Android) | Tiny tap targets without padding |
| **Gesture conflict prevention** | One primary gesture per region | Overlapping gestures causing accidental actions |
| **Disabled state clarity** | Reduced emphasis, no tap action | Controls that look tappable but do nothing |

### Light/Dark Mode Contrast

| Rule | Do | Don't |
|------|----|----- |
| **Text contrast (light)** | Body text contrast ≥4.5:1 | Low-contrast gray body text |
| **Text contrast (dark)** | Primary ≥4.5:1, secondary ≥3:1 on dark surfaces | Dark mode text blending into background |
| **Token-driven theming** | Semantic color tokens per theme | Hardcoded per-screen hex values |
| **Modal/scrim legibility** | 40-60% black scrim for modals | Weak scrim competing with foreground |

### Layout & Spacing

| Rule | Do | Don't |
|------|----|----- |
| **Safe-area compliance** | Respect top/bottom safe areas for fixed headers, tab bars | Placing fixed UI under notch or gesture area |
| **8dp spacing rhythm** | Consistent 4/8dp spacing system | Random spacing with no rhythm |
| **Scroll and fixed elements** | Add insets so lists aren't hidden behind fixed bars | Scroll content obscured by sticky headers |
| **Adaptive gutters** | Increase insets on larger widths and landscape | Same narrow gutter on all device sizes |

---

## Pre-Delivery Checklist

### Visual Quality
- [ ] No emojis used as icons (use SVG instead)
- [ ] All icons from a consistent icon family and style
- [ ] Pressed-state visuals do not shift layout bounds or cause jitter
- [ ] Semantic theme tokens used consistently (no ad-hoc hardcoded colors)

### Interaction
- [ ] All tappable elements provide clear pressed feedback
- [ ] Touch targets meet minimum size (≥44×44pt iOS, ≥48×48dp Android)
- [ ] Micro-interaction timing 150-300ms with native-feeling easing
- [ ] Disabled states visually clear and non-interactive
- [ ] Screen reader focus order matches visual order

### Light/Dark Mode
- [ ] Primary text contrast ≥4.5:1 in both light and dark mode
- [ ] Secondary text contrast ≥3:1 in both modes
- [ ] Both themes tested before delivery

### Layout
- [ ] Safe areas respected for headers, tab bars, bottom CTA bars
- [ ] Scroll content not hidden behind fixed/sticky bars
- [ ] Verified on small phone, large phone, and tablet (portrait + landscape)
- [ ] 4/8dp spacing rhythm maintained across component, section, and page levels

### Accessibility
- [ ] All meaningful images/icons have accessibility labels
- [ ] Color is not the only indicator
- [ ] Reduced motion and dynamic text size supported
- [ ] Accessibility traits/roles/states announced correctly
