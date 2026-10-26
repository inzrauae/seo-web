"""Generate the SEO playbook pages and hub from tools/playbook_data.py.

Run from the repo root:  python tools/generate_playbooks.py
Uses seo-audit-sri-lanka.html as the page shell (head assets, header, footer, scripts).
"""
import json
import os
import re
import sys
from html import escape

sys.path.insert(0, os.path.dirname(__file__))
from playbook_data import PLAYBOOKS  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = "https://seoconsultantsrilanka.com"
TODAY = "2026-10-26"
HUB = "seo-playbooks"

shell = open(os.path.join(ROOT, "seo-audit-sri-lanka.html"), encoding="utf-8-sig").read()
HEAD_START = shell[: shell.index("<title>")]
HEADER = shell[shell.index("<body>") : shell.index('<section class="page-hero">')]
FOOTER = shell[shell.index('<footer class="site-footer">') :]
# The shell footer highlights nothing page-specific, so it can be reused as is.

e = lambda t: escape(t, quote=True)


def ld(obj):
    return '    <script type="application/ld+json">\n    ' + json.dumps(obj, ensure_ascii=False) + "\n    </script>\n"


def head(title, desc, slug, kws, og_type="article"):
    url = f"{SITE}/{slug}"
    return (
        HEAD_START
        + f"<title>{e(title)}</title>\n"
        + f'    <meta name="description" content="{e(desc)}">\n'
        + f'    <meta name="keywords" content="{e(", ".join(kws))}">\n'
        + '    <meta name="author" content="Buddhika S Weerasekara">\n'
        + '    <meta name="robots" content="index, follow, max-snippet:-1, max-image-preview:large">\n'
        + f'    <link rel="canonical" href="{url}">\n'
        + '    <meta property="og:site_name" content="SEO Consultant Sri Lanka">\n'
        + f'    <meta property="og:title" content="{e(title)}">\n'
        + f'    <meta property="og:description" content="{e(desc)}">\n'
        + f'    <meta property="og:type" content="{og_type}">\n'
        + f'    <meta property="og:url" content="{url}">\n'
        + f'    <meta property="og:image" content="{SITE}/assets/img/seo-logo.png">\n'
        + '    <meta property="og:locale" content="en_US">\n'
        + '    <meta name="twitter:card" content="summary_large_image">\n'
        + f'    <meta name="twitter:title" content="{e(title)}">\n'
        + f'    <meta name="twitter:description" content="{e(desc)}">\n'
        + f'    <meta name="twitter:image" content="{SITE}/assets/img/seo-logo.png">\n'
    )


def breadcrumb_ld(items):
    return {
        "@context": "https://schema.org",
        "@type": "BreadcrumbList",
        "itemListElement": [
            {"@type": "ListItem", "position": i + 1, "name": n, "item": u} for i, (n, u) in enumerate(items)
        ],
    }


def write(slug, html):
    with open(os.path.join(ROOT, slug + ".html"), "w", encoding="utf-8", newline="") as f:
        f.write(html)


