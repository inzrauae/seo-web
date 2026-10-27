(function () {
    'use strict';
    var goals = {
        local: ['Local visibility', 'Turn nearby searches into real conversations.', 'Give customers a clear path from finding your business on Google to calling, visiting, or making an enquiry.', ['Google Business Profile review', 'Location and service page optimization', 'Local enquiry and conversion tracking'], 'local-seo-sri-lanka', 'Explore local SEO'],
        shop: ['eCommerce growth', 'Help the right shoppers find your products.', 'Connect product discovery with purchase intent through better categories, product pages, and technical foundations.', ['Product and category keyword mapping', 'Crawl, indexing, and product schema review', 'Organic sales and conversion measurement'], 'ecommerce-seo-sri-lanka', 'Explore eCommerce SEO'],
        authority: ['Search & AI visibility', 'Make your expertise easier to discover.', 'Develop useful content and a consistent brand presence that helps people and search systems understand your business.', ['Content gaps and topical coverage review', 'Structured data and entity consistency', 'Google and AI search visibility assessment'], 'ai-seo', 'Explore AI SEO & GEO']
    };
    var buttons = document.querySelectorAll('[data-goal]');
    buttons.forEach(function (button) {
        button.addEventListener('click', function () {
            var goal = goals[button.dataset.goal];
            if (!goal) return;
            buttons.forEach(function (item) { item.setAttribute('aria-pressed', String(item === button)); });
            ['goal-label', 'goal-title', 'goal-description'].forEach(function (id, index) { document.getElementById(id).textContent = goal[index]; });
            var list = document.getElementById('goal-points');
            list.replaceChildren();
            goal[3].forEach(function (text) { var li = document.createElement('li'); li.textContent = text; list.appendChild(li); });
            var link = document.getElementById('goal-link');
            link.href = goal[4];
            link.textContent = goal[5] + ' \u2197';
        });
    });
})();
