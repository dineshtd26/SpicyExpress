package com.food.model;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items;

    public Cart() {
        this.items = new HashMap<>();
    }

    // Add or update an item in the cart
    public void addItem(CartItem item) {
        if (items.containsKey(item.getMenuID())) {
            // If the item already exists, update the quantity
            CartItem existingItem = items.get(item.getMenuID());
            existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
        } else {
            // If the item does not exist, add it to the cart
            items.put(item.getMenuID(), item);
        }
    }

    // Remove an item from the cart
    public void removeItem(int menuID) {
        items.remove(menuID);
    }

    // Get the total price of the items in the cart
    public BigDecimal getTotalPrice() {
        return items.values().stream()
                .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    // Get all items in the cart
    public Map<Integer, CartItem> getItems() {
        return items;
    }

    // Clear the cart
    public void clear() {
        items.clear();
    }

    // Get the number of items in the cart
    public int getItemCount() {
        return items.size();
    }

    // Check if the cart is empty
    public boolean isEmpty() {
        return items.isEmpty();
    }
    
    public void increaseQuantity(int menuID) {
        CartItem item = items.get(menuID);
        if (item != null) {
            item.setQuantity(item.getQuantity() + 1);
        }
    }

    public void decreaseQuantity(int menuID) {
        CartItem item = items.get(menuID);
        if (item != null && item.getQuantity() > 1) {
            item.setQuantity(item.getQuantity() - 1);
        } else {
            // If quantity is 1, remove the item from the cart when decreasing
            items.remove(menuID);
        }
    }

    public int getRestaurantID() {
        if (!items.isEmpty()) {
            // Retrieve the restaurant ID from any item (assuming all items are from the same restaurant)
            return items.values().iterator().next().getRestaurantID();
        }
        return 0; // Default to 0 if the cart is empty
    }


    
    
}
