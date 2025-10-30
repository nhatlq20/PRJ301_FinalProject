package controllers;

import dao.MedicineDAO;
import java.io.IOException;
import java.util.List;
import models.Medicine;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ProductController extends HttpServlet {

    private MedicineDAO medicineDAO = new MedicineDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

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

        request.getRequestDispatcher("/view/admin/product.jsp").forward(request, response);

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

}
