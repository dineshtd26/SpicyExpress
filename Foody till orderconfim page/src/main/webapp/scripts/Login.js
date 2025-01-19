document.addEventListener('DOMContentLoaded', () => {
    const loginContainer = document.querySelector('.login-container');
    
    function handleScrollAnimation() {
        const windowHeight = window.innerHeight;
        const elementTop = loginContainer.getBoundingClientRect().top;

        if (elementTop - windowHeight <= 0) {
            loginContainer.classList.add('animated');
        }
    }

    // Initial check
    handleScrollAnimation();

    // Check on scroll
    window.addEventListener('scroll', handleScrollAnimation);
});
