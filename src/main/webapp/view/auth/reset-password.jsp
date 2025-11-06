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
    <style>
        .password-strength {
            height: 4px;
            background-color: #e9ecef;
            border-radius: 2px;
            margin-top: 5px;
            overflow: hidden;
        }
        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }
        .strength-weak { background-color: #dc3545; }
        .strength-medium { background-color: #ffc107; }
        .strength-strong { background-color: #198754; }
        
        .password-requirements {
            font-size: 0.875rem;
            margin-top: 5px;
        }
        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 2px;
        }
        .requirement.met {
            color: #198754;
        }
        .requirement.unmet {
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="card login-card">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <i class="fas fa-lock fa-4x text-primary mb-3"></i>
                            <h3 class="fw-bold">Đặt lại mật khẩu</h3>
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
                                    <i class="fas fa-lock me-1 text-primary"></i>Mật khẩu mới
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-key"></i></span>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" required>
                                    <button class="btn btn-outline-secondary" type="button" id="toggleNewPassword">
                                        <i class="fas fa-eye" id="toggleNewIcon"></i>
                                    </button>
                                </div>
                                <div class="password-strength">
                                    <div class="password-strength-bar" id="strengthBar"></div>
                                </div>
                                <div class="password-requirements" id="passwordRequirements">
                                    <div class="requirement unmet" id="req-length">
                                        <i class="fas fa-circle me-1"></i>
                                        <span>Ít nhất 8 ký tự</span>
                                    </div>
                                    <div class="requirement unmet" id="req-uppercase">
                                        <i class="fas fa-circle me-1"></i>
                                        <span>Có chữ hoa</span>
                                    </div>
                                    <div class="requirement unmet" id="req-lowercase">
                                        <i class="fas fa-circle me-1"></i>
                                        <span>Có chữ thường</span>
                                    </div>
                                    <div class="requirement unmet" id="req-number">
                                        <i class="fas fa-circle me-1"></i>
                                        <span>Có số</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="confirmPassword" class="form-label fw-semibold">
                                    <i class="fas fa-lock me-1 text-primary"></i>Xác nhận mật khẩu
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
                                <button type="submit" class="btn btn-secondary btn-login" id="resetBtn" disabled>
                                    <i class="fas fa-save me-2"></i>Đặt lại mật khẩu
                                </button>
                            </div>
                            
                            <div class="text-center">
                                <p class="mb-0">
                                    <a href="<c:url value='/auth'/>" class="text-decoration-none text-primary fw-semibold">Quay lại đăng nhập</a>
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
        const strengthBar = document.getElementById('strengthBar');
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
        
        // Password strength checker
        newPasswordInput.addEventListener('input', function() {
            const password = this.value;
            checkPasswordStrength(password);
            checkPasswordMatch();
            updateResetButton(); // Thêm dòng này
        });
        
        confirmPasswordInput.addEventListener('input', function() {
            checkPasswordMatch();
            updateResetButton(); // Thêm dòng này
        });
        
        function checkPasswordStrength(password) {
            const requirements = {
                length: password.length >= 8,
                uppercase: /[A-Z]/.test(password),
                lowercase: /[a-z]/.test(password),
                number: /\d/.test(password)
            };
            
            // Update requirement indicators
            updateRequirement('req-length', requirements.length);
            updateRequirement('req-uppercase', requirements.uppercase);
            updateRequirement('req-lowercase', requirements.lowercase);
            updateRequirement('req-number', requirements.number);
            
            // Calculate strength
            const metCount = Object.values(requirements).filter(Boolean).length;
            const strength = metCount / 4;
            
            // Update strength bar
            strengthBar.style.width = (strength * 100) + '%';
            strengthBar.className = 'password-strength-bar';
            
            if (strength < 0.5) {
                strengthBar.classList.add('strength-weak');
            } else if (strength < 0.8) {
                strengthBar.classList.add('strength-medium');
            } else {
                strengthBar.classList.add('strength-strong');
            }
        }
        
        function updateRequirement(id, met) {
            const element = document.getElementById(id);
            if (met) {
                element.classList.remove('unmet');
                element.classList.add('met');
                element.querySelector('i').className = 'fas fa-check-circle me-1';
            } else {
                element.classList.remove('met');
                element.classList.add('unmet');
                element.querySelector('i').className = 'fas fa-circle me-1';
            }
        }
        
        function checkPasswordMatch() {
            const password = newPasswordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            const matchElement = document.getElementById('passwordMatch');
            
            if (confirmPassword && password !== confirmPassword) {
                matchElement.innerHTML = '<i class="fas fa-exclamation-triangle me-1 text-danger"></i><span class="text-danger">Mật khẩu không khớp</span>';
                confirmPasswordInput.classList.add('is-invalid');
            } else if (confirmPassword && password === confirmPassword) {
                matchElement.innerHTML = '<i class="fas fa-check-circle me-1 text-success"></i><span class="text-success">Mật khẩu khớp</span>';
                confirmPasswordInput.classList.remove('is-invalid');
                confirmPasswordInput.classList.add('is-valid');
            } else {
                matchElement.innerHTML = '<i class="fas fa-info-circle me-1"></i>Mật khẩu xác nhận phải khớp với mật khẩu mới';
                confirmPasswordInput.classList.remove('is-invalid', 'is-valid');
            }
            
            updateResetButton();
        }
        
        function updateResetButton() {
            const password = newPasswordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            const requirements = {
                length: password.length >= 8,
                uppercase: /[A-Z]/.test(password),
                lowercase: /[a-z]/.test(password),
                number: /\d/.test(password)
            };
            
            const allRequirementsMet = Object.values(requirements).every(Boolean);
            const passwordsMatch = password && confirmPassword && password === confirmPassword;
            
            // Debug log (có thể xóa sau khi test)
            console.log('Password:', password);
            console.log('Confirm Password:', confirmPassword);
            console.log('Requirements:', requirements);
            console.log('All Requirements Met:', allRequirementsMet);
            console.log('Passwords Match:', passwordsMatch);
            console.log('Button should be enabled:', allRequirementsMet && passwordsMatch);
            
            resetBtn.disabled = !(allRequirementsMet && passwordsMatch);
            
            // Thêm visual feedback
            if (allRequirementsMet && passwordsMatch) {
                resetBtn.classList.remove('btn-secondary');
                resetBtn.classList.add('btn-primary');
            } else {
                resetBtn.classList.remove('btn-primary');
                resetBtn.classList.add('btn-secondary');
            }
        }
        
        // Form submission
        document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
            const password = newPasswordInput.value;
            const confirmPassword = confirmPasswordInput.value;
            
            if (!password || !confirmPassword) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin!');
                return;
            }
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
                return;
            }
            
            // Check password strength
            const requirements = {
                length: password.length >= 8,
                uppercase: /[A-Z]/.test(password),
                lowercase: /[a-z]/.test(password),
                number: /\d/.test(password)
            };
            
            if (!Object.values(requirements).every(Boolean)) {
                e.preventDefault();
                alert('Mật khẩu không đáp ứng yêu cầu bảo mật!');
                return;
            }
        });
        
        // Initialize button state on page load
        updateResetButton();
        
        // Auto dismiss alerts after 5 seconds
        setTimeout(function() {
            document.querySelectorAll('.alert').forEach(alert => {
                new bootstrap.Alert(alert).close();
            });
        }, 5000);
    </script>
</body>
</html>
