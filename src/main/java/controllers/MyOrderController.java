package controllers;

import dao.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import models.Order;
import models.OrderItem;
import models.User;

public class MyOrderController extends HttpServlet {

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
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("detail".equals(action)) {
                // Xem chi tiết đơn hàng của user
                long orderID = Long.parseLong(request.getParameter("id"));
                Order order = orderDAO.getOrderByID(orderID);
                
                // Kiểm tra quyền truy cập - user chỉ xem được đơn hàng của mình
                if (order == null || order.getUserID() != user.getUserID()) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xem đơn hàng này");
                    return;
                }
                
                List<OrderItem> orderItems = orderDAO.getOrderItems(orderID);
                
                request.setAttribute("order", order);
                request.setAttribute("orderItems", orderItems);
                
                RequestDispatcher rd = request.getRequestDispatcher("/view/client/my-order-detail.jsp");
                rd.forward(request, response);
                
            } else {
                // Hiển thị danh sách đơn hàng của user
                List<Order> orders = new java.util.ArrayList<>();
                
                System.out.println("==========================================");
                System.out.println("MyOrderController: Getting orders for userID: " + user.getUserID());
                System.out.println("MyOrderController: User object: " + user);
                System.out.println("MyOrderController: User username: " + user.getUsername());
                
                try {
                    orders = orderDAO.getOrdersByUserID(user.getUserID());
                    System.out.println("MyOrderController: Retrieved " + orders.size() + " orders");
                    
                    if (orders.isEmpty()) {
                        System.out.println("MyOrderController: No orders found for userID: " + user.getUserID());
                    } else {
                        System.out.println("MyOrderController: Orders details:");
                        for (Order order : orders) {
                            System.out.println("  - OrderID: " + order.getOrderID() + 
                                             ", UserID: " + order.getUserID() + 
                                             ", Status: " + order.getStatus() + 
                                             ", Total: " + order.getTotalAmount());
                        }
                    }
                } catch (Exception e) {
                    System.err.println("MyOrderController: Exception occurred: " + e.getMessage());
                    e.printStackTrace();
                    // Không set errorMessage vì OrderDAO đã xử lý và trả về danh sách rỗng
                }
                
                System.out.println("MyOrderController: Setting orders attribute with " + orders.size() + " orders");
                request.setAttribute("orders", orders);
                
                System.out.println("MyOrderController: Forwarding to my-orders.jsp");
                System.out.println("==========================================");
                
                RequestDispatcher rd = request.getRequestDispatcher("/view/client/my-orders.jsp");
                rd.forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "ID đơn hàng không hợp lệ");
            request.setAttribute("orders", new java.util.ArrayList<>());
            RequestDispatcher rd = request.getRequestDispatcher("/view/client/my-orders.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            System.err.println("Exception in MyOrderController: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống. Vui lòng thử lại sau.");
            request.setAttribute("orders", new java.util.ArrayList<>());
            RequestDispatcher rd = request.getRequestDispatcher("/view/client/my-orders.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}

