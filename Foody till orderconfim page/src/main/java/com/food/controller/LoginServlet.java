package com.food.controller;

import java.io.IOException;

import com.food.DAO.UserDAO;
import com.food.DAOImpl.UserDAOImpl;
import com.food.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();  // Initialize the DAO to interact with the database
        System.out.println("LoginServlet initialized and UserDAO is set up.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Login attempt with email: " + email);

        // Call the DAO method to get the user by email and password
        User user = userDAO.getUserByEmailAndPassword(email, password);

        if (user == null) {
            // If the user does not exist, forward to the invaliduser.jsp
            System.out.println("User not found for email: " + email);
            request.setAttribute("errorMessage", "User does not exist!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("invaliduser.jsp");
            dispatcher.forward(request, response);
        } else if (!user.getPassword().equals(password)) {
            // If the password is incorrect, forward to the wrongpassword.jsp
            System.out.println("Incorrect password for user: " + email);
            request.setAttribute("errorMessage", "Incorrect password!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("wrongpassword.jsp");
            dispatcher.forward(request, response);
        } else {
            // If the user exists and the password is correct, store the userID in the session
            System.out.println("Login successful for user: " + email);
            HttpSession session = request.getSession();
            session.setAttribute("userID", user.getUserID()); // Store userID in session instead of full user object

            // If there was an originally requested page (before login), redirect there, otherwise go to RestaurantServlet
            String redirectTo = (String) session.getAttribute("redirectTo");
            if (redirectTo != null) {
                session.removeAttribute("redirectTo"); // Clear the redirect after using it
                response.sendRedirect(redirectTo);  // Redirect back to the original requested page
            } else {
                response.sendRedirect("RestaurantServlet"); // Redirect to the home/restaurant page if no prior redirect
            }
        }
    }

    @Override
    public void destroy() {
        // Clean up any resources when the servlet is destroyed
        userDAO = null;
        System.out.println("LoginServlet destroyed and UserDAO cleaned up.");
    }
}
