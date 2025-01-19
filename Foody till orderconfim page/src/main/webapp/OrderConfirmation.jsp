<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.food.model.Order" %>
<%@ page import="com.food.DAO.OrderDAO" %>
<%@ page import="com.food.DAOImpl.OrderDAOImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SpicyExpress - Order Confirmation</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/3075/3075977.png" type="image/png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="styles/OrderConfirmation.css">
</head>
<body>
    <div class="page-wrapper">
        <nav class="navbar">
            <div class="navbar-container container">
                <a href="index.html" class="logo">SpicyExpress</a>
                <div class="nav-links">
                    <a href="index.html" class="nav-link">Home</a><!-- 
                    <a href="Menu.jsp" class="nav-link">Menu</a>
                    <a href="index.html#about" class="nav-link">About</a>
                    <a href="index.html#contact" class="nav-link">Contact</a> -->
                </div>
            </div>
        </nav>

        <main class="main-content">
            <div class="content-container">
                <div class="order-confirmation-wrapper animate-on-scroll">
                    <div class="orange-blob blob-1"></div>
                    <div class="orange-blob blob-2"></div>

					<div class="floating-food burger"></div>
					<div class="floating-food pizza"></div>
					<div class="floating-food taco"></div>

					<div class="order-confirmation-container">
                        <!-- <div class="bike-animation-container">
                            <img src="images/delivery-bike.png" alt="Delivery Bike" class="bike-image">
                        </div>
                        <div class="cracker-container left">
                            <div class="cracker"></div>
                            <div class="cracker"></div>
                            <div class="cracker"></div>
                        </div>
                        <div class="cracker-container right">
                            <div class="cracker"></div>
                            <div class="cracker"></div>
                            <div class="cracker"></div>
                        </div> -->
                        <div class="tick-container">
                            <svg class="tick" viewBox="0 0 50 50">
                                <circle class="circle" cx="25" cy="25" r="23"/>
                                <polyline class="check" points="15,25 23,33 35,18"/>
                            </svg>
                        </div>
                        <h2>THANK YOU !!</h2>

                        <% 
                            Integer orderID = (Integer) session.getAttribute("orderID");
                            if (orderID != null) {
                                OrderDAO orderDAO = new OrderDAOImpl();
                                Order order = orderDAO.getOrderById(orderID);

                                if (order != null) {
                        %>
                                    <p class="success">Your order has been successfully placed!</p>
                                    <div class="order-details">
                                        <p><strong>Order ID:</strong> <%= order.getOrderID() %></p><%-- 
                                        <p><strong>Restaurant ID:</strong> <%= order.getRestaurantID() %></p> --%>
                                        <p><strong>Total Amount:</strong> Rs.<%= order.getTotalAmount() %></p>
                                        <p><strong>Status:</strong> <%= order.getStatus() %></p>
                                        <p><strong>Order Date:</strong> <%= order.getCreatedAt() %></p>
                                    </div>
                                   <!--  <a href="Menu.jsp" class="btn-primary">Go back to menu</a> -->
                        <% 
                                } else {
                        %>
                                    <p class="error">There was an issue fetching your order details. Please try again later.</p>
                                    <a href="Menu.jsp" class="btn-primary">Back to Menu</a>
                        <%
                                }
                            } else {
                        %>
                            <p class="error">No order found. Please place an order first.</p>
                            <a href="Menu.jsp" class="btn-primary">Back to Menu</a>
                        <% 
                            }
                        %>
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

    <script src="scripts/OrderConfirmation.js"></script>
</body>
</html>

