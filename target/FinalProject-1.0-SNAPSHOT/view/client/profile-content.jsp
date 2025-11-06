<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
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
</style>

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


