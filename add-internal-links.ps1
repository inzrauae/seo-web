# add-internal-links.ps1
# Builds powerful internal link structure across ALL pages
# 3 link layers:
#   1) "Related SEO Services" card grid before footer (all non-city pages)
#   2) "Professional SEO Services" button bar before footer (city pages)
#   3) "Also Explore" quick links between GEO section and About section (6 keyword pages)
#   4) Contextual in-text links in city page footer description

$base = 'c:\Users\inzra\OneDrive\Documents\GitHub\seo'

# ── MARKERS ──────────────────────────────────────────────────────────────────
$FOOTER_ANCHOR = '        <!-- Start Footer Section -->'
$GEO_TRANSITION = '        <!-- End GEO Authority Answer Section -->'
$ABOUT_START    = '        <!-- Start About Section -->'

# ── CITY FOOTER TEXT (contextual in-text links) ───────────────────────────
$OLD_CITY_FOOTER_P = 'Buddhika S. Weerasekara - #1 SEO Consultant in Sri Lanka. As the leading SEO Consultant Sri Lanka, I specialize in SEO and GEO optimization for businesses of all sizes. Get expert SEO services from the best SEO Consultant in Sri Lanka.'
$NEW_CITY_FOOTER_P = 'Buddhika S. Weerasekara — Sri Lanka&#39;s <a href="index.html" style="color:#2d5016;font-weight:600;">#1 SEO Consultant</a>. As the leading <a href="seo-specialist-sri-lanka.html" style="color:#2d5016;text-decoration:none;">SEO specialist Sri Lanka</a>, I specialize in <a href="seo-service-in-sri-lanka.html" style="color:#2d5016;text-decoration:none;">SEO &amp; GEO optimization</a>. The <a href="best-seo-company-sri-lanka.html" style="color:#2d5016;text-decoration:none;">best SEO company in Sri Lanka</a> for businesses of all sizes.'

# ── SERVICE CARDS DATA ────────────────────────────────────────────────────────
$allCards = @(
    [ordered]@{ slug='index';            href='index.html';                     icon='&#128269;'; title='SEO Consultant Sri Lanka';   desc='Sri Lanka&#39;s #1 SEO consultant. White-hat SEO, GEO &amp; guaranteed rankings.' }
    [ordered]@{ slug='best-seo-company'; href='best-seo-company-sri-lanka.html'; icon='&#127942;'; title='Best SEO Company Sri Lanka';  desc='Sri Lanka&#39;s best SEO company. 200+ clients, 15+ years, guaranteed results.' }
    [ordered]@{ slug='seo-company';      href='seo-company-sri-lanka.html';      icon='&#127970;'; title='SEO Company Sri Lanka';       desc='Professional SEO company in Sri Lanka serving all 9 provinces since 2010.' }
    [ordered]@{ slug='seo-service-in';   href='seo-service-in-sri-lanka.html';   icon='&#9889;';   title='SEO Service in Sri Lanka';    desc='Full SEO service: on-page, technical, link building &amp; GEO optimization.' }
    [ordered]@{ slug='seo-sri-lanka';    href='seo-sri-lanka.html';              icon='&#127760;'; title='SEO Sri Lanka';               desc='Expert SEO across Sri Lanka. White-hat, technical &amp; local SEO for all businesses.' }
    [ordered]@{ slug='seo-specialist';   href='seo-specialist-sri-lanka.html';   icon='&#128104;'; title='SEO Specialist Sri Lanka';    desc='Certified SEO specialist. E-E-A-T compliant, data-driven SEO strategies.' }
    [ordered]@{ slug='seo-agency';       href='seo-agency-sri-lanka.html';       icon='&#128202;'; title='SEO Agency Sri Lanka';        desc='Full-service SEO agency in Sri Lanka. Digital marketing &amp; SEO solutions.' }
    [ordered]@{ slug='seo-expert';       href='seo-expert-sri-lanka.html';       icon='&#11088;';  title='SEO Expert Sri Lanka';        desc='Top-rated SEO expert with 15+ years hands-on SEO experience in Sri Lanka.' }
    [ordered]@{ slug='ai-seo';           href='ai-seo.html';                     icon='&#129302;'; title='AI SEO / GEO Optimization';   desc='GEO optimization for ChatGPT, Gemini &amp; Perplexity AI search visibility.' }
    [ordered]@{ slug='pricing';          href='pricing.html';                    icon='&#128184;'; title='SEO Pricing Sri Lanka';       desc='Transparent, affordable SEO packages with guaranteed Google rankings.' }
    [ordered]@{ slug='contact';          href='contact.html';                    icon='&#128222;'; title='Free SEO Consultation';       desc='Book a free SEO consultation with Sri Lanka&#39;s #1 SEO expert today.' }
)

