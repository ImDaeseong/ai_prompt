---
name: algorithmic-art
description: Create generative art using p5.js with seeded randomness and interactive parameter exploration. Use when generating computational art, creative coding projects, or interactive visual artifacts.
---

# Algorithmic Art Generator

## Overview

Create original generative art through two phases:
1. **Philosophy** — define a computational aesthetic manifesto
2. **Implementation** — express it in p5.js as a self-contained HTML artifact

Each seed produces a unique variation. Seed navigation replaces multiple static files.

---

## Phase 1: Algorithmic Philosophy

Write 4–6 paragraphs defining the generative movement:

### Naming
Choose a movement name (1–2 words):
- Examples: "Thermal Drift", "Void Lattice", "Chromatic Decay", "Stochastic Growth"

### Philosophy Components
- **Computational process**: What algorithm drives the work?
- **Noise functions**: How does randomness manifest? (Perlin noise, simplex, gaussian)
- **Particle behaviors**: What rules govern elements?
- **Temporal evolution**: How does the piece change over time or seeds?
- **Parametric variation**: What qualities can be tuned?

### Craft Language
Frame the work as mastery:
- "meticulously crafted through deep expertise"
- "refined through countless iterations"
- "master-level implementation of emergent complexity"

### Subtle Reference
Embed one niche concept as algorithmic DNA — recognizable to those who know it, beautiful to those who don't.

---

## Phase 2: p5.js Implementation

### HTML Artifact Structure

```html
<!DOCTYPE html>
<html>
<head>
  <title>[Movement Name]</title>
  <!-- Poppins + Lora fonts (Anthropic brand) -->
  <style>
    /* Fixed layout: header | sidebar | canvas */
    body { font-family: 'Poppins', sans-serif; background: #faf9f5; }
  </style>
</head>
<body>
  <!-- Header with title -->
  <!-- Sidebar: seed controls + parameters + actions -->
  <!-- Canvas area -->

  <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.9.0/p5.min.js"></script>
  <script>
    // Seeded randomness (Art Blocks pattern)
    let currentSeed = Math.floor(Math.random() * 1000000);

    // Parameters object
    const params = {
      elementCount: { value: 200, min: 50, max: 500, label: "Elements" },
      speed: { value: 0.5, min: 0.1, max: 2.0, label: "Speed" },
      // ... more params
    };

    // p5.js sketch
    const sketch = (p) => {
      p.setup = () => {
        p.randomSeed(currentSeed);
        p.noiseSeed(currentSeed);
        p.createCanvas(800, 600);
        initialize();
      };

      p.draw = () => {
        // Core algorithm
      };
    };

    new p5(sketch, 'canvas-container');
  </script>
</body>
</html>
```

### Seeded Randomness (Required)
```javascript
// Art Blocks pattern — always use this
p.randomSeed(currentSeed);
p.noiseSeed(currentSeed);

// Use p.random() and p.noise() — NOT Math.random()
const x = p.random(0, p.width);
const n = p.noise(x * 0.01, frameCount * 0.005);
```

### Required Interactive Controls

**Seed Navigation**:
```javascript
function previousSeed() { currentSeed = Math.max(0, currentSeed - 1); restart(); }
function nextSeed() { currentSeed++; restart(); }
function randomSeed() { currentSeed = Math.floor(Math.random() * 1000000); restart(); }
function jumpToSeed(val) { currentSeed = parseInt(val); restart(); }
```

**Parameter Sliders**:
```html
<input type="range" min="50" max="500" value="200"
  oninput="params.elementCount.value = +this.value; restart()">
```

**Action Buttons**: Regenerate, Reset, Download PNG

---

## Parameter Design

Ask: "What qualities of this system can be tuned?"

| Quality | Parameter Type |
|---------|---------------|
| Population | count (integer) |
| Scale relationships | ratio (float 0–2) |
| Animation rate | speed (float) |
| Randomness amount | noise scale (float) |
| Direction | angle (float 0–360) |
| Interaction | threshold (float) |

Avoid generic "pattern type" dropdowns — emerge parameters from the philosophy.

---

## Craftsmanship Standards

| Quality | How to Achieve |
|---------|---------------|
| Emergent complexity | Rules that interact unexpectedly |
| Visual balance | Contrast between dense and sparse regions |
| Color harmony | 3–5 colors with intentional relationships |
| Performance | 60fps at default params |
| Reproducibility | Same seed = same output, always |

---

## Common Algorithms

```javascript
// Perlin noise flow field
const angle = p.noise(x * scale, y * scale, t) * p.TWO_PI * 4;

// Particle system
class Particle {
  constructor() {
    this.pos = p.createVector(p.random(p.width), p.random(p.height));
    this.vel = p.createVector(0, 0);
    this.acc = p.createVector(0, 0);
  }
  update() {
    this.vel.add(this.acc);
    this.vel.limit(maxSpeed);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }
}

// Recursive subdivision
function subdivide(x, y, w, h, depth) {
  if (depth === 0 || p.random() < 0.3) {
    p.rect(x, y, w, h);
    return;
  }
  if (w > h) {
    subdivide(x, y, w/2, h, depth - 1);
    subdivide(x + w/2, y, w/2, h, depth - 1);
  } else {
    subdivide(x, y, w, h/2, depth - 1);
    subdivide(x, y + h/2, w, h/2, depth - 1);
  }
}
```

---

## Output

Single self-contained HTML file:
- No external files (p5.js via CDN only)
- Opens in any browser without server
- All controls functional
- Download as PNG supported
