/**
 * CineTrack – Interactive Client-Side Script
 */

if (!window.__CINETRACK_INITIALIZED__) {
    window.__CINETRACK_INITIALIZED__ = true;

    document.addEventListener('DOMContentLoaded', () => {
        initSearchAndFilter();
        initStatCounters();
        initTimeGreeting();
    });
}

/**
 * Filter and Search logic for showcase movie cards
 */
function initSearchAndFilter() {
    const searchInput = document.getElementById('movieSearchInput');
    const chipButtons = document.querySelectorAll('.chip-btn');
    const movieCards = document.querySelectorAll('.movie-card');
    const emptyState = document.getElementById('searchEmptyState');
    let currentCategory = 'all';

    function filterMovies() {
        const query = searchInput ? searchInput.value.trim().toLowerCase() : '';
        let visibleCount = 0;

        movieCards.forEach(card => {
            const title = card.getAttribute('data-title') || '';
            const director = card.getAttribute('data-director') || '';
            const categories = (card.getAttribute('data-category') || '').toLowerCase();

            const matchesQuery = !query || 
                title.toLowerCase().includes(query) || 
                director.toLowerCase().includes(query) || 
                categories.includes(query);

            const matchesCategory = currentCategory === 'all' || 
                categories.includes(currentCategory);

            if (matchesQuery && matchesCategory) {
                card.style.display = 'flex';
                card.style.animation = 'fadeIn 0.3s ease forwards';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        if (emptyState) {
            emptyState.style.display = visibleCount === 0 ? 'block' : 'none';
        }
    }

    if (searchInput) {
        searchInput.addEventListener('input', filterMovies);
    }

    chipButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            chipButtons.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            currentCategory = (btn.getAttribute('data-filter') || 'all').toLowerCase();
            filterMovies();
        });
    });
}

/**
 * Number counting animation for statistics
 */
function initStatCounters() {
    const statElements = document.querySelectorAll('.stat-value[data-target]');
    
    statElements.forEach(el => {
        const target = parseInt(el.getAttribute('data-target'), 10);
        const prefix = el.getAttribute('data-prefix') || '';
        const suffix = el.getAttribute('data-suffix') || '';
        if (isNaN(target)) return;

        let current = 0;
        const duration = 1200;
        const stepTime = 20;
        const totalSteps = duration / stepTime;
        const increment = target / totalSteps;

        const timer = setInterval(() => {
            current += increment;
            if (current >= target) {
                el.textContent = `${prefix}${target.toLocaleString()}${suffix}`;
                clearInterval(timer);
            } else {
                el.textContent = `${prefix}${Math.floor(current).toLocaleString()}${suffix}`;
            }
        }, stepTime);
    });
}

/**
 * Contextual Greeting according to time of day
 */
function initTimeGreeting() {
    const greetingEl = document.getElementById('dynamicGreeting');
    if (!greetingEl) return;

    const hour = new Date().getHours();
    let greeting = 'Welcome';
    if (hour < 12) {
        greeting = 'Good Morning';
    } else if (hour < 18) {
        greeting = 'Good Afternoon';
    } else {
        greeting = 'Good Evening';
    }

    greetingEl.textContent = `${greeting}, Cinema Administrator`;
}
