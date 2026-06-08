# PowerShell Script to Auto-Generate both sitemap.xml files from public HTML pages

$domain = "https://seoconsultantsrilanka.com"
$outputPaths = @(
    ".\sitemap.xml",
    ".\assets\sitemap.xml"
)
$currentDate = (Get-Date).ToString("yyyy-MM-ddTHH:mm:sszzz")
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# Get all public HTML files in the current directory
$exclude = @(
    'header-component.html',
    'navbar-component.html',
    'single-blog.html',
    '403.html',
    '404.html',
    '500.html'
)

$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" |
    Where-Object { $exclude -notcontains $_.Name } |
    Sort-Object Name

function Get-SitemapMeta {
    param([string]$fileName)

    $corePages = @(
        'best-seo-company-sri-lanka.html',
        'seo-company-sri-lanka.html',
        'seo-service-in-sri-lanka.html',
        'seo-sri-lanka.html',
        'seo-specialist-sri-lanka.html'
    )

    $weeklySupportPages = @(
        'local-seo-sri-lanka.html',
        'technical-seo-sri-lanka.html',
        'ecommerce-seo-sri-lanka.html',
        'seo-audit-sri-lanka.html',
        'on-page-seo-sri-lanka.html',
        'google-maps-seo-sri-lanka.html'
    )

    $secondaryMoneyPages = @(
        'seo-agency-sri-lanka.html',
        'seo-expert-sri-lanka.html',
        'ai-seo.html',
        'seo-price-in-sri-lanka.html',
        'seo-service-sri-lanka.html'
    )

    $mainPages = @(
        'about.html',
        'blog.html',
        'contact.html',
        'faq.html',
        'pricing.html',
        'services.html'
    )

    $educationPages = @(
        'how-long-does-seo-take.html',
        'how-to-become-seo-specialist.html',
        'seo-specialist-guide-sri-lanka.html',
        'what-does-seo-stand-for.html',
        'what-is-seo.html'
    )

    if ($fileName -eq 'index.html') {
        return @{ Order = 0; Priority = '1.00'; ChangeFreq = 'weekly' }
    }

    if ($corePages -contains $fileName) {
        return @{ Order = 10; Priority = '0.90'; ChangeFreq = 'weekly' }
    }

    if ($fileName -eq 'seo-consultant-sri-lanka-guide.html') {
        return @{ Order = 20; Priority = '0.88'; ChangeFreq = 'weekly' }
    }

    if ($fileName -eq 'seo-courses-in-sri-lanka.html') {
        return @{ Order = 21; Priority = '0.82'; ChangeFreq = 'weekly' }
    }

    if ($weeklySupportPages -contains $fileName) {
        return @{ Order = 22; Priority = '0.84'; ChangeFreq = 'weekly' }
    }

    if ($secondaryMoneyPages -contains $fileName) {
        return @{ Order = 30; Priority = '0.85'; ChangeFreq = 'monthly' }
    }

    if ($mainPages -contains $fileName) {
        return @{ Order = 40; Priority = '0.80'; ChangeFreq = 'monthly' }
    }

    if ($educationPages -contains $fileName) {
        return @{ Order = 50; Priority = '0.75'; ChangeFreq = 'monthly' }
    }

    if ($fileName -like 'seo-consultant-*.html') {
        return @{ Order = 60; Priority = '0.80'; ChangeFreq = 'monthly' }
    }

    return @{ Order = 90; Priority = '0.64'; ChangeFreq = 'monthly' }
}

function Get-UrlPath {
    param([string]$fileName)

    if ($fileName -eq 'index.html') {
        return '/'
    }

    return '/' + $fileName.Replace('.html', '').Replace(' ', '%20')
}

$pages = @(foreach ($file in $htmlFiles) {
    $meta = Get-SitemapMeta -fileName $file.Name

    [pscustomobject]@{
        Name       = $file.Name
        UrlPath    = Get-UrlPath -fileName $file.Name
        LastMod    = $file.LastWriteTime.ToString("yyyy-MM-ddTHH:mm:sszzz")
        ChangeFreq = $meta.ChangeFreq
        Priority   = $meta.Priority
        Order      = [int]$meta.Order
    }
}) | Sort-Object Order, Name

$lines = @(
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
)

foreach ($page in $pages) {
    $lines += '  <url>'
    $lines += "    <loc>$domain$($page.UrlPath)</loc>"
    $lines += "    <lastmod>$($page.LastMod)</lastmod>"
    $lines += "    <changefreq>$($page.ChangeFreq)</changefreq>"
    $lines += "    <priority>$($page.Priority)</priority>"
    $lines += '  </url>'
}

$lines += '</urlset>'
$xmlContent = [string]::Join("`r`n", $lines) + "`r`n"

foreach ($outputPath in $outputPaths) {
    $directory = Split-Path -Path $outputPath -Parent

    if ($directory) {
        New-Item -Path $directory -ItemType Directory -Force | Out-Null
    }

    $fullOutputPath = [System.IO.Path]::GetFullPath($outputPath)
    [System.IO.File]::WriteAllText($fullOutputPath, $xmlContent, $utf8NoBom)
}

Write-Host "Sitemaps generated successfully."
Write-Host "Outputs: $($outputPaths -join ', ')"
Write-Host "Total pages: $($pages.Count)"
Write-Host "Last updated: $currentDate"
