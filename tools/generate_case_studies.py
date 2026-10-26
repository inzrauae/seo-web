"""Generate anonymized SEO case study pages from tools/case_studies.json.

Run from the repo root:
    python tools/generate_case_studies.py
Test without touching the site:
    python tools/generate_case_studies.py --data tools/case_studies.example.json --out <folder> --allow-unverified

An entry is only published when it is marked "verified": true. Client names and domains are
omitted; add evidence images only when they are available and approved for publication.
"""
import argparse
import json
import os
import sys
from html import escape

sys.path.insert(0, os.path.dirname(__file__))
import generate_playbooks as g  # noqa: E402  (reuses the page shell, head and schema helpers)

e, ld, head, breadcrumb_ld = g.e, g.ld, g.head, g.breadcrumb_ld
ROOT, SITE, HEADER, FOOTER = g.ROOT, g.SITE, g.HEADER, g.FOOTER
HUB = "case-studies"
FOOTER = FOOTER.replace(
    "Buddhika S. Weerasekara &ndash; Sri Lanka&#39;s <a href=\"/\" style=\"color:#f4d976;font-weight:600;\">#1 SEO Consultant in Sri Lanka</a>. As the leading SEO Consultant Sri Lanka, I specialize in 100% white-hat SEO, technical audits, and Generative Engine Optimization (GEO) for businesses of all sizes.",
    "SEO Consultant Sri Lanka is powered by Applantics (Pvt) Ltd. Buddhika S Weerasekara provides SEO consulting, technical audits, and Generative Engine Optimization.",
).replace(
    '<li><a href="seo-consultant-sri-lanka-guide">SEO consultant guide</a></li>',
    '<li><a href="case-studies">SEO case studies</a></li>\n                    <li><a href="seo-consultant-sri-lanka-guide">SEO consultant guide</a></li>',
)
REQUIRED = ["slug", "meta_title", "title", "description", "service", "industry", "markets", "date",
            "duration", "stats", "summary", "methods"]


def dims(path):
    try:
        from PIL import Image
        with Image.open(path) as im:
            return im.size
    except Exception:
        return None


def validate(c, allow_unverified):
    errs = [f"missing '{k}'" for k in REQUIRED if not c.get(k)]
    if not c.get("verified") and not allow_unverified:
        errs.append('not marked "verified": true')
    if len(c.get("meta_title", "")) > 60:
        errs.append("meta_title over 60 characters")
    if len(c.get("description", "")) > 160:
        errs.append("description over 160 characters")
    for p in c.get("proof", []):
        if not os.path.exists(os.path.join(ROOT, p.get("image", ""))):
            errs.append(f"proof image not found: {p.get('image')}")
        if not p.get("alt") or not p.get("caption"):
            errs.append(f"proof image needs alt and caption: {p.get('image')}")
    return errs


def paras(items):
    return "".join(f"            <p>{e(t)}</p>\n" for t in items)


