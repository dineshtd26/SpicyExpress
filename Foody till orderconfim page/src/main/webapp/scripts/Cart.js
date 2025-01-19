document.addEventListener('DOMContentLoaded', () => {
    const productList = document.getElementById('product-list');
    const cartCount = document.getElementById('cart-count');
    const subtotalElement = document.getElementById('subtotal');
    const discountElement = document.getElementById('discount');
    const totalElement = document.getElementById('total');
    const clearCartBtn = document.getElementById('clear-cart-btn');
    const applyPromoBtn = document.getElementById('apply-promo-btn');
    const promoCodeInput = document.getElementById('promo-code-input');

    function handleQuantityChange(e) {
        if (e.target.classList.contains('quantity-btn')) {
            const menuID = e.target.dataset.id;
            const productItem = e.target.closest('.product-item');
            const quantityForm = productItem.querySelector('.quantity-form');
            const quantityInput = quantityForm.querySelector('.quantity-input');
            const quantityDisplay = productItem.querySelector('.quantity-display');
            const currentQuantity = parseInt(quantityInput.value);

            if (e.target.classList.contains('plus')) {
                quantityInput.value = currentQuantity + 1;
                quantityDisplay.textContent = currentQuantity + 1;
            } else if (e.target.classList.contains('minus') && currentQuantity > 1) {
                quantityInput.value = currentQuantity - 1;
                quantityDisplay.textContent = currentQuantity - 1;
            }

            // Submit the form
            quantityForm.submit();
        }
    }

    function handleClearCart(e) {
        e.preventDefault();
        if (confirm('Are you sure you want to clear your cart?')) {
            clearCartBtn.closest('form').submit();
        }
    }

    function handleApplyPromo() {
        const promoCode = promoCodeInput.value.trim().toUpperCase();
        if (promoCode === 'DISCOUNT10') {
            const subtotal = parseFloat(subtotalElement.textContent.replace('Rs.', ''));
            const discount = subtotal * 0.1;
            discountElement.textContent = `-Rs.${discount.toFixed(2)}`;
            updateTotals();
            alert('Promo code applied successfully!');
        } else {
            alert('Invalid promo code. Please try again.');
        }
    }

    function updateTotals() {
        let subtotal = 0;
        const items = productList.querySelectorAll('.product-item');
        items.forEach(item => {
            const price = parseFloat(item.querySelector('.item-price').textContent.replace('Rs.', ''));
            subtotal += price;
        });

        const discount = parseFloat(discountElement.textContent.replace('-Rs.', ''));
        const total = subtotal - discount;

        subtotalElement.textContent = `Rs.${subtotal.toFixed(2)}`;
        totalElement.textContent = `Rs.${total.toFixed(2)}`;
    }

    // Event listeners
    productList.addEventListener('click', handleQuantityChange);
    clearCartBtn.addEventListener('click', handleClearCart);
    applyPromoBtn.addEventListener('click', handleApplyPromo);

    // Initialize
    updateTotals();

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

    // Animate floating food
    function animateFloatingFood() {
        const floatingFoods = document.querySelectorAll('.floating-food');
        floatingFoods.forEach(food => {
            const randomX = Math.random() * 20 - 10;
            const randomY = Math.random() * 20 - 10;
            const randomDuration = Math.random() * 2 + 4;

            food.style.animation = `float ${randomDuration}s ease-in-out infinite`;
            food.style.transform = `translate(${randomX}px, ${randomY}px)`;
        });
    }

    animateFloatingFood();
});

