package filter;

import dao.CartDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import models.User;

/**
 * Filter chỉ gắn cartCount & cartItems cho header, không ảnh hưởng đến các
 * controller khác.
 */
@WebFilter(filterName = "CartCountFilter", urlPatterns = {"/*"})
public class CartCountFilter implements Filter {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);

        // ✅ Bỏ qua nếu là AJAX (fetch hoặc XMLHttpRequest)
        String action = req.getParameter("action");
        String path = req.getRequestURI();

        if (action != null && (action.equalsIgnoreCase("update")
                || action.equalsIgnoreCase("remove")
                || action.equalsIgnoreCase("add"))) {
            chain.doFilter(request, response);
            return;
        }

        // ✅ Bỏ qua API, assets
        if (path.contains("/assets/") || path.endsWith(".js") || path.endsWith(".css")) {
            chain.doFilter(request, response);
            return;
        }

        // ✅ Nếu có user → nạp cart info
        if (session != null) {
            Object u = session.getAttribute("user");
            if (u instanceof User) {
                User user = (User) u;
                try {
                    var items = cartDAO.listItems(user.getUserID());
                    int count = (items != null) ? items.size() : 0;
                    req.setAttribute("cartCount", count);
                    req.setAttribute("cartItems", items);
                } catch (Exception e) {
                    req.setAttribute("cartCount", 0);
                    req.setAttribute("cartItems", null);
                }
            }
        }

        chain.doFilter(request, response);
    }
}