def page(p):
    slug, c, ind, svc = p["slug"], p["country"], p["industry"], p["service"]
    url = f"{SITE}/{slug}"
    faqs = [
        (p["q"], p["a"]),
        (f"Is this a real client case study?",
         f"No. This is a strategy playbook showing how I would approach {svc.lower()} for {ind.lower()} in {c}. It does not describe a specific client or claim any results."),
        (f"Can you apply this approach to my {ind.lower()} business?",
         f"Yes. Every plan starts with an audit of your site, competitors and market in {c}, so the real plan is adapted to your situation. Contact Buddhika S Weerasekara for a free review."),
    ]
    out = head(p["title"], p["desc"], slug, p["kws"] + [f"seo {c}", svc.lower()])
    out += ld({
        "@context": "https://schema.org", "@type": "Article", "@id": url + "#article",
        "headline": p["title"], "description": p["desc"], "url": url, "inLanguage": "en",
        "datePublished": TODAY, "dateModified": TODAY,
        "author": {"@id": SITE + "/#person"}, "publisher": {"@id": SITE + "/#organization"},
        "mainEntityOfPage": url, "about": f"{svc} for {ind} in {c}",
    })
    out += ld(breadcrumb_ld([("Home", SITE + "/"), ("SEO Playbooks", f"{SITE}/{HUB}"), (f"{ind} ({c})", url)]))
    out += ld({
        "@context": "https://schema.org", "@type": "FAQPage",
        "mainEntity": [{"@type": "Question", "name": q, "acceptedAnswer": {"@type": "Answer", "text": a}} for q, a in faqs],
    })
    out += '    <link rel="icon" type="image/png" href="assets/img/favicon.png">\n</head>\n' + HEADER

    steps = "".join(
        f"            <h3>Step {i}: {e(t)}</h3>\n            <p>{e(x)}</p>\n" for i, (t, x) in enumerate(p["steps"], 1)
    )
    chal = "".join(f"                <li>{e(x)}</li>\n" for x in p["challenges"])
    kws = "".join(f"                <li>{e(k)}</li>\n" for k in p["kws"])
    same = [q for q in PLAYBOOKS if q["country"] == c and q["slug"] != slug][:3]
    other = [q for q in PLAYBOOKS if q["service"] == svc and q["slug"] != slug and q not in same][:2]
    rel = "".join(f'                <li><a href="{q["slug"]}">{e(q["industry"])} SEO playbook ({e(q["country"])})</a></li>\n' for q in same + other)

    out += f"""<section class="page-hero">
    <div class="container">
        <span class="eyebrow">SEO Strategy Playbook &middot; {e(c)}</span>
        <h1>{e(svc[0].upper() + svc[1:])} Playbook for {e(ind)} in {e(c)}</h1>
        <div class="breadcrumb"><a href="/">Home</a> / <a href="{HUB}">SEO Playbooks</a> / {e(ind)}</div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="prose">
            <div style="background:var(--surface);border:1px solid var(--border);border-left:4px solid var(--accent);border-radius:12px;padding:16px 20px;margin-bottom:28px;">
                <strong>This is a strategy playbook, not a client case study.</strong> It describes the approach I would recommend for this type of business. No client, traffic figure or ranking result is claimed on this page.
            </div>

            <h2>The Market: {e(ind)} in {e(c)}</h2>
            <p>{e(p["market"])}</p>

            <h2>Typical Challenges</h2>
            <ul>
{chal}            </ul>

            <h2>Recommended Approach: {e(svc[0].upper() + svc[1:])}</h2>
{steps}
            <h2>Keyword Themes to Target</h2>
            <p>Research for this type of business usually centres on patterns like these (replace the bracketed parts with real products, places and terms):</p>
            <ul>
{kws}            </ul>

            <h2>How Progress Would Be Measured</h2>
            <p>Success is tracked against the business goal, not rankings alone: qualified enquiries or sales from organic search, visibility for the target keyword groups, indexation health and conversion rate on the key landing pages. Baselines are recorded before any work starts so improvement can be shown honestly.</p>

            <h2>Results</h2>
            <p>No results are published for this scenario. When a real engagement of this type is completed and the client agrees to share it, verified results will be added to a separate case study.</p>
            <p><a class="btn btn-gold" href="contact">Get a free SEO review for your business <i class="fa fa-arrow-right"></i></a></p>

            <h2>Related Playbooks and Pages</h2>
            <ul>
{rel}                <li><a href="{HUB}">all SEO strategy playbooks</a></li>
                <li><a href="seo-audit-sri-lanka">SEO audit framework</a></li>
                <li><a href="seo-sri-lanka">SEO services in Sri Lanka and worldwide</a></li>
                <li><a href="contact">talk to an SEO consultant</a></li>
            </ul>
        </div>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <div class="section-head center">
            <span class="eyebrow">Common Questions</span>
            <h2>{e(ind)} in {e(c)}: FAQs</h2>
        </div>
        <div class="faq-list">
"""
    for i, (q, a) in enumerate(faqs):
        out += f'            <details class="faq-item"{" open" if i == 0 else ""}>\n                <summary>{e(q)}</summary>\n                <p>{e(a)}</p>\n            </details>\n'
    out += "        </div>\n    </div>\n</section>\n\n" + FOOTER
    write(slug, out)


