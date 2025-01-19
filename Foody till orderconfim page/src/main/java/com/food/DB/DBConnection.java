package com.food.DB;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static Connection connection;

    private DBConnection() { }

    public static Connection getConnection() {
        if (connection == null) {
            try {
                String url = "jdbc:mysql://localhost:3306/foodclone";
                String username = "root";
                String password = "Dinesh@0802";
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(url, username, password);
                System.out.println("Database connected successfully!");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return connection;
    }
}
