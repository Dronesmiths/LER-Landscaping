// Basic interactions scripts
document.addEventListener('DOMContentLoaded', () => {
    console.log('LER Landscaping site loaded');

    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });

    // Mobile Menu Toggle
    const mobileBtn = document.querySelector('.mobile-menu-btn');
    const navMenu = document.querySelector('.nav-menu');
    const icon = mobileBtn ? mobileBtn.querySelector('i') : null;

    if (mobileBtn && navMenu) {
        mobileBtn.addEventListener('click', (e) => {
            e.stopPropagation(); // Prevent bubbling
            navMenu.classList.toggle('active');

            // Toggle icon
            if (icon) {
                if (navMenu.classList.contains('active')) {
                    icon.classList.remove('fa-bars');
                    icon.classList.add('fa-times');
                } else {
                    icon.classList.remove('fa-times');
                    icon.classList.add('fa-bars');
                }
            }
        });

        // Close menu when clicking a link
        navMenu.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => {
                navMenu.classList.remove('active');
                if (icon) {
                    icon.classList.remove('fa-times');
                    icon.classList.add('fa-bars');
                }
            });
        });

        // Close menu when clicking outside
        document.addEventListener('click', (e) => {
            if (navMenu.classList.contains('active') && !navMenu.contains(e.target) && !mobileBtn.contains(e.target)) {
                navMenu.classList.remove('active');
                if (icon) {
                    icon.classList.remove('fa-times');
                    icon.classList.add('fa-bars');
                }
            }
        });
    }


    // Dynamic Year in Footer
    const yearSpan = document.getElementById('year');
    if (yearSpan) {
        yearSpan.textContent = new Date().getFullYear();
    }

    // Comparison Slider Logic (New Range Input Method)
    document.querySelectorAll('.av-yard-ba-slider').forEach(slider => {
        const range = slider.querySelector('.av-yard-range');
        const after = slider.querySelector('.av-yard-after');
        const divider = slider.querySelector('.av-yard-divider');
        const handle = slider.querySelector('.av-yard-handle');

        function update(val) {
            after.style.clipPath = `inset(0 0 0 ${val}%)`;
            divider.style.left = val + '%';
            handle.style.left = val + '%';
        }

        if (range && after && divider && handle) {
            update(range.value);
            range.addEventListener('input', e => update(e.target.value));
        }
    });

    // Language Toggle Logic
    const langToggle = document.getElementById('langToggle');
    const currentLang = localStorage.getItem('preferredLang') || 'en';

    function setLanguage(lang) {
        document.documentElement.lang = lang;
        localStorage.setItem('preferredLang', lang);

        // Update Toggle UI
        const enSpan = document.querySelector('.lang-en');
        const esSpan = document.querySelector('.lang-es');

        if (enSpan && esSpan) {
            if (lang === 'es') {
                enSpan.classList.remove('active');
                esSpan.classList.add('active');
            } else {
                esSpan.classList.remove('active');
                enSpan.classList.add('active');
            }
        }

        // Translate elements with data attributes
        document.querySelectorAll('[data-en]').forEach(el => {
            const translation = el.getAttribute(`data-${lang}`);
            if (translation) {
                // If it's a placeholder, update that too
                if (el.tagName === 'INPUT' || el.tagName === 'TEXTAREA') {
                    if (el.hasAttribute('placeholder')) {
                        el.setAttribute('placeholder', translation);
                    }
                } else {
                    el.textContent = translation;
                }
            }
        });

        // Handle meta description if needed - simpler to just stick to content for now
    }

    if (langToggle) {
        langToggle.addEventListener('click', () => {
            const nextLang = document.documentElement.lang === 'en' ? 'es' : 'en';
            setLanguage(nextLang);
        });
    }

    // Initialize Language
    setLanguage(currentLang);
});
