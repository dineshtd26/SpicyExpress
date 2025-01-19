<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Menu" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SpicyExpress - Menu</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/3075/3075977.png" type="image/png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles/Menu.css?v1.0">
</head>
<body>
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
                <div class="search-container">
                    <input type="text" id="searchInput" class="search-input" placeholder="Search menu items">
                    <i class="fas fa-search search-icon"></i>
                </div>
                <button class="cart-button">
                	<a href="Cart.jsp" class="cart-link">
                    	<i class="fas fa-shopping-cart"></i>
                    	<span class="cart-count">0</span>
                    </a>
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

            <h1 class="page-title animate-on-scroll">Our Delicious Menu</h1>
            
            <section class="menu-section animate-on-scroll">
                <% 
                    List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
                    String message = (String) request.getAttribute("message");

                    String[] sampleImageUrls = {
                        "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=300&q=80",
                        "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?auto=format&fit=crop&w=300&q=80",
                        "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=300&q=80",
                        "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=300&q=80",
                        "https://images.unsplash.com/photo-1565958011703-44f9829ba187?auto=format&fit=crop&w=300&q=80"
                    };

                    if (message != null) {
                %>
                    <p class="message"><%= message %></p>
                <% 
                    } else if (menuList == null || menuList.isEmpty()) {
                %>
                    <p class="message">No menu items available.</p>
                <% 
                    } else { 
                %>
                    <div class="menu-grid">
                    <% 
                        for (int i = 0; i < menuList.size(); i++) {
                            Menu menu = menuList.get(i);
                            String imageUrl = sampleImageUrls[i % sampleImageUrls.length];
                    %>
                        <div class="menu-card">
                            <div class="menu-image-wrapper">
                                <img src="<%= imageUrl %>" 
                                     alt="<%= menu.getName() %>" 
                                     class="menu-image"
                                     onerror="this.src='/placeholder.svg?height=180&width=250'">
                            </div>
                            <div class="menu-content">
                                <h3 class="menu-title"><%= menu.getName() %></h3>
                                <p class="menu-description"><%= menu.getDescription() %></p>
                                <!-- <div class="menu-details">
                                    <span><i class="fas fa-fire"></i> 60 calories</span>
                                    <span><i class="fas fa-users"></i> 4 servings</span>
                                </div> -->
                                <div class="menu-actions">
                                    <span class="price">Rs.<%= String.format("%.2f", menu.getPrice()) %></span>
                                    <form action="CartServlet" method="post">
                                    <button class="add-button" data-id="<%= menu.getMenuID() %>" aria-label="Add to cart">
                                        <i class="fas fa-plus"></i>
                                    </button>
                            		</form>
                                </div>
                            </div>
                        </div>
                    <% 
                        }
                    %>
                    </div>
                <% 
                    } 
                %>
            </section>
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

    <script src="scripts/Menu.js"></script>
</body>
</html>