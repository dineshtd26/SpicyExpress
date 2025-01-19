package com.food.DAO;

import com.food.model.Menu;

import java.util.List;

public interface MenuDAO {
    // CRUD operations
    int addMenu(Menu menu);
    int updateMenu(Menu menu);
    int deleteMenu(int menuID);
    Menu getMenu(int menuID);
    List<Menu> getAllMenusByRestaurant(int restaurantID);
}