# ── FUNCTION: Build card grid HTML (exclude current page) ────────────────────
function Get-CardsHtml {
    param([string]$excludeSlug)
    $html = ''
    foreach ($card in $allCards) {
        if ($card.slug -ne $excludeSlug) {
            $html += '                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">'
            $html += '<a href="' + $card.href + '" style="display:block;background:#f7fdf4;border:1px solid #cce5b5;border-radius:10px;padding:20px;text-decoration:none;height:100%;border-top:4px solid #2d5016;">'
            $html += '<div style="font-size:22px;margin-bottom:8px;">' + $card.icon + '</div>'
            $html += '<h3 style="color:#1e4010;font-size:14px;font-weight:700;margin:0 0 6px;">' + $card.title + '</h3>'
            $html += '<p style="color:#555;font-size:12px;line-height:1.5;margin:0;">' + $card.desc + '</p>'
            $html += '</a></div>' + "`n"
        }
    }
    return $html
}

# ── FUNCTION: Build full Related Services section ────────────────────────────
function Get-RelatedSection {
    param([string]$excludeSlug)
    $cards = Get-CardsHtml -excludeSlug $excludeSlug
    return (
        '        <!-- Start: Internal Links - Related SEO Services -->' + "`n" +
        '        <section style="background:#f6faf2;padding:55px 0;border-top:2px solid #d8edd0;">' + "`n" +
        '            <div class="container">' + "`n" +
        '                <div class="row">' + "`n" +
        '                    <div class="col-12 text-center mb-4">' + "`n" +
        '                        <span style="background:#2d5016;color:#fff;padding:5px 16px;border-radius:20px;font-size:11px;font-weight:700;letter-spacing:1px;text-transform:uppercase;">Also Explore</span>' + "`n" +
        '                        <h2 style="color:#1a1a1a;font-size:24px;font-weight:700;margin-top:14px;margin-bottom:8px;">More SEO Services in Sri Lanka</h2>' + "`n" +
        '                        <p style="color:#666;font-size:14px;max-width:560px;margin:0 auto;">All professional SEO services by <a href="index.html" style="color:#2d5016;font-weight:600;text-decoration:none;">Buddhika S Weerasekara</a> &#8212; Sri Lanka&#39;s #1 SEO expert with 15+ years experience</p>' + "`n" +
        '                    </div>' + "`n" +
        '                </div>' + "`n" +
        '                <div class="row">' + "`n" +
        $cards +
        '                </div>' + "`n" +
        '                <div class="row mt-3">' + "`n" +
        '                    <div class="col-12 text-center">' + "`n" +
        '                        <a href="contact.html" style="background:#2d5016;color:#fff;padding:12px 28px;border-radius:6px;font-size:14px;font-weight:700;text-decoration:none;margin-right:10px;">&#128222; Get Free SEO Consultation</a>' + "`n" +
        '                        <a href="pricing.html" style="background:#fff;color:#2d5016;border:2px solid #2d5016;padding:12px 28px;border-radius:6px;font-size:14px;font-weight:700;text-decoration:none;">&#128184; View SEO Pricing</a>' + "`n" +
        '                    </div>' + "`n" +
        '                </div>' + "`n" +
        '            </div>' + "`n" +
        '        </section>' + "`n" +
        '        <!-- End: Internal Links - Related SEO Services -->' + "`n" + "`n"
    )
}

