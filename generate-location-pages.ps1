# Script to generate location-based SEO pages for all cities in Sri Lanka
# This script creates HTML pages with proper SEO and geo-structured data for each city

$cities = @(
    @{name="Colombo"; province="Western Province"; slug="colombo"; lat="6.9271"; lon="80.6369"; region="LK-WP"},
    @{name="Sri Jayawardenepura Kotte"; province="Western Province"; slug="sri-jayawardenepura-kotte"; lat="6.8879"; lon="80.7744"; region="LK-WP"},
    @{name="Dehiwala Mount Lavinia"; province="Western Province"; slug="dehiwala-mount-lavinia"; lat="6.8310"; lon="80.7743"; region="LK-WP"},
    @{name="Moratuwa"; province="Western Province"; slug="moratuwa"; lat="6.8089"; lon="80.7933"; region="LK-WP"},
    @{name="Negombo"; province="Western Province"; slug="negombo"; lat="7.2064"; lon="79.8581"; region="LK-WP"},
    @{name="Gampaha"; province="Western Province"; slug="gampaha"; lat="7.0920"; lon="80.1342"; region="LK-WP"},
    @{name="Kalutara"; province="Western Province"; slug="kalutara"; lat="6.5882"; lon="80.0729"; region="LK-WP"},
    @{name="Kandy"; province="Central Province"; slug="kandy"; lat="7.2906"; lon="80.6337"; region="LK-CP"},
    @{name="Matale"; province="Central Province"; slug="matale"; lat="7.7731"; lon="80.7306"; region="LK-CP"},
    @{name="Nuwara Eliya"; province="Central Province"; slug="nuwara-eliya"; lat="6.9497"; lon="80.7725"; region="LK-CP"},
    @{name="Galle"; province="Southern Province"; slug="galle"; lat="6.0535"; lon="80.2162"; region="LK-SP"},
    @{name="Matara"; province="Southern Province"; slug="matara"; lat="5.7800"; lon="80.5489"; region="LK-SP"},
    @{name="Hambantota"; province="Southern Province"; slug="hambantota"; lat="6.1236"; lon="81.1177"; region="LK-SP"},
    @{name="Tangalle"; province="Southern Province"; slug="tangalle"; lat="5.9146"; lon="80.8131"; region="LK-SP"},
    @{name="Jaffna"; province="Northern Province"; slug="jaffna"; lat="9.6615"; lon="80.0255"; region="LK-NP"},
    @{name="Kilinochchi"; province="Northern Province"; slug="kilinochchi"; lat="9.3842"; lon="80.4162"; region="LK-NP"},
    @{name="Mannar"; province="Northern Province"; slug="mannar"; lat="8.9667"; lon="79.9167"; region="LK-NP"},
    @{name="Vavuniya"; province="Northern Province"; slug="vavuniya"; lat="8.7542"; lon="80.8006"; region="LK-NP"},
    @{name="Mullaitivu"; province="Northern Province"; slug="mullaitivu"; lat="8.6833"; lon="81.3500"; region="LK-NP"},
    @{name="Trincomalee"; province="Eastern Province"; slug="trincomalee"; lat="8.5874"; lon="81.2359"; region="LK-EP"},
    @{name="Batticaloa"; province="Eastern Province"; slug="batticaloa"; lat="7.7131"; lon="81.7046"; region="LK-EP"},
    @{name="Ampara"; province="Eastern Province"; slug="ampara"; lat="7.2972"; lon="81.6831"; region="LK-EP"},
    @{name="Kalmunai"; province="Eastern Province"; slug="kalmunai"; lat="7.4065"; lon="81.8238"; region="LK-EP"},
    @{name="Kurunegala"; province="North Western Province"; slug="kurunegala"; lat="7.4833"; lon="80.6333"; region="LK-NWP"},
    @{name="Puttalam"; province="North Western Province"; slug="puttalam"; lat="8.0279"; lon="79.8279"; region="LK-NWP"},
    @{name="Chilaw"; province="North Western Province"; slug="chilaw"; lat="7.5644"; lon="79.7928"; region="LK-NWP"},
    @{name="Anuradhapura"; province="North Central Province"; slug="anuradhapura"; lat="8.3381"; lon="80.4050"; region="LK-NCP"},
    @{name="Polonnaruwa"; province="North Central Province"; slug="polonnaruwa"; lat="7.9381"; lon="80.9763"; region="LK-NCP"},
    @{name="Badulla"; province="Uva Province"; slug="badulla"; lat="6.9936"; lon="81.2708"; region="LK-UP"},
    @{name="Bandarawela"; province="Uva Province"; slug="bandarawela"; lat="6.8308"; lon="81.0564"; region="LK-UP"},
    @{name="Monaragala"; province="Uva Province"; slug="monaragala"; lat="6.8219"; lon="81.3472"; region="LK-UP"},
    @{name="Ratnapura"; province="Sabaragamuwa Province"; slug="ratnapura"; lat="6.6995"; lon="80.3918"; region="LK-SAB"},
    @{name="Kegalle"; province="Sabaragamuwa Province"; slug="kegalle"; lat="7.2558"; lon="80.6415"; region="LK-SAB"}
)

