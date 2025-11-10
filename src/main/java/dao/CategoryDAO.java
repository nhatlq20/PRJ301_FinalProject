package dao;

import models.Category;
import utils.DBContext;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CategoryDAO {
    private DBContext dbContext = new DBContext();
    
//    public List<Category> getAllCategories() {
//        List<Category> categories = new ArrayList<>();
//        String sql = "SELECT CategoryID, CategoryName, CreatedAt, UpdatedAt FROM Category ORDER BY CategoryName";
//        
//        try (Connection conn = dbContext.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql);
//             ResultSet rs = ps.executeQuery()) {
//            
//            while (rs.next()) {
//                Category category = new Category();
//                category.setCategoryID(rs.getString("CategoryID"));
//                category.setCategoryName(rs.getString("CategoryName"));
//                
//                Timestamp createdAt = rs.getTimestamp("CreatedAt");
//                if (createdAt != null) {
//                    category.setCreatedAt(createdAt.toLocalDateTime());
//                }
//                
//                Timestamp updatedAt = rs.getTimestamp("UpdatedAt");
//                if (updatedAt != null) {
//                    category.setUpdatedAt(updatedAt.toLocalDateTime());
//                }
//                
//                categories.add(category);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        
//        return categories;
//    }
    
    public List<Category> getAllCategories() {
    List<Category> categories = new ArrayList<>();
    String sql = "SELECT CategoryID, CategoryName FROM Category ORDER BY CategoryName";

    try (Connection conn = dbContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {


        while (rs.next()) {
            Category category = new Category();
            category.setCategoryID(rs.getString("CategoryID"));
            category.setCategoryName(rs.getString("CategoryName"));
            categories.add(category);
        }

        System.out.println("✅ Total categories loaded: " + categories.size());
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return categories;
}

    
    public Category getCategoryById(String categoryID) {
        String sql = "SELECT CategoryID, CategoryName, CreatedAt, UpdatedAt FROM Category WHERE CategoryID = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, categoryID);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Category category = new Category();
                    category.setCategoryID(rs.getString("CategoryID"));
                    category.setCategoryName(rs.getString("CategoryName"));
                    
                    Timestamp createdAt = rs.getTimestamp("CreatedAt");
                    if (createdAt != null) {
                        category.setCreatedAt(createdAt.toLocalDateTime());
                    }
                    
                    Timestamp updatedAt = rs.getTimestamp("UpdatedAt");
                    if (updatedAt != null) {
                        category.setUpdatedAt(updatedAt.toLocalDateTime());
                    }
                    
                    return category;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public boolean createCategory(Category category) {
        String sql = "INSERT INTO Category (CategoryID, CategoryName, CreatedAt, UpdatedAt) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, category.getCategoryID());
            ps.setString(2, category.getCategoryName());
            
            LocalDateTime now = LocalDateTime.now();
            ps.setTimestamp(3, Timestamp.valueOf(now));
            ps.setTimestamp(4, Timestamp.valueOf(now));
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateCategory(Category category) {
        String sql = "UPDATE Category SET CategoryName = ?, UpdatedAt = ? WHERE CategoryID = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, category.getCategoryName());
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(3, category.getCategoryID());
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteCategory(String categoryID) {
        String sql = "DELETE FROM Category WHERE CategoryID = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, categoryID);
            
            int result = ps.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean categoryExists(String categoryID) {
        String sql = "SELECT COUNT(*) FROM Category WHERE CategoryID = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, categoryID);
            
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
    
    public List<Category> searchCategoriesByName(String searchTerm) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT CategoryID, CategoryName, CreatedAt, UpdatedAt FROM Category WHERE CategoryName LIKE ? ORDER BY CategoryName";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + searchTerm + "%");
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Category category = new Category();
                    category.setCategoryID(rs.getString("CategoryID"));
                    category.setCategoryName(rs.getString("CategoryName"));
                    
                    Timestamp createdAt = rs.getTimestamp("CreatedAt");
                    if (createdAt != null) {
                        category.setCreatedAt(createdAt.toLocalDateTime());
                    }
                    
                    Timestamp updatedAt = rs.getTimestamp("UpdatedAt");
                    if (updatedAt != null) {
                        category.setUpdatedAt(updatedAt.toLocalDateTime());
                    }
                    
                    categories.add(category);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return categories;
    }
    
    public Map<String, Integer> countAllMedicinesByCategory() {
    Map<String, Integer> map = new HashMap<>();
    String sql = "SELECT CategoryID, COUNT(*) AS total FROM Medicine GROUP BY CategoryID";
    try (Connection conn = dbContext.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            map.put(rs.getString("CategoryID"), rs.getInt("total"));
        }
    } catch (SQLException e) {
        System.out.println("Error in countAllMedicinesByCategory: " + e.getMessage());
    }
    return map;
}


}