package filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import models.User;

@WebFilter(filterName = "AdminFilter", urlPatterns = {"/product"})
public class AdminFilter extends HttpFilter {

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth");
            return;
        }

        List<String> roles = user.getRoles();
        boolean isAdmin = roles != null && roles.stream().anyMatch(role -> "admin".equalsIgnoreCase(role));

        if (!isAdmin) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        request.setAttribute(AuthenticationFilter.AUTHENTICATED_USER_ATTRIBUTE, user);
        chain.doFilter(request, response);
    }
}

