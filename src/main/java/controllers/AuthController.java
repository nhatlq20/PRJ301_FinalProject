package controllers;

import dals.UserDAO;
import models.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author qnhat
 */
@WebServlet(name = "AuthController", urlPatterns = {"/auth"})
public class AuthController extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        } else {
            request.setAttribute("errorMessage", "Hành động không hợp lệ");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            handleLogout(request, response);
            return;
        }
        if ("users".equals(action)) {
            handleGetAllUsers(request, response);
            return;
        }
        // default views
        if ("register".equals(action)) {
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usernameOrEmail = request.getParameter("usernameOrEmail");
        String password = request.getParameter("password");
        if (usernameOrEmail == null || password == null || usernameOrEmail.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
            return;
        }
        User user = getUserByUsernameOrEmail(usernameOrEmail);
        if (user == null) {
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
            return;
        }

        boolean passwordMatches = false;
        String stored = user.getPassword();
        if (stored != null) stored = stored.trim();
        try {
            passwordMatches = BCrypt.checkpw(password, stored);
        } catch (IllegalArgumentException ex) {
            // stored password is not a valid bcrypt hash (legacy plaintext). Fallback to plaintext compare
            if (stored != null && stored.equals(password)) {
                passwordMatches = true;
                // rehash with bcrypt and update DB
                String newHash = BCrypt.hashpw(password, BCrypt.gensalt());
                try {
                    userDAO.updatePassword(user.getUserID(), newHash);
                    user.setPassword(newHash);
                } catch (Exception e) {
                    // log but allow login
                    e.printStackTrace();
                }
            }
        }

        if (!passwordMatches) {
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserID());
        session.setAttribute("username", user.getUsername());
        session.setAttribute("isLoggedIn", true);
        // After successful login redirect to /medicine which is mapped to MedicineController
        response.sendRedirect(request.getContextPath() + "/medicine");
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        if (username == null || email == null || password == null || username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng điền đầy đủ thông tin bắt buộc!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }
        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }
        User existingUserByUsername = getUserByUsernameOrEmail(username);
        if (existingUserByUsername != null) {
            request.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }
        User existingUserByEmail = getUserByUsernameOrEmail(email);
        if (existingUserByEmail != null) {
            request.setAttribute("errorMessage", "Email đã được sử dụng!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
        newUser.setFullName(fullName != null ? fullName : "");
        newUser.setPhoneNumber(phoneNumber != null ? phoneNumber : "");
        newUser.setIsActive(true);
        newUser.setCreatedAt(java.time.LocalDate.now());
        newUser.setUpdatedAt(java.time.LocalDate.now());
        boolean success = userDAO.createUser(newUser);
        if (success) {
            request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Đăng ký thất bại, vui lòng thử lại!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        request.setAttribute("successMessage", "Đăng xuất thành công!");
        request.getRequestDispatcher("/view/login.jsp").forward(request, response);
    }

    private void handleGetAllUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userDAO.GetAllUser();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/view/users.jsp").forward(request, response);
    }

    private User getUserByUsernameOrEmail(String usernameOrEmail) {
        return userDAO.findByUsernameOrEmail(usernameOrEmail);
    }
}
