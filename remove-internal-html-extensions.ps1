# Strips .html from internal <a href="..."> links across all site pages so
# links point straight at the clean URL instead of relying on the .htaccess
# 301 redirect. href="index.html" becomes href="/"; href="page.html" becomes
# href="page". External links, mailto:/tel:, and asset paths (.css/.js/.png)
# are untouched because they don't end in a bare ".html" before the closing
# quote.

$root = "c:\Users\inzra\OneDrive\Documents\GitHub\seo"
$htmlFiles = Get-ChildItem -Path $root -Filter "*.html" -File

$pattern = 'href="([a-zA-Z][^"]*)\.html"'
$totalChanged = 0

foreach ($file in $htmlFiles) {
    [string]$content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $original = $content

    $content = [System.Text.RegularExpressions.Regex]::Replace($content, $pattern, {
        param($m)
        $target = $m.Groups[1].Value
        if ($target -eq "index") { return 'href="/"' }
        return "href=`"$target`""
    })

    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
        $totalChanged++
        Write-Host "Updated: $($file.Name)"
    }
}

Write-Host "Done. Files changed: $totalChanged"
