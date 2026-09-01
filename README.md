# Prox Search Capital — website

Static HTML/CSS site. No build step, no dependencies. Open `index.html` or drop the
whole folder on any host.

## Pages

| File | Nav label |
|---|---|
| `index.html` | Overview |
| `about.html` | About |
| `for-sponsors.html` | For Sponsors |
| `portfolio.html` | Portfolio |
| `insights.html` | Insights |
| `investors.html` | Investors |
| `submit.html` | Submit a Deal (header CTA) |
| `privacy-policy.html` | Footer only |

**Investment Criteria was merged into For Sponsors.** The old page is gone; its
"Not a Fit" and "What to Send" sections now live on `for-sponsors.html`, and the
parameters table sits under the anchor `#what-we-invest-in`. Every link that used to
point at `investment-criteria.html` now points at `for-sponsors.html#what-we-invest-in`.
**If the old URL was ever published, add a 301 to the new anchor.**

## Structure

```
css/tokens.css   Brand tokens (colors, type, spacing) — from the Feb 2025 brand guide
css/site.css     All site styles, composed from those tokens
js/site.js       Mobile nav toggle. That is the only script.
assets/logos/    Primary, stacked, and brandmark lockups in color / black / white
assets/elements/ Focus frame and crosshair SVGs from the brand system
assets/img/      Photography, resized to max 1800px and re-encoded at quality 82
```

Header and footer are duplicated in every page. If you change one, change all eight.

## Layout components

Reach for these before inventing something new.

| Class | What it is |
|---|---|
| `.photoband` | Full-bleed grayscale photo under a green wash, white copy on top. The signature band. Needs a child `<img class="photoband__img">`. |
| `.photostrip` | Full-bleed photo at full colour, no copy. A visual break between sections. |
| `.process` / `.process--3` | Numbered rail. Nodes on a connector that darkens toward the last step. Goes vertical below 1140px. |
| `.feature-list` | Hairline-topped columns with a blue eyebrow label. Replaces filled card grids. `--2` and `--3` set the column count. |
| `.rule-list` | Hairline rows with a blue dash. Replaces bulleted checklists. |
| `.rule-list--muted` | Same, greyed with a tick glyph. For exclusions, so a "no" never looks like a "yes". |
| `.section-head--split` | Big title left, supporting copy right. |
| `.page-hero__grid` | Same idea for page heroes. |
| `.facts` | Five-column parameter strip. Add `.facts--filled` for green cells with white values. |
| `.framed` | Focus-frame brackets on an image. |
| `.card`, `.step` | The older filled containers. Still used on Portfolio and Insights. |

On green and photo bands, blue accents invert to `#C3FDE8`. Blue on green fails
contrast badly, so do not force it back.

## Numbers used across the site

From the Thesis Changes section of the pivot doc:

- **Business size** — adjusted EBITDA of $1M–$5M
- **Check size** — $500K–$1.1M, capped at 10% of the fund
- **Position** — minority, non-control equity of 5%–20%
- **Geography** — US based, lower 48
- **Industry** — agnostic
- **No SBA**

Search for `$1M` and `$500K` if you change them.

## Photography

| File | Used on |
|---|---|
| `hero-team.jpg` | Overview hero |
| `deal-workshop.jpg` | Overview photoband |
| `whiteboard.jpg` | About, Our Story |
| `built-by-operators.jpg` | About photoband — IMG_0081 from the Aug 2025 shoot |
| `deal-process.jpg` | Investors photoband — IMG_0284 from the Aug 2025 shoot |
| `adam-headshot.jpg`, `peggy-headshot.jpg`, `eliza-headshot.jpg` | About, team |
| ~~`one-pager.jpg`~~ | Removed — the printed one-pager shows the old self-funded thesis (SBA, search funds) and its print green is off-brand. Legible even under the photoband wash. |
| `deal-notes.jpg` | For Sponsors photoband, Portfolio photoband |
| `peggy-phone.jpg` | For Sponsors, Submit |
| `adam-speaking.jpg` | Insights |
| `adam-portrait.jpg`, `peggy-adam.jpg` | Spares — not currently placed |

Three from the zip were left out: the Jenga shot (the mural clashes with the palette),
the November panel shot (dark, red curtain), and the SMBash photo (it carries the
SMBootcamp brand, which the pivot doc says you are discontinuing).

## Before this goes live

1. **Wire the two forms.** `submit.html` and the newsletter signup on `insights.html`
   both `POST` to `#`. Point them at a handler and add spam protection.
2. **Portfolio holdings are live** — five investments, described by sector and year
   with no company names. Confirm each sponsor is comfortable before adding names.
3. **Write the Insights pieces.** Three headlines and deks are drafted; the articles
   are not written. The `Read` links point to `#`.
4. **Review Investors.** Drafted from your fund facts. Have counsel read the page and
   the disclaimer.
5. **Team titles** are Managing Director for all three, confirmed. Adam's founder
   status is carried in the Our Story copy and in his bio, not in a title.
6. **LinkedIn company URL.** The footer links to
   `linkedin.com/company/prox-search-capital/` — verify that is the right handle.
7. **Redirects.** The old site is a single page with `#contact-sec` anchors. Point
   those at `submit.html`, and redirect `investment-criteria.html` if it was ever live.
8. **Logo files are PNG only.** Fine at header and footer size. Get SVG or EPS before
   using them anywhere large.

## Notes on the brand

- Headings are Urbanist, body is Open Sans, both from Google Fonts.
- Primary green is `#0B6756`. The tint ramp in `tokens.css` handles hover, emphasis,
  and the process rail — do not introduce new greens.
- Prox Blue `#087CC1` is an accent only: eyebrow labels, list dashes, chip dots, and
  the keyboard focus ring. Never headings, never large fills.
- Recurring devices: the dashed corner-bracket section marker (`.marker`), the
  dashed-bracket button (`.btn--bracket`), the focus frame (`.framed`), and one
  crosshair per page at most.
- Full-bleed green and photo bands are emphasis moments. Roughly one or two per page;
  more than that flattens the effect.

## Local preview

```
powershell -ExecutionPolicy Bypass -File serve.ps1
```

Serves the folder at http://localhost:8123.