def page(c, out_dir):
    slug, url = c["slug"], f"{SITE}/{c['slug']}"
    nda = c.get("nda", False)
    kws = [c["service"].lower(), f"{c['industry'].lower()} seo", "seo case study"]
    html = head(c["meta_title"], c["description"], slug, kws)
    article = {
        "@context": "https://schema.org", "@type": "Article", "@id": url + "#article",
        "headline": c["title"], "description": c["description"], "url": url, "inLanguage": "en",
        "datePublished": c["date"], "dateModified": c.get("modified", c["date"]),
        "author": {"@id": SITE + "/#person"}, "publisher": {"@id": SITE + "/#organization"},
        "mainEntityOfPage": url, "about": [c["service"], c["industry"]],
    }
    if c.get("proof"):
        article["image"] = f"{SITE}/{c['proof'][0]['image']}"
    html += ld(article)
    html += ld(breadcrumb_ld([("Home", SITE + "/"), ("Case Studies", f"{SITE}/{HUB}"), (c["title"], url)]))
    html += '    <link rel="icon" type="image/png" href="assets/img/favicon.png">\n</head>\n' + HEADER

    stats = "".join(
        f'            <div class="card cs-stat"><div class="cs-stat-value">{e(s["value"])}</div><p>{e(s["label"])}</p></div>\n'
        for s in c["stats"])
    proof = ""
    for p in c.get("proof", []):
        d = dims(os.path.join(ROOT, p["image"]))
        size = f' width="{d[0]}" height="{d[1]}"' if d else ""
        proof += (f'        <figure class="cs-figure"><img loading="lazy" src="{e(p["image"])}" alt="{e(p["alt"])}"{size}>'
                  f'<figcaption>{e(p["caption"])}</figcaption></figure>\n')
    methods = "".join(f"            <li>{e(m)}</li>\n" for m in c["methods"])
    scope = (
        f"This anonymized {c['industry']} campaign applied {c['service']} "
        f"for {c['markets']}, with a reported timeframe of {c['duration']}."
    )
    metric_labels = ", ".join(s["label"] for s in c["stats"])
    method_summary = ", ".join(c["methods"])
    nda_block = ""
    if nda:
        nda_block = f"""<section class="section section-alt">
    <div class="container">
        <div class="prose">
            <h2>Client Identity Withheld</h2>
            <p>{e(c.get("nda_note", "The client name and website are omitted. The industry, market, campaign summary, and reported measurements are shared without identifying the business."))}</p>
        </div>
    </div>
</section>

"""
    html += f"""<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Case Study &middot; {e(c["service"])}{" &middot; Anonymized" if c.get("anonymized", True) else ""}</span>
        <h1>{e(c["title"])}</h1>
        <p>{e(c["description"])}</p>
        <div class="breadcrumb"><a href="/">Home</a> / <a href="{HUB}">Case Studies</a> / {e(c["service"])}</div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="cs-tags"><span>{e(c["industry"])}</span><span>{e(c["service"])}</span><span>{e(c["markets"])}</span>{f'<span>{e(c["duration"])}</span>' if c.get("duration") else ""}</div>
        <div class="grid grid-3 cs-stats">
{stats}        </div>
    </div>
</section>

{nda_block}{f'''<section class="section">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">Campaign Evidence</span>
            <h2>{e(c.get("proof_heading", "Campaign Measurement"))}</h2>
        </div>
{proof}    </div>
</section>
''' if c.get("proof") else ""}<section class="section section-alt">
    <div class="container">
        <div class="prose">
            <h2>Campaign Summary</h2>
            <p>{e(c["summary"])}</p>
            <h2>Campaign Scope</h2>
            <p>{e(scope)}</p>
            <h2>Approach and Work Covered</h2>
            <p>The documented work focused on {e(method_summary)}.</p>
            <h2>Work Covered</h2>
            <ul>
{methods}            </ul>
            <h2>Reported Outcomes</h2>
            <p>The headline indicators for this campaign include {e(metric_labels)}. Read these measures alongside the campaign summary and the stated market and timeframe.</p>
            <h2>How to Interpret These Results</h2>
            <p>These are reported outcomes for this campaign, not guaranteed benchmarks or forecasts. Traffic, ranking, enquiry, and technical measures describe different aspects of performance and should not be compared as if they were equivalent. A future campaign should be assessed against its own baseline, measurement setup, market, and business goals.</p>
            <h2>Practical Takeaway</h2>
            <p>For other {e(c["industry"].lower())} businesses considering {e(c["service"])}, this case offers an example of the measures that can be monitored. The right priorities depend on the business's starting position, target audience, and objectives.</p>
            <p>Client names and domains are omitted from this case study. Results and timeframes are reported as supplied for the campaign.</p>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="prose">
            <h2>About the Author</h2>
            <p>By <a href="about">Buddhika S Weerasekara</a>, SEO consultant with 15+ years of experience since 2010 and founder of Applantics (Pvt) Ltd.</p>
            <h2>Ready to see results like these?</h2>
            <p>Let&#39;s talk about what a focused SEO strategy could deliver for your business. Every plan starts with a free review of your site, market and competitors.</p>
            <p><a class="btn btn-gold" href="contact">Get a free SEO review <i class="fa fa-arrow-right"></i></a></p>
            <p><a href="{HUB}">&larr; All case studies</a></p>
        </div>
    </div>
</section>

""" + FOOTER
    with open(os.path.join(out_dir, slug + ".html"), "w", encoding="utf-8", newline="") as f:
        f.write(html)


