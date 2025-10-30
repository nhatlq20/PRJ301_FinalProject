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
import models.Category;
import models.Medicine;

public class HomeController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO categoryDAO = new CategoryDAO();
        MedicineDAO medicineDAO = new MedicineDAO();

        List<Category> listCategory = categoryDAO.getAllCategories();
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
