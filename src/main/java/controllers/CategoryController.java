package controllers;

import dao.MedicineDAO;
import dao.CategoryDAO;
import models.Medicine;
import models.Category;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class CategoryController extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final MedicineDAO medicineDAO = new MedicineDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy id danh mục từ URL
        String categoryID = request.getParameter("category");
        if (categoryID == null || categoryID.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Lấy thông tin danh mục và sản phẩm
        Category category = categoryDAO.getCategoryById(categoryID);
        List<Medicine> medicines = medicineDAO.getMedicinesByCategory(categoryID);

        // Đưa dữ liệu sang JSP
        request.setAttribute("category", category);
        request.setAttribute("medicines", medicines);

        // Hiển thị trang JSP
        request.getRequestDispatcher("/view/client/category-products.jsp").forward(request, response);
    }
}
