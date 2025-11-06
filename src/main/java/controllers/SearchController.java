package controllers;

import dao.MedicineDAO;
import dao.CategoryDAO;
import java.io.IOException;
import java.util.List;
import models.Medicine;
import models.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SearchController", urlPatterns = {"/search"})
public class SearchController extends HttpServlet {

    private MedicineDAO medicineDAO = new MedicineDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Ensure UTF-8 encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String searchQuery = request.getParameter("q");
        
        // Get all categories for sidebar
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // Search medicines
            List<Medicine> searchResults = medicineDAO.searchMedicines(searchQuery.trim());
            request.setAttribute("searchResults", searchResults);
            request.setAttribute("searchQuery", searchQuery.trim());
            request.setAttribute("resultCount", searchResults != null ? searchResults.size() : 0);
        } else {
            // No search query, show all medicines
            List<Medicine> allMedicines = medicineDAO.getAllMedicines();
            request.setAttribute("searchResults", allMedicines);
            request.setAttribute("searchQuery", "");
            request.setAttribute("resultCount", allMedicines != null ? allMedicines.size() : 0);
        }
        
        request.getRequestDispatcher("/view/client/search-results.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