# ── CITY PAGE SERVICES BAR (static HTML) ─────────────────────────────────────
$CITY_BAR = (
    '        <!-- Start: Internal Links - SEO Services Bar -->' + "`n" +
    '        <section style="background:#eaf4e1;padding:35px 0;border-top:2px solid #c5dfa8;">' + "`n" +
    '            <div class="container">' + "`n" +
    '                <div class="row align-items-center">' + "`n" +
    '                    <div class="col-lg-4 mb-3 mb-lg-0">' + "`n" +
    '                        <h3 style="color:#2d5016;font-size:17px;font-weight:700;margin:0 0 4px;">Professional SEO Services in Sri Lanka</h3>' + "`n" +
    '                        <p style="color:#555;font-size:13px;margin:0;">By <a href="index.html" style="color:#2d5016;font-weight:700;text-decoration:none;">Buddhika S Weerasekara</a> &#8212; Sri Lanka&#39;s #1 SEO Expert</p>' + "`n" +
    '                    </div>' + "`n" +
    '                    <div class="col-lg-8">' + "`n" +
    '                        <div style="display:flex;flex-wrap:wrap;gap:8px;">' + "`n" +
    '                            <a href="index.html" style="background:#2d5016;color:#fff;padding:7px 12px;border-radius:5px;font-size:12px;font-weight:700;text-decoration:none;white-space:nowrap;">SEO Consultant SL</a>' + "`n" +
    '                            <a href="best-seo-company-sri-lanka.html" style="background:#fff;color:#2d5016;border:1.5px solid #2d5016;padding:7px 12px;border-radius:5px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;">Best SEO Company</a>' + "`n" +
    '                            <a href="seo-company-sri-lanka.html" style="background:#fff;color:#2d5016;border:1.5px solid #2d5016;padding:7px 12px;border-radius:5px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;">SEO Company SL</a>' + "`n" +
    '                            <a href="seo-service-in-sri-lanka.html" style="background:#fff;color:#2d5016;border:1.5px solid #2d5016;padding:7px 12px;border-radius:5px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;">SEO Service SL</a>' + "`n" +
    '                            <a href="seo-specialist-sri-lanka.html" style="background:#fff;color:#2d5016;border:1.5px solid #2d5016;padding:7px 12px;border-radius:5px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;">SEO Specialist SL</a>' + "`n" +
    '                            <a href="seo-agency-sri-lanka.html" style="background:#fff;color:#2d5016;border:1.5px solid #2d5016;padding:7px 12px;border-radius:5px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;">SEO Agency SL</a>' + "`n" +
    '                            <a href="seo-sri-lanka.html" style="background:#fff;color:#2d5016;border:1.5px solid #2d5016;padding:7px 12px;border-radius:5px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;">SEO Sri Lanka</a>' + "`n" +
    '                            <a href="ai-seo.html" style="background:#fff;color:#2d5016;border:1.5px solid #2d5016;padding:7px 12px;border-radius:5px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;">AI / GEO SEO</a>' + "`n" +
    '                            <a href="pricing.html" style="background:#fff;color:#2d5016;border:1.5px solid #2d5016;padding:7px 12px;border-radius:5px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;">SEO Pricing</a>' + "`n" +
    '                            <a href="contact.html" style="background:#f5821e;color:#fff;padding:7px 12px;border-radius:5px;font-size:12px;font-weight:700;text-decoration:none;white-space:nowrap;">Free Consultation</a>' + "`n" +
    '                        </div>' + "`n" +
    '                    </div>' + "`n" +
    '                </div>' + "`n" +
    '            </div>' + "`n" +
    '        </section>' + "`n" +
    '        <!-- End: Internal Links - SEO Services Bar -->' + "`n" + "`n"
)

# ── GEO SECTION QUICK LINKS (between GEO end and About start) ────────────────
$nl = "`r`n"
$GEO_QUICK_SECTION = (
    '        <!-- End GEO Authority Answer Section -->' + $nl +
    '        <!-- Start: GEO Internal Quick Links -->' + $nl +
    '        <div style="background:#fff;border-top:1px solid #e8f0e0;border-bottom:1px solid #e8f0e0;padding:14px 0;">' + $nl +
    '            <div class="container">' + $nl +
    '                <p style="margin:0;font-size:13px;color:#555;text-align:center;line-height:2;">' + $nl +
    '                    <strong style="color:#2d5016;">&#128279; Explore all SEO services:</strong>&nbsp;&nbsp;' + $nl +
    '                    <a href="best-seo-company-sri-lanka.html" style="color:#2d5016;font-weight:600;text-decoration:none;">Best SEO Company</a> &nbsp;&#8226;&nbsp;' + $nl +
    '                    <a href="seo-company-sri-lanka.html" style="color:#2d5016;text-decoration:none;">SEO Company Sri Lanka</a> &nbsp;&#8226;&nbsp;' + $nl +
    '                    <a href="seo-service-in-sri-lanka.html" style="color:#2d5016;text-decoration:none;">SEO Service Sri Lanka</a> &nbsp;&#8226;&nbsp;' + $nl +
    '                    <a href="seo-specialist-sri-lanka.html" style="color:#2d5016;text-decoration:none;">SEO Specialist Sri Lanka</a> &nbsp;&#8226;&nbsp;' + $nl +
    '                    <a href="seo-agency-sri-lanka.html" style="color:#2d5016;text-decoration:none;">SEO Agency Sri Lanka</a> &nbsp;&#8226;&nbsp;' + $nl +
    '                    <a href="ai-seo.html" style="color:#2d5016;text-decoration:none;">AI / GEO SEO</a> &nbsp;&#8226;&nbsp;' + $nl +
    '                    <a href="pricing.html" style="color:#2d5016;text-decoration:none;">SEO Pricing</a> &nbsp;&#8226;&nbsp;' + $nl +
    '                    <a href="contact.html" style="color:#2d5016;font-weight:600;text-decoration:none;">Free Consultation</a>' + $nl +
    '                </p>' + $nl +
    '            </div>' + $nl +
    '        </div>' + $nl +
    '        <!-- End: GEO Internal Quick Links -->'
)

