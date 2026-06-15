$scriptPath = Join-Path $PSScriptRoot 'update-sitemap.ps1'

if (-not (Test-Path $scriptPath)) {
    throw "update-sitemap.ps1 was not found next to update-sitemap-cities.ps1"
}

Write-Host "update-sitemap-cities.ps1 is deprecated. Rebuilding sitemap without city landing pages."
& $scriptPath
