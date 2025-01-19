package com.food.model;

import java.math.BigDecimal;

public class CartItem {
    private int menuID;
    private int restaurantID;
    private String name;
    private int quantity;
    private BigDecimal price;
    
    public CartItem() {
    	super();
	}

	// Constructor
    public CartItem(int menuID, int restaurantID, String name, int quantity, BigDecimal price) {
        this.menuID = menuID;
        this.restaurantID = restaurantID;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    // toString Method
    @Override
    public String toString() {
        return "Menu{" +
                "menuID=" + menuID +
                ", restaurantID=" + restaurantID +
                ", name='" + name + '\'' +
                ", quantity=" + quantity +
                ", price=" + price +
                '}';
    }
}
