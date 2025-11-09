package models;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Cart {

    private int cartId;
    private int userId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private List<CartItem> items = new ArrayList<>();

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public int getTotalQuantity() {
        return items.stream().mapToInt(CartItem::getQuantity).sum();
    }

    public BigDecimal getTotalPrice() {
        return items.stream()
                .map(i -> i.getPrice().multiply(new BigDecimal(i.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public void removeItemsByIds(String[] ids) {
        List<String> removeIds = new ArrayList<>();
        for (String id : ids) {
            removeIds.add(id);
        }

        // Xóa những sản phẩm có ID trùng với danh sách removeIds
        items.removeIf(i -> removeIds.contains(i.getMedicineID()));
    }

    // --- Thêm sản phẩm ---
    public void addItem(Medicine medicine) {
        for (CartItem item : items) {
            if (item.getMedicineID().equals(medicine.getMedicineID())) {
                // Nếu thuốc đã có trong giỏ → tăng số lượng
                item.setQuantity(item.getQuantity() + 1);
                return;
            }
        }

        // Nếu thuốc chưa có trong giỏ → thêm mới
        CartItem newItem = new CartItem(
                medicine.getMedicineID(),
                medicine.getMedicineName(),
                medicine.getImageUrl(),
                medicine.getUnit(),
                medicine.getSellingPrice(),
                1
        );

        items.add(newItem);
    }

}
