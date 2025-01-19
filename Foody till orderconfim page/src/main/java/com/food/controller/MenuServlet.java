package com.food.controller;

import com.food.DAO.MenuDAO;
import com.food.DAOImpl.MenuDAOImpl;
import com.food.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


public class MenuServlet extends HttpServlet {

    private MenuDAO menuDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize the DAO
        this.menuDAO = new MenuDAOImpl();
        System.out.println("MenuDAO initialized.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the restaurant ID from the request
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        System.out.println("Fetching menu for restaurant ID: " + restaurantId);
        
        // Fetch the menu list for the restaurant
        List<Menu> menuList = menuDAO.getAllMenusByRestaurant(restaurantId);

        // Check if menu list is available
        if (menuList != null && !menuList.isEmpty()) {
            request.setAttribute("menuList", menuList);
            System.out.println("Found " + menuList.size() + " menus for restaurant ID: " + restaurantId);
        } else {
            request.setAttribute("message", "No menu items available for this restaurant.");
            System.out.println("No menu items found for restaurant ID: " + restaurantId);
        }

        // Forward the request to Menu.jsp to display the menu
        request.getRequestDispatcher("Menu.jsp").forward(request, response);
    }
}
