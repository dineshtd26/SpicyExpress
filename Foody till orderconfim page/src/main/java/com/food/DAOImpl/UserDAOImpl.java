package com.food.DAOImpl;

import com.food.DAO.UserDAO;
import com.food.model.User;
import com.food.DB.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {
    private Connection connection;

    // Constructor: Initializes the DB connection using DBConnection
    public UserDAOImpl() {
        this.connection = DBConnection.getConnection();  // Use DBConnection to get the connection
    }

    @Override
    public User getUserByID(int userID) {
        User user = null;
        try {
            String query = "SELECT * FROM User WHERE UserID = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User(
                        rs.getInt("UserID"),
                        rs.getString("Name"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Address"),
                        rs.getString("Phone"),
                        rs.getTimestamp("CreatedAt")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            String query = "SELECT * FROM User";
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("UserID"),
                        rs.getString("Name"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Address"),
                        rs.getString("Phone"),
                        rs.getTimestamp("CreatedAt")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public void addUser(User user) {
        String query = "INSERT INTO User (Name, Email, Password, Address, Phone) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getPhone());
            
            // Execute the update and check if the insert was successful
            int result = stmt.executeUpdate();
            if (result > 0) {
                System.out.println("User registered successfully.");
            } else {
                System.out.println("Failed to register the user.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    @Override
    public void updateUser(User user) {
        try {
            String query = "UPDATE User SET Name = ?, Email = ?, Password = ?, Address = ?, Phone = ? WHERE UserID = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getPhone());
            stmt.setInt(6, user.getUserID());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteUser(int userID) {
        try {
            String query = "DELETE FROM User WHERE UserID = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, userID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        try {
            // SQL query to get user by email and password
            String query = "SELECT * FROM User WHERE Email = ? AND Password = ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);  // Be sure to hash the password in a real scenario!
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Create a User object from the result set
                user = new User(
                        rs.getInt("UserID"),
                        rs.getString("Name"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Address"),
                        rs.getString("Phone"),
                        rs.getTimestamp("CreatedAt")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;  // Returns null if no user is found
    }

    @Override
    public User getUserByEmail(String email) {
        User user = null;
        String query = "SELECT * FROM User WHERE Email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("UserID"),
                    rs.getString("Name"),
                    rs.getString("Email"),
                    rs.getString("Password"),
                    rs.getString("Address"),
                    rs.getString("Phone"),
                    rs.getTimestamp("CreatedAt")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

	@Override
	public User getUserByID(String email) {
		// TODO Auto-generated method stub
		return null;
	}

}
