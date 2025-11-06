package dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.math.BigDecimal;
import models.Order;
import models.CartItem;
import utils.DBContext;

public class OrderDAO extends DBContext {

    // Thêm đơn hàng và trả về ID tự sinh
    public long insertOrder(Order order) {
    String sql = "INSERT INTO Orders (UserID, OrderDate, Status, ShippingName, ShippingPhone, ShippingAddress, TotalAmount) "
               + "VALUES (?, ?, ?, ?, ?, ?, ?)";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

        ps.setInt(1, order.getUserID());
        ps.setTimestamp(2, Timestamp.valueOf(order.getOrderDate()));
        ps.setString(3, order.getStatus());
        ps.setString(4, order.getShippingName());
        ps.setString(5, order.getShippingPhone());
        ps.setString(6, order.getShippingAddress());
        ps.setBigDecimal(7, order.getTotalAmount());

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            return rs.getLong(1);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return -1;
}


    public void insertOrderItem(long orderID, CartItem item) {
    String sql = "INSERT INTO OrderItems (OrderID, MedicineID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";

    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setLong(1, orderID);
        ps.setString(2, item.getMedicineID());
        ps.setInt(3, item.getQuantity());
        ps.setBigDecimal(4, item.getPrice());
        ps.executeUpdate();

    } catch (SQLException e) {
        e.printStackTrace();
    }
}

}
