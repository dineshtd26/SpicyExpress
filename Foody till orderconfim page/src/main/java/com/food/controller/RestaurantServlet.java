package com.food.controller;

import com.food.DAO.RestaurantDAO;
import com.food.DAOImpl.RestaurantDAOImpl;
import com.food.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/RestaurantServlet")
public class RestaurantServlet extends HttpServlet {

    private RestaurantDAO restaurantDAO;

    @Override
    public void init() throws ServletException {
        // Initialize the DAO
        this.restaurantDAO = new RestaurantDAOImpl();
        System.out.println("RestaurantDAO initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch the list of restaurants
            List<Restaurant> restaurantList = restaurantDAO.getAllRestaurants();

            if (restaurantList != null && !restaurantList.isEmpty()) {
                request.getSession().setAttribute("restaurantList", restaurantList);
                System.out.println("Session attribute 'restaurantList' set with " + restaurantList.size() + " items.");
            } else {
                System.out.println("No restaurants found in the database.");
                request.setAttribute("message", "No restaurants available.");
            }

            // Forward the request to the JSP page
            request.getRequestDispatcher("Restaurant.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving restaurant data.");
        }
    }
}
