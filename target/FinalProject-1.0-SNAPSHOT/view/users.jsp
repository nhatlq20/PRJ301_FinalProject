<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách người dùng</title>
    <link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">
</head>
<body>
<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="mb-0">Danh sách người dùng</h3>
        <div>
            <a href="<c:url value='/view/dashboard.jsp'/>" class="btn btn-outline-secondary">Về bảng điều khiển</a>
            <a href="<c:url value='/auth?action=logout'/>" class="btn btn-outline-danger">Đăng xuất</a>
        </div>
    </div>

    <c:if test="${empty users}">
        <div class="alert alert-info">Không có người dùng.</div>
    </c:if>

    <c:if test="${not empty users}">
        <div class="table-responsive">
            <table class="table table-striped table-bordered align-middle">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Họ tên</th>
                        <th>Điện thoại</th>
                        <th>Active</th>
                        <th>Created</th>
                        <th>Updated</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>${u.userID}</td>
                            <td>${u.username}</td>
                            <td>${u.email}</td>
                            <td>${u.fullName}</td>
                            <td>${u.phoneNumber}</td>
                            <td>
                                <span class="badge ${u.active ? 'bg-success' : 'bg-secondary'}">
                                    <c:out value="${u.active ? 'Yes' : 'No'}"/>
                                </span>
                            </td>
                            <td>${u.createdAt}</td>
                            <td>${u.updatedAt}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>
<script src="<c:url value='/assets/js/bootstrap.bundle.min.js'/>" ></script>
</body>
</html>
