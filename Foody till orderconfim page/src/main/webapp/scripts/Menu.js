document.addEventListener('DOMContentLoaded', () => {
    const menuGrid = document.querySelector('.menu-grid');
    const navbar = document.querySelector('.navbar');

    // Function to handle scroll animations
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

    // Add to cart functionality with fetch and POST method
    const addButtons = document.querySelectorAll('.add-button');
    addButtons.forEach(button => {
        button.addEventListener('click', async (e) => {
            e.preventDefault();
            const menuItem = button.closest('.menu-card');
            const itemName = menuItem.querySelector('.menu-title').textContent;
            const itemPrice = menuItem.querySelector('.price').textContent;
            const itemId = button.getAttribute('data-id');

            // Debugging: Log the item details
            console.log(`Adding to cart: ${itemName} - ${itemPrice} (ID: ${itemId})`);

            // Send data to the server
            try {
                const response = await fetch('CartServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: `menuID=${itemId}&action=add`
                });

                if (response.ok) {
                    console.log('Item successfully added to cart');
                    // Update the cart count by 1
                    updateCartCount(1);
                    // Redirect to Cart.jsp after adding item
                    window.location.href = 'Cart.jsp';
                } else {
                    console.error('Failed to add item to cart');
                    alert('Failed to add item to cart. Please try again.');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('An error occurred while adding the item to cart. Please try again.');
            }
        });
    });

    // Function to update the cart count displayed in the navbar
    function updateCartCount(amount) {
        const cartCount = document.querySelector('.cart-count');
        let currentCount = parseInt(cartCount.textContent) || 0; // Default to 0 if no count is present
        currentCount += amount;
        cartCount.textContent = currentCount;
    }

    // Search functionality to filter menu items by name or description
    const searchInput = document.getElementById('searchInput');
    const searchIcon = document.querySelector('.search-icon');

    searchIcon.addEventListener('click', performSearch);
    searchInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            performSearch();
        }
    });

    function performSearch() {
        const searchTerm = searchInput.value.trim().toLowerCase();
        if (searchTerm) {
            const menuItems = document.querySelectorAll('.menu-card');
            menuItems.forEach(item => {
                const title = item.querySelector('.menu-title').textContent.toLowerCase();
                const description = item.querySelector('.menu-description').textContent.toLowerCase();
                if (title.includes(searchTerm) || description.includes(searchTerm)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        }
    }

    // Newsletter form submission
    const newsletterForm = document.querySelector('.newsletter-form');
    newsletterForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const email = newsletterForm.querySelector('input[type="email"]').value;
        console.log(`Newsletter subscription for: ${email}`);
        alert('Thank you for subscribing to our newsletter!');
        newsletterForm.reset();
    });

    // Function to animate floating food items
    function animateFloatingFood() {
        const floatingFoods = document.querySelectorAll('.floating-food');
        floatingFoods.forEach(food => {
            const randomX = Math.random() * 20 - 10; // Random value between -10 and 10
            const randomY = Math.random() * 20 - 10; // Random value between -10 and 10
            const randomDuration = Math.random() * 2 + 4; // Random duration between 4 and 6 seconds

            food.style.animation = `float ${randomDuration}s ease-in-out infinite`;
            food.style.transform = `translate(${randomX}px, ${randomY}px)`;
        });
    }

    // Call the function to animate floating food
    animateFloatingFood();
});
