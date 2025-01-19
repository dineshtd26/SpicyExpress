document.addEventListener('DOMContentLoaded', () => {
    // Initialize calendar
    const calendar = {
        currentDate: new Date(),
        selectedDate: null,
        monthNames: [
            'January', 'February', 'March', 'April', 'May', 'June',
            'July', 'August', 'September', 'October', 'November', 'December'
        ],
        dayNames: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    };

    function updateCalendar() {
        const year = calendar.currentDate.getFullYear();
        const month = calendar.currentDate.getMonth();
        
        document.getElementById('currentMonth').textContent = 
            `${calendar.monthNames[month]} ${year}`;

        const firstDay = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);
        const daysInMonth = lastDay.getDate();
        const startingDay = firstDay.getDay() || 7; // Convert Sunday (0) to 7

        const calendarGrid = document.querySelector('.calendar-grid');
        calendarGrid.innerHTML = '';

        // Add day names
        calendar.dayNames.forEach(day => {
            const dayElement = document.createElement('div');
            dayElement.className = 'calendar-day day-name';
            dayElement.textContent = day;
            calendarGrid.appendChild(dayElement);
        });

        // Add empty cells for days before the first day of the month
        for (let i = 1; i < startingDay; i++) {
            const emptyDay = document.createElement('div');
            emptyDay.className = 'calendar-day empty';
            calendarGrid.appendChild(emptyDay);
        }

        // Add days of the month
        for (let day = 1; day <= daysInMonth; day++) {
            const dayElement = document.createElement('div');
            dayElement.className = 'calendar-day';
            dayElement.textContent = day;

            const currentDate = new Date(year, month, day);
            if (currentDate < new Date()) {
                dayElement.classList.add('disabled');
            } else {
                dayElement.addEventListener('click', () => selectDate(currentDate, dayElement));
            }

            if (calendar.selectedDate && 
                currentDate.toDateString() === calendar.selectedDate.toDateString()) {
                dayElement.classList.add('selected');
            }

            calendarGrid.appendChild(dayElement);
        }
    }

    function selectDate(date, element) {
        const selectedElements = document.querySelectorAll('.calendar-day.selected');
        selectedElements.forEach(el => el.classList.remove('selected'));
        
        calendar.selectedDate = date;
        element.classList.add('selected');
    }

    // Calendar navigation
    document.getElementById('prevMonth').addEventListener('click', () => {
        calendar.currentDate.setMonth(calendar.currentDate.getMonth() - 1);
        updateCalendar();
    });

    document.getElementById('nextMonth').addEventListener('click', () => {
        calendar.currentDate.setMonth(calendar.currentDate.getMonth() + 1);
        updateCalendar();
    });

    // Initialize calendar
    updateCalendar();

    // Schedule delivery toggle
    const scheduleToggle = document.getElementById('scheduleToggle');
    const calendarContainer = document.getElementById('calendar');

    scheduleToggle.addEventListener('change', (e) => {
        calendarContainer.style.display = e.target.checked ? 'block' : 'none';
    });

    // Quantity controls
    const quantityBtns = document.querySelectorAll('.quantity-btn');
    quantityBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            const action = e.target.dataset.action;
            const quantitySpan = e.target.parentElement.querySelector('span');
            let quantity = parseInt(quantitySpan.textContent);

            if (action === 'increase') {
                quantity++;
            } else if (action === 'decrease' && quantity > 1) {
                quantity--;
            }

            quantitySpan.textContent = quantity;
            updateTotals();
        });
    });

    // Update totals
    function updateTotals() {
        const items = document.querySelectorAll('.order-item');
        let subtotal = 0;

        items.forEach(item => {
            const price = parseFloat(item.querySelector('.item-price').textContent.replace('Rs.', ''));
            const quantity = parseInt(item.querySelector('.item-quantity span').textContent);
            subtotal += price * quantity;
        });

        const subtotalElement = document.querySelector('.subtotal span:last-child');
        const totalElement = document.querySelector('.total span:last-child');
        
        subtotalElement.textContent = `Rs.${subtotal.toFixed(2)}`;
        totalElement.textContent = `Rs.${subtotal.toFixed(2)}`;
    }

    const checkoutForm = document.getElementById('checkout-form');
    const paymentOptions = document.querySelectorAll('input[name="payment"]');

    // Payment method handling
    const cardPaymentForm = document.getElementById('cardPaymentForm');
    const upiPaymentForm = document.getElementById('upiPaymentForm');

    function handlePaymentMethodChange() {
        const selectedPayment = document.querySelector('input[name="payment"]:checked').value;

        // Hide all payment forms first
        cardPaymentForm.style.display = 'none';
        upiPaymentForm.style.display = 'none';

        // Show the selected payment form
        if (selectedPayment === 'card') {
            cardPaymentForm.style.display = 'block';
        } else if (selectedPayment === 'online') {
            upiPaymentForm.style.display = 'block';
        }
    }

    paymentOptions.forEach(option => {
        option.addEventListener('change', handlePaymentMethodChange);
    });

    // Initial call to set the correct payment form visibility
    handlePaymentMethodChange();

    // Card number formatting
    const cardNumber = document.getElementById('cardNumber');
    cardNumber.addEventListener('input', (e) => {
        let value = e.target.value.replace(/\s/g, '');
        let formattedValue = '';

        for (let i = 0; i < value.length && i < 16; i++) {
            if (i > 0 && i % 4 === 0) {
                formattedValue += ' ';
            }
            formattedValue += value[i];
        }

        e.target.value = formattedValue;
    });

    // Expiry date formatting
    const expiry = document.getElementById('expiry');
    expiry.addEventListener('input', (e) => {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length >= 2) {
            value = value.slice(0, 2) + '/' + value.slice(2);
        }
        e.target.value = value;
    });

    checkoutForm.addEventListener('submit', (e) => {
        e.preventDefault(); // Prevent form submission

        // Basic form validation
        const name = document.getElementById('name').value.trim();
        const mobile = document.getElementById('mobile').value.trim();
        const email = document.getElementById('email').value.trim();
        const address = document.getElementById('address').value.trim();
        const pin = document.getElementById('pin').value.trim();

        // Validate required fields
        if (!name || !mobile || !email || !address || !pin) {
            alert('Please fill in all required fields');
            return;
        }

        // Validate email format
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert('Please enter a valid email address');
            return;
        }

        // Validate mobile number (assuming 10 digits)
        const mobileRegex = /^\+?[\d\s-]{10,}$/;
        if (!mobileRegex.test(mobile.replace(/[\s-]/g, ''))) {
            alert('Please enter a valid mobile number');
            return;
        }

        // Validate PIN code (assuming 6 digits for Indian PIN codes)
        const pinRegex = /^\d{6}$/;
        if (!pinRegex.test(pin)) {
            alert('Please enter a valid PIN code');
            return;
        }

        // If scheduled delivery is enabled, validate date selection
        if (scheduleToggle.checked && !calendar.selectedDate) {
            alert('Please select a delivery date');
            return;
        }

        // Payment method handling
        const selectedPayment = document.querySelector('input[name="payment"]:checked').value;
        
        if (selectedPayment === 'card') {
            const cardNumber = document.getElementById('cardNumber').value.trim();
            const cvv = document.getElementById('cvv').value.trim();
            const cardName = document.getElementById('cardName').value.trim();
            const expiry = document.getElementById('expiry').value.trim();

            if (!cardNumber || !cvv || !cardName || !expiry) {
                alert('Please fill in all card details');
                return;
            }

            // Basic card validation
            if (cardNumber.replace(/\s/g, '').length !== 16) {
                alert('Please enter a valid card number');
                return;
            }

            if (cvv.length !== 3) {
                alert('Please enter a valid CVV');
                return;
            }

            if (!expiry.match(/^(0[1-9]|1[0-2])\/20[2-9]\d$/)) {
                alert('Please enter a valid expiry date (MM/YYYY)');
                return;
            }
        } else if (selectedPayment === 'online') {
            const upiId = document.getElementById('upiId').value.trim();
            
            if (!upiId) {
                alert('Please enter your UPI ID');
                return;
            }

            if (!upiId.includes('@')) {
                alert('Please enter a valid UPI ID');
                return;
            }
        }

        // If all validations pass, submit the form
        checkoutForm.submit();
    });

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

    // Enhance form interactions
    const formInputs = document.querySelectorAll('input, select, textarea');
    formInputs.forEach(input => {
        input.addEventListener('focus', () => {
            input.parentElement.classList.add('focused');
        });
        
        input.addEventListener('blur', () => {
            input.parentElement.classList.remove('focused');
            if (input.value) {
                input.parentElement.classList.add('filled');
            } else {
                input.parentElement.classList.remove('filled');
            }
        });
    });

    updateTotals();
});

console.log("Checkout.js loaded successfully!");

