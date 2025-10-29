
package controllers;

import java.io.IOException;
import java.util.List;

import dao.CategoryDAO;
import dao.MedicineDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Category;

public class HomeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the medicines list view
      // Lấy danh sách danh mục có kèm số lượng sản phẩm
        CategoryDAO categoryDAO = new CategoryDAO();
        MedicineDAO medicineDAO = new MedicineDAO();

        List<Category> listCategory = categoryDAO.getAllCategories();

        // Gửi qua JSP
        request.setAttribute("listCategory", listCategory);
        // Debug log: print how many categories were loaded (visible in server console)
        if (listCategory == null) {
            System.out.println("HomeController: listCategory is null");
        } else {
            System.out.println("HomeController: loaded categories count = " + listCategory.size());
        }
        request.getRequestDispatcher("/view/client/home.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    // Populate categories and forward to home page (use the same processing as POST)
    processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
