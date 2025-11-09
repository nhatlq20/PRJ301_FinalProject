package models;

import java.math.BigDecimal;

public class OrderItem {
    private long orderID;
    private String medicineID;
    private int quantity;
    private BigDecimal unitPrice;
    private String medicineName;
    private String imageUrl;

    public OrderItem() {}

    public OrderItem(long orderID, String medicineID, int quantity, BigDecimal unitPrice) {
        this.orderID = orderID;
        this.medicineID = medicineID;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    // Getters & Setters
    public long getOrderID() { return orderID; }
    public void setOrderID(long orderID) { this.orderID = orderID; }

    public String getMedicineID() { return medicineID; }
    public void setMedicineID(String medicineID) { this.medicineID = medicineID; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }

    public String getMedicineName() { return medicineName; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
}
