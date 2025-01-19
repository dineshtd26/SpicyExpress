<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - SpicyExpress</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/3075/3075977.png" type="image/png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="styles/Login.css">
</head>
<body>
    <div class="login-page">
        <nav class="navbar">
            <div class="logo">SpicyExpress</div>
            <a href="index.html" class="home-link">Home</a>
        </nav>

        <div class="login-container animate-on-scroll">
            <div class="orange-blob blob-1"></div>
            <div class="orange-blob blob-2"></div>
            
            <div class="floating-food burger"></div>
            <div class="floating-food pizza"></div>
            <div class="floating-food taco"></div>

            <h1 class="login-heading">Welcome Back!</h1>
            <form action="LoginServlet" method="POST" class="login-form">
                <div class="form-group">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" required placeholder="Enter your email" class="form-input" />
                </div>
                <div class="form-group">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" name="password" required placeholder="Enter your password" class="form-input" />
                </div>
                <button type="submit" class="submit-button">Login</button>
            </form>
            <p class="register-text">
                Don't have an account? <a href="Register.jsp" class="register-link">Register here</a>
            </p>
        </div>
    </div>

    <script src="scripts/Login.js"></script>
</body>
</html>
