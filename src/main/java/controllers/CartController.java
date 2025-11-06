package controllers;

import filter.AuthenticationFilter;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.CartDAO;
import dao.MedicineDAO;
import jakarta.servlet.http.HttpSession;
import models.Cart;
import models.Medicine;
import models.User;

public class CartController extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final MedicineDAO medicineDAO = new MedicineDAO();

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
            //addToCart(request, response);
            return;
        }
        if ("update".equalsIgnoreCase(action)) {
            String id = request.getParameter("id");
            int qty = parseQty(request.getParameter("qty"));
            if (id != null && !id.isEmpty()) {
                cartDAO.setQuantity(user.getUserID(), id, qty);
            }
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        if ("remove".equalsIgnoreCase(action)) {
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                cartDAO.remove(user.getUserID(), id);
            }
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        // Default: show cart
        Cart cart = cartDAO.getCart(user.getUserID());
        request.setAttribute("cart", cart);
        request.setAttribute("cartItems", cartDAO.listItems(user.getUserID()));

// ✅ Lưu giỏ hàng vào session để CheckoutServlet sử dụng
        HttpSession session = request.getSession();
        session.setAttribute("cart", cart);

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
        try {
            if (q != null) {
                qty = Math.max(1, Integer.parseInt(q));
            }
        } catch (NumberFormatException ignored) {
        }
        return qty;
    }

    @Override
    public String getServletInfo() {
        return "Cart controller";
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        String id = request.getParameter("id");

        // ✅ Lấy giỏ hàng hiện tại trong session
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart(); // tạo mới nếu chưa có
        }

        // ✅ Lấy thông tin sản phẩm từ DB
        Medicine med = medicineDAO.getMedicineById(id);
        if (med == null) {
            response.sendRedirect(request.getContextPath() + "/home?msg=Không tìm thấy sản phẩm");
            return;
        }

        // ✅ Thêm vào giỏ
        cart.addItem(med);

        // ✅ Lưu lại vào session
        session.setAttribute("cart", cart);

        // ✅ Quay lại trang giỏ hàng
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
