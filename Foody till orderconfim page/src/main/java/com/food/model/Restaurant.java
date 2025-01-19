package com.food.model;

public class Restaurant {
    private int restaurantID;
    private String name;
    private String address;
    private String phone;
    private String email;
    private String cuisineType;
    private double rating;
    private int estimatedTime;

    // Constructor
    public Restaurant(int restaurantID, String name, String address, String phone, String email, String cuisineType, double rating, int estimatedTime) {
        this.restaurantID = restaurantID;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.cuisineType = cuisineType;
        this.rating = rating;
        this.estimatedTime = estimatedTime;
    }

    // Getters and Setters
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCuisineType() {
        return cuisineType;
    }

    public void setCuisineType(String cuisineType) {
        this.cuisineType = cuisineType;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public int getEstimatedTime() {
        return estimatedTime;
    }

    public void setEstimatedTime(int estimatedTime) {
        this.estimatedTime = estimatedTime;
    }

    // toString Method
    @Override
    public String toString() {
        return "Restaurant [restaurantID=" + restaurantID + ", name=" + name + ", address=" + address 
                + ", phone=" + phone + ", email=" + email + ", cuisineType=" + cuisineType 
                + ", rating=" + rating + ", estimatedTime=" + estimatedTime + "]";
    }
}
