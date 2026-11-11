(function () {
  'use strict';

  var header = document.getElementById('site-header');
  var toggle = header.querySelector('.nav-toggle');
  var mobileMenu = header.querySelector('.mobile-menu');
  var goTop = document.getElementById('go-top');
  var progress = document.querySelector('.reading-progress');
  var article = document.querySelector('.guide-article');
  var tocLinks = Array.from(document.querySelectorAll('.guide-toc a'));
  var sections = tocLinks.map(function (link) {
    return document.querySelector(link.getAttribute('href'));
  });
  var reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');

  function setMenu(open) {
    header.classList.toggle('open', open);
    toggle.setAttribute('aria-expanded', String(open));
    toggle.setAttribute('aria-label', open ? 'Close navigation' : 'Open navigation');
    mobileMenu.hidden = !open;
  }

  toggle.addEventListener('click', function () {
    setMenu(toggle.getAttribute('aria-expanded') !== 'true');
  });
  mobileMenu.addEventListener('click', function (event) {
    if (event.target.closest('a')) setMenu(false);
  });
  document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape' && !mobileMenu.hidden) {
      setMenu(false);
      toggle.focus();
    }
  });
  window.matchMedia('(min-width: 900px)').addEventListener('change', function (event) {
    if (event.matches) setMenu(false);
  });

  function updateReadingState() {
    goTop.classList.toggle('show', window.scrollY > 500);
    var articleStart = article.offsetTop;
    var end = articleStart + article.offsetHeight - window.innerHeight;
    var fraction = (window.scrollY - articleStart) / Math.max(end - articleStart, 1);
    progress.style.transform = 'scaleX(' + Math.min(1, Math.max(0, fraction)) + ')';

    var current = -1;
    sections.forEach(function (section, index) {
      if (section && section.getBoundingClientRect().top <= 160) current = index;
    });
    tocLinks.forEach(function (link, index) {
      if (index === current) link.setAttribute('aria-current', 'location');
      else link.removeAttribute('aria-current');
    });
  }

  var scheduled = false;
  window.addEventListener('scroll', function () {
    if (scheduled) return;
    scheduled = true;
    window.requestAnimationFrame(function () {
      updateReadingState();
      scheduled = false;
    });
  }, { passive: true });
  window.addEventListener('resize', updateReadingState);
  window.addEventListener('load', updateReadingState);
  goTop.addEventListener('click', function () {
    window.scrollTo({ top: 0, behavior: reducedMotion.matches ? 'auto' : 'smooth' });
    document.getElementById('main-content').focus({ preventScroll: true });
  });
  updateReadingState();
})();