$baseDir = "c:\Users\inzra\OneDrive\Documents\GitHub\seo"
$count = 0

Write-Host "Generating location pages for Sri Lankan cities..." -ForegroundColor Green
Write-Host ""

foreach ($city in $cities) {
    $filename = "$baseDir\seo-consultant-$($city.slug).html"
    
    # Generate the HTML content with proper SEO
    $htmlContent = @"
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <link rel="dns-prefetch" href="//fonts.googleapis.com">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/animate.min.css" media="print" onload="this.media='all'">
        <link rel="stylesheet" href="assets/css/flaticon.css" media="print" onload="this.media='all'">
        <link rel="stylesheet" href="assets/css/flaticon-two.css" media="print" onload="this.media='all'">
        <link rel="stylesheet" href="assets/css/flaticon-three.css" media="print" onload="this.media='all'">
        <link rel="stylesheet" href="assets/css/odometer.min.css">
        <link rel="stylesheet" href="assets/css/meanmenu.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.min.css" media="print" onload="this.media='all'">
        <link rel="stylesheet" href="assets/css/nice-select.min.css">
        <link rel="stylesheet" href="assets/css/owl.carousel.min.css" media="print" onload="this.media='all'">
        <link rel="stylesheet" href="assets/css/fontawesome.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/dark.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
        <title>SEO Consultant in $($city.name) | Best SEO Services - Buddhika S Weerasekara</title>
        <meta name="description" content="Professional SEO Consultant in $($city.name), $($city.province), Sri Lanka. Buddhika S Weerasekara offers white-hat SEO services, technical optimization, and guaranteed Google rankings in $($city.name).">
        <meta name="keywords" content="SEO Consultant $($city.name), SEO Services $($city.name), Best SEO Consultant $($city.name), SEO Expert $($city.name), Digital Marketing $($city.name)">
        <link rel="canonical" href="https://seoconsultantsrilanka.com/seo-consultant-$($city.slug).html" />
        <meta property="og:title" content="SEO Consultant in $($city.name) | Buddhika S Weerasekara">
        <meta property="og:description" content="Professional SEO Consultant in $($city.name) offering white-hat SEO, technical optimization, and guaranteed Google rankings.">
        <meta property="og:type" content="website">
        <meta property="og:url" content="https://seoconsultantsrilanka.com/seo-consultant-$($city.slug).html">
        <meta property="og:image" content="https://seoconsultantsrilanka.com/assets/img/seo-logo.png">
        <meta property="og:locale" content="en_US">
        <meta property="og:site_name" content="SEO Consultant Sri Lanka">
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:title" content="SEO Consultant in $($city.name) | Buddhika S Weerasekara">
        <meta name="twitter:description" content="Professional SEO Consultant $($city.name) with expertise in white-hat SEO and guaranteed Google rankings.">
        <meta name="twitter:image" content="https://seoconsultantsrilanka.com/assets/img/seo-logo.png">
        <meta name="geo.region" content="$($city.region)">
        <meta name="geo.placename" content="$($city.name)">
        <meta name="geo.position" content="$($city.lat);$($city.lon)">
        <meta name="ICBM" content="$($city.lat), $($city.lon)">
        <meta name="author" content="Buddhika S Weerasekara">
        <meta name="robots" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1">
        <meta name="googlebot" content="index, follow">
        <meta name="bingbot" content="index, follow">
        <script type="application/ld+json">
        {
          "@context": "https://schema.org",
          "@type": "LocalBusiness",
          "@id": "https://seoconsultantsrilanka.com/seo-consultant-$($city.slug).html#organization",
          "name": "Buddhika S Weerasekara - SEO Consultant $($city.name)",
          "alternateName": "Best SEO Consultant in $($city.name), Sri Lanka",
          "url": "https://seoconsultantsrilanka.com/seo-consultant-$($city.slug).html",
          "logo": "https://seoconsultantsrilanka.com/assets/img/seo-logo.png",
          "image": "https://seoconsultantsrilanka.com/assets/img/seo-logo.png",
          "description": "Professional SEO Consultant in $($city.name), $($city.province), Sri Lanka. Offering comprehensive white-hat SEO services, technical optimization, GEO optimization, and guaranteed Google rankings for businesses in $($city.name).",
          "telephone": "+94-77-806-4714",
          "email": "seo@inzra.com",
          "address": {
            "@type": "PostalAddress",
            "@type": "PostalAddress",
            "addressCountry": "LK",
            "addressRegion": "$($city.province)",
            "addressLocality": "$($city.name)",
            "streetAddress": "$($city.name), Sri Lanka"
          },
          "geo": {
            "@type": "GeoCoordinates",
            "latitude": "$($city.lat)",
            "longitude": "$($city.lon)"
          },
          "areaServed": {
            "@type": "City",
            "name": "$($city.name)"
          },
          "priceRange": "`$`$",
          "openingHours": "Mo-Su 00:00-23:59",
          "sameAs": [
            "https://www.facebook.com/buddika.suresh/",
            "https://www.facebook.com/seoexpertsrilanka/",
            "https://www.linkedin.com/in/seo-consultant-uae/"
          ]
        }
        </script>
        <script type="application/ld+json">
        {
          "@context": "https://schema.org",
          "@type": "Person",
          "name": "Buddhika S Weerasekara",
          "jobTitle": "SEO Consultant in $($city.name)",
          "description": "Professional SEO Consultant serving $($city.name) and surrounding areas in $($city.province). Specializing in white-hat SEO, technical optimization, and guaranteed Google rankings.",
          "url": "https://seoconsultantsrilanka.com/seo-consultant-$($city.slug).html",
          "image": "https://seoconsultantsrilanka.com/assets/img/seo.jpg",
          "email": "seo@inzra.com",
          "telephone": "+94-77-806-4714",
          "address": {
            "@type": "PostalAddress",
            "addressCountry": "LK",
            "addressRegion": "$($city.province)",
            "addressLocality": "$($city.name)"
          }
        }
        </script>
    </head>
    <body class="dark">
        <header class="navbar-area">
            <div class="navbar-wrap navbar-dark">
                <div class="navbar-logo">
                    <a href="index.html" aria-label="Buddhika S Weerasekara - SEO Consultant">
                        <img src="assets/img/seo-logo.png" alt="Logo" style="max-height: 50px;">
                    </a>
                </div>
                <nav class="navbar">
                    <ul class="nav-list">
                        <li role="none"><a role="menuitem" href="index.html">Home</a></li>
                        <li role="none"><a role="menuitem" href="services.html">Services</a></li>
                        <li role="none"><a role="menuitem" href="pricing.html">Pricing</a></li>
                        <li role="none"><a role="menuitem" href="faq.html">FAQ</a></li>
                        <li role="none"><a role="menuitem" href="blog.html">Blog</a></li>
                        <li role="none"><a role="menuitem" href="contact.html">Contact</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <h1 class="hero-title">SEO Consultant in $($city.name)</h1>
                        <p class="hero-subtitle">Professional SEO Services for $($city.name) Businesses | Guaranteed Google Rankings</p>
                        <p class="hero-desc">Looking for the best SEO consultant in $($city.name)? Buddhika S Weerasekara is the #1 choice for businesses in $($city.name), $($city.province) seeking professional SEO services. With 10+ years of experience, we deliver white-hat SEO strategies that guarantee results.</p>
                        <div class="hero-buttons">
                            <a href="contact.html" class="btn btn-primary">Get Free Consultation</a>
                            <a href="pricing.html" class="btn btn-secondary">View Pricing</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="about-section">
            <div class="container">
                <h2>Why Choose Our SEO Services in $($city.name)?</h2>
                <div class="row">
                    <div class="col-md-6">
                        <h3>Local SEO Expertise</h3>
                        <p>As a $($city.name) SEO consultant, I understand the local business landscape in $($city.province). Our SEO strategies are specifically tailored to $($city.name)'s competitive market.</p>
                    </div>
                    <div class="col-md-6">
                        <h3>White-Hat SEO Techniques</h3>
                        <p>We use only ethical, sustainable SEO methods that comply with Google's guidelines. No shortcuts, no black-hat tactics—just results that last for your $($city.name) business.</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <h3>Comprehensive Services</h3>
                        <p>From on-page optimization to technical SEO, link building, and content strategy—we handle all aspects of search engine optimization for $($city.name) businesses.</p>
                    </div>
                    <div class="col-md-6">
                        <h3>Proven Results</h3>
                        <p>Over 10+ years, we've helped hundreds of businesses in $($city.name) and across Sri Lanka achieve top Google rankings and sustainable organic growth.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="cta-section">
            <div class="container">
                <h2>Need SEO Services in $($city.name)?</h2>
                <p>Get your free SEO audit and consultation for your $($city.name) business today. Discover how our SEO consultant in $($city.name) can help you rank higher on Google.</p>
                <a href="contact.html" class="btn btn-primary btn-lg">Contact Us Today</a>
            </div>
        </section>

        <footer class="footer-section">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <h4>Quick Links</h4>
                        <ul>
                            <li><a href="index.html">Home</a></li>
                            <li><a href="services.html">Services</a></li>
                            <li><a href="pricing.html">Pricing</a></li>
                            <li><a href="contact.html">Contact</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h4>SEO Resources</h4>
                        <ul>
                            <li><a href="blog.html">Blog</a></li>
                            <li><a href="faq.html">FAQ</a></li>
                            <li><a href="what-is-seo.html">What is SEO</a></li>
                            <li><a href="ai-seo.html">AI SEO</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h4>Contact Information</h4>
                        <p>Phone: <a href="tel:+94778064714">+94 77 806 4714</a></p>
                        <p>Email: <a href="mailto:seo@inzra.com">seo@inzra.com</a></p>
                        <p>Location: $($city.name), Sri Lanka</p>
                    </div>
                    <div class="col-md-3">
                        <h4>Follow Us</h4>
                        <ul class="social-links">
                            <li><a href="https://www.facebook.com/seoexpertsrilanka/" target="_blank" rel="noopener noreferrer">Facebook</a></li>
                            <li><a href="https://www.linkedin.com/in/seo-consultant-uae/" target="_blank" rel="noopener noreferrer">LinkedIn</a></li>
                        </ul>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p>&copy; 2025 Buddhika S Weerasekara - SEO Consultant in $($city.name). All rights reserved.</p>
                </div>
            </div>
        </footer>

        <a href="https://wa.me/94778064714" class="whatsapp-float" target="_blank" rel="noopener noreferrer" aria-label="Chat on WhatsApp">
            <i class="fab fa-whatsapp"></i>
        </a>

        <script src="assets/js/jquery.min.js" defer></script>
        <script src="assets/js/bootstrap.bundle.min.js" defer></script>
        <script src="assets/js/main.js" defer></script>
    </body>
</html>
"@

    # Write the file
    $htmlContent | Out-File -FilePath $filename -Encoding UTF8 -Force
    $count++
    Write-Host "✓ Created: seo-consultant-$($city.slug).html - $($city.name), $($city.province)"
}

Write-Host ""
Write-Host "Successfully created $count location-based SEO pages!" -ForegroundColor Green
Write-Host "All pages include:"
Write-Host "  ✓ Location-specific meta tags and keywords"
Write-Host "  ✓ Geo-structured data (LocalBusiness schema)"
Write-Host "  ✓ Person schema for Buddhika S Weerasekara"
Write-Host "  ✓ Open Graph and Twitter cards"
Write-Host "  ✓ Proper heading hierarchy (H1, H2, H3)"
Write-Host "  ✓ Geographic coordinates (lat/lon)"
Write-Host "  ✓ Local business information"
