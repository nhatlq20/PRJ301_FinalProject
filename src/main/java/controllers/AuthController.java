package controllers;

import dao.UserDAO;
import models.User;
import utils.HashUtil;
import utils.Validator;
import utils.EmailService;
import utils.OtpService;
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
    private EmailService emailService = new EmailService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        } else if ("forgot-password".equals(action)) {
            handleForgotPassword(request, response);
        } else if ("verify-otp".equals(action)) {
            handleVerifyOtp(request, response);
        } else if ("reset-password".equals(action)) {
            handleResetPassword(request, response);
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
        if ("forgot-password".equals(action)) {
            request.getRequestDispatcher("/view/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        if ("verify-otp".equals(action)) {
            request.getRequestDispatcher("/view/auth/verify-otp.jsp").forward(request, response);
            return;
        }
        if ("reset-password".equals(action)) {
            request.getRequestDispatcher("/view/auth/reset-password.jsp").forward(request, response);
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

    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập email!");
            request.getRequestDispatcher("/view/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Check if email exists in database
        User user = userDAO.findByUsernameOrEmail(email);
        if (user == null) {
            request.setAttribute("errorMessage", "Email không tồn tại trong hệ thống!");
            request.getRequestDispatcher("/view/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Generate OTP
        String otp = OtpService.generateOtp(email);
        
        // Send OTP email
        boolean emailSent = emailService.sendOtpEmail(email, otp);
        
        if (emailSent) {
            HttpSession session = request.getSession();
            session.setAttribute("resetEmail", email);
            request.setAttribute("successMessage", "Mã OTP đã được gửi đến email của bạn!");
            request.getRequestDispatcher("/view/auth/verify-otp.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Không thể gửi email. Vui lòng thử lại sau!");
            request.getRequestDispatcher("/view/auth/forgot-password.jsp").forward(request, response);
        }
    }

    private void handleVerifyOtp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String otp = request.getParameter("otp");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");
        
        if (email == null) {
            request.setAttribute("errorMessage", "Phiên làm việc đã hết hạn. Vui lòng thử lại!");
            request.getRequestDispatcher("/view/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Validate OTP
        if (otp == null || otp.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập mã OTP!");
            request.getRequestDispatcher("/view/auth/verify-otp.jsp").forward(request, response);
            return;
        }
        
        boolean isValidOtp = OtpService.verifyOtp(email, otp);
        
        if (isValidOtp) {
            session.setAttribute("otpVerified", true);
            request.setAttribute("successMessage", "Xác thực OTP thành công! Vui lòng đặt mật khẩu mới.");
            request.getRequestDispatcher("/view/auth/reset-password.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Mã OTP không đúng hoặc đã hết hạn!");
            request.getRequestDispatcher("/view/auth/verify-otp.jsp").forward(request, response);
        }
    }

    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");
        Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");
        
        if (email == null || otpVerified == null || !otpVerified) {
            request.setAttribute("errorMessage", "Phiên làm việc không hợp lệ. Vui lòng thử lại!");
            request.getRequestDispatcher("/view/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Validate passwords
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập mật khẩu mới!");
            request.getRequestDispatcher("/view/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng xác nhận mật khẩu!");
            request.getRequestDispatcher("/view/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/view/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        // Validate password strength
        Validator.ValidationResult validationResult = Validator.validatePassword(newPassword);
        if (!validationResult.isValid()) {
            request.setAttribute("errorMessage", validationResult.getErrorMessage());
            request.getRequestDispatcher("/view/auth/reset-password.jsp").forward(request, response);
            return;
        }
        
        // Get user and update password
        User user = userDAO.findByUsernameOrEmail(email);
        if (user == null) {
            request.setAttribute("errorMessage", "Người dùng không tồn tại!");
            request.getRequestDispatcher("/view/auth/forgot-password.jsp").forward(request, response);
            return;
        }
        
        String hashedPassword = HashUtil.hashPassword(newPassword);
        boolean success = userDAO.updatePassword(user.getUserID(), hashedPassword);
        
        if (success) {
            // Clear session
            session.removeAttribute("resetEmail");
            session.removeAttribute("otpVerified");
            OtpService.removeOtp(email);
            
            request.setAttribute("successMessage", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Không thể đặt lại mật khẩu. Vui lòng thử lại!");
            request.getRequestDispatcher("/view/auth/reset-password.jsp").forward(request, response);
        }
    }
}
