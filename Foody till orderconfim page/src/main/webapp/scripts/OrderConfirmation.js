document.addEventListener('DOMContentLoaded', () => {
    // Scroll animations
    function handleScrollAnimation() {
        const animatedElements = document.querySelectorAll('.animate-on-scroll');
        const windowHeight = window.innerHeight;

        animatedElements.forEach(element => {
            const elementTop = element.getBoundingClientRect().top;
            if (elementTop - windowHeight <= 0) {
                element.classList.add('animated');
            }
        });
    }

    window.addEventListener('scroll', handleScrollAnimation);
    handleScrollAnimation();

    // Tick animation
    const tick = document.querySelector('.tick');
    if (tick) {
        setTimeout(() => {
            tick.style.display = 'block';
        }, 500);
    }

    // Cracker animation
    function animateCrackers() {
        const crackers = document.querySelectorAll('.cracker');
        crackers.forEach(cracker => {
            cracker.style.animation = 'none';
            cracker.offsetHeight; // Trigger reflow
            cracker.style.animation = null;
        });
    }

    // Trigger cracker animation every 2 seconds
    setInterval(animateCrackers, 2000);

    // Bike animation
    const bike = document.querySelector('.bike-image');
    if (bike) {
        bike.style.display = 'block';
    }

    console.log("OrderConfirmation.js loaded successfully!");
});

