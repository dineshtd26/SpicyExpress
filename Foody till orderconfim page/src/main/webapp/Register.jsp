<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - SpicyExpress</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/3075/3075977.png" type="image/png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/Register.css">
</head>
<body>
    <div class="register-page">
        <nav class="navbar">
            <a href="index.html" class="logo">SpicyExpress</a>
            <div class="nav-links">
                <a href="index.html" class="nav-link">Home</a>
                <!-- <a href="index.html#menu" class="nav-link">Menu</a>
                <a href="index.html#about" class="nav-link">About</a>
                <a href="index.html#contact" class="nav-link">Contact</a> -->
            </div>
        </nav>

        <div class="orange-blob blob-1"></div>
        <div class="orange-blob blob-2"></div>

        <div class="floating-food burger"></div>
        <div class="floating-food pizza"></div>
        <div class="floating-food taco"></div>

        <div class="register-container animate-on-scroll">
            <h1 class="register-heading">Join SpicyExpress</h1>
            <form action="RegisterServlet" method="POST" class="register-form">
                <div class="form-group">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" id="name" name="name" required placeholder="Enter your name" class="form-input" />
                </div>
                <div class="form-group">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" required placeholder="Enter your email" class="form-input" />
                </div>
                <div class="form-group">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" name="password" required placeholder="Enter your password" class="form-input" />
                </div>
                <div class="form-group">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" id="address" name="address" required placeholder="Enter your address" class="form-input" />
                </div>
                <div class="form-group">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="tel" id="phone" name="phone" required placeholder="Enter your phone number" class="form-input" />
                </div>
                <button type="submit" class="submit-button">Register</button>
            </form>
            <p class="login-text">
                Already have an account? <a href="Login.jsp" class="login-link">Login here</a>
            </p>
        </div>
    </div>

    <script src="scripts/Register.js"></script>
</body>
</html>