def hub():
    title = "SEO Strategy Playbooks by Country & Industry"
    desc = "30 SEO strategy playbooks by country and industry, from local SEO and ecommerce to B2B, tourism and programmatic SEO. Planning guides, not client claims."
    url = f"{SITE}/{HUB}"
    out = head(title, desc, HUB, ["seo playbooks", "seo strategy by industry", "international seo", "seo case study approach"], "website")
    out += ld({"@context": "https://schema.org", "@type": "CollectionPage", "@id": url + "#webpage", "url": url, "name": title,
               "description": desc, "inLanguage": "en", "isPartOf": {"@id": SITE + "/#website"}})
    out += ld({"@context": "https://schema.org", "@type": "ItemList", "itemListElement": [
        {"@type": "ListItem", "position": i + 1, "url": f"{SITE}/{p['slug']}", "name": p["title"]} for i, p in enumerate(PLAYBOOKS)]})
    out += ld(breadcrumb_ld([("Home", SITE + "/"), ("SEO Playbooks", url)]))
    out += '    <link rel="icon" type="image/png" href="assets/img/favicon.png">\n</head>\n' + HEADER
    out += f"""<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Strategy by Country &amp; Industry</span>
        <h1>SEO Strategy Playbooks</h1>
        <p>How I would approach SEO for {len(PLAYBOOKS)} types of business across {len({p['country'] for p in PLAYBOOKS})} countries.</p>
        <div class="breadcrumb"><a href="/">Home</a> / SEO Playbooks</div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="prose" style="margin-bottom:32px;">
            <p>Each playbook explains the market, the typical challenges and the approach I recommend for a type of business in a specific country. These are planning guides, not client case studies, and no client results are claimed. Verified case studies will be published separately as engagements are completed.</p>
        </div>
"""
    countries = []
    for p in PLAYBOOKS:
        if p["country"] not in countries:
            countries.append(p["country"])
    for c in countries:
        out += f'        <h2 style="margin:36px 0 18px;font-size:26px;">{e(c)}</h2>\n        <div class="grid grid-3">\n'
        for p in [q for q in PLAYBOOKS if q["country"] == c]:
            out += (f'            <a href="{p["slug"]}" class="explore-card"><h3>{e(p["industry"])}</h3>'
                    f'<p>{e(p["service"])}</p></a>\n')
        out += "        </div>\n"
    out += "    </div>\n</section>\n\n" + FOOTER
    write(HUB, out)


def sitemap():
    path = os.path.join(ROOT, "sitemap.xml")
    sm = open(path, encoding="utf-8").read()
    entries = ""
    for slug, pr, cf in [(HUB, "0.80", "weekly")] + [(p["slug"], "0.70", "monthly") for p in PLAYBOOKS]:
        loc = f"{SITE}/{slug}"
        if f"<loc>{loc}</loc>" in sm:
            continue
        entries += f"  <url>\n    <loc>{loc}</loc>\n    <lastmod>{TODAY}</lastmod>\n    <changefreq>{cf}</changefreq>\n    <priority>{pr}</priority>\n  </url>\n"
    if entries:
        sm = sm.replace("</urlset>", entries + "</urlset>")
        open(path, "w", encoding="utf-8", newline="").write(sm)


if __name__ == "__main__":
    for p in PLAYBOOKS:
        page(p)
    hub()
    sitemap()
    print(f"generated {len(PLAYBOOKS)} playbooks + hub")
