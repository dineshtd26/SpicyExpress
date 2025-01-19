package com.food.controller;

import com.food.DAO.OrderDAO;
import com.food.DAOImpl.OrderDAOImpl;
import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

public class CheckoutServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();

	    // Check if user is logged in
	    Integer userID = (Integer) session.getAttribute("userID");
	    if (userID == null) {
	        // Redirect to login if user is not logged in
	        session.setAttribute("error", "You must be logged in to place an order.");
	        response.sendRedirect("Login.jsp");
	        return;
	    }

	    // Retrieve cart from session
	    Cart cart = (Cart) session.getAttribute("cart");
	    if (cart == null || cart.isEmpty()) {
	        // Redirect to cart page if cart is empty
	        session.setAttribute("error", "Your cart is empty.");
	        response.sendRedirect("Cart.jsp");
	        return;
	    }

	    // Get restaurant ID and total amount
	    int restaurantID = cart.getRestaurantID(); // Update if logic is different
	    double totalAmount = cart.getTotalPrice().doubleValue();

	    // Create order object
	    Order order = new Order();
	    order.setUserID(userID);
	    order.setRestaurantID(restaurantID);
	    order.setTotalAmount(totalAmount);
	    order.setStatus("Pending");
	    order.setCreatedAt(String.valueOf(System.currentTimeMillis())); // Replace with proper date formatting

	    // Save order using DAO
	    OrderDAO orderDAO = new OrderDAOImpl();
	    int orderID = orderDAO.createOrder(order);

	    // Check if order creation was successful
	    if (orderID == -1) {
	        System.out.println("Failed to create order in database");
	        session.setAttribute("error", "Failed to place the order. Please try again.");
	        response.sendRedirect("Cart.jsp");
	        return;
	    }

	    // Save order items
	    for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
	        CartItem item = entry.getValue();
	        orderDAO.addOrderItem(orderID, item); // Ensure addOrderItem is implemented in OrderDAO
	    }

	    // Clear the cart after successful order placement
	    session.removeAttribute("cart");

	    // Store the OrderID in session for confirmation page
	    session.setAttribute("orderID", orderID);

	    // Redirect to order confirmation page
	    response.sendRedirect("OrderConfirmation.jsp");
	}

}
