<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hồ sơ cá nhân</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="<c:url value='/assets/css/header.css'/>" rel="stylesheet">
        <!-- CSS này phải được load sau tất cả CSS khác để override -->
        <style>
            /* Reset và override tất cả CSS khác - MUST BE LAST */
            * {
                box-sizing: border-box;
            }
            html {
                margin: 0 !important;
                padding: 0 !important;
            }
            /* Tăng specificity để override home.css và header.css */
            html body.profile-page,
            html body {
                margin: 0 !important;
                padding: 0 !important;
                padding-top: 115px !important; /* Khoảng cách cho header fixed - MUST BE LAST */
                background-color: #f8fafc !important;
            }
            .profile-container {
                margin-top: 0 !important;
                padding-top: 24px !important;
            }
            .profile-wrap { 
                max-width: 980px; 
                margin: 0 auto !important; 
                padding: 0 16px !important;
            }
            .profile-card { background: #fff; border-radius: 14px; box-shadow: 0 6px 24px rgba(0,0,0,.08); overflow: hidden; }
            .profile-header { display: flex; align-items: center; gap: 16px; padding: 22px 22px 0; }
            .profile-avatar { width: 64px; height: 64px; border-radius: 50%; background: #e8eefc; display:flex;align-items:center;justify-content:center; }
            .profile-avatar i { color:#2a60e8; font-size: 28px; }
            .profile-name { font-weight: 700; font-size: 1.25rem; }
            .profile-body { padding: 18px 22px 22px; }
            .info-grid { display: grid; grid-template-columns: repeat(2, minmax(0,1fr)); gap: 14px 22px; }
            .info-item { background:#f8fafc; border:1px solid #eef2f7; border-radius: 10px; padding: 12px 14px; }
            .info-label { color:#64748b; font-size:.92rem; margin-bottom:6px; }
            .info-value { color:#0f172a; font-weight:600; }
            .profile-actions { display:flex; gap:10px; margin-top: 14px; }
            .btn-primary { background:#2a60e8; border:none; }
            .btn-primary:hover { background:#1c4fd6; }
            .btn-outline-secondary { border-color:#cbd5e1; color:#334155; }
        </style>
    </head>
    <body class="profile-page" style="padding-top: 115px !important; margin: 0 !important; background-color: #f8fafc !important;">
        <%@ include file="../common/header.jsp" %>

        <div class="profile-container">
            <div class="profile-wrap">
            <div class="profile-card">
                <div class="profile-header">
                    <div class="profile-avatar"><i class="fas fa-user"></i></div>
                    <div>
                        <div class="profile-name">
                            <c:out value='${sessionScope.user.fullName}'/>
                        </div>
                        <div class="text-muted" style="font-size:.95rem;">Hồ sơ cá nhân</div>
                    </div>
                </div>
                <div class="profile-body">
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">Tên đăng nhập</div>
                            <div class="info-value"><c:out value='${sessionScope.user.username}'/></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Họ và tên</div>
                            <div class="info-value"><c:out value='${sessionScope.user.fullName}'/></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Email</div>
                            <div class="info-value"><c:out value='${sessionScope.user.email}'/></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Số điện thoại</div>
                            <div class="info-value"><c:out value='${sessionScope.user.phoneNumber}'/></div>
                        </div>
                    </div>

                    <div class="profile-actions">
                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/auth?action=reset-password">Đổi mật khẩu</a>
                        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/home">Về trang chủ</a>
                    </div>
                </div>
            </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
        <!-- CSS override cuối cùng để đảm bảo padding-top được áp dụng -->
        <style>
            /* Override tất cả CSS khác - phải được load cuối cùng */
            html body.profile-page {
                padding-top: 115px !important;
                margin: 0 !important;
                background-color: #f8fafc !important;
            }
        </style>
    </body>
    </html>


