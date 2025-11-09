package models;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class Order {
    private long orderID;          // bigint
    private int userID;            // int
    private LocalDateTime orderDate;
    private String status;
    private String shippingName;
    private String shippingPhone;
    private String shippingAddress;
    private BigDecimal totalAmount;

    public Order() {}

    public Order(int userID, LocalDateTime orderDate, String status,
                 String shippingName, String shippingPhone,
                 String shippingAddress, BigDecimal totalAmount) {
        this.userID = userID;
        this.orderDate = orderDate;
        this.status = status;
        this.shippingName = shippingName;
        this.shippingPhone = shippingPhone;
        this.shippingAddress = shippingAddress;
        this.totalAmount = totalAmount;
    }

    // Getters & Setters
    public long getOrderID() { return orderID; }
    public void setOrderID(long orderID) { this.orderID = orderID; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public LocalDateTime getOrderDate() { return orderDate; }
    public void setOrderDate(LocalDateTime orderDate) { this.orderDate = orderDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getShippingName() { return shippingName; }
    public void setShippingName(String shippingName) { this.shippingName = shippingName; }

    public String getShippingPhone() { return shippingPhone; }
    public void setShippingPhone(String shippingPhone) { this.shippingPhone = shippingPhone; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    
    // Helper method để format date cho JSP
    public String getFormattedOrderDate() {
        if (orderDate == null) {
            return "N/A";
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return orderDate.format(formatter);
    }

}
