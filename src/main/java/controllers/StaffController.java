package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "StaffController", urlPatterns = {"/staff"})
public class StaffController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String role = session != null ? (String) session.getAttribute("roleName") : null;
        if (role == null || !"admin".equalsIgnoreCase(role)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        // Ensure UTF-8 output
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        request.setAttribute("pageTitle", "Quản lí nhân viên");
        request.setAttribute("content", "/view/admin/staff-content.jsp");
        request.getRequestDispatcher("/view/common/sidebar.jsp").forward(request, response);
    }
}