# ── PAGE SLUG MAP (for "exclude self" logic) ──────────────────────────────────
$slugMap = @{
    'index.html'                     = 'index'
    'best-seo-company-sri-lanka.html'= 'best-seo-company'
    'seo-company-sri-lanka.html'     = 'seo-company'
    'seo-service-in-sri-lanka.html'  = 'seo-service-in'
    'seo-sri-lanka.html'             = 'seo-sri-lanka'
    'seo-specialist-sri-lanka.html'  = 'seo-specialist'
    'seo-agency-sri-lanka.html'      = 'seo-agency'
    'seo-expert-sri-lanka.html'      = 'seo-expert'
    'ai-seo.html'                    = 'ai-seo'
    'pricing.html'                   = 'pricing'
    'contact.html'                   = 'contact'
}

# ── PAGES WITH GEO SECTION (for quick links insertion) ────────────────────────
$geoPages = @('index.html','best-seo-company-sri-lanka.html','seo-company-sri-lanka.html','seo-service-in-sri-lanka.html','seo-sri-lanka.html','seo-specialist-sri-lanka.html')

# ── SKIP LIST ─────────────────────────────────────────────────────────────────
$skipPages = @('header-component.html')

# ── PROCESS ALL HTML PAGES ────────────────────────────────────────────────────
$allHtml = Get-ChildItem "$base" -Filter "*.html" | Where-Object { $skipPages -notcontains $_.Name -and $_.Name -notlike '*backup*' -and $_.Name -notlike '*navremoved*' }

$cityCount = 0
$serviceCount = 0
$geoCount = 0
$inTextCount = 0

foreach ($f in $allHtml) {
    $c = [System.IO.File]::ReadAllText($f.FullName)
    $changed = $false

    # ── CITY PAGES: button bar + in-text links ─────────────────────────────
    if ($f.Name -like 'seo-consultant-*.html') {
        # 1. Services button bar before footer
        if ($c.Contains($FOOTER_ANCHOR) -and (-not $c.Contains('Internal Links - SEO Services Bar'))) {
            $c = $c.Replace($FOOTER_ANCHOR, $CITY_BAR + $FOOTER_ANCHOR)
            $cityCount++
            $changed = $true
        }
        # 2. Contextual in-text links in footer description
        if ($c.Contains($OLD_CITY_FOOTER_P)) {
            $c = $c.Replace($OLD_CITY_FOOTER_P, $NEW_CITY_FOOTER_P)
            $inTextCount++
            $changed = $true
        }
    }
    else {
        # ── NON-CITY PAGES: Related Services card grid ─────────────────────
        if ($c.Contains($FOOTER_ANCHOR) -and (-not $c.Contains('Internal Links - Related SEO Services'))) {
            $selfSlug = if ($slugMap.ContainsKey($f.Name)) { $slugMap[$f.Name] } else { '' }
            $section = Get-RelatedSection -excludeSlug $selfSlug
            $c = $c.Replace($FOOTER_ANCHOR, $section + $FOOTER_ANCHOR)
            $serviceCount++
            $changed = $true
        }
    }

    # ── GEO PAGES: quick links strip between GEO and About ─────────────────
    if ($geoPages -contains $f.Name) {
        $oldGeoTransition = $GEO_TRANSITION + "`r`n" + '        <!-- Start About Section -->'
        $newGeoTransition = $GEO_QUICK_SECTION + "`r`n" + '        <!-- Start About Section -->'
        if ($c.Contains($oldGeoTransition) -and (-not $c.Contains('GEO Internal Quick Links'))) {
            $c = $c.Replace($oldGeoTransition, $newGeoTransition)
            $geoCount++
            $changed = $true
        }
    }

    # Save if changed
    if ($changed) {
        [System.IO.File]::WriteAllText($f.FullName, $c, [System.Text.Encoding]::UTF8)
    }
}

Write-Host "`nInternal Link Structure applied:" -ForegroundColor Yellow
Write-Host "  Related Services sections (non-city): $serviceCount pages" -ForegroundColor Green
Write-Host "  City SEO Services bars:                $cityCount pages" -ForegroundColor Green
Write-Host "  GEO quick links strips:                $geoCount pages" -ForegroundColor Green
Write-Host "  In-text contextual links (city footer): $inTextCount pages" -ForegroundColor Green
Write-Host "`nTotal pages updated: $($serviceCount + $cityCount + $geoCount)" -ForegroundColor Cyan
