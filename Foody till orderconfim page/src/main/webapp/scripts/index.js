// Menu items data
const menuItems = [
    {
        id: 1,
        name: "Spicy Beef Burger",
        category: "Burgers",
        price: 15.99,
        image: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500"
    },
    {
        id: 2,
        name: "Hot Chicken Fillet",
        category: "Chicken",
        price: 14.99,
        image: "https://images.unsplash.com/photo-1562967914-608f82629710?w=500"
    },
    {
        id: 3,
        name: "Veggie Supreme Pizza",
        category: "Pizza",
        price: 18.99,
        image: "https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500"
    },
    {
        id: 4,
        name: "Spicy Taco Platter",
        category: "Mexican",
        price: 16.99,
        image: "https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=500"
    }
];

// Cart functionality
let cart = [];

function addToCart(itemId) {
    const item = menuItems.find(item => item.id === itemId);
    if (item) {
        cart.push(item);
        updateCartCount();
        updateCartDisplay();
    }
}

function updateCartCount() {
    const cartCount = document.querySelector('.cart-count');
    cartCount.textContent = cart.length;
}

function updateCartDisplay() {
    // This function would update a cart modal or page
    console.log('Cart updated:', cart);
}

// Mobile menu functionality
const mobileMenuBtn = document.querySelector('.mobile-menu');
const closeMenuBtn = document.querySelector('.close-menu');
const mobileNav = document.querySelector('.mobile-nav');

mobileMenuBtn.addEventListener('click', () => {
    mobileNav.classList.add('active');
    document.body.style.overflow = 'hidden';
});

closeMenuBtn.addEventListener('click', () => {
    mobileNav.classList.remove('active');
    document.body.style.overflow = '';
});

// Smooth scroll for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            smoothScroll(target, 1000);
            // Close mobile menu if open
            mobileNav.classList.remove('active');
            document.body.style.overflow = '';
        }
    });
});

// Smooth scroll function
function smoothScroll(target, duration) {
    const targetPosition = target.getBoundingClientRect().top + window.pageYOffset;
    const startPosition = window.pageYOffset;
    const distance = targetPosition - startPosition;
    let startTime = null;

    function animation(currentTime) {
        if (startTime === null) startTime = currentTime;
        const timeElapsed = currentTime - startTime;
        const run = ease(timeElapsed, startPosition, distance, duration);
        window.scrollTo(0, run);
        if (timeElapsed < duration) requestAnimationFrame(animation);
    }

    function ease(t, b, c, d) {
        t /= d / 2;
        if (t < 1) return c / 2 * t * t + b;
        t--;
        return -c / 2 * (t * (t - 2) - 1) + b;
    }

    requestAnimationFrame(animation);
}

// Floating food animation
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

// Scrolling animations
function handleScrollAnimations() {
    const elements = document.querySelectorAll('.animate-on-scroll');
    const windowHeight = window.innerHeight;

    elements.forEach(el => {
        const positionFromTop = el.getBoundingClientRect().top;

        if (positionFromTop - windowHeight <= 0) {
            el.classList.add('animated');
        }
    });
}

// Parallax effect
function handleParallax() {
    const parallaxBg = document.querySelector('.parallax-bg');
    const parallaxElements = document.querySelectorAll('[data-speed]');
    
    window.addEventListener('scroll', () => {
        const scrolled = window.pageYOffset;
        
        if (parallaxBg) {
            parallaxBg.style.transform = `translateY(${scrolled * 0.5}px)`;
        }
        
        parallaxElements.forEach((element) => {
            const speed = element.getAttribute('data-speed');
            element.style.transform = `translateY(${scrolled * speed}px)`;
        });
    });
}

// Initialize the page
document.addEventListener('DOMContentLoaded', () => {
    // Populate menu items
    displayMenuItems();
    
    // Handle form submissions
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', handleContactSubmit);
    }

    // Newsletter form
    const newsletterForm = document.querySelector('.newsletter-form');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', handleNewsletterSubmit);
    }

    // Navbar scroll effect
    window.addEventListener('scroll', () => {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 100) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
        handleScrollAnimations();
    });

    // Initialize floating food animations
    animateFloatingFood();

    // Initialize scroll animations
    handleScrollAnimations();

    // Initialize parallax effect
    handleParallax();
});

// Display menu items
function displayMenuItems() {
    const menuGrid = document.querySelector('.menu-grid');
    if (!menuGrid) return;

    menuGrid.innerHTML = menuItems.map(item => `
        <div class="menu-item animate-on-scroll">
            <img src="${item.image}" alt="${item.name}">
            <div class="menu-item-content">
                <h3>${item.name}</h3>
                <p class="price">$${item.price.toFixed(2)}</p>
                <button onclick="addToCart(${item.id})" class="add-to-cart">Add to Cart</button>
            </div>
        </div>
    `).join('');
}

// Handle form submissions
function handleContactSubmit(e) {
    e.preventDefault();
    // Add contact form submission logic here
    alert('Message sent successfully!');
    e.target.reset();
}

function handleNewsletterSubmit(e) {
    e.preventDefault();
    // Add newsletter subscription logic here
    alert('Thank you for subscribing!');
    e.target.reset();
}

// Search functionality
const searchBtn = document.querySelector('.search-btn');
const searchInput = document.querySelector('.search-bar input');

searchBtn.addEventListener('click', () => {
    const searchTerm = searchInput.value.toLowerCase();
    // Implement search logic here
    console.log('Searching for:', searchTerm);
    // You could filter menuItems based on the search term and re-display the results
});

// Initialize the cart count
updateCartCount();

