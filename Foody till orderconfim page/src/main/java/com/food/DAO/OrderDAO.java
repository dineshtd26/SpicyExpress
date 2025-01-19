package com.food.DAO;

import com.food.model.CartItem;
import com.food.model.Order;
import java.util.List;

public interface OrderDAO {
    // CRUD operations
    int createOrder(Order order);
    Order getOrderById(int orderID);
    List<Order> getAllOrders();
    void updateOrder(Order order);
    void deleteOrder(int orderID);
	void addOrderItem(int orderID, CartItem item);
}
