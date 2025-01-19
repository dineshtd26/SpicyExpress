package com.food.DAOImpl;

import com.food.DB.DBConnection;
import com.food.DAO.MenuDAO;
import com.food.model.Menu;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {

    private Connection connection;

    public MenuDAOImpl() {
        connection = DBConnection.getConnection();
    }

    @Override
    public int addMenu(Menu menu) {
        String query = "INSERT INTO Menu (RestaurantID, Name, Description, Price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, menu.getRestaurantID());
            statement.setString(2, menu.getName());
            statement.setString(3, menu.getDescription());
            statement.setBigDecimal(4, menu.getPrice());
            int result = statement.executeUpdate();
            if (result > 0) {
                ResultSet generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    menu.setMenuID(generatedKeys.getInt(1));
                }
            }
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int updateMenu(Menu menu) {
        String query = "UPDATE Menu SET RestaurantID = ?, Name = ?, Description = ?, Price = ? WHERE MenuID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, menu.getRestaurantID());
            statement.setString(2, menu.getName());
            statement.setString(3, menu.getDescription());
            statement.setBigDecimal(4, menu.getPrice());
            statement.setInt(5, menu.getMenuID());
            return statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int deleteMenu(int menuID) {
        String query = "DELETE FROM Menu WHERE MenuID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, menuID);
            return statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public Menu getMenu(int menuID) {
        String query = "SELECT * FROM Menu WHERE MenuID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, menuID);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Menu(
                        resultSet.getInt("MenuID"),
                        resultSet.getInt("RestaurantID"),
                        resultSet.getString("Name"),
                        resultSet.getString("Description"),
                        resultSet.getBigDecimal("Price"),
                        resultSet.getTimestamp("CreatedAt")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Menu> getAllMenusByRestaurant(int restaurantID) {
        List<Menu> menus = new ArrayList<>();
        String query = "SELECT * FROM Menu WHERE RestaurantID = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, restaurantID);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                menus.add(new Menu(
                        resultSet.getInt("MenuID"),
                        resultSet.getInt("RestaurantID"),
                        resultSet.getString("Name"),
                        resultSet.getString("Description"),
                        resultSet.getBigDecimal("Price"),
                        resultSet.getTimestamp("CreatedAt")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }
}
