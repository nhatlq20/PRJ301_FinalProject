package models;

import java.math.BigDecimal;

public class CartItem {
    private String medicineID;
    private String medicineName;
    private String imageUrl;
    private String unit;
    private BigDecimal price; // selling price
    private int quantity;
    
    /** Constructor mặc định */
    public CartItem() {
    }

    /** Constructor khởi tạo nhanh từ Medicine */
    public CartItem(String medicineID, String medicineName, String imageUrl, String unit, BigDecimal price, int quantity) {
        this.medicineID = medicineID;
        this.medicineName = medicineName;
        this.imageUrl = imageUrl;
        this.unit = unit;
        this.price = price;
        this.quantity = quantity;
    }

    public String getMedicineID() { return medicineID; }
    public void setMedicineID(String medicineID) { this.medicineID = medicineID; }

    public String getMedicineName() { return medicineName; }
    public void setMedicineName(String medicineName) { this.medicineName = medicineName; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    // Tính tổng tiền cho 1 item
    public BigDecimal getTotal() {
        return price.multiply(new BigDecimal(quantity));
    }
}
