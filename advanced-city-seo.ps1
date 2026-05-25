# ============================================================
# Advanced On-Page SEO Optimizer for All City Pages
# Fixes: geo coords, JSON-LD schemas, breadcrumb, meta desc,
#        hero content, nearby cities internal links, priceValidUntil
# ============================================================

$workDir = "c:\Users\inzra\OneDrive\Documents\GitHub\seo"

# City data: slug, display name, lat/lng, region code, province, unique tagline, nearby slugs + display names
$cities = @(
    @{Slug="colombo"; Name="Colombo"; Lat="6.9271"; Lng="79.8612"; Region="LK-11"; Province="Western Province"; Tagline="Sri Lanka's commercial capital and largest city"; NearbyS=@("gampaha","negombo","moratuwa","dehiwala-mount-lavinia","sri-jayawardenepura-kotte","kalutara"); NearbyN=@("Gampaha","Negombo","Moratuwa","Dehiwala","Sri Jayawardenepura Kotte","Kalutara")},
    @{Slug="kandy"; Name="Kandy"; Lat="7.2906"; Lng="80.6337"; Region="LK-21"; Province="Central Province"; Tagline="the cultural capital of Sri Lanka in the Central Highlands"; NearbyS=@("matale","kegalle","nuwara-eliya","kurunegala"); NearbyN=@("Matale","Kegalle","Nuwara Eliya","Kurunegala")},
    @{Slug="galle"; Name="Galle"; Lat="6.0535"; Lng="80.2210"; Region="LK-31"; Province="Southern Province"; Tagline="a UNESCO World Heritage city on Sri Lanka's southern coast"; NearbyS=@("matara","hambantota","tangalle","kalutara"); NearbyN=@("Matara","Hambantota","Tangalle","Kalutara")},
    @{Slug="jaffna"; Name="Jaffna"; Lat="9.6615"; Lng="80.0255"; Region="LK-41"; Province="Northern Province"; Tagline="the cultural capital of Northern Sri Lanka"; NearbyS=@("kilinochchi","mannar","vavuniya","mullaitivu"); NearbyN=@("Kilinochchi","Mannar","Vavuniya","Mullaitivu")},
    @{Slug="negombo"; Name="Negombo"; Lat="7.2083"; Lng="79.8358"; Region="LK-11"; Province="Western Province"; Tagline="a major coastal city near Bandaranaike International Airport"; NearbyS=@("colombo","gampaha","chilaw","puttalam"); NearbyN=@("Colombo","Gampaha","Chilaw","Puttalam")},
    @{Slug="anuradhapura"; Name="Anuradhapura"; Lat="8.3114"; Lng="80.4037"; Region="LK-71"; Province="North Central Province"; Tagline="one of the ancient capitals and a UNESCO World Heritage site in Sri Lanka"; NearbyS=@("polonnaruwa","kurunegala","vavuniya","puttalam"); NearbyN=@("Polonnaruwa","Kurunegala","Vavuniya","Puttalam")},
    @{Slug="trincomalee"; Name="Trincomalee"; Lat="8.5874"; Lng="81.2152"; Region="LK-53"; Province="Eastern Province"; Tagline="a major port city on the east coast of Sri Lanka"; NearbyS=@("batticaloa","polonnaruwa","vavuniya"); NearbyN=@("Batticaloa","Polonnaruwa","Vavuniya")},
    @{Slug="batticaloa"; Name="Batticaloa"; Lat="7.7170"; Lng="81.7000"; Region="LK-52"; Province="Eastern Province"; Tagline="the main city of the Eastern Province known for its lagoons"; NearbyS=@("trincomalee","ampara","kalmunai"); NearbyN=@("Trincomalee","Ampara","Kalmunai")},
    @{Slug="badulla"; Name="Badulla"; Lat="6.9934"; Lng="81.0550"; Region="LK-81"; Province="Uva Province"; Tagline="the capital of Uva Province nestled in the highlands"; NearbyS=@("monaragala","bandarawela","nuwara-eliya","ratnapura"); NearbyN=@("Monaragala","Bandarawela","Nuwara Eliya","Ratnapura")},
    @{Slug="ratnapura"; Name="Ratnapura"; Lat="6.6828"; Lng="80.4016"; Region="LK-91"; Province="Sabaragamuwa Province"; Tagline="the gem city of Sri Lanka in Sabaragamuwa Province"; NearbyS=@("kegalle","badulla","galle","colombo"); NearbyN=@("Kegalle","Badulla","Galle","Colombo")},
    @{Slug="kurunegala"; Name="Kurunegala"; Lat="7.4867"; Lng="80.3647"; Region="LK-61"; Province="North Western Province"; Tagline="the commercial hub of North Western Province"; NearbyS=@("kandy","anuradhapura","puttalam","gampaha","kegalle"); NearbyN=@("Kandy","Anuradhapura","Puttalam","Gampaha","Kegalle")},
    @{Slug="matara"; Name="Matara"; Lat="5.9549"; Lng="80.5550"; Region="LK-32"; Province="Southern Province"; Tagline="a key city in Southern Sri Lanka with a rich historical heritage"; NearbyS=@("galle","hambantota","tangalle"); NearbyN=@("Galle","Hambantota","Tangalle")},
    @{Slug="hambantota"; Name="Hambantota"; Lat="6.1241"; Lng="81.1185"; Region="LK-33"; Province="Southern Province"; Tagline="the fastest-growing port city in Southern Sri Lanka"; NearbyS=@("galle","matara","tangalle","ratnapura"); NearbyN=@("Galle","Matara","Tangalle","Ratnapura")},
    @{Slug="nuwara-eliya"; Name="Nuwara Eliya"; Lat="6.9497"; Lng="80.7891"; Region="LK-23"; Province="Central Province"; Tagline="Sri Lanka's premier hill country resort town famous for tea plantations"; NearbyS=@("kandy","badulla","matale"); NearbyN=@("Kandy","Badulla","Matale")},
    @{Slug="gampaha"; Name="Gampaha"; Lat="7.0873"; Lng="80.0144"; Region="LK-12"; Province="Western Province"; Tagline="the most densely populated district in Sri Lanka after Colombo"; NearbyS=@("colombo","negombo","kurunegala","chilaw"); NearbyN=@("Colombo","Negombo","Kurunegala","Chilaw")},
    @{Slug="kalutara"; Name="Kalutara"; Lat="6.5855"; Lng="79.9607"; Region="LK-13"; Province="Western Province"; Tagline="a coastal city south of Colombo known for rubber and coconut"; NearbyS=@("colombo","galle","ratnapura","moratuwa"); NearbyN=@("Colombo","Galle","Ratnapura","Moratuwa")},
    @{Slug="kegalle"; Name="Kegalle"; Lat="7.2515"; Lng="80.3464"; Region="LK-92"; Province="Sabaragamuwa Province"; Tagline="the commercial center of Sabaragamuwa Province"; NearbyS=@("kandy","ratnapura","colombo","kurunegala"); NearbyN=@("Kandy","Ratnapura","Colombo","Kurunegala")},
    @{Slug="matale"; Name="Matale"; Lat="7.4675"; Lng="80.6234"; Region="LK-22"; Province="Central Province"; Tagline="a key agricultural and spice-producing district in Central Province"; NearbyS=@("kandy","polonnaruwa","anuradhapura"); NearbyN=@("Kandy","Polonnaruwa","Anuradhapura")},
    @{Slug="monaragala"; Name="Monaragala"; Lat="6.8727"; Lng="81.3506"; Region="LK-82"; Province="Uva Province"; Tagline="the largest district by area in Sri Lanka in Uva Province"; NearbyS=@("badulla","ratnapura","hambantota","ampara"); NearbyN=@("Badulla","Ratnapura","Hambantota","Ampara")},
    @{Slug="polonnaruwa"; Name="Polonnaruwa"; Lat="7.9403"; Lng="81.0188"; Region="LK-72"; Province="North Central Province"; Tagline="the ancient second capital of Sri Lanka and UNESCO World Heritage site"; NearbyS=@("anuradhapura","batticaloa","matale","trincomalee"); NearbyN=@("Anuradhapura","Batticaloa","Matale","Trincomalee")},
    @{Slug="puttalam"; Name="Puttalam"; Lat="8.0362"; Lng="79.8283"; Region="LK-62"; Province="North Western Province"; Tagline="a key fishing and agricultural city in North Western Province"; NearbyS=@("kurunegala","chilaw","negombo","anuradhapura"); NearbyN=@("Kurunegala","Chilaw","Negombo","Anuradhapura")},
    @{Slug="vavuniya"; Name="Vavuniya"; Lat="8.7514"; Lng="80.4971"; Region="LK-44"; Province="Northern Province"; Tagline="the gateway city to Northern Sri Lanka"; NearbyS=@("jaffna","anuradhapura","trincomalee","mullaitivu","mannar"); NearbyN=@("Jaffna","Anuradhapura","Trincomalee","Mullaitivu","Mannar")},
    @{Slug="ampara"; Name="Ampara"; Lat="7.2983"; Lng="81.6724"; Region="LK-51"; Province="Eastern Province"; Tagline="the administrative capital of Ampara District in the Eastern Province"; NearbyS=@("batticaloa","kalmunai","monaragala","polonnaruwa"); NearbyN=@("Batticaloa","Kalmunai","Monaragala","Polonnaruwa")},
    @{Slug="kalmunai"; Name="Kalmunai"; Lat="7.4095"; Lng="81.8261"; Region="LK-51"; Province="Eastern Province"; Tagline="the largest city in Ampara District and a key commercial center"; NearbyS=@("batticaloa","ampara","trincomalee"); NearbyN=@("Batticaloa","Ampara","Trincomalee")},
    @{Slug="kilinochchi"; Name="Kilinochchi"; Lat="9.3803"; Lng="80.3997"; Region="LK-42"; Province="Northern Province"; Tagline="the administrative center of the Northern Province"; NearbyS=@("jaffna","vavuniya","mannar","mullaitivu"); NearbyN=@("Jaffna","Vavuniya","Mannar","Mullaitivu")},
    @{Slug="mullaitivu"; Name="Mullaitivu"; Lat="9.2671"; Lng="80.8128"; Region="LK-45"; Province="Northern Province"; Tagline="a coastal district in the Northern Province bordering the sea"; NearbyS=@("vavuniya","trincomalee","kilinochchi"); NearbyN=@("Vavuniya","Trincomalee","Kilinochchi")},
    @{Slug="mannar"; Name="Mannar"; Lat="8.9810"; Lng="79.9044"; Region="LK-43"; Province="Northern Province"; Tagline="an island district known for pearl fishing and wildlife"; NearbyS=@("jaffna","vavuniya","anuradhapura"); NearbyN=@("Jaffna","Vavuniya","Anuradhapura")},
    @{Slug="chilaw"; Name="Chilaw"; Lat="7.5742"; Lng="79.7969"; Region="LK-61"; Province="North Western Province"; Tagline="a coastal town in North Western Province known for fishing"; NearbyS=@("puttalam","negombo","kurunegala","gampaha"); NearbyN=@("Puttalam","Negombo","Kurunegala","Gampaha")},
    @{Slug="dehiwala-mount-lavinia"; Name="Dehiwala-Mount Lavinia"; Lat="6.8510"; Lng="79.8652"; Region="LK-11"; Province="Western Province"; Tagline="a beachside suburb just south of Colombo with a vibrant business district"; NearbyS=@("colombo","moratuwa","kalutara"); NearbyN=@("Colombo","Moratuwa","Kalutara")},
    @{Slug="moratuwa"; Name="Moratuwa"; Lat="6.7728"; Lng="79.8818"; Region="LK-11"; Province="Western Province"; Tagline="a major industrial and educational city south of Colombo"; NearbyS=@("colombo","dehiwala-mount-lavinia","kalutara"); NearbyN=@("Colombo","Dehiwala-Mount Lavinia","Kalutara")},
    @{Slug="sri-jayawardenepura-kotte"; Name="Sri Jayawardenepura Kotte"; Lat="6.8935"; Lng="79.8999"; Region="LK-11"; Province="Western Province"; Tagline="the legislative capital and parliamentary city of Sri Lanka"; NearbyS=@("colombo","gampaha","kalutara"); NearbyN=@("Colombo","Gampaha","Kalutara")},
    @{Slug="bandarawela"; Name="Bandarawela"; Lat="6.8310"; Lng="80.9881"; Region="LK-81"; Province="Uva Province"; Tagline="a scenic highland town in Badulla District known for its cool climate"; NearbyS=@("badulla","monaragala","nuwara-eliya"); NearbyN=@("Badulla","Monaragala","Nuwara Eliya")},
    @{Slug="tangalle"; Name="Tangalle"; Lat="6.0253"; Lng="80.7972"; Region="LK-33"; Province="Southern Province"; Tagline="a picturesque coastal town in Hambantota District"; NearbyS=@("galle","matara","hambantota"); NearbyN=@("Galle","Matara","Hambantota")}
)

