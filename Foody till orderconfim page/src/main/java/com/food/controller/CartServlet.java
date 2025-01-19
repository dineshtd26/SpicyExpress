package com.food.controller;

import java.io.IOException;
import java.math.BigDecimal;

import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.DAO.MenuDAO;
import com.food.DAOImpl.MenuDAOImpl;
import com.food.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String menuIDStr = request.getParameter("menuID");
        if (menuIDStr == null || menuIDStr.isEmpty()) {
            session.setAttribute("error", "Menu ID is missing.");
            response.sendRedirect("Cart.jsp");
            return;
        }

        int menuID;
        try {
            menuID = Integer.parseInt(menuIDStr);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid Menu ID format.");
            response.sendRedirect("Cart.jsp");
            return;
        }

        String action = request.getParameter("action");
        MenuDAO menuDAO = new MenuDAOImpl();
        Menu menu = menuDAO.getMenu(menuID);

        if (menu == null) {
            session.setAttribute("error", "Menu item not found.");
            response.sendRedirect("Cart.jsp");
            return;
        }

        switch (action) {
            case "add":
                cart.addItem(new CartItem(menuID, menu.getRestaurantID(), menu.getName(), 1, menu.getPrice()));
                break;
            case "increase":
                cart.increaseQuantity(menuID);
                break;
            case "decrease":
                cart.decreaseQuantity(menuID);
                break;
            case "remove":
                cart.removeItem(menuID);
                break;
            case "update":
                String quantityStr = request.getParameter("quantity");
                try {
                    int quantity = Integer.parseInt(quantityStr);
                    if (quantity > 0) {
                        CartItem item = cart.getItems().get(menuID);
                        if (item != null) {
                            item.setQuantity(quantity);
                        }
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("error", "Invalid quantity format.");
                }
                break;
            case "clear":
                cart.clear();
                break;
            default:
                session.setAttribute("error", "Invalid action.");
                break;
        }

        if (cart.isEmpty()) {
            String restaurantID = String.valueOf(menu.getRestaurantID());
            response.sendRedirect("MenuServlet?restaurantId=" + restaurantID);
        } else {
            session.setAttribute("cart", cart);
            response.sendRedirect("Cart.jsp");
        }
    }
}

