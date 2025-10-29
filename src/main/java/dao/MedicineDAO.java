package dao;

import models.Medicine;
import models.Category;
import utils.DBContext;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class MedicineDAO {
    private DBContext dbContext = new DBContext();
    
    public List<Medicine> getAllMedicines() {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT m.*, c.CategoryName FROM Medicine m " +
                    "LEFT JOIN Category c ON m.CategoryID = c.CategoryID " +
                    "ORDER BY m.MedicineName";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Medicine medicine = mapResultSetToMedicine(rs);
                medicines.add(medicine);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return medicines;
    }
    
    public Medicine getMedicineById(String medicineID) {
        String sql = "SELECT m.*, c.CategoryName FROM Medicine m " +
                    "LEFT JOIN Category c ON m.CategoryID = c.CategoryID " +
                    "WHERE m.MedicineID = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, medicineID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToMedicine(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public List<Medicine> getMedicinesByCategory(String categoryID) {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT m.*, c.CategoryName FROM Medicine m " +
                    "LEFT JOIN Category c ON m.CategoryID = c.CategoryID " +
                    "WHERE m.CategoryID = ? ORDER BY m.MedicineName";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, categoryID);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Medicine medicine = mapResultSetToMedicine(rs);
                    medicines.add(medicine);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return medicines;
    }
    
    public List<Medicine> searchMedicines(String searchTerm) {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT m.*, c.CategoryName FROM Medicine m " +
                    "LEFT JOIN Category c ON m.CategoryID = c.CategoryID " +
                    "WHERE m.MedicineName LIKE ? OR m.ShortDescription LIKE ? OR m.Manufacturer LIKE ? " +
                    "ORDER BY m.MedicineName";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Medicine medicine = mapResultSetToMedicine(rs);
                    medicines.add(medicine);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return medicines;
    }
    
    public List<Medicine> getMedicinesInStock() {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT m.*, c.CategoryName FROM Medicine m " +
                    "LEFT JOIN Category c ON m.CategoryID = c.CategoryID " +
                    "WHERE m.RemainingQuantity > 0 ORDER BY m.MedicineName";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Medicine medicine = mapResultSetToMedicine(rs);
                medicines.add(medicine);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return medicines;
    }
    
    public List<Medicine> getExpiringMedicines(int daysAhead) {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT m.*, c.CategoryName FROM Medicine m " +
                    "LEFT JOIN Category c ON m.CategoryID = c.CategoryID " +
                    "WHERE m.ExpirationDate IS NOT NULL AND m.ExpirationDate <= DATEADD(day, ?, GETDATE()) " +
                    "ORDER BY m.ExpirationDate";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, daysAhead);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Medicine medicine = mapResultSetToMedicine(rs);
                    medicines.add(medicine);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return medicines;
    }
    
    public boolean createMedicine(Medicine medicine) {
        String sql = "INSERT INTO Medicine (MedicineID, MedicineName, SellingPrice, Unit, PackDescription, " +
                    "ManufactureDate, ExpirationDate, RemainingQuantity, CategoryID, RegistrationNumber, " +
                    "DosageForm, Contraindications, Ingredients, Indications, Directions, SideEffects, " +
                    "Precautions, Storage, Manufacturer, CountryOfOrigin, BrandOrigin, PrescriptionRequired, " +
                    "ImageUrl, ShortDescription, CreatedAt, UpdatedAt) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            int index = 1;
            ps.setString(index++, medicine.getMedicineID());
            ps.setString(index++, medicine.getMedicineName());
            ps.setBigDecimal(index++, medicine.getSellingPrice());
            ps.setString(index++, medicine.getUnit());
            ps.setString(index++, medicine.getPackDescription());
            
            if (medicine.getManufactureDate() != null) {
                ps.setDate(index++, Date.valueOf(medicine.getManufactureDate()));
            } else {
                ps.setNull(index++, Types.DATE);
            }
            
            if (medicine.getExpirationDate() != null) {
                ps.setDate(index++, Date.valueOf(medicine.getExpirationDate()));
            } else {
                ps.setNull(index++, Types.DATE);
            }
            
            ps.setInt(index++, medicine.getRemainingQuantity());
            ps.setString(index++, medicine.getCategoryID());
            ps.setString(index++, medicine.getRegistrationNumber());
            ps.setString(index++, medicine.getDosageForm());
            ps.setString(index++, medicine.getContraindications());
            ps.setString(index++, medicine.getIngredients());
            ps.setString(index++, medicine.getIndications());
            ps.setString(index++, medicine.getDirections());
            ps.setString(index++, medicine.getSideEffects());
            ps.setString(index++, medicine.getPrecautions());
            ps.setString(index++, medicine.getStorage());
            ps.setString(index++, medicine.getManufacturer());
            ps.setString(index++, medicine.getCountryOfOrigin());
            ps.setString(index++, medicine.getBrandOrigin());
            ps.setBoolean(index++, medicine.isPrescriptionRequired());
            ps.setString(index++, medicine.getImageUrl());
            ps.setString(index++, medicine.getShortDescription());
            
            LocalDateTime now = LocalDateTime.now();
            ps.setTimestamp(index++, Timestamp.valueOf(now));
            ps.setTimestamp(index++, Timestamp.valueOf(now));
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateMedicine(Medicine medicine) {
        String sql = "UPDATE Medicine SET MedicineName = ?, SellingPrice = ?, Unit = ?, PackDescription = ?, " +
                    "ManufactureDate = ?, ExpirationDate = ?, RemainingQuantity = ?, CategoryID = ?, " +
                    "RegistrationNumber = ?, DosageForm = ?, Contraindications = ?, Ingredients = ?, " +
                    "Indications = ?, Directions = ?, SideEffects = ?, Precautions = ?, Storage = ?, " +
                    "Manufacturer = ?, CountryOfOrigin = ?, BrandOrigin = ?, PrescriptionRequired = ?, " +
                    "ImageUrl = ?, ShortDescription = ?, UpdatedAt = ? WHERE MedicineID = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            int index = 1;
            ps.setString(index++, medicine.getMedicineName());
            ps.setBigDecimal(index++, medicine.getSellingPrice());
            ps.setString(index++, medicine.getUnit());
            ps.setString(index++, medicine.getPackDescription());
            
            if (medicine.getManufactureDate() != null) {
                ps.setDate(index++, Date.valueOf(medicine.getManufactureDate()));
            } else {
                ps.setNull(index++, Types.DATE);
            }
            
            if (medicine.getExpirationDate() != null) {
                ps.setDate(index++, Date.valueOf(medicine.getExpirationDate()));
            } else {
                ps.setNull(index++, Types.DATE);
            }
            
            ps.setInt(index++, medicine.getRemainingQuantity());
            ps.setString(index++, medicine.getCategoryID());
            ps.setString(index++, medicine.getRegistrationNumber());
            ps.setString(index++, medicine.getDosageForm());
            ps.setString(index++, medicine.getContraindications());
            ps.setString(index++, medicine.getIngredients());
            ps.setString(index++, medicine.getIndications());
            ps.setString(index++, medicine.getDirections());
            ps.setString(index++, medicine.getSideEffects());
            ps.setString(index++, medicine.getPrecautions());
            ps.setString(index++, medicine.getStorage());
            ps.setString(index++, medicine.getManufacturer());
            ps.setString(index++, medicine.getCountryOfOrigin());
            ps.setString(index++, medicine.getBrandOrigin());
            ps.setBoolean(index++, medicine.isPrescriptionRequired());
            ps.setString(index++, medicine.getImageUrl());
            ps.setString(index++, medicine.getShortDescription());
            ps.setTimestamp(index++, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(index++, medicine.getMedicineID());
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteMedicine(String medicineID) {
        String sql = "DELETE FROM Medicine WHERE MedicineID = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, medicineID);
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateQuantity(String medicineID, int newQuantity) {
        String sql = "UPDATE Medicine SET RemainingQuantity = ?, UpdatedAt = ? WHERE MedicineID = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, newQuantity);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(3, medicineID);
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean medicineExists(String medicineID) {
        String sql = "SELECT COUNT(*) FROM Medicine WHERE MedicineID = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, medicineID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    private Medicine mapResultSetToMedicine(ResultSet rs) throws SQLException {
        Medicine medicine = new Medicine();
        
        medicine.setMedicineID(rs.getString("MedicineID"));
        medicine.setMedicineName(rs.getString("MedicineName"));
        medicine.setSellingPrice(rs.getBigDecimal("SellingPrice"));
        medicine.setUnit(rs.getString("Unit"));
        medicine.setPackDescription(rs.getString("PackDescription"));
        
        Date manufactureDate = rs.getDate("ManufactureDate");
        if (manufactureDate != null) {
            medicine.setManufactureDate(manufactureDate.toLocalDate());
        }
        
        Date expirationDate = rs.getDate("ExpirationDate");
        if (expirationDate != null) {
            medicine.setExpirationDate(expirationDate.toLocalDate());
        }
        
        medicine.setRemainingQuantity(rs.getInt("RemainingQuantity"));
        medicine.setCategoryID(rs.getString("CategoryID"));
        
        // Set category object if CategoryName is available
        String categoryName = rs.getString("CategoryName");
        if (categoryName != null) {
            Category category = new Category();
            category.setCategoryID(rs.getString("CategoryID"));
            category.setCategoryName(categoryName);
            medicine.setCategory(category);
        }
        
        medicine.setRegistrationNumber(rs.getString("RegistrationNumber"));
        medicine.setDosageForm(rs.getString("DosageForm"));
        medicine.setContraindications(rs.getString("Contraindications"));
        medicine.setIngredients(rs.getString("Ingredients"));
        medicine.setIndications(rs.getString("Indications"));
        medicine.setDirections(rs.getString("Directions"));
        medicine.setSideEffects(rs.getString("SideEffects"));
        medicine.setPrecautions(rs.getString("Precautions"));
        medicine.setStorage(rs.getString("Storage"));
        medicine.setManufacturer(rs.getString("Manufacturer"));
        medicine.setCountryOfOrigin(rs.getString("CountryOfOrigin"));
        medicine.setBrandOrigin(rs.getString("BrandOrigin"));
        medicine.setPrescriptionRequired(rs.getBoolean("PrescriptionRequired"));
        medicine.setImageUrl(rs.getString("ImageUrl"));
        medicine.setShortDescription(rs.getString("ShortDescription"));
        
        Timestamp createdAt = rs.getTimestamp("CreatedAt");
        if (createdAt != null) {
            medicine.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        Timestamp updatedAt = rs.getTimestamp("UpdatedAt");
        if (updatedAt != null) {
            medicine.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        
        return medicine;
    }
}