$updated = 0
$skipped = 0

foreach ($city in $cities) {
    $filePath = Join-Path $workDir "seo-consultant-$($city.Slug).html"
    if (-not (Test-Path $filePath)) { Write-Warning "NOT FOUND: $filePath"; $skipped++; continue }

    $c = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    $n  = $city.Name
    $s  = $city.Slug
    $lat = $city.Lat
    $lng = $city.Lng
    $reg = $city.Region
    $prov = $city.Province
    $tag = $city.Tagline

    # ── 1. Geo meta tags ──────────────────────────────────────────
    $c = $c -replace '<meta name="geo\.region" content="LK">', "<meta name=`"geo.region`" content=`"$reg`">"
    $c = $c -replace '<meta name="geo\.placename" content="Sri Lanka">', "<meta name=`"geo.placename`" content=`"$n, Sri Lanka`">"
    $c = $c -replace '<meta name="geo\.position" content="7\.8731;80\.7718">', "<meta name=`"geo.position`" content=`"$lat;$lng`">"
    $c = $c -replace '<meta name="ICBM" content="7\.8731, 80\.7718">', "<meta name=`"ICBM`" content=`"$lat, $lng`">"

    # ── 2. JSON-LD @id – unique per city page ─────────────────────
    $c = $c -replace '"@id": "https://seoconsultantsrilanka\.com/#organization"', "`"@id`": `"https://seoconsultantsrilanka.com/seo-consultant-$s#local-business`""

    # ── 3. JSON-LD geo coordinates ────────────────────────────────
    $c = $c -replace '"latitude": "7\.8731"', "`"latitude`": `"$lat`""
    $c = $c -replace '"longitude": "80\.7718"', "`"longitude`": `"$lng`""

    # ── 4. JSON-LD areaServed – country → specific city ───────────
    $c = $c -replace '(?s)"areaServed":\s*\{\s*"@type":\s*"Country",\s*"name":\s*"Sri Lanka"\s*\}', "`"areaServed`": {`"@type`": `"City`", `"name`": `"$n`", `"containedInPlace`": {`"@type`": `"Country`", `"name`": `"Sri Lanka`"}}`n          ,`"serviceArea`": {`"@type`": `"GeoCircle`", `"geoMidpoint`": {`"@type`": `"GeoCoordinates`", `"latitude`": `"$lat`", `"longitude`": `"$lng`"}, `"geoRadius`": `"75000`"}"

    # ── 5. priceValidUntil 2025 → 2026 ───────────────────────────
    $c = $c -replace '"priceValidUntil": "2025-12-31"', '"priceValidUntil": "2026-12-31"'

    # ── 6. Breadcrumb item 2 – fix URL to actual city page ────────
    $escapedName = [regex]::Escape($n)
    $breadPattern = "(?s)(""name"":\s*""SEO Consultant $escapedName"",\s*""item"":\s*"")https://seoconsultantsrilanka\.com/("")"
    $breadReplace = "`${1}https://seoconsultantsrilanka.com/seo-consultant-$s`${2}"
    $c = $c -replace $breadPattern, $breadReplace

    # ── 7. Meta description – richer, includes province ──────────
    $oldDesc = "Professional SEO Consultant in $n offering white-hat SEO services, technical optimization, and guaranteed Google rankings in $n."
    $newDesc = "Looking for the best SEO Consultant in $n? Buddhika S Weerasekara is Sri Lanka's #1 SEO Consultant offering white-hat SEO, technical optimization, and guaranteed Google rankings for $prov businesses. 15+ years experience."
    $c = $c.Replace($oldDesc, $newDesc)

    # ── 8. Hero description – add unique city tagline ─────────────
    $oldHero = "As the leading SEO Consultant in $n, I use 100% white-hat SEO techniques"
    $newHero = "As the leading SEO Consultant in $n ($tag), I use 100% white-hat SEO techniques"
    $c = $c.Replace($oldHero, $newHero)

    # ── 9. Nearby cities internal links section ───────────────────
    # First: strip any existing nearby-cities sections (prevents duplicates)
    $c = $c -replace '(?s)\r?\n\s*<!-- Start Nearby Cities Section -->.*?<!-- End Nearby Cities Section -->', ''

    $links = ""
    for ($i = 0; $i -lt $city.NearbyS.Count; $i++) {
        $ns = $city.NearbyS[$i]
        $nn = $city.NearbyN[$i]
        $links += "                    <a href=`"seo-consultant-$ns.html`" class=`"nearby-city-pill`">SEO Consultant $nn</a>`n"
    }
    $nearbySection = @"

        <!-- Start Nearby Cities Section -->
        <section class="nearby-cities-section ptb-100" style="background:#f4f8f0;border-top:4px solid #2d5016;">
            <div class="container">
                <div class="section-title text-center">
                    <span>Serving All of Sri Lanka</span>
                    <h2>SEO Consultant Services in Nearby Cities</h2>
                    <p>As the #1 SEO Consultant in Sri Lanka, I provide professional SEO services across all major cities and districts. Explore SEO consulting near $n.</p>
                </div>
                <div class="text-center mt-4">
                    <style>.nearby-city-pill{display:inline-block;background:#2d5016;color:#fff!important;padding:10px 22px;border-radius:30px;margin:6px 4px;font-weight:600;text-decoration:none!important;font-size:14px;transition:all .3s;}.nearby-city-pill:hover{background:#1f3a0f;transform:translateY(-2px);box-shadow:0 6px 15px rgba(45,80,22,.3);}</style>
$links                    <a href="/" class="nearby-city-pill" style="background:#667eea;">View All Sri Lanka Cities</a>
                </div>
            </div>
        </section>
        <!-- End Nearby Cities Section -->
"@
    # Insert once using exact string Replace (safe, no regex, no duplicates)
    $marker = "        <!-- Start Job Opportunities Section -->"
    $c = $c.Replace($marker, $nearbySection + $marker)

    # ── Save ──────────────────────────────────────────────────────
    [System.IO.File]::WriteAllText($filePath, $c, [System.Text.Encoding]::UTF8)
    $updated++
    Write-Host "OK  seo-consultant-$s.html"
}

Write-Host ""
Write-Host "Done. Updated: $updated  Skipped: $skipped"
