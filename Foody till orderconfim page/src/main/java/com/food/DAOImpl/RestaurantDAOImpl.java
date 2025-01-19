package com.food.DAOImpl;

import com.food.DAO.RestaurantDAO;
import com.food.DB.DBConnection;
import com.food.model.Restaurant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {
    private Connection connection;

    public RestaurantDAOImpl() {
        this.connection = DBConnection.getConnection();
    }

    @Override
    public void addRestaurant(Restaurant restaurant) {
        String query = "INSERT INTO Restaurant (Name, Address, Phone, Email, CuisineType, Rating, EstimatedTime) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, restaurant.getName());
            stmt.setString(2, restaurant.getAddress());
            stmt.setString(3, restaurant.getPhone());
            stmt.setString(4, restaurant.getEmail());
            stmt.setString(5, restaurant.getCuisineType());
            stmt.setDouble(6, restaurant.getRating());
            stmt.setInt(7, restaurant.getEstimatedTime());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {
        String query = "UPDATE Restaurant SET Name = ?, Address = ?, Phone = ?, Email = ?, CuisineType = ?, Rating = ?, EstimatedTime = ? WHERE RestaurantID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, restaurant.getName());
            stmt.setString(2, restaurant.getAddress());
            stmt.setString(3, restaurant.getPhone());
            stmt.setString(4, restaurant.getEmail());
            stmt.setString(5, restaurant.getCuisineType());
            stmt.setDouble(6, restaurant.getRating());
            stmt.setInt(7, restaurant.getEstimatedTime());
            stmt.setInt(8, restaurant.getRestaurantID());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantID) {
        String query = "DELETE FROM Restaurant WHERE RestaurantID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, restaurantID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurantById(int restaurantID) {
        String query = "SELECT * FROM Restaurant WHERE RestaurantID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, restaurantID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Restaurant(
                    rs.getInt("RestaurantID"),
                    rs.getString("Name"),
                    rs.getString("Address"),
                    rs.getString("Phone"),
                    rs.getString("Email"),
                    rs.getString("CuisineType"),
                    rs.getDouble("Rating"),
                    rs.getInt("EstimatedTime")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String query = "SELECT * FROM Restaurant";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                restaurants.add(new Restaurant(
                    rs.getInt("RestaurantID"),
                    rs.getString("Name"),
                    rs.getString("Address"),
                    rs.getString("Phone"),
                    rs.getString("Email"),
                    rs.getString("CuisineType"),
                    rs.getDouble("Rating"),
                    rs.getInt("EstimatedTime")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }
}
