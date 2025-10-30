package controllers;

import dao.MedicineDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import models.Medicine;

public class ProductDetailController extends HttpServlet {

    private final MedicineDAO medicineDAO = new MedicineDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        Medicine medicine = medicineDAO.getMedicineById(id);
        if (medicine == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        request.setAttribute("medicine", medicine);
        request.getRequestDispatcher("/view/client/product-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
