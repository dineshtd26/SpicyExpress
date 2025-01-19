package com.food.DAO;

import com.food.model.User;
import java.util.List;

public interface UserDAO {
    // Method to get a user by their ID
    User getUserByID(String email);
    
    // Method to get all users
    List<User> getAllUsers();
    
    // Method to add a new user
    void addUser(User user);
    
    // Method to update an existing user
    void updateUser(User user);
    
    // Method to delete a user by their ID
    void deleteUser(int userID);

	User getUserByEmailAndPassword(String email, String password);

	User getUserByEmail(String email);

	User getUserByID(int userID);
}
