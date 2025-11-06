package dao;

import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import models.CartItem;

public class CartDAO {

    private final DBContext dbContext = new DBContext();

    private Integer getOrCreateCartId(int userId) throws SQLException {
        final String selectSql = "SELECT CartID FROM dbo.Carts WHERE UserID = ?";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(selectSql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        // create new cart
        final String insertSql = "INSERT INTO dbo.Carts(UserID, CreatedAt) OUTPUT INSERTED.CartID VALUES(?, SYSUTCDATETIME())";
        try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(insertSql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return null;
    }

    public void addOrIncrement(int userId, String medicineId, int quantity) {
        try {
            Integer cartId = getOrCreateCartId(userId);
            if (cartId == null) {
                return;
            }
            final String checkSql = "SELECT Quantity FROM dbo.CartItems WHERE CartID = ? AND MedicineID = ?";
            final String insertSql = "INSERT INTO dbo.CartItems(CartID, MedicineID, Quantity) VALUES(?, ?, ?)";
            final String updateSql = "UPDATE dbo.CartItems SET Quantity = Quantity + ? WHERE CartID = ? AND MedicineID = ?";
            try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(checkSql)) {
                ps.setInt(1, cartId);
                ps.setString(2, medicineId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        try (PreparedStatement up = conn.prepareStatement(updateSql)) {
                            up.setInt(1, quantity);
                            up.setInt(2, cartId);
                            up.setString(3, medicineId);
                            up.executeUpdate();
                        }
                    } else {
                        try (PreparedStatement ins = conn.prepareStatement(insertSql)) {
                            ins.setInt(1, cartId);
                            ins.setString(2, medicineId);
                            ins.setInt(3, quantity);
                            ins.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to add item to cart", e);
        }
    }

    public List<CartItem> listItems(int userId) {
        List<CartItem> items = new ArrayList<>();
        try {
            Integer cartId = getOrCreateCartId(userId);
            if (cartId == null) {
                return items;
            }
            final String sql = "SELECT ci.MedicineID, ci.Quantity, m.MedicineName, m.ImageUrl, m.SellingPrice, m.Unit "
                    + "FROM dbo.CartItems ci JOIN dbo.Medicine m ON m.MedicineID = ci.MedicineID "
                    + "WHERE ci.CartID = ? ORDER BY m.MedicineName";
            try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, cartId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        CartItem it = new CartItem();
                        it.setMedicineID(rs.getString(1));
                        it.setQuantity(rs.getInt(2));
                        it.setMedicineName(rs.getString(3));
                        it.setImageUrl(rs.getString(4));
                        it.setPrice(rs.getBigDecimal(5) != null ? rs.getBigDecimal(5) : BigDecimal.ZERO);
                        it.setUnit(rs.getString(6));
                        items.add(it);
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to list cart items", e);
        }
        return items;
    }

    public void setQuantity(int userId, String medicineId, int quantity) {
        try {
            Integer cartId = getOrCreateCartId(userId);
            if (cartId == null) {
                return;
            }
            if (quantity <= 0) {
                remove(userId, medicineId);
                return;
            }
            final String sql = "UPDATE dbo.CartItems SET Quantity = ? WHERE CartID = ? AND MedicineID = ?";
            try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, quantity);
                ps.setInt(2, cartId);
                ps.setString(3, medicineId);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to set cart quantity", e);
        }
    }

    public void remove(int userId, String medicineId) {
        try {
            Integer cartId = getOrCreateCartId(userId);
            if (cartId == null) {
                return;
            }
            final String sql = "DELETE FROM dbo.CartItems WHERE CartID = ? AND MedicineID = ?";
            try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, cartId);
                ps.setString(2, medicineId);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to remove cart item", e);
        }
    }

    public models.Cart getCart(int userId) {
        models.Cart cart = new models.Cart();
        try {
            Integer cartId = getOrCreateCartId(userId);
            if (cartId == null) {
                return cart;
            }
            cart.setCartId(cartId);
            cart.setUserId(userId);
            // read cart meta if exists
            final String metaSql = "SELECT CreatedAt, UpdatedAt FROM dbo.Carts WHERE CartID = ?";
            try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(metaSql)) {
                ps.setInt(1, cartId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        Timestamp c = rs.getTimestamp(1);
                        Timestamp u = rs.getTimestamp(2);
                        cart.setCreatedAt(c != null ? c.toLocalDateTime() : null);
                        cart.setUpdatedAt(u != null ? u.toLocalDateTime() : null);
                    }
                }
            }
            cart.setItems(listItems(userId));
        } catch (SQLException e) {
            throw new RuntimeException("Failed to get cart", e);
        }
        return cart;
    }

    // ✅ Đếm tổng số lượng sản phẩm trong giỏ (dùng cho badge ở header)
    public int countItems(int userId) {
        try {
            Integer cartId = getOrCreateCartId(userId);
            if (cartId == null) {
                return 0;
            }
            final String sql = "SELECT SUM(Quantity) AS Total FROM dbo.CartItems WHERE CartID = ?";
            try (Connection conn = dbContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, cartId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt("Total");
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to count cart items", e);
        }
        return 0;
    }

}
