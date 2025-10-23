package controllers;

import dao.UserDAO;
import models.User;
import utils.HashUtil;
import utils.Validator;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


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
            request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
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
            request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usernameOrEmail = request.getParameter("usernameOrEmail");
        String password = request.getParameter("password");
        
        // Validate input
        Validator.ValidationResult validationResult = Validator.validateLogin(usernameOrEmail, password);
        if (!validationResult.isValid()) {
            request.setAttribute("errorMessage", validationResult.getErrorMessage());
            request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
            return;
        }
        
        User user = getUserByUsernameOrEmail(usernameOrEmail);
        if (user == null) {
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
            return;
        }

        boolean passwordMatches = false;
        String stored = user.getPassword();
        HashUtil.PasswordCheckResult result = HashUtil.checkPasswordAndRehash(password, stored);
        
        if (result.isMatches()) {
            passwordMatches = true;
            // If password was rehashed, update it in the database
            if (result.needsRehash()) {
                try {
                    userDAO.updatePassword(user.getUserID(), result.getNewHash());
                    user.setPassword(result.getNewHash());
                } catch (Exception e) {
                    // log but allow login
                    e.printStackTrace();
                }
            }
        }

        if (!passwordMatches) {
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserID());
        session.setAttribute("username", user.getUsername());
        session.setAttribute("isLoggedIn", true);
        // After successful login redirect to /home which is mapped to HomeController
        response.sendRedirect(request.getContextPath() + "/home");
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        
        // Validate input
        Validator.ValidationResult validationResult = Validator.validateRegistration(
            username, email, password, confirmPassword, fullName, phoneNumber);
        if (!validationResult.isValid()) {
            request.setAttribute("errorMessage", validationResult.getErrorMessage());
            request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
            return;
        }
        
        // Check if username already exists
        User existingUserByUsername = getUserByUsernameOrEmail(username);
        if (existingUserByUsername != null) {
            request.setAttribute("errorMessage", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        User existingUserByEmail = getUserByUsernameOrEmail(email);
        if (existingUserByEmail != null) {
            request.setAttribute("errorMessage", "Email đã được sử dụng!");
            request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
            return;
        }
        
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(HashUtil.hashPassword(password));
        newUser.setFullName(fullName != null ? fullName : "");
        newUser.setPhoneNumber(phoneNumber != null ? phoneNumber : "");
        newUser.setIsActive(true);
        newUser.setCreatedAt(java.time.LocalDate.now());
        newUser.setUpdatedAt(java.time.LocalDate.now());
        boolean success = userDAO.createUser(newUser);
        if (success) {
            request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Đăng ký thất bại, vui lòng thử lại!");
            request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        request.setAttribute("successMessage", "Đăng xuất thành công!");
        request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
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
