/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CartDAO;
import dao.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import models.Cart;
import models.CartItem;
import models.Order;
import models.User;

/**
 *
 * @author ADMIN
 */
public class PlaceOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null || cart == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String[] selectedIds = request.getParameterValues("selectedIds");

        String paymentMethod = request.getParameter("paymentMethod");

        BigDecimal total = new BigDecimal(request.getParameter("total"));
        String shippingAddress = request.getParameter("shippingAddress");

        // ✅ Lấy thông tin người nhận từ tài khoản
        String shippingName = user.getFullName();
        String shippingPhone = user.getPhoneNumber();

        // ✅ Tạo đơn hàng
        Order order = new Order(
                user.getUserID(),
                LocalDateTime.now(),
                "Pending",
                shippingName,
                shippingPhone,
                shippingAddress,
                total
        );

        long orderId = orderDAO.insertOrder(order);
        if (orderId == -1) {

            response.sendRedirect(request.getContextPath() + "/checkout?error=Lỗi khi tạo đơn hàng");

            return;
        }

        // ✅ Lưu chi tiết sản phẩm

        boolean allItemsSaved = true;
        for (CartItem item : cart.getItems()) {
            for (String id : selectedIds) {
                if (item.getMedicineID().equals(id)) {
                    try {
                        orderDAO.insertOrderItem(orderId, item);
                        cartDAO.remove(user.getUserID(), id);
                    } catch (Exception e) {
                        e.printStackTrace();
                        allItemsSaved = false;
                    }

                }
            }
        }

        if (!allItemsSaved) {
            // Nếu có lỗi khi lưu chi tiết, vẫn giữ đơn hàng nhưng cảnh báo
            System.out.println("Warning: Some order items may not have been saved for order: " + orderId);
        }

        // Xóa cart khỏi session sau khi đặt hàng thành công
        session.removeAttribute("cart");
        
        // Redirect đến trang thành công với orderId
        response.sendRedirect(request.getContextPath() + "/view/client/order-success.jsp?orderId=" + orderId + "&total=" + total);

    }
}
