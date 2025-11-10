package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import dao.CategoryDAO;
import dao.MedicineDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;
import models.Category;
import models.Medicine;

public class HomeController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO categoryDAO = new CategoryDAO();
        MedicineDAO medicineDAO = new MedicineDAO();

        List<Category> listCategory = categoryDAO.getAllCategories();
        
        System.out.println("Total categories loaded: " + listCategory.size());
        
        // 🔹 3. Đếm số lượng thuốc trong từng danh mục (gom 1 query cho hiệu năng)
        Map<String, Integer> counts = categoryDAO.countAllMedicinesByCategory();

        // Gắn số lượng vào từng đối tượng Category
        for (Category c : listCategory) {
            int total = counts.getOrDefault(c.getCategoryID(), 0);
            c.setProductCount(total);
            System.out.println(c.getCategoryName() + " → " + total + " sản phẩm");
        }
        
        request.setAttribute("listCategory", listCategory);

        List<Medicine> all = medicineDAO.getAllMedicines();
        final List<Medicine> data = (all == null) ? new ArrayList<>() : all;

        request.setAttribute("bestSellers", safeSlice(data, 0, 5));
        request.setAttribute("featuredProducts", safeSlice(data, 5, 6));
        request.setAttribute("favoriteBrandsProducts", safeSlice(data, 11, 6));
        request.setAttribute("seasonalProducts", safeSlice(data, 17, 6));
        request.setAttribute("healthCornerProducts", safeSlice(data, 23, 6));
        request.setAttribute("cardioProducts", safeSlice(data, 29, 6));
        request.setAttribute("supplementsProducts", safeSlice(data, 35, 6));
        request.setAttribute("todayFeaturedProducts", safeSlice(data, 41, 6));
        
        // 🔹 4. Dữ liệu cho "Bệnh theo mùa"
        // CAT007 – Thuốc giảm đau, hạ sốt (Sốt xuất huyết)
        // CAT008 – Thuốc hô hấp (Cúm mùa)
        // CAT003 – Thuốc da liễu (Da liễu & Dị ứng)
        List<Medicine> dengue = medicineDAO.getMedicinesByCategory("CAT007");
        List<Medicine> flu = medicineDAO.getMedicinesByCategory("CAT008");
        List<Medicine> skin = medicineDAO.getMedicinesByCategory("CAT003");

        request.setAttribute("dengueMedicines", dengue);
        request.setAttribute("fluMedicines", flu);
        request.setAttribute("skinMedicines", skin);
        

        request.getRequestDispatcher("/view/client/home.jsp").forward(request, response);
    }

    private static List<Medicine> safeSlice(List<Medicine> list, int start, int count) {
        if (list == null || list.isEmpty() || count <= 0) return new ArrayList<>();
        int s = Math.max(0, start);
        int e = Math.min(list.size(), s + count);
        if (s >= e) return new ArrayList<>();
        return new ArrayList<>(list.subList(s, e));
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

    @Override
    public String getServletInfo() {
        return "Home page controller";
    }
}
