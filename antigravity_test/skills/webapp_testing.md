---
name: webapp-testing
description: Automated testing of local web applications using Playwright. Use when verifying frontend functionality, debugging UI behavior, capturing screenshots, or checking browser console logs for a running local app.
---

# Web Application Testing

## Overview

Test local web applications using Playwright automation. Supports single or multiple concurrent servers (e.g., backend + frontend). Captures screenshots, inspects DOM, monitors console logs, and executes user interactions.

## Core Workflow: Reconnaissance First

Always follow **reconnaissance-then-action**:

1. Navigate to the app and wait for the UI condition needed by the test
2. Take a screenshot or inspect the DOM
3. Identify selectors from what's actually rendered
4. Execute interactions based on discovered elements

**Readiness:** wait for a relevant visible element or application state with Playwright assertions. Network silence is not a reliable readiness signal for polling or streaming apps. See the [Playwright load-state guidance](https://playwright.dev/docs/api/class-page#page-wait-for-load-state).

```python
from playwright.sync_api import sync_playwright, expect

with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page()
    page.goto("http://localhost:3000")
    expect(page.get_by_role("button", name="Submit")).to_be_visible()

    # Take screenshot for visual verification
    page.screenshot(path="screenshot.png")

    # Inspect rendered DOM
    content = page.content()

    # Find elements
    button = page.get_by_role("button", name="Submit")
    input_field = page.get_by_label("Email")
```

## Element Discovery Strategies

```python
# By role (most robust)
page.get_by_role("button", name="Login")
page.get_by_role("textbox", name="Username")

# By text content
page.get_by_text("Submit Form")

# By CSS selector (fallback)
page.locator(".submit-btn")
page.locator("#email-input")

# By test ID (best practice)
page.get_by_test_id("submit-button")
```

## Common Test Patterns

### Form Submission
```python
page.fill("#email", "test@example.com")
page.fill("#password", "password123")
page.click("button[type='submit']")
page.wait_for_url("**/dashboard")
```

### Console Log Monitoring
```python
logs = []
page.on("console", lambda msg: logs.append(msg.text))
page.goto("http://localhost:3000")
expect(page.get_by_role("heading", name="Dashboard")).to_be_visible()  # Match the actual app
print(logs)
```

### Screenshot Capture
```python
# Full page
page.screenshot(path="full.png", full_page=True)

# Specific element
page.locator(".chart-container").screenshot(path="chart.png")
```

### Multi-Server Setup (Backend + Frontend)
```python
import subprocess, time

backend = subprocess.Popen(["python", "server.py"])
frontend = subprocess.Popen(["npm", "run", "dev"])
time.sleep(2)  # Wait for servers to start

# Run tests...

backend.terminate()
frontend.terminate()
```

## Verification Checklist

- [ ] Page loads without JS errors in console
- [ ] Assertions confirm the required UI elements or application state are ready
- [ ] User interactions produce expected DOM changes
- [ ] Form submissions reach the correct endpoint
- [ ] Error states display correctly
- [ ] Screenshots confirm visual layout

## Anti-Patterns

| Anti-Pattern | Fix |
|---|---|
| Treat network silence as UI readiness | Assert the element or state needed by the test |
| Hard-coded CSS selectors | Prefer role/label/text selectors |
| No screenshot baseline | Take screenshots at each key step |
| Ignore console errors | Monitor and assert no unexpected errors |
