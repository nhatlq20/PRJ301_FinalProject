<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Final Project</title>
    <link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="register-page">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card register-card">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <i class="fas fa-user-plus fa-4x text-primary mb-3"></i>
                            <h3 class="fw-bold text-dark">Đăng ký tài khoản</h3>
                            <p class="text-muted">Tạo tài khoản mới để bắt đầu</p>
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

                        <form action="<c:url value='/auth'/>" method="POST" id="registerForm" novalidate>
                            <input type="hidden" name="action" value="register">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="username" class="form-label fw-semibold"><i class="fas fa-user me-1"></i>Tên đăng nhập <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-at"></i></span>
                                        <input type="text" class="form-control" id="username" name="username" placeholder="Nhập tên đăng nhập" required>
                                        <div class="invalid-feedback">Vui lòng nhập tên đăng nhập!</div>
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label fw-semibold"><i class="fas fa-envelope me-1"></i>Email <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email" required>
                                        <div class="invalid-feedback">Vui lòng nhập email hợp lệ!</div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="fullName" class="form-label fw-semibold"><i class="fas fa-id-card me-1"></i>Họ và tên</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập họ và tên">
                                    </div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="phoneNumber" class="form-label fw-semibold"><i class="fas fa-phone me-1"></i>Số điện thoại</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                        <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Nhập số điện thoại">
                                    </div>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label fw-semibold"><i class="fas fa-lock me-1"></i>Mật khẩu <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Nhập mật khẩu" required>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword"><i class="fas fa-eye" id="toggleIcon"></i></button>
                                    <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự!</div>
                                </div>
                                <div class="mt-2">
                                    <div class="password-strength" id="passwordStrength"></div>
                                    <small class="text-muted" id="passwordStrengthText">Độ mạnh mật khẩu</small>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label for="confirmPassword" class="form-label fw-semibold"><i class="fas fa-lock me-1"></i>Xác nhận mật khẩu <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                                    <div class="invalid-feedback">Mật khẩu xác nhận không khớp!</div>
                                </div>
                            </div>
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-register"><i class="fas fa-user-plus me-2"></i>Đăng ký</button>
                            </div>
                            <div class="text-center">
                                <p class="mb-0">Đã có tài khoản? <a href="<c:url value='/auth'/>" class="text-decoration-none fw-semibold">Đăng nhập ngay</a></p>
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
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value; const bar = document.getElementById('passwordStrength'); const txt = document.getElementById('passwordStrengthText');
            let s=0; if (password.length>=6) s++; if (/[a-z]/.test(password)) s++; if (/[A-Z]/.test(password)) s++; if (/[0-9]/.test(password)) s++; if (/[^a-zA-Z0-9]/.test(password)) s++;
            if (s<2){ bar.className='password-strength strength-weak'; txt.textContent='Độ mạnh mật khẩu: Yếu'; }
            else if (s<4){ bar.className='password-strength strength-medium'; txt.textContent='Độ mạnh mật khẩu: Trung bình'; }
            else { bar.className='password-strength strength-strong'; txt.textContent='Độ mạnh mật khẩu: Mạnh'; }
        });
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const u=document.getElementById('username').value.trim(); const em=document.getElementById('email').value.trim(); const p=document.getElementById('password').value.trim(); const cp=document.getElementById('confirmPassword').value.trim();
            let ok=true; const emailRe=/^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            document.querySelectorAll('.form-control').forEach(i=>i.classList.remove('is-invalid','is-valid'));
            if(!u){document.getElementById('username').classList.add('is-invalid'); ok=false;} else {document.getElementById('username').classList.add('is-valid');}
            if(!em||!emailRe.test(em)){document.getElementById('email').classList.add('is-invalid'); ok=false;} else {document.getElementById('email').classList.add('is-valid');}
            if(!p||p.length<6){document.getElementById('password').classList.add('is-invalid'); ok=false;} else {document.getElementById('password').classList.add('is-valid');}
            if(!cp||p!==cp){document.getElementById('confirmPassword').classList.add('is-invalid'); ok=false;} else {document.getElementById('confirmPassword').classList.add('is-valid');}
            if(!ok){ e.preventDefault(); alert('Vui lòng kiểm tra lại thông tin!'); }
        });
        setTimeout(function(){ document.querySelectorAll('.alert').forEach(a=> new bootstrap.Alert(a).close()); }, 5000);
    </script>
</body>
</html>
