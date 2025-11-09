package controllers;

import dao.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import models.Order;
import models.OrderItem;
import models.User;

public class OrderController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/auth");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // AuthenticationFilter đã kiểm tra, nhưng kiểm tra lại để an toàn
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth");
            return;
        }

        String action = request.getParameter("action");
        String roleName = (String) session.getAttribute("roleName");
        boolean isAdmin = "admin".equalsIgnoreCase(roleName);

        // Chỉ admin mới có thể quản lí đơn hàng
        if (!isAdmin) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này");
            return;
        }

        try {
            if ("detail".equals(action)) {
                // Xem chi tiết đơn hàng
                long orderID = Long.parseLong(request.getParameter("id"));
                Order order = orderDAO.getOrderByID(orderID);
                
                // Kiểm tra quyền truy cập
                if (order == null) {
                    String errorMsg = URLEncoder.encode("Đơn hàng không tồn tại", StandardCharsets.UTF_8);
                    response.sendRedirect(request.getContextPath() + "/order?error=" + errorMsg);
                    return;
                }
                
                // Admin có thể xem tất cả đơn hàng, không cần kiểm tra userID
                
                List<OrderItem> orderItems = orderDAO.getOrderItems(orderID);
                
                request.setAttribute("order", order);
                request.setAttribute("orderItems", orderItems);
                
                RequestDispatcher rd = request.getRequestDispatcher("/view/client/order-detail.jsp");
                rd.forward(request, response);
                
            } else if ("updateStatus".equals(action) && isAdmin) {
                // Cập nhật trạng thái đơn hàng (chỉ admin)
                try {
                    String idParam = request.getParameter("id");
                    String statusParam = request.getParameter("status");
                    
                    System.out.println("==========================================");
                    System.out.println("OrderController.updateStatus: Admin updating order status");
                    System.out.println("OrderController.updateStatus: id parameter: " + idParam);
                    System.out.println("OrderController.updateStatus: status parameter: " + statusParam);
                    System.out.println("OrderController.updateStatus: Admin User: " + user.getUsername());
                    
                    if (idParam == null || idParam.trim().isEmpty()) {
                        System.err.println("OrderController.updateStatus: OrderID parameter is null or empty");
                        String errorMsg = URLEncoder.encode("ID đơn hàng không hợp lệ", StandardCharsets.UTF_8);
                        response.sendRedirect(request.getContextPath() + "/order?error=" + errorMsg);
                        return;
                    }
                    
                    if (statusParam == null || statusParam.trim().isEmpty()) {
                        System.err.println("OrderController.updateStatus: Status parameter is null or empty");
                        String errorMsg = URLEncoder.encode("Trạng thái không hợp lệ", StandardCharsets.UTF_8);
                        response.sendRedirect(request.getContextPath() + "/order?error=" + errorMsg);
                        return;
                    }
                    
                    long orderID = Long.parseLong(idParam.trim());
                    String status = statusParam.trim();
                    
                    System.out.println("OrderController.updateStatus: Parsed OrderID: " + orderID);
                    System.out.println("OrderController.updateStatus: Parsed Status: " + status);
                    
                    if (orderDAO.updateOrderStatus(orderID, status)) {
                        System.out.println("OrderController.updateStatus: Successfully updated order status");
                        System.out.println("OrderController.updateStatus: Redirecting to order list");
                        System.out.println("==========================================");
                        String msg = URLEncoder.encode("Đã cập nhật trạng thái đơn hàng", StandardCharsets.UTF_8);
                        response.sendRedirect(request.getContextPath() + "/order?msg=" + msg);
                    } else {
                        System.err.println("OrderController.updateStatus: Failed to update order status");
                        System.out.println("==========================================");
                        String errorMsg = URLEncoder.encode("Lỗi khi cập nhật trạng thái. Đơn hàng có thể không tồn tại.", StandardCharsets.UTF_8);
                        response.sendRedirect(request.getContextPath() + "/order?error=" + errorMsg);
                    }
                } catch (NumberFormatException e) {
                    System.err.println("OrderController.updateStatus: NumberFormatException - Invalid OrderID format");
                    e.printStackTrace();
                    String errorMsg = URLEncoder.encode("ID đơn hàng không hợp lệ", StandardCharsets.UTF_8);
                    response.sendRedirect(request.getContextPath() + "/order?error=" + errorMsg);
                } catch (Exception e) {
                    System.err.println("OrderController.updateStatus: Unexpected error: " + e.getMessage());
                    e.printStackTrace();
                    String errorMsg = URLEncoder.encode("Lỗi hệ thống khi cập nhật trạng thái", StandardCharsets.UTF_8);
                    response.sendRedirect(request.getContextPath() + "/order?error=" + errorMsg);
                }
                
            } else {
                // Hiển thị danh sách đơn hàng (chỉ admin)
                List<Order> orders = new java.util.ArrayList<>();
                
                System.out.println("==========================================");
                System.out.println("OrderController: Getting all orders for admin");
                System.out.println("OrderController: Admin user: " + user.getUsername());
                System.out.println("OrderController: Admin userID: " + user.getUserID());
                
                try {
                    // Admin xem tất cả đơn hàng
                    orders = orderDAO.getAllOrders();
                    System.out.println("OrderController: Retrieved " + orders.size() + " orders");
                    
                    if (orders.isEmpty()) {
                        System.out.println("OrderController: No orders found in database");
                    } else {
                        System.out.println("OrderController: Orders details:");
                        for (Order order : orders) {
                            System.out.println("  - OrderID: " + order.getOrderID() + 
                                             ", UserID: " + order.getUserID() + 
                                             ", Status: " + order.getStatus() + 
                                             ", Total: " + order.getTotalAmount());
                        }
                    }
                } catch (Exception daoException) {
                    System.err.println("OrderController: Exception occurred: " + daoException.getMessage());
                    daoException.printStackTrace();
                    // Nếu có lỗi khi lấy dữ liệu, trả về danh sách rỗng thay vì redirect
                    orders = new java.util.ArrayList<>();
                    request.setAttribute("errorMessage", "Có lỗi xảy ra khi tải danh sách đơn hàng. Vui lòng thử lại sau.");
                }
                
                System.out.println("OrderController: Setting orders attribute with " + orders.size() + " orders");
                request.setAttribute("orders", orders);
                request.setAttribute("isAdmin", true);
                
                System.out.println("OrderController: Forwarding to order-list.jsp");
                System.out.println("==========================================");
                
                RequestDispatcher rd = request.getRequestDispatcher("/view/client/order-list.jsp");
                rd.forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            // Tránh vòng lặp redirect - chỉ redirect nếu không phải đang xử lý error
            if (request.getParameter("error") == null) {
                String errorMsg = URLEncoder.encode("ID đơn hàng không hợp lệ", StandardCharsets.UTF_8);
                response.sendRedirect(request.getContextPath() + "/order?error=" + errorMsg);
            } else {
                // Nếu đã có error parameter, hiển thị trang lỗi thay vì redirect
                request.setAttribute("errorMessage", "ID đơn hàng không hợp lệ");
                RequestDispatcher rd = request.getRequestDispatcher("/view/client/order-list.jsp");
                rd.forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Tránh vòng lặp redirect - chỉ redirect nếu không phải đang xử lý error
            if (request.getParameter("error") == null) {
                String errorMsg = URLEncoder.encode("Lỗi hệ thống", StandardCharsets.UTF_8);
                response.sendRedirect(request.getContextPath() + "/order?error=" + errorMsg);
            } else {
                // Nếu đã có error parameter, hiển thị trang lỗi thay vì redirect
                request.setAttribute("errorMessage", "Lỗi hệ thống. Vui lòng thử lại sau.");
                request.setAttribute("orders", new java.util.ArrayList<>());
                RequestDispatcher rd = request.getRequestDispatcher("/view/client/order-list.jsp");
                rd.forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
