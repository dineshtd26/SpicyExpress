package com.food.DAOImpl;

import com.food.DAO.OrderDAO;
import com.food.model.CartItem;
import com.food.model.Order;
import com.food.DB.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {
    private Connection connection;

    public OrderDAOImpl() {
        this.connection = DBConnection.getConnection();
    }
    
    @Override
    public int createOrder(Order order) {
    	int orderID = -1;
    	String sql = "INSERT INTO `Order` (userID, restaurantID, totalAmount, status, createdAt) VALUES (?, ?, ?, ?, ?)";

    	try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
    		stmt.setInt(1, order.getUserID());
    		stmt.setInt(2, order.getRestaurantID());
    		stmt.setDouble(3, order.getTotalAmount());
    		stmt.setString(4, order.getStatus());

    		// Convert the millisecond timestamp to a proper java.sql.Timestamp
    		long timestamp = System.currentTimeMillis();  // Milliseconds since epoch
    		java.sql.Timestamp createdAt = new java.sql.Timestamp(timestamp);
    		stmt.setTimestamp(5, createdAt);  // Set the timestamp value

    		int rowsAffected = stmt.executeUpdate();
    		if (rowsAffected > 0) {
    			try (ResultSet rs = stmt.getGeneratedKeys()) {
    				if (rs.next()) {
    					orderID = rs.getInt(1);  // Retrieve the generated order ID
    				}
    			}
    		}
    	} catch (SQLException e) {
    		e.printStackTrace();  // Log the exception to see what went wrong
    	}
    	return orderID;
    }



    @Override
    public Order getOrderById(int orderID) {
    	String query = "SELECT * FROM `Order` WHERE OrderID = ?";
    	try (PreparedStatement statement = connection.prepareStatement(query)) {
    		statement.setInt(1, orderID);
    		ResultSet resultSet = statement.executeQuery();
    		if (resultSet.next()) {
    			return new Order(
    					resultSet.getInt("OrderID"),
    					resultSet.getInt("UserID"),
    					resultSet.getInt("RestaurantID"),
    					resultSet.getDouble("TotalAmount"),
    					resultSet.getString("Status"),
    					resultSet.getString("CreatedAt")
    					);
    		}
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return null;
    }

    @Override
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM `Order`";
        try (Statement statement = connection.createStatement()) {
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                orders.add(new Order(
                        resultSet.getInt("OrderID"),
                        resultSet.getInt("UserID"),
                        resultSet.getInt("RestaurantID"),
                        resultSet.getDouble("TotalAmount"),
                        resultSet.getString("Status"),
                        resultSet.getString("CreatedAt")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public void updateOrder(Order order) {
        String query = "UPDATE `Order` SET UserID = ?, RestaurantID = ?, TotalAmount = ?, Status = ?, CreatedAt = ? WHERE OrderID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, order.getUserID());
            statement.setInt(2, order.getRestaurantID());
            statement.setDouble(3, order.getTotalAmount());
            statement.setString(4, order.getStatus());
            statement.setString(5, order.getCreatedAt());
            statement.setInt(6, order.getOrderID());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(int orderID) {
        String query = "DELETE FROM `Order` WHERE OrderID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public void addOrderItem(int orderID, CartItem item) {
        String query = "INSERT INTO OrderItems (OrderID, MenuID, Quantity, Price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderID);
            statement.setInt(2, item.getMenuID());
            statement.setInt(3, item.getQuantity());
            statement.setBigDecimal(4, item.getPrice());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
