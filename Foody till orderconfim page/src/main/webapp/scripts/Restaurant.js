document.addEventListener('DOMContentLoaded', () => {
    const restaurantGrid = document.querySelector('.restaurant-grid');
    const navbar = document.querySelector('.navbar');
    const tabButtons = document.querySelectorAll('.tab-button');
    
    function handleScrollAnimation() {
        const windowHeight = window.innerHeight;
        const animatedElements = document.querySelectorAll('.animate-on-scroll');

        animatedElements.forEach(element => {
            const elementTop = element.getBoundingClientRect().top;

            if (elementTop - windowHeight <= 0) {
                element.classList.add('animated');
            }
        });
    }

    // Initial check
    handleScrollAnimation();

    // Check on scroll
    window.addEventListener('scroll', handleScrollAnimation);

    // Navbar scroll effect
    window.addEventListener('scroll', () => {
        if (window.scrollY > 100) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Tab functionality
    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            tabButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            // Here you would typically implement the logic to show/hide content based on the selected tab
            console.log(`Switched to ${button.dataset.tab} tab`);
        });
    });

    // Search functionality
    const searchInput = document.getElementById('searchInput');
    const searchIcon = document.querySelector('.search-icon');

    searchIcon.addEventListener('click', performSearch);
    searchInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            performSearch();
        }
    });

    function performSearch() {
        const searchTerm = searchInput.value.trim();
        if (searchTerm) {
            // Here you would typically implement the search logic
            console.log(`Searching for: ${searchTerm}`);
            // For demonstration, let's filter the restaurant cards
            filterRestaurants(searchTerm);
        }
    }

    function filterRestaurants(searchTerm) {
        const restaurantCards = document.querySelectorAll('.restaurant-card');
        restaurantCards.forEach(card => {
            const restaurantName = card.querySelector('.restaurant-name').textContent.toLowerCase();
            const cuisineType = card.querySelector('.cuisine-type').textContent.toLowerCase();
            if (restaurantName.includes(searchTerm.toLowerCase()) || cuisineType.includes(searchTerm.toLowerCase())) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    // Newsletter form submission
    const newsletterForm = document.querySelector('.newsletter-form');
    newsletterForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const email = newsletterForm.querySelector('input[type="email"]').value;
        // Here you would typically send the email to your server
        console.log(`Newsletter subscription for: ${email}`);
        alert('Thank you for subscribing to our newsletter!');
        newsletterForm.reset();
    });

    // Animate floating food
    function animateFloatingFood() {
        const floatingFoods = document.querySelectorAll('.floating-food');
        floatingFoods.forEach(food => {
            const randomX = Math.random() * 20 - 10; // Random value between -10 and 10
            const randomY = Math.random() * 20 - 10; // Random value between -10 and 10
            const randomDuration = Math.random() * 2 + 4; // Random duration between 4 and 6 seconds

            food.style.animation = `float ${randomDuration}s ease-in-out infinite, sway ${randomDuration}s ease-in-out infinite`;
            food.style.transform = `translate(${randomX}px, ${randomY}px)`;
        });
    }

    animateFloatingFood();
});