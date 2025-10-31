package controllers;

import filter.AuthenticationFilter;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.CartDAO;
import models.User;

public class CartController extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = requireAuthenticatedUser(request, response);
        if (user == null) {
            return;
        }
        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            handleAdd(request, response, user);
            return;
        }
        if ("update".equalsIgnoreCase(action)) {
            String id = request.getParameter("id");
            int qty = parseQty(request.getParameter("qty"));
            if (id != null && !id.isEmpty()) cartDAO.setQuantity(user.getUserID(), id, qty);
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        if ("remove".equalsIgnoreCase(action)) {
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) cartDAO.remove(user.getUserID(), id);
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        // Default: show cart
        request.setAttribute("cart", cartDAO.getCart(user.getUserID()));
        request.setAttribute("cartItems", cartDAO.listItems(user.getUserID()));
        request.getRequestDispatcher("/view/client/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
        String id = request.getParameter("id");
        int qty = parseQty(request.getParameter("qty"));
        if (id != null && !id.isEmpty()) {
            cartDAO.addOrIncrement(user.getUserID(), id, qty);
        }
        String back = request.getHeader("Referer");
        response.sendRedirect(back != null ? back : (request.getContextPath() + "/cart"));
    }

    private User requireAuthenticatedUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Object attr = request.getAttribute(AuthenticationFilter.AUTHENTICATED_USER_ATTRIBUTE);
        if (attr instanceof User) {
            return (User) attr;
        }
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
        return null;
    }

    private int parseQty(String q) {
        int qty = 1;
        try { if (q != null) qty = Math.max(1, Integer.parseInt(q)); } catch (NumberFormatException ignored) {}
        return qty;
    }

    @Override
    public String getServletInfo() { return "Cart controller"; }
}
