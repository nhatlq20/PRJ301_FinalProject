package controllers;

import dao.MedicineDAO;
import dao.CategoryDAO;
import models.Medicine;
import models.Category;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class CategoryController extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final MedicineDAO medicineDAO = new MedicineDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thiết lập encoding UTF-8 để hiển thị đúng tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Lấy id danh mục từ URL
        String categoryID = request.getParameter("category");
        if (categoryID == null || categoryID.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }


        Category category = categoryDAO.getCategoryById(categoryID);
        
       
        if (category == null) {
            System.out.println("⚠️ Category not found: " + categoryID);
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // Log để debug
        System.out.println("✅ Category found: " + category.getCategoryID() + " - " + category.getCategoryName());
        
        List<Medicine> medicines = medicineDAO.getMedicinesByCategory(categoryID);
        
        // Log số lượng sản phẩm
        System.out.println("✅ Found " + medicines.size() + " medicines in category " + categoryID);

        // Đưa dữ liệu sang JSP
        request.setAttribute("category", category);
        request.setAttribute("medicines", medicines);

        // Hiển thị trang JSP
        request.getRequestDispatcher("/view/client/category-products.jsp").forward(request, response);
    }
}
