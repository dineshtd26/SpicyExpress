/**
 * 
 */
document.addEventListener('DOMContentLoaded', () => {
    const registerContainer = document.querySelector('.register-container');
    const navbar = document.querySelector('.navbar');
    
    function handleScrollAnimation() {
        const windowHeight = window.innerHeight;
        const elementTop = registerContainer.getBoundingClientRect().top;

        if (elementTop - windowHeight <= 0) {
            registerContainer.classList.add('animated');
        }
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

    // Form submission
    const registerForm = document.querySelector('.register-form');
    registerForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;
        const address = document.getElementById('address').value;
        const phone = document.getElementById('phone').value;

        // Here you would typically send the registration data to your server
        console.log('Registration attempt:', { name, email, password, address, phone });

        // For demonstration purposes, we'll just show an alert
        alert('Registration functionality would be implemented here.');
    });
});