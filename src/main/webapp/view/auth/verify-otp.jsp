<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực OTP - Final Project</title>
    <link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .otp-input {
            font-size: 1.5rem;
            text-align: center;
            letter-spacing: 0.5rem;
            font-weight: bold;
        }
        .otp-container {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 20px 0;
        }
        .otp-digit {
            width: 50px;
            height: 50px;
            border: 2px solid #dee2e6;
            border-radius: 8px;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .otp-digit:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
            outline: none;
        }
        .otp-digit.filled {
            border-color: #198754;
            background-color: #f8f9fa;
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
                            <i class="fas fa-shield-alt fa-4x text-primary mb-3"></i>
                            <h3 class="fw-bold text-dark">Xác thực OTP</h3>
                            <p class="text-muted">Nhập mã OTP đã được gửi đến email của bạn</p>
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

                        <form action="<c:url value='/auth'/>" method="POST" id="verifyOtpForm">
                            <input type="hidden" name="action" value="verify-otp">
                            <input type="hidden" name="otp" id="otpInput">
                            
                            <div class="mb-4">
                                <label class="form-label fw-semibold text-center d-block">
                                    <i class="fas fa-key me-1"></i>Mã OTP (6 chữ số)
                                </label>
                                <div class="otp-container">
                                    <input type="text" class="otp-digit" maxlength="1" data-index="0" autocomplete="off">
                                    <input type="text" class="otp-digit" maxlength="1" data-index="1" autocomplete="off">
                                    <input type="text" class="otp-digit" maxlength="1" data-index="2" autocomplete="off">
                                    <input type="text" class="otp-digit" maxlength="1" data-index="3" autocomplete="off">
                                    <input type="text" class="otp-digit" maxlength="1" data-index="4" autocomplete="off">
                                    <input type="text" class="otp-digit" maxlength="1" data-index="5" autocomplete="off">
                                </div>
                                <div class="form-text text-center">
                                    <i class="fas fa-clock me-1"></i>
                                    Mã OTP có hiệu lực trong 5 phút
                                </div>
                            </div>
                            
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary btn-login" id="verifyBtn" disabled>
                                    <i class="fas fa-check me-2"></i>Xác thực OTP
                                </button>
                            </div>
                            
                            <div class="text-center">
                                <p class="mb-0">Không nhận được mã? 
                                    <a href="<c:url value='/auth?action=forgot-password'/>" class="text-decoration-none fw-semibold">Gửi lại</a>
                                </p>
                                <p class="mb-0 mt-2">
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
        const otpDigits = document.querySelectorAll('.otp-digit');
        const otpInput = document.getElementById('otpInput');
        const verifyBtn = document.getElementById('verifyBtn');
        
        // Auto-focus first input
        otpDigits[0].focus();
        
        // Handle input events
        otpDigits.forEach((digit, index) => {
            digit.addEventListener('input', function(e) {
                const value = e.target.value;
                
                // Only allow numbers
                if (!/^\d$/.test(value)) {
                    e.target.value = '';
                    return;
                }
                
                // Add filled class
                e.target.classList.add('filled');
                
                // Move to next input
                if (value && index < otpDigits.length - 1) {
                    otpDigits[index + 1].focus();
                }
                
                // Update hidden input and check if form is complete
                updateOtpInput();
            });
            
            digit.addEventListener('keydown', function(e) {
                // Handle backspace
                if (e.key === 'Backspace') {
                    if (!e.target.value && index > 0) {
                        otpDigits[index - 1].focus();
                        otpDigits[index - 1].classList.remove('filled');
                    } else {
                        e.target.classList.remove('filled');
                    }
                    updateOtpInput();
                }
                
                // Handle paste
                if (e.key === 'v' && (e.ctrlKey || e.metaKey)) {
                    e.preventDefault();
                    navigator.clipboard.readText().then(text => {
                        if (/^\d{6}$/.test(text)) {
                            text.split('').forEach((char, i) => {
                                if (i < otpDigits.length) {
                                    otpDigits[i].value = char;
                                    otpDigits[i].classList.add('filled');
                                }
                            });
                            updateOtpInput();
                        }
                    });
                }
            });
        });
        
        function updateOtpInput() {
            const otp = Array.from(otpDigits).map(digit => digit.value).join('');
            otpInput.value = otp;
            
            // Enable/disable verify button
            verifyBtn.disabled = otp.length !== 6;
        }
        
        // Form submission
        document.getElementById('verifyOtpForm').addEventListener('submit', function(e) {
            const otp = otpInput.value;
            if (otp.length !== 6) {
                e.preventDefault();
                alert('Vui lòng nhập đầy đủ 6 chữ số OTP!');
                return;
            }
            
            if (!/^\d{6}$/.test(otp)) {
                e.preventDefault();
                alert('Mã OTP chỉ được chứa số!');
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
