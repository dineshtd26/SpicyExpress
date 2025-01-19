package com.food.controller;

import java.io.IOException;

import com.food.DAOImpl.UserDAOImpl;
import com.food.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	
	private UserDAOImpl userDAO;

	@Override
    public void init() throws ServletException {
        // Initialize the DAO
        userDAO = new UserDAOImpl();
    }
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // Log the received data (for debugging or testing purposes)
        System.out.println("Received registration request: " + name + " | " + email);

        // Optionally create a User object (but don't store it)
        User newUser = new User(0, name, email, password, address, phone, null);

        System.out.println("User details: " + newUser);
        
        try {
            // Store the user in the database
            userDAO.addUser(newUser);
            System.out.println("User registered successfully: " + newUser);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving user: " + e.getMessage());
            return;
        }

        // Redirect to a success or login page without storing the data
        response.sendRedirect("Login.jsp");
    }

    @Override
    public void destroy() {
    	userDAO = null;    
    }

}
