# fix-missing-related-links.ps1
# Adds Related SEO Services section to the 3 pages that don't use
# the standard '<!-- Start Footer Section -->' comment anchor.

$base = 'c:\Users\inzra\OneDrive\Documents\GitHub\seo'

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

function Get-RelatedSection {
    param([string]$excludeSlug, [string]$indent = '    ')
    $cards = ''
    foreach ($card in $allCards) {
        if ($card.slug -ne $excludeSlug) {
            $cards += $indent + '    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">'
            $cards += '<a href="' + $card.href + '" style="display:block;background:#f7fdf4;border:1px solid #cce5b5;border-radius:10px;padding:20px;text-decoration:none;height:100%;border-top:4px solid #2d5016;">'
            $cards += '<div style="font-size:22px;margin-bottom:8px;">' + $card.icon + '</div>'
            $cards += '<h3 style="color:#1e4010;font-size:14px;font-weight:700;margin:0 0 6px;">' + $card.title + '</h3>'
            $cards += '<p style="color:#555;font-size:12px;line-height:1.5;margin:0;">' + $card.desc + '</p>'
            $cards += '</a></div>' + "`r`n"
        }
    }
    $s = $indent + '<!-- Start: Internal Links - Related SEO Services -->' + "`r`n"
    $s += $indent + '<section style="background:#f6faf2;padding:55px 0;border-top:2px solid #d8edd0;">' + "`r`n"
    $s += $indent + '    <div class="container">' + "`r`n"
    $s += $indent + '        <div class="row">' + "`r`n"
    $s += $indent + '            <div class="col-12 text-center mb-4">' + "`r`n"
    $s += $indent + '                <span style="background:#2d5016;color:#fff;padding:5px 16px;border-radius:20px;font-size:11px;font-weight:700;letter-spacing:1px;text-transform:uppercase;">Also Explore</span>' + "`r`n"
    $s += $indent + '                <h2 style="color:#1a1a1a;font-size:24px;font-weight:700;margin-top:14px;margin-bottom:8px;">More SEO Services in Sri Lanka</h2>' + "`r`n"
    $s += $indent + '                <p style="color:#666;font-size:14px;max-width:560px;margin:0 auto;">All professional SEO services by <a href="index.html" style="color:#2d5016;font-weight:600;text-decoration:none;">Buddhika S Weerasekara</a> &#8212; Sri Lanka&#39;s #1 SEO expert</p>' + "`r`n"
    $s += $indent + '            </div>' + "`r`n"
    $s += $indent + '        </div>' + "`r`n"
    $s += $indent + '        <div class="row">' + "`r`n"
    $s += $cards
    $s += $indent + '        </div>' + "`r`n"
    $s += $indent + '        <div class="row mt-3">' + "`r`n"
    $s += $indent + '            <div class="col-12 text-center">' + "`r`n"
    $s += $indent + '                <a href="contact.html" style="background:#2d5016;color:#fff;padding:12px 28px;border-radius:6px;font-size:14px;font-weight:700;text-decoration:none;margin-right:10px;">&#128222; Get Free SEO Consultation</a>' + "`r`n"
    $s += $indent + '                <a href="pricing.html" style="background:#fff;color:#2d5016;border:2px solid #2d5016;padding:12px 28px;border-radius:6px;font-size:14px;font-weight:700;text-decoration:none;">&#128184; View SEO Pricing</a>' + "`r`n"
    $s += $indent + '            </div>' + "`r`n"
    $s += $indent + '        </div>' + "`r`n"
    $s += $indent + '    </div>' + "`r`n"
    $s += $indent + '</section>' + "`r`n"
    $s += $indent + '<!-- End: Internal Links - Related SEO Services -->' + "`r`n" + "`r`n"
    return $s
}

# Each page has a unique footer opening tag that will serve as the insertion anchor.
# anchor = the exact string to search for; we insert the section immediately before it.
$targets = @(
    [ordered]@{
        file   = 'ai-seo.html'
        slug   = 'ai-seo'
        indent = '  '
        anchor = '  <footer class="footer-section" style="padding-top:'
    }
    [ordered]@{
        file   = 'seo-agency-sri-lanka.html'
        slug   = 'seo-agency'
        indent = '    '
        anchor = '    <footer class="footer-section startup-footer">'
    }
    [ordered]@{
        file   = 'seo-price-in-sri-lanka.html'
        slug   = ''
        indent = '    '
        anchor = '    <footer class="footer-section">'
    }
)

$count = 0
foreach ($t in $targets) {
    $path = "$base\$($t.file)"
    if (-not (Test-Path $path)) { Write-Host "NOT FOUND: $($t.file)" -ForegroundColor Red; continue }
    $c = [System.IO.File]::ReadAllText($path)
    if ($c.Contains('Internal Links - Related SEO Services')) {
        Write-Host "SKIP (already has section): $($t.file)" -ForegroundColor Yellow
        continue
    }
    if (-not $c.Contains($t.anchor)) {
        Write-Host "ANCHOR NOT FOUND in $($t.file): [$($t.anchor)]" -ForegroundColor Red
        continue
    }
    $section = Get-RelatedSection -excludeSlug $t.slug -indent $t.indent
    $c = $c.Replace($t.anchor, $section + $t.anchor)
    [System.IO.File]::WriteAllText($path, $c, [System.Text.Encoding]::UTF8)
    $count++
    Write-Host "Updated: $($t.file)" -ForegroundColor Green
}

Write-Host "`nDone. Updated $count pages." -ForegroundColor Yellow
