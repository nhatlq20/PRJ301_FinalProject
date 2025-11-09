/*
 * Author: Phan Tuan Thanh
 * Created date: 2025-11-01
 * Purpose: Xử lý bước xác nhận thanh toán - hiển thị danh sách sản phẩm đã chọn
 */
package controllers;

import models.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import models.Cart;
import models.CartItem;
import models.User;

public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Lấy session hiện tại
        HttpSession session = request.getSession();

        // ✅ Lấy thông tin người dùng và giỏ hàng từ session
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        // ✅ Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");
            return;
        }

        // ✅ Kiểm tra giỏ hàng rỗng
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/view/client/cart.jsp");
            return;
        }

        // ✅ Lấy danh sách sản phẩm được tick
        String[] selectedIds = request.getParameterValues("selectedIds");
        if (selectedIds == null || selectedIds.length == 0) {
            response.sendRedirect(request.getContextPath() + "/view/client/cart.jsp?msg=Vui lòng chọn sản phẩm để mua");
            return;
        }

        // ✅ Lọc danh sách sản phẩm được chọn
        List<CartItem> selectedItems = new ArrayList<>();
        for (CartItem item : cart.getItems()) {
            if (item != null && item.getMedicineID() != null) {
                for (String id : selectedIds) {
                    if (item.getMedicineID().equals(id)) {
                        selectedItems.add(item);
                        break;
                    }
                }
            }
        }

        // ✅ Tính tổng tiền
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : selectedItems) {
            total = total.add(item.getTotal());
        }

        // ✅ Đưa dữ liệu sang trang thanh toán
        request.setAttribute("selectedItems", selectedItems);
        request.setAttribute("total", total);

        // ✅ Chuyển đến trang xác nhận thanh toán
        request.getRequestDispatcher("/view/client/checkout.jsp").forward(request, response);
    }
}
