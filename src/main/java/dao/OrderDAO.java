package dao;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;
import models.Order;
import models.CartItem;
import models.OrderItem;

import utils.DBContext;

public class OrderDAO extends DBContext {

    // Thêm đơn hàng và trả về ID tự sinh
    public long insertOrder(Order order) {

        String sql = "INSERT INTO Orders (UserID, OrderDate, Status, ShippingName, ShippingPhone, ShippingAddress, TotalAmount) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserID());
            ps.setTimestamp(2, Timestamp.valueOf(order.getOrderDate()));
            ps.setString(3, order.getStatus());
            ps.setString(4, order.getShippingName());
            ps.setString(5, order.getShippingPhone());
            ps.setString(6, order.getShippingAddress());
            ps.setBigDecimal(7, order.getTotalAmount());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    long orderId = rs.getLong(1);
                    System.out.println("Order created successfully with ID: " + orderId);
                    return orderId;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error inserting order: " + e.getMessage());
            e.printStackTrace();
        }
        return -1;
    }


    public void insertOrderItem(long orderID, CartItem item) {
        String sql = "INSERT INTO OrderItems (OrderID, MedicineID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setLong(1, orderID);
            ps.setString(2, item.getMedicineID());
            ps.setInt(3, item.getQuantity());
            ps.setBigDecimal(4, item.getPrice());
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Order item inserted: OrderID=" + orderID + ", MedicineID=" + item.getMedicineID());
            }

        } catch (SQLException e) {
            System.err.println("Error inserting order item: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to insert order item", e);
        }
    }

    // Lấy tất cả đơn hàng (cho admin)
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY OrderDate DESC";
        
        System.out.println("==========================================");
        System.out.println("OrderDAO.getAllOrders: Starting query");
        System.out.println("OrderDAO.getAllOrders: SQL: " + sql);
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            System.out.println("OrderDAO.getAllOrders: Connection obtained: " + (conn != null));
            System.out.println("OrderDAO.getAllOrders: Executing query...");
            
            int rowCount = 0;
            while (rs.next()) {
                rowCount++;
                try {
                    System.out.println("OrderDAO.getAllOrders: Processing row " + rowCount);
                    System.out.println("OrderDAO.getAllOrders: OrderID from DB: " + rs.getLong("OrderID"));
                    System.out.println("OrderDAO.getAllOrders: UserID from DB: " + rs.getInt("UserID"));
                    System.out.println("OrderDAO.getAllOrders: Status from DB: " + rs.getString("Status"));
                    
                    Order order = mapResultSetToOrder(rs);
                    orders.add(order);
                    System.out.println("OrderDAO.getAllOrders: Successfully added order ID: " + order.getOrderID());
                } catch (SQLException e) {
                    System.err.println("OrderDAO.getAllOrders: Error mapping order from ResultSet: " + e.getMessage());
                    e.printStackTrace();
                } catch (Exception e) {
                    System.err.println("OrderDAO.getAllOrders: Unexpected error mapping order: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            System.out.println("OrderDAO.getAllOrders: Total rows processed: " + rowCount);
            System.out.println("OrderDAO.getAllOrders: Found " + orders.size() + " orders");
        } catch (SQLException e) {
            System.err.println("OrderDAO.getAllOrders: SQLException occurred: " + e.getMessage());
            System.err.println("OrderDAO.getAllOrders: SQL State: " + e.getSQLState());
            System.err.println("OrderDAO.getAllOrders: Error Code: " + e.getErrorCode());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("OrderDAO.getAllOrders: Unexpected error: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("OrderDAO.getAllOrders: Returning " + orders.size() + " orders");
        System.out.println("==========================================");
        return orders;
    }

    // Lấy đơn hàng theo UserID
    public List<Order> getOrdersByUserID(int userID) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE UserID = ? ORDER BY OrderDate DESC";
        
        System.out.println("==========================================");
        System.out.println("OrderDAO.getOrdersByUserID: Starting query for userID: " + userID);
        System.out.println("OrderDAO.getOrdersByUserID: SQL: " + sql);
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            System.out.println("OrderDAO.getOrdersByUserID: Connection obtained: " + (conn != null));
            System.out.println("OrderDAO.getOrdersByUserID: Setting parameter userID = " + userID);
            ps.setInt(1, userID);
            
            try (ResultSet rs = ps.executeQuery()) {
                System.out.println("OrderDAO.getOrdersByUserID: Executing query...");
                int rowCount = 0;
                while (rs.next()) {
                    rowCount++;
                    try {
                        System.out.println("OrderDAO.getOrdersByUserID: Processing row " + rowCount);
                        System.out.println("OrderDAO.getOrdersByUserID: OrderID from DB: " + rs.getLong("OrderID"));
                        System.out.println("OrderDAO.getOrdersByUserID: UserID from DB: " + rs.getInt("UserID"));
                        System.out.println("OrderDAO.getOrdersByUserID: Status from DB: " + rs.getString("Status"));
                        
                        Order order = mapResultSetToOrder(rs);
                        orders.add(order);
                        System.out.println("OrderDAO.getOrdersByUserID: Successfully added order ID: " + order.getOrderID() + " for userID: " + userID);
                    } catch (SQLException e) {
                        System.err.println("OrderDAO.getOrdersByUserID: Error mapping order from ResultSet: " + e.getMessage());
                        e.printStackTrace();
                    } catch (Exception e) {
                        System.err.println("OrderDAO.getOrdersByUserID: Unexpected error mapping order: " + e.getMessage());
                        e.printStackTrace();
                    }
                }
                System.out.println("OrderDAO.getOrdersByUserID: Total rows processed: " + rowCount);
            }
            System.out.println("OrderDAO.getOrdersByUserID: Found " + orders.size() + " orders for userID: " + userID);
        } catch (SQLException e) {
            System.err.println("OrderDAO.getOrdersByUserID: SQLException occurred: " + e.getMessage());
            System.err.println("OrderDAO.getOrdersByUserID: SQL State: " + e.getSQLState());
            System.err.println("OrderDAO.getOrdersByUserID: Error Code: " + e.getErrorCode());
            e.printStackTrace();
            // Không throw exception, trả về danh sách rỗng để tránh crash
        } catch (Exception e) {
            System.err.println("OrderDAO.getOrdersByUserID: Unexpected error: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("OrderDAO.getOrdersByUserID: Returning " + orders.size() + " orders");
        System.out.println("==========================================");
        return orders;
    }

    // Lấy chi tiết đơn hàng theo OrderID
    public Order getOrderByID(long orderID) {
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, orderID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToOrder(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    // Lấy danh sách sản phẩm trong đơn hàng
    public List<OrderItem> getOrderItems(long orderID) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.*, m.MedicineName, m.ImageUrl " +
                     "FROM OrderItems oi " +
                     "LEFT JOIN Medicine m ON oi.MedicineID = m.MedicineID " +
                     "WHERE oi.OrderID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, orderID);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setOrderID(rs.getLong("OrderID"));
                    item.setMedicineID(rs.getString("MedicineID"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setUnitPrice(rs.getBigDecimal("UnitPrice"));
                    item.setMedicineName(rs.getString("MedicineName"));
                    item.setImageUrl(rs.getString("ImageUrl"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return items;
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(long orderID, String status) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
        
        System.out.println("==========================================");
        System.out.println("OrderDAO.updateOrderStatus: Updating order status");
        System.out.println("OrderDAO.updateOrderStatus: OrderID: " + orderID);
        System.out.println("OrderDAO.updateOrderStatus: New Status: " + status);
        
        // Kiểm tra order tồn tại trước khi update
        Order existingOrder = getOrderByID(orderID);
        if (existingOrder == null) {
            System.err.println("OrderDAO.updateOrderStatus: Order not found with OrderID: " + orderID);
            System.out.println("==========================================");
            return false;
        }
        
        System.out.println("OrderDAO.updateOrderStatus: Order found - Current Status: " + existingOrder.getStatus());
        System.out.println("OrderDAO.updateOrderStatus: Updating to Status: " + status);
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            System.out.println("OrderDAO.updateOrderStatus: Connection obtained: " + (conn != null));
            System.out.println("OrderDAO.updateOrderStatus: SQL: " + sql);
            
            ps.setString(1, status);
            ps.setLong(2, orderID);
            
            System.out.println("OrderDAO.updateOrderStatus: Setting parameter 1 (Status): " + status);
            System.out.println("OrderDAO.updateOrderStatus: Setting parameter 2 (OrderID): " + orderID);
            
            int rowsAffected = ps.executeUpdate();
            System.out.println("OrderDAO.updateOrderStatus: Rows affected: " + rowsAffected);
            
            if (rowsAffected > 0) {
                System.out.println("OrderDAO.updateOrderStatus: Successfully updated order status");
                
                // Verify update
                Order updatedOrder = getOrderByID(orderID);
                if (updatedOrder != null) {
                    System.out.println("OrderDAO.updateOrderStatus: Verified - Order Status is now: " + updatedOrder.getStatus());
                }
                
                System.out.println("==========================================");
                return true;
            } else {
                System.err.println("OrderDAO.updateOrderStatus: No rows affected - update failed");
                System.out.println("==========================================");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("OrderDAO.updateOrderStatus: SQLException occurred: " + e.getMessage());
            System.err.println("OrderDAO.updateOrderStatus: SQL State: " + e.getSQLState());
            System.err.println("OrderDAO.updateOrderStatus: Error Code: " + e.getErrorCode());
            System.err.println("OrderDAO.updateOrderStatus: SQL Query: " + sql);
            e.printStackTrace();
            System.out.println("==========================================");
        } catch (Exception e) {
            System.err.println("OrderDAO.updateOrderStatus: Unexpected error: " + e.getMessage());
            e.printStackTrace();
            System.out.println("==========================================");
        }
        
        return false;
    }

    // Map ResultSet to Order
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderID(rs.getLong("OrderID"));
        order.setUserID(rs.getInt("UserID"));
        order.setOrderDate(rs.getTimestamp("OrderDate").toLocalDateTime());
        order.setStatus(rs.getString("Status"));
        order.setShippingName(rs.getString("ShippingName"));
        order.setShippingPhone(rs.getString("ShippingPhone"));
        order.setShippingAddress(rs.getString("ShippingAddress"));
        order.setTotalAmount(rs.getBigDecimal("TotalAmount"));
        return order;
    }


}
