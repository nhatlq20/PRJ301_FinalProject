package filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import models.User;

@WebFilter(filterName = "AuthenticationFilter", urlPatterns = {
    "/cart", "/order", "/product/cart", "/checkout", "/placeOrder"
})

public class AuthenticationFilter extends HttpFilter {

    public static final String AUTHENTICATED_USER_ATTRIBUTE = "authenticatedUser";

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth");
//            response.sendRedirect(request.getContextPath() + "/view/auth/login.jsp");
            return;
        }

        request.setAttribute(AUTHENTICATED_USER_ATTRIBUTE, user);
        chain.doFilter(request, response);
    }
}
