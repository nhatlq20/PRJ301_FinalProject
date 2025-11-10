package controllers;

import dao.MedicineDAO;
import dao.CategoryDAO;
import java.io.IOException;
import java.util.List;
import models.Medicine;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ProductController extends HttpServlet {

    private MedicineDAO medicineDAO = new MedicineDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        
        // --- 🔹 Người dùng xem sản phẩm theo danh mục ---
    String categoryID = request.getParameter("category");
    if (categoryID != null && !categoryID.isEmpty()) {
        List<Medicine> medicines = medicineDAO.getMedicinesByCategory(categoryID);
        models.Category category = categoryDAO.getCategoryById(categoryID);

        request.setAttribute("category", category);
        request.setAttribute("medicines", medicines);
        request.getRequestDispatcher("/view/client/category-products.jsp").forward(request, response);
        return;
    }

        // Admin guard
        jakarta.servlet.http.HttpSession session = request.getSession(false);
        String role = session != null ? (String) session.getAttribute("roleName") : null;
        if (role == null || !"admin".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Ensure UTF-8 output
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        if ("add".equalsIgnoreCase(action)) {
            request.setAttribute("pageTitle", "Thêm Sản Phẩm");
            request.setAttribute("categories", categoryDAO.getAllCategories());
            request.setAttribute("content", "/view/admin/product-add.jsp");
            request.getRequestDispatcher("/view/common/sidebar.jsp").forward(request, response);
            return;
        }

        if ("create".equalsIgnoreCase(action) && "POST".equalsIgnoreCase(request.getMethod())) {
            createMedicineFromRequest(request, response);
            return;
        }

        if ("edit".equalsIgnoreCase(action)) {
            String id = request.getParameter("id");
            Medicine med = id != null ? medicineDAO.getMedicineById(id) : null;
            if (med == null) {
                response.sendRedirect(request.getContextPath() + "/product");
                return;
            }
            request.setAttribute("medicine", med);
            request.setAttribute("categories", categoryDAO.getAllCategories());
            request.setAttribute("pageTitle", "Cập nhật sản phẩm");
            request.setAttribute("content", "/view/admin/product-edit.jsp");
            request.getRequestDispatcher("/view/common/sidebar.jsp").forward(request, response);
            return;
        }

        if ("update".equalsIgnoreCase(action) && "POST".equalsIgnoreCase(request.getMethod())) {
            updateMedicineFromRequest(request, response);
            return;
        }

        if ("delete".equals(action)) {
            String medicineID = request.getParameter("id");
            if (medicineID != null) {
                medicineDAO.deleteMedicine(medicineID);
            }
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }

        // Get all medicines for display
        List<Medicine> medicines = medicineDAO.getAllMedicines();
        request.setAttribute("medicines", medicines);

        request.setAttribute("pageTitle", "Quản lí sản phẩm");
        request.setAttribute("content", "/view/admin/product-content.jsp");
        request.getRequestDispatcher("/view/common/sidebar.jsp").forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    // Helper to create medicine from form
    private void createMedicineFromRequest(jakarta.servlet.http.HttpServletRequest request,
                                       jakarta.servlet.http.HttpServletResponse response)
        throws java.io.IOException, jakarta.servlet.ServletException {
    try {
        String medicineID = request.getParameter("medicineID");
        String medicineName = request.getParameter("medicineName");
        String sellingPriceStr = request.getParameter("sellingPrice");
        String unit = request.getParameter("unit");
        String categoryID = request.getParameter("categoryID");
        String remainingQuantityStr = request.getParameter("remainingQuantity");
        String imageUrl = request.getParameter("imageUrl");
        String shortDescription = request.getParameter("shortDescription");
        String packDescription = request.getParameter("packDescription");

        models.Medicine m = new models.Medicine();
        m.setMedicineID(medicineID);
        m.setMedicineName(medicineName);
        if (sellingPriceStr != null && !sellingPriceStr.isEmpty()) {
            m.setSellingPrice(new java.math.BigDecimal(sellingPriceStr));
        }
        m.setUnit(unit);
        m.setCategoryID(categoryID);
        int qty = 0;
        try { qty = Integer.parseInt(remainingQuantityStr); } catch (Exception ignored) {}
        m.setRemainingQuantity(qty);
        m.setImageUrl(imageUrl);
        m.setShortDescription(shortDescription);
        m.setPackDescription(packDescription);

        boolean ok = medicineDAO.createMedicine(m);
        if (ok) {
            response.sendRedirect(request.getContextPath() + "/product");
        } else {
            request.setAttribute("errorMessage", "Không thể thêm sản phẩm. Vui lòng thử lại.");
            request.setAttribute("categories", categoryDAO.getAllCategories());
            request.setAttribute("pageTitle", "Thêm Sản Phẩm");
            request.setAttribute("content", "/view/admin/product-add.jsp");
            request.getRequestDispatcher("/view/common/sidebar.jsp").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "Có lỗi xảy ra.");
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.setAttribute("pageTitle", "Thêm Sản Phẩm");
        request.setAttribute("content", "/view/admin/product-add.jsp");
        request.getRequestDispatcher("/view/common/sidebar.jsp").forward(request, response);
    }
}

// Helper to update medicine from form
private void updateMedicineFromRequest(jakarta.servlet.http.HttpServletRequest request,
                                       jakarta.servlet.http.HttpServletResponse response)
        throws java.io.IOException, jakarta.servlet.ServletException {
    try {
        String medicineID = request.getParameter("medicineID");
        String medicineName = request.getParameter("medicineName");
        String sellingPriceStr = request.getParameter("sellingPrice");
        String unit = request.getParameter("unit");
        String categoryID = request.getParameter("categoryID");
        String remainingQuantityStr = request.getParameter("remainingQuantity");
        String imageUrl = request.getParameter("imageUrl");
        String shortDescription = request.getParameter("shortDescription");
        String packDescription = request.getParameter("packDescription");

        Medicine m = new Medicine();
        m.setMedicineID(medicineID);
        m.setMedicineName(medicineName);
        if (sellingPriceStr != null && !sellingPriceStr.isEmpty()) {
            m.setSellingPrice(new java.math.BigDecimal(sellingPriceStr));
        }
        m.setUnit(unit);
        m.setCategoryID(categoryID);
        int qty = 0; try { qty = Integer.parseInt(remainingQuantityStr); } catch (Exception ignored) {}
        m.setRemainingQuantity(qty);
        m.setImageUrl(imageUrl);
        m.setShortDescription(shortDescription);
        m.setPackDescription(packDescription);

        boolean ok = medicineDAO.updateMedicine(m);
        if (ok) {
            response.sendRedirect(request.getContextPath() + "/product");
        } else {
            request.setAttribute("errorMessage", "Không thể cập nhật sản phẩm.");
            request.setAttribute("medicine", m);
            request.setAttribute("categories", categoryDAO.getAllCategories());
            request.setAttribute("pageTitle", "Cập nhật sản phẩm");
            request.setAttribute("content", "/view/admin/product-edit.jsp");
            request.getRequestDispatcher("/view/common/sidebar.jsp").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "Có lỗi xảy ra.");
        String id = request.getParameter("medicineID");
        request.setAttribute("medicine", medicineDAO.getMedicineById(id));
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.setAttribute("pageTitle", "Cập nhật sản phẩm");
        request.setAttribute("content", "/view/admin/product-edit.jsp");
        request.getRequestDispatcher("/view/common/sidebar.jsp").forward(request, response);
    }
}
}
