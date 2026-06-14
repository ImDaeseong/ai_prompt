---
name: web-artifacts-builder
description: Build sophisticated React-based HTML artifacts using modern frontend technologies. Use when creating interactive web UIs, dashboards, or tools that need to be bundled into a single self-contained HTML file for sharing.
---

# Web Artifacts Builder

## Overview

Create multi-component React applications and bundle them into a single self-contained HTML file. All dependencies are inlined — no server or build step required to view.

## Tech Stack

- React 18 + TypeScript
- Vite (dev) + Parcel (bundling)
- Tailwind CSS + shadcn/ui (40+ components)

## Workflow

### Step 1: Initialize Project

```bash
bash scripts/init-artifact.sh <project-name>
cd <project-name>
```

This sets up:
- React 18 + TypeScript + Vite
- Tailwind CSS with shadcn/ui theming
- 40+ pre-installed UI components
- Parcel bundling configuration
- Path aliases (`@/` → `src/`)

### Step 2: Develop

```bash
npm run dev  # Hot reload at localhost:5173
```

Structure:
```
src/
├── App.tsx          ← Main component
├── components/      ← Reusable components
│   └── ui/          ← shadcn/ui components
├── lib/
│   └── utils.ts     ← cn() utility
└── main.tsx
```

### Step 3: Bundle to Single HTML

```bash
bash scripts/bundle.sh
# Output: dist/artifact.html (fully self-contained)
```

### Step 4: Share

The `artifact.html` file contains everything inline — open directly in any browser.

---

## shadcn/ui Components

```tsx
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Badge } from "@/components/ui/badge"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Progress } from "@/components/ui/progress"
```

Full docs: https://ui.shadcn.com/docs/components

---

## Design Guidelines

Avoid default AI aesthetics:
- ❌ Centered layouts with max-w-sm cards
- ❌ Purple/violet gradients
- ❌ Uniform rounded corners on everything
- ❌ Inter font with gray-100 backgrounds

Instead:
- ✅ Purpose-driven layout (dashboard, tool, report)
- ✅ Color palette from the content domain
- ✅ Deliberate typographic hierarchy
- ✅ Components that earn their place

---

## Example: Dashboard Component

```tsx
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Progress } from "@/components/ui/progress"

export function MetricCard({ title, value, trend, progress }: {
  title: string
  value: string
  trend: "up" | "down"
  progress: number
}) {
  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between pb-2">
        <CardTitle className="text-sm font-medium">{title}</CardTitle>
        <Badge variant={trend === "up" ? "default" : "destructive"}>
          {trend === "up" ? "↑" : "↓"}
        </Badge>
      </CardHeader>
      <CardContent>
        <div className="text-2xl font-bold">{value}</div>
        <Progress value={progress} className="mt-2" />
      </CardContent>
    </Card>
  )
}
```

---

## Verification Checklist

- [ ] `npm run build` passes without TypeScript errors
- [ ] Bundle produces single HTML file (no external dependencies)
- [ ] Opens correctly in browser without server
- [ ] Responsive layout works at 320px–1440px
- [ ] No console errors on load
