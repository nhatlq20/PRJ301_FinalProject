<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - Final Project</title>
    <link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card login-card">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <i class="fas fa-lock fa-4x text-primary mb-3"></i>
                            <h3 class="fw-bold text-dark">Đặt lại mật khẩu</h3>
                            <p class="text-muted">Tạo mật khẩu mới cho tài khoản của bạn</p>
                        </div>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i>
                                ${successMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="<c:url value='/auth'/>" method="POST" id="resetPasswordForm">
                            <input type="hidden" name="action" value="reset-password">
                            
                            <div class="mb-3">
                                <label for="newPassword" class="form-label fw-semibold">
                                    <i class="fas fa-lock me-1"></i>Mật khẩu mới
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" required>
                                    <button class="btn btn-outline-secondary" type="button" id="toggleNewPassword">
                                        <i class="fas fa-eye" id="toggleNewIcon"></i>
                                    </button>
                                </div>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="confirmPassword" class="form-label fw-semibold">
                                    <i class="fas fa-lock me-1"></i>Xác nhận mật khẩu
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                                    <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                                        <i class="fas fa-eye" id="toggleConfirmIcon"></i>
                                    </button>
                                </div>
                                <div class="form-text" id="passwordMatch">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Mật khẩu xác nhận phải khớp với mật khẩu mới
                                </div>
                            </div>
                            
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-login" id="resetBtn">
                                    <i class="fas fa-save me-2"></i>Đặt lại mật khẩu
                                </button>
                            </div>
                            
                            <div class="text-center">
                                <p class="mb-0">
                                    <a href="<c:url value='/auth'/>" class="text-decoration-none">Quay lại đăng nhập</a>
                                </p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="<c:url value='/assets/js/bootstrap.bundle.min.js'/>"></script>
    <script>
        const newPasswordInput = document.getElementById('newPassword');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const resetBtn = document.getElementById('resetBtn');
        
        // Toggle password visibility
        document.getElementById('toggleNewPassword').addEventListener('click', function() {
            const icon = document.getElementById('toggleNewIcon');
            if (newPasswordInput.type === 'password') {
                newPasswordInput.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                newPasswordInput.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        });
        
        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const icon = document.getElementById('toggleConfirmIcon');
            if (confirmPasswordInput.type === 'password') {
                confirmPasswordInput.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                confirmPasswordInput.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        });
        
        // Simple validation
        function validateForm() {
            const password = newPasswordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            
            // Check if passwords match
            if (password !== confirmPassword) {
                document.getElementById('passwordMatch').innerHTML = 
                    '<i class="fas fa-exclamation-triangle me-1 text-danger"></i><span class="text-danger">Mật khẩu không khớp</span>';
                return false;
            } else if (password && confirmPassword) {
                document.getElementById('passwordMatch').innerHTML = 
                    '<i class="fas fa-check-circle me-1 text-success"></i><span class="text-success">Mật khẩu khớp</span>';
            }
            
            // Check password strength
            const hasLength = password.length >= 8;
            const hasUppercase = /[A-Z]/.test(password);
            const hasLowercase = /[a-z]/.test(password);
            const hasNumber = /\d/.test(password);
            
            if (!hasLength || !hasUppercase || !hasLowercase || !hasNumber) {
                return false;
            }
            
            return true;
        }
        
        // Real-time validation
        newPasswordInput.addEventListener('input', validateForm);
        confirmPasswordInput.addEventListener('input', validateForm);
        
        // Form submission
        document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
            if (!validateForm()) {
                e.preventDefault();
                alert('Vui lòng kiểm tra lại thông tin mật khẩu!');
                return;
            }
        });
        
        // Auto dismiss alerts after 5 seconds
        setTimeout(function() {
            document.querySelectorAll('.alert').forEach(alert => {
                new bootstrap.Alert(alert).close();
            });
        }, 5000);
    </script>
</body>
</html>
