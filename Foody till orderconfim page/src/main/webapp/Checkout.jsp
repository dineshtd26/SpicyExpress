<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.food.model.Cart" %>
<%@ page import="com.food.model.CartItem" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Map" %>

<%
    // Array of food image URLs
    String[] foodImageUrls = {
        "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
        "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445",
        "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38",
        "https://images.unsplash.com/photo-1565958011703-44f9829ba187",
        "https://images.unsplash.com/photo-1482049016688-2d3e1b311543"
    };
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SpicyExpress - Checkout</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/3075/3075977.png" type="image/png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles/Checkout.css?v1.4">
</head>
<body>
    <div class="page-wrapper">
        <nav class="navbar">
            <div class="navbar-container container">
                <a href="index.html" class="logo">SpicyExpress</a>
                <!-- <div class="nav-links">
                    <a href="index.html" class="nav-link">Home</a>
                    <a href="index.html#menu" class="nav-link">Menu</a>
                    <a href="index.html#about" class="nav-link">About</a>
                    <a href="index.html#contact" class="nav-link">Contact</a>
                </div> -->
                <div class="nav-actions">
                    <a href="Cart.jsp" class="cart-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </a>
                    <a href="Login.jsp" class="sign-in-button">Sign In</a>
                </div>
            </div>
        </nav>

        <main class="main-content">
            <div class="content-container">
                <div class="checkout-wrapper">
                    <div class="orange-blob blob-1"></div>
                    <div class="orange-blob blob-2"></div>

                    <div class="floating-food burger"></div>
                    <div class="floating-food pizza"></div>
                    <div class="floating-food taco"></div>

                    <div class="checkout-container animate-on-scroll">
                        <div class="delivery-section">
                            <h2>Delivery Information</h2>
                            <form id="checkout-form" class="checkout-form" action="CheckoutServlet" method="POST">
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="name">Name</label>
                                        <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="mobile">Mobile Number</label>
                                        <input type="tel" id="mobile" name="mobile" placeholder="+1 424-236-3574" required>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input type="email" id="email" name="email" placeholder="Enter your email" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="pin">PIN</label>
                                        <input type="text" id="pin" name="pin" placeholder="Enter PIN code" required>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <textarea id="address" name="address" placeholder="Enter your full address" required></textarea>
                                </div>

                                <div class="delivery-schedule">
                                    <div class="schedule-header">
                                        <h3>Schedule Delivery</h3>
                                        <label class="switch">
                                            <input type="checkbox" id="scheduleToggle" name="scheduleDelivery">
                                            <span class="slider"></span>
                                        </label>
                                    </div>
                                    <div id="calendar" class="calendar-container">
                                        <div class="calendar-header">
                                            <button type="button" class="calendar-nav" id="prevMonth">&lt;</button>
                                            <h4 id="currentMonth">August 2023</h4>
                                            <button type="button" class="calendar-nav" id="nextMonth">&gt;</button>
                                        </div>
                                        <div class="calendar-grid">
                                            <!-- Calendar will be populated by JavaScript -->
                                        </div>
                                    </div>
                                </div>

                                <div class="payment-method">
                                    <h3>Payment Method</h3>
                                    <div class="payment-options">
                                        <div class="payment-option-wrapper">
                                            <label class="payment-option">
                                                <input type="radio" name="payment" value="card">
                                                <span class="radio-custom"></span>
                                                <span class="payment-icon card-icon"><i class="fas fa-credit-card"></i></span>
                                                <span class="label-text">Card Payment</span>
                                            </label>
                                            <!-- Card Payment Form -->
                                            <div id="cardPaymentForm" class="payment-form">
                                                <div class="form-row">
                                                    <div class="form-group">
                                                        <label for="cardNumber">Card Number</label>
                                                        <div class="card-number-input">
                                                            <span class="card-icon mastercard"></span>
                                                            <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 0000 0000 0000" maxlength="19">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="cvv">CVV</label>
                                                        <input type="password" id="cvv" name="cvv" placeholder="***" maxlength="3">
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group">
                                                        <label for="cardName">Name on card</label>
                                                        <input type="text" id="cardName" name="cardName" placeholder="Enter name on card">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="expiry">Expiry</label>
                                                        <input type="text" id="expiry" name="expiry" placeholder="MM/YYYY" maxlength="7">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="payment-option-wrapper">
                                            <label class="payment-option">
                                                <input type="radio" name="payment" value="online">
                                                <span class="radio-custom"></span>
                                                <span class="payment-icon upi-icon"><i class="fas fa-mobile-alt"></i></span>
                                                <span class="label-text">UPI Payment</span>
                                            </label>
                                            <!-- UPI Payment Form -->
                                            <div id="upiPaymentForm" class="payment-form">
                                                <div class="form-group">
                                                    <label for="upiId">UPI ID</label>
                                                    <input type="text" id="upiId" name="upiId" placeholder="username@upi">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="payment-option-wrapper">
                                            <label class="payment-option">
                                                <input type="radio" name="payment" value="cash" checked>
                                                <span class="radio-custom"></span>
                                                <span class="payment-icon cash-icon"><i class="fas fa-money-bill-wave"></i></span>
                                                <span class="label-text">Cash on Delivery</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="order-summary">
                            <h2>Order Summary</h2>
                            <div class="order-items">
                                <% 
                                    Cart cart = (Cart) session.getAttribute("cart");
                                    if (cart != null && !cart.isEmpty()) {
                                        int index = 0;
                                        for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                                            CartItem item = entry.getValue();
                                            String imageUrl = foodImageUrls[index % foodImageUrls.length];
                                            index++;
                                %>
                                <div class="order-item">
                                    <div class="item-image">
                                        <img src="<%= imageUrl %>?auto=format&fit=crop&w=80&h=80" alt="<%= item.getName() %>" class="product-image">
                                    </div>
                                    <div class="item-details">
                                        <h4 class="item-name"><%= item.getName() %></h4>
                                        <div class="item-quantity">
                                            <button type="button" class="quantity-btn" data-action="decrease">-</button>
                                            <span><%= item.getQuantity() %></span>
                                            <button type="button" class="quantity-btn" data-action="increase">+</button>
                                        </div>
                                        <div class="item-price">
                                            Rs.<%= item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())) %>
                                        </div>
                                    </div>
                                </div>
                                <% 
                                        }
                                    }
                                %>
                            </div>

                            <div class="order-totals">
                                <div class="subtotal">
                                    <span>Subtotal</span>
                                    <span>Rs.<%= cart != null ? cart.getTotalPrice() : "0.00" %></span>
                                </div>
                                <div class="shipping">
                                    <span>Shipping</span>
                                    <span>Free</span>
                                </div>
                                <div class="total">
                                    <span>Total (INR)</span>
                                    <span>Rs.<%= cart != null ? cart.getTotalPrice() : "0.00" %></span>
                                </div>
                            </div>
                            
                            <button type="submit" form="checkout-form" class="order-now-btn">
                                Order Now
                                <i class="fas fa-arrow-right"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <footer class="footer">
            <div class="container">
                <div class="footer-content">
                    <div class="footer-section">
                        <h3>About SpicyExpress</h3>
                        <p>Delivering delicious meals to your doorstep since 2023.</p>
                        <div class="social-links">
                            <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        </div>
                    </div>
                    <div class="footer-section">
                        <h3>Quick Links</h3>
                        <ul>
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Careers</a></li>
                            <li><a href="#">FAQs</a></li>
                            <li><a href="#">Contact Us</a></li>
                        </ul>
                    </div>
                    <div class="footer-section">
                        <h3>Contact</h3>
                        <p><i class="fas fa-phone"></i> +91 1234567899</p>
                        <p><i class="fas fa-envelope"></i> info@spicyexpress.com</p>
                    </div>
                    <div class="footer-section">
                        <h3>Newsletter</h3>
                        <form class="newsletter-form">
                            <input type="email" placeholder="Your email address">
                            <button type="submit">Subscribe</button>
                        </form>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p>&copy; 2023 SpicyExpress. All rights reserved.</p>
                </div>
            </div>
        </footer>
    </div>

    <script src="scripts/Checkout.js"></script>
</body>
</html>

