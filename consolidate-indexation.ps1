$root = $PSScriptRoot
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

$cityPages = Get-ChildItem -Path $root -Filter 'seo-consultant-*.html' |
    Where-Object { $_.Name -ne 'seo-consultant-sri-lanka-guide.html' }

$htmlPages = Get-ChildItem -Path $root -Filter '*.html'

$cityCoverageSection = @'
        <!-- Start Service Coverage Section -->
        <section class="ptb-100" style="background:#f4f8f0;border-top:4px solid #2d5016;">
            <div class="container">
                <div class="section-title text-center">
                    <span>Serving Businesses Across Sri Lanka</span>
                    <h2>National SEO Coverage Without Thin City Pages</h2>
                    <p>SEO campaigns are delivered across Colombo, Kandy, Galle, Jaffna, and other major service areas through stronger national service pages rather than duplicated city landing pages.</p>
                </div>
                <div class="text-center mt-4">
                    <a href="services.html" class="default-btn">View SEO Services</a>
                    <a href="contact.html" class="default-btn" style="margin-left:12px;background:#2d5016;">Request a Consultation</a>
                </div>
            </div>
        </section>
        <!-- End Service Coverage Section -->
'@

$nearbyCitiesSection = @'
        <!-- Start Service Coverage Section -->
        <section class="nearby-cities-section ptb-100" style="background:#f4f8f0;border-top:4px solid #2d5016;">
            <div class="container">
                <div class="section-title text-center">
                    <span>National SEO Coverage</span>
                    <h2>SEO Services Available Across Sri Lanka</h2>
                    <p>Campaign planning, technical SEO, content optimization, and reporting are delivered nationally. Use the main SEO service pages instead of thin city-specific landing pages.</p>
                </div>
                <div class="text-center mt-4">
                    <a href="services.html" class="default-btn">View SEO Services</a>
                    <a href="contact.html" class="default-btn" style="margin-left:12px;background:#2d5016;">Contact for Coverage</a>
                </div>
            </div>
        </section>
        <!-- End Service Coverage Section -->
'@

$footerCoverageBlock = @'
                            <h3>Service Coverage</h3>
                            <p>Serving businesses across Colombo, Kandy, Galle, Jaffna, Trincomalee, Kurunegala, and other major Sri Lankan districts through national SEO campaigns.</p>
'@

$updatedFiles = [System.Collections.Generic.List[string]]::new()

foreach ($file in $cityPages) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $originalContent = $content

    $content = $content.Replace(
        '<meta name="robots" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1">',
        '<meta name="robots" content="noindex, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1">'
    )
    $content = $content.Replace(
        '<meta name="googlebot" content="index, follow">',
        '<meta name="googlebot" content="noindex, follow">'
    )
    $content = $content.Replace(
        '<meta name="bingbot" content="index, follow">',
        '<meta name="bingbot" content="noindex, follow">'
    )

    $content = [regex]::Replace(
        $content,
        '(?s)\s*<!-- Start Nearby Cities Section -->.*?<!-- End Nearby Cities Section -->',
        "`r`n$nearbyCitiesSection",
        1
    )

    $content = [regex]::Replace(
        $content,
        '(?s)<h3>Sri Lanka Cities</h3>\s*<p>.*?</p>',
        $footerCoverageBlock,
        1
    )

    if ($content -ne $originalContent) {
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        $updatedFiles.Add($file.Name) | Out-Null
    }
}

foreach ($file in $htmlPages) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $originalContent = $content

    $content = [regex]::Replace(
        $content,
        '(?s)\s*<!-- City Coverage ItemList Schema - All 33 Sri Lanka Cities -->\s*<script type="application/ld\+json">.*?</script>',
        '',
        1
    )

    $content = [regex]::Replace(
        $content,
        '(?s)\s*<!-- Start Sri Lanka Cities Coverage Section -->.*?<!-- End Sri Lanka Cities Coverage Section -->',
        "`r`n$cityCoverageSection",
        1
    )

    $content = [regex]::Replace(
        $content,
        '(?s)<h3>Sri Lanka Cities</h3>\s*<p>.*?</p>',
        $footerCoverageBlock,
        1
    )

    if ($content -ne $originalContent) {
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        if (-not $updatedFiles.Contains($file.Name)) {
            $updatedFiles.Add($file.Name) | Out-Null
        }
    }
}

Write-Host "Updated files: $($updatedFiles.Count)"
$updatedFiles | Sort-Object | ForEach-Object { Write-Host " - $_" }