def hub(cases, out_dir):
    title, desc = "SEO Case Studies | Campaign Results", "Anonymized SEO case studies from real campaigns across industries and markets, with reported campaign timeframes and outcomes."
    url = f"{SITE}/{HUB}"
    html = head(title, desc, HUB, ["seo case studies", "seo results"], "website")
    html += ld({"@context": "https://schema.org", "@type": "CollectionPage", "url": url, "name": title, "description": desc,
                "inLanguage": "en", "isPartOf": {"@id": SITE + "/#website"}})
    html += ld(breadcrumb_ld([("Home", SITE + "/"), ("Case Studies", url)]))
    html += '    <link rel="icon" type="image/png" href="assets/img/favicon.png">\n</head>\n' + HEADER
    cards = "".join(
        f'            <a href="{c["slug"]}" class="explore-card"><h3>{e(c["title"])}</h3><p>{e(c["industry"])} &middot; {e(c["service"])} &middot; {e(c["markets"])}</p><p>{e(c["summary"])}</p><p><strong>{e(" | ".join(s["value"] + " " + s["label"] for s in c["stats"][:2]))}</strong></p></a>\n'
        for c in cases)
    html += f"""<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Client Results</span>
        <h1>SEO Case Studies</h1>
        <p>Real campaign outcomes, presented without client names or domains.</p>
        <div class="breadcrumb"><a href="/">Home</a> / Case Studies</div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="grid grid-3">
{cards}        </div>
    </div>
</section>

""" + FOOTER
    with open(os.path.join(out_dir, HUB + ".html"), "w", encoding="utf-8", newline="") as f:
        f.write(html)


def sitemap(slugs):
    path = os.path.join(ROOT, "sitemap.xml")
    sm = open(path, encoding="utf-8").read()
    add = ""
    for slug, pr in [(HUB, "0.80")] + [(s, "0.70") for s in slugs]:
        loc = f"{SITE}/{slug}"
        if f"<loc>{loc}</loc>" not in sm:
            add += f"  <url>\n    <loc>{loc}</loc>\n    <lastmod>{g.TODAY}</lastmod>\n    <changefreq>monthly</changefreq>\n    <priority>{pr}</priority>\n  </url>\n"
    if add:
        open(path, "w", encoding="utf-8", newline="").write(sm.replace("</urlset>", add + "</urlset>"))


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--data", default=os.path.join(os.path.dirname(__file__), "case_studies.json"))
    ap.add_argument("--out", default=ROOT)
    ap.add_argument("--allow-unverified", action="store_true", help="testing only")
    a = ap.parse_args()
    cases = json.load(open(a.data, encoding="utf-8"))
    ok = []
    for c in cases:
        errs = validate(c, a.allow_unverified)
        if errs:
            print(f"SKIPPED {c.get('slug', '?')}: " + "; ".join(errs))
        else:
            ok.append(c)
    if not ok:
        print("No publishable case studies. Nothing generated.")
        sys.exit(0)
    os.makedirs(a.out, exist_ok=True)
    for c in ok:
        page(c, a.out)
    hub(ok, a.out)
    if os.path.abspath(a.out) == os.path.abspath(ROOT):
        sitemap([c["slug"] for c in ok])
    print(f"generated {len(ok)} case studies + hub in {a.out}")
