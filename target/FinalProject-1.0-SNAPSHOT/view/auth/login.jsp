<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Final Project</title>
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
                            <i class="fas fa-user-circle fa-4x text-primary mb-3"></i>
                            <h3 class="fw-bold text-dark">Đăng nhập</h3>
                            <p class="text-muted">Chào mừng bạn quay trở lại!</p>
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

                        <form action="<c:url value='/auth'/>" method="POST" id="loginForm">
                            <input type="hidden" name="action" value="login">
                            <div class="mb-3">
                                <label for="usernameOrEmail" class="form-label fw-semibold">
                                    <i class="fas fa-user me-1"></i>Tên đăng nhập hoặc Email
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-at"></i></span>
                                    <input type="text" class="form-control" id="usernameOrEmail" name="usernameOrEmail" placeholder="Nhập tên đăng nhập hoặc email" required>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label for="password" class="form-label fw-semibold">
                                    <i class="fas fa-lock me-1"></i>Mật khẩu
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword"><i class="fas fa-eye" id="toggleIcon"></i></button>
                                </div>
                            </div>
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-login"><i class="fas fa-sign-in-alt me-2"></i>Đăng nhập</button>
                            </div>
                            <div class="text-center">
                                <p class="mb-2">
                                    <a href="<c:url value='/auth?action=forgot-password'/>" class="text-decoration-none fw-semibold">
                                        <i class="fas fa-key me-1"></i>Quên mật khẩu?
                                    </a>
                                </p>
                                <p class="mb-0">Chưa có tài khoản? 
                                    <a href="<c:url value='/auth?action=register'/>" class="text-decoration-none fw-semibold">Đăng ký ngay</a>
                                </p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="<c:url value='/assets/js/bootstrap.bundle.min.js'/>" ></script>
    <script>
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordField = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            if (passwordField.type === 'password') { passwordField.type = 'text'; toggleIcon.classList.replace('fa-eye','fa-eye-slash'); }
            else { passwordField.type = 'password'; toggleIcon.classList.replace('fa-eye-slash','fa-eye'); }
        });
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const usernameOrEmail = document.getElementById('usernameOrEmail').value.trim();
            const password = document.getElementById('password').value.trim();
            if (!usernameOrEmail || !password) { e.preventDefault(); alert('Vui lòng điền đầy đủ thông tin!'); }
        });
        setTimeout(function(){ document.querySelectorAll('.alert').forEach(a=> new bootstrap.Alert(a).close()); }, 5000);
    </script>
</body>
</html>
