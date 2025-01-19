<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Restaurant" %>

<%
    List<Restaurant> restaurantList = (List<Restaurant>) session.getAttribute("restaurantList");
    String message = (String) request.getAttribute("message");
    
    // Sample list of online image URLs
    String[] imageUrls = {
        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80",
        "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80",
        "https://images.unsplash.com/photo-1552566626-52f8b828add9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80",
        "https://images.unsplash.com/photo-1544148103-0773bf10d330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80",
        "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=300&q=80"
    };
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SpicyExpress - Discover Great Food</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/3075/3075977.png" type="image/png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles/Restaurant.css?v=1.1">
</head>
<body>
    <nav class="navbar">
        <div class="navbar-container container">
            <a href="index.html" class="logo">SpicyExpress</a>
            <div class="nav-actions">
                <div class="search-container">
                    <input type="text" id="searchInput" class="search-input" placeholder="Search for food or restaurants">
                    <i class="fas fa-search search-icon"></i>
                </div>
                <button class="cart-button">
                    <i class="fas fa-shopping-cart"></i>
                </button>
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

            <h1 class="page-title animate-on-scroll">Discover Great Food</h1>
            
            <div class="tabs animate-on-scroll">
                <button class="tab-button active" data-tab="dishes">Dishes</button>
                <button class="tab-button" data-tab="restaurants">Restaurants</button>
            </div>

            <div class="restaurant-grid animate-on-scroll">
                <% if (message != null) { %>
                    <p class="message"><%= message %></p>
                <% } else if (restaurantList == null || restaurantList.isEmpty()) { %>
                    <p class="message">No restaurants available at the moment. Check back soon!</p>
                <% } else {
                    for (int i = 0; i < restaurantList.size(); i++) {
                        Restaurant restaurant = restaurantList.get(i);
                        String imageUrl = imageUrls[i % imageUrls.length]; // Cycle through image URLs
                    %>
                    
                        <div class="restaurant-card" onclick="window.location.href='MenuServlet?restaurantId=<%= restaurant.getRestaurantID() %>'">
                            <img src="<%= imageUrl %>" 
                                 alt="<%= restaurant.getName() %>" 
                                 class="restaurant-image">
                            <div class="restaurant-content">
                                <div class="restaurant-header">
                                    <h3 class="restaurant-name"><%= restaurant.getName() %></h3>
                                    <span class="rating"><%= String.format("%.1f", restaurant.getRating()) %> <i class="fas fa-star"></i></span>
                                </div>
                                <p class="cuisine-type"><%= restaurant.getCuisineType() %></p>
                                <!-- <div class="price-time">
                                    <span class="price">₹200 for two</span>
                                    <span class="time"><i class="fas fa-clock"></i> 20 Mins</span>
                                </div> -->
                            </div>
                        </div>
                    
                    <% } %>
                <% } %>
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

    <script src="scripts/Restaurant.js"></script>
</body>
</html>
