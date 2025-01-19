package com.food.DAO;

import com.food.model.Restaurant;
import java.util.List;

public interface RestaurantDAO {
    void addRestaurant(Restaurant restaurant);
    void updateRestaurant(Restaurant restaurant);
    void deleteRestaurant(int restaurantID);
    Restaurant getRestaurantById(int restaurantID);
    List<Restaurant> getAllRestaurants();
}
