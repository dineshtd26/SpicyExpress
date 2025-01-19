<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.food.model.Cart" %>
<%@ page import="com.food.model.CartItem" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Map" %>

<%
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
    <title>SpicyExpress - Your Shopping Cart</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/3075/3075977.png" type="image/png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles/Cart.css">
</head>
<body>
    <div class="page-container">
        <nav class="navbar">
            <div class="navbar-container container">
                <a href="index.html" class="logo">SpicyExpress</a>
                <!-- <div class="nav-links">
                    <a href="index.html" class="nav-link">Home</a>
                    <a href="index.html#menu" class="nav-link">Menu</a>
                    <a href="index.html#about" class="nav-link">About</a>
                    <a href="index.html#contact" class="nav-link">Contact</a>
                </div> -->
                <div class="nav-actions"><!-- 
                	<button class="cart-button">
                    	<i class="fas fa-shopping-bag"></i>
                	</button> -->
                    <a href="Login.jsp" class="sign-in-button">Sign In</a>
                </div>
            </div>
        </nav>

        <main class="main-content">
            <div class="container">
                <div class="orange-blob blob-1"></div>
                <div class="orange-blob blob-2"></div>
                
                <div class="floating-food burger"></div>
                <div class="floating-food pizza"></div>
                <div class="floating-food taco"></div>

                <h1 class="page-title animate-on-scroll">Your Shopping Cart</h1>
                
                <% 
                    // Retrieve cart and error messages from session/request
                    Cart cart = (Cart) session.getAttribute("cart");
                    String error = (String) request.getAttribute("error"); 
                    
                    // Retrieve restaurantID from request parameter or fallback to the first cart item
                    String restaurantID = request.getParameter("restaurantID"); 
                    if (restaurantID == null && cart != null && !cart.isEmpty()) {
                        restaurantID = String.valueOf(cart.getItems().values().iterator().next().getRestaurantID());
                    }
                %>

                <div class="cart-container animate-on-scroll">
                    <% if (error != null) { %>
                        <p class="error-message"><%= error %></p>
                    <% } %>

                    <% if (cart == null || cart.isEmpty()) { %>
                        <p class="empty-cart-message">Your cart is empty.</p>
                        <% if (restaurantID != null) { %>
                            <a href="MenuServlet?restaurantId=<%= restaurantID %>" class="back-to-menu-btn">Back to Menu</a>
                        <% } else { %>
                            <p>No restaurant selected. Please browse the menu to add items.</p>
                        <% } %>
                    <% } else { %>
                        <div class="cart-items">
                            <div class="cart-header">
                                <h2>Cart <span id="cart-count">(<%= cart.getItems().size() %> items)</span></h2>
                                <form action="CartServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="action" value="clear">
                                    <button type="submit" class="clear-cart" id="clear-cart-btn">Clear cart</button>
                                </form>
                            </div>

                            <div class="product-list" id="product-list">
                                <% for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                                    CartItem item = entry.getValue();
                                %>
                                <div class="product-item" data-menu-id="<%= item.getMenuID() %>">
                                    <div class="product-info">
                                        <img src="<%= foodImageUrls[entry.getKey() % foodImageUrls.length] %>?auto=format&fit=crop&w=80&h=80" alt="<%= item.getName() %>" class="product-image">
                                        <div>
                                            <h3><%= item.getName() %></h3>
                                            <p>Quantity: <span class="item-quantity"><%= item.getQuantity() %></span></p>
                                        </div>
                                    </div>
                                    <div class="quantity-controls">
                                        <form action="CartServlet" method="post" class="quantity-form" style="display: none;">
                                            <input type="hidden" name="menuID" value="<%= item.getMenuID() %>">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="quantity" class="quantity-input" value="<%= item.getQuantity() %>">
                                        </form>
                                        <button type="button" class="quantity-btn minus" data-id="<%= item.getMenuID() %>">&minus;</button>
                                        <span class="quantity-display"><%= item.getQuantity() %></span>
                                        <button type="button" class="quantity-btn plus" data-id="<%= item.getMenuID() %>">&plus;</button>
                                    </div>
                                    <div class="price-section">
                                        <span class="item-price">Rs.<%= item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())) %></span>
                                        <form action="CartServlet" method="post" class="remove-form" style="display: inline;">
                                            <input type="hidden" name="menuID" value="<%= item.getMenuID() %>">
                                            <input type="hidden" name="action" value="remove">
                                            <button type="submit" class="remove-btn" data-id="<%= item.getMenuID() %>">&times;</button>
                                        </form>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                        </div>

                        <div class="cart-summary">
                            <div class="promo-code">
                                <h3>Promo code</h3>
                                <div class="promo-input">
                                    <input type="text" placeholder="Enter promo code" id="promo-code-input">
                                    <button id="apply-promo-btn">Apply</button>
                                </div>
                            </div>

                            <div class="price-summary">
                                <div class="summary-row">
                                    <span>Subtotal</span>
                                    <span id="subtotal">Rs.<%= cart.getTotalPrice() %></span>
                                </div>
                                <div class="summary-row">
                                    <span>Discount</span>
                                    <span id="discount">-Rs.0.00</span>
                                </div>
                                <div class="summary-row total">
                                    <span>Total</span>
                                    <span id="total">Rs.<%= cart.getTotalPrice() %></span>
                                </div>
                            </div>

                            <% if (restaurantID != null) { %>
                                <a href="MenuServlet?restaurantId=<%= restaurantID %>" class="add-more-items-btn">Add More Items</a>
                            <% } %>
                            <a href="Checkout.jsp" class="checkout-btn" id="checkout-btn">Proceed to Checkout</a>
                        </div>
                    <% } %>
                </div>

                <div class="promo-banner animate-on-scroll">
                    <div class="banner-content">
                        <h3>Discover Our Special Offers</h3>
                        <p>Enjoy exclusive discounts on selected items</p>
                        <a href="Menu.jsp" class="shop-now-btn">Shop Now</a>
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

    <script src="scripts/Cart.js"></script>
</body>
</html>

