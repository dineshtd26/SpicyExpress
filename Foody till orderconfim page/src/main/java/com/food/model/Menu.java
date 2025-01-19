package com.food.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Menu {
    private int menuID;
    private int restaurantID;
    private String name;
    private String description;
    private BigDecimal price;
    private Timestamp createdAt;

    public Menu() {
		super();
	}

	// Constructor
    public Menu(int menuID, int restaurantID, String name, String description, BigDecimal price, Timestamp createdAt) {
        this.menuID = menuID;
        this.restaurantID = restaurantID;
        this.name = name;
        this.description = description;
        this.price = price;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getMenuID() {
        return menuID;
    }

    public void setMenuID(int menuID) {
        this.menuID = menuID;
    }

    public int getRestaurantID() {
        return restaurantID;
    }

    public void setRestaurantID(int restaurantID) {
        this.restaurantID = restaurantID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // toString method
    @Override
    public String toString() {
        return "Menu{" +
                "menuID=" + menuID +
                ", restaurantID=" + restaurantID +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", createdAt=" + createdAt +
                '}';
    }
}
