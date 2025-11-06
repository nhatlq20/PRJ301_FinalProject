package controllers;

import dao.MedicineDAO;
import dao.CategoryDAO;
import java.io.IOException;
import java.util.List;
import models.Medicine;
import models.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ProductListController extends HttpServlet {

    private MedicineDAO medicineDAO = new MedicineDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryID = request.getParameter("category");
        List<Medicine> medicines;
        Category category = null;
        
        if (categoryID != null && !categoryID.isEmpty()) {
            // Get medicines by category
            medicines = medicineDAO.getMedicinesByCategory(categoryID);
            category = categoryDAO.getCategoryById(categoryID);
            
            if (category == null) {
                // Category not found, redirect to home
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
        } else {
            // No category specified, show all medicines
            medicines = medicineDAO.getAllMedicines();
        }
        
        // Get all categories for sidebar or filter
        List<Category> allCategories = categoryDAO.getAllCategories();
        
        request.setAttribute("medicines", medicines);
        request.setAttribute("currentCategory", category);
        request.setAttribute("allCategories", allCategories);
        
        request.getRequestDispatcher("/view/client/product-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    public String getServletInfo() {
        return "Product List Controller for client-side product browsing";
    }
}

