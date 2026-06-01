# Do They Like You? — Crush Calculator

A self-contained web app that estimates the probability your crush likes you back. It walks you through a branching flowchart of romantic-signal questions (tailored to whether you know them in person, online, or from afar), weighs each answer as evidence, and returns a bounded probability with a playful verdict and an honest "outside observer" read.

Built as a single HTML file with zero dependencies and no build step. Installs as a PWA — add it to your home screen for a fullscreen, offline-capable app with its own icon.

## Features

- **Branching question flow** — three tracks (in-person / online / from-afar) plus a shared deep "core" set
- **Calibrated scoring** — logistic model in log-odds space; returns a probability *with a confidence range*, not false certainty
- **Quick vs. deep read** — a ~5-question quick path or a ~15-question deep dive, calibrated to feel comparable
- **Low-signal humility guard** — refuses to fake a number when the evidence is too thin, and tells you what to watch for instead
- **Shareable result card** — generated client-side with Canvas
- **Past reads history** — saved locally in your browser
- **Installable PWA** — fullscreen, offline-capable, home-screen icon

## Run it locally

It's a single static file — no build step. Open `index.html` directly in a browser, or serve the folder:

```powershell
# Windows / PowerShell (included helper)
./serve.ps1            # serves on http://localhost:8777
```

Any static file server works (`python -m http.server`, `npx serve`, etc.).

## Deploy

Drag the folder onto **[Netlify Drop](https://app.netlify.com/drop)** for an instant URL, or push to a repo and enable **GitHub Pages** (Settings → Pages → deploy from `main`, root).

The files needed in production are:

```
index.html
manifest.webmanifest
sw.js
tools/icon.svg
tools/icon-192.png
tools/icon-512.png
tools/apple-touch-icon.png
```

(`serve.ps1` and `generate-icons.ps1` are local dev helpers — they don't need to ship.)

## Install on your phone

Open the deployed URL on your phone, then:

- **iPhone (Safari):** Share → *Add to Home Screen*
- **Android (Chrome):** ⋮ → *Install app* / *Add to Home Screen*

It launches fullscreen with no browser bar and works offline after the first load.

## Languages used

- **HTML5** — single-file app structure, semantic markup, PWA meta tags
- **CSS3** — responsive layout, custom properties, gradients, animations, mobile-first media queries
- **JavaScript (vanilla, ES6+)** — all logic, no frameworks or libraries
- **JSON** — web app manifest
- **SVG** — scalable app icon
- **PowerShell** — local static dev server + icon generation tooling

## Skills demonstrated

**Frontend / UX**
- Zero-dependency, single-file architecture (no build tooling, fully portable)
- Responsive, mobile-first design with touch-friendly controls
- Animated reveal, progress tracking, and shareable result cards (Canvas)
- State management and dynamic view rendering in plain JS

**Progressive Web App**
- Web app manifest + installability (Add to Home Screen)
- Service worker with cache-first offline support
- iOS/Android-specific meta tags, theme color, maskable icons

**Applied logic / modeling**
- Logistic (sigmoid) scoring in log-odds space with calibrated weights
- Branching question graph with multiple paths and a shared deep "core"
- Confidence-range output and a low-signal humility guard
- Two interview depths (quick vs. deep) with curve calibration

**Tooling**
- Custom PowerShell static server and programmatic icon generation (System.Drawing)

## How the scoring works

Each answer carries an evidence weight in log-odds. The app sums them and maps the total through a logistic function:

```
p = 1 / (1 + e^(-k · evSum))
```

The result is clamped to a sane range and paired with a confidence band that widens when the evidence is sparse or conflicting. It's a deliberately humble model — it would rather say "too soon to tell" than overclaim.

## Disclaimer

This is for fun. It's a structured way to reflect on signals you've already noticed — not a verdict on another person's feelings. The only reliable way to find out if someone likes you is kind, honest communication.
