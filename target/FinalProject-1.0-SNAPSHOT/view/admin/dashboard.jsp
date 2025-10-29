<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng điều khiển</title>
    <link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-body p-4">
                    <h3 class="mb-3">Xin chào, <span class="text-primary">${sessionScope.username}</span></h3>
                    <p class="text-muted mb-4">Bạn đã đăng nhập thành công.</p>
                    <div class="d-flex gap-2">
                        <a href="<c:url value='/auth?action=users'/>" class="btn btn-outline-primary">Xem danh sách người dùng</a>
                        <a href="<c:url value='/auth?action=logout'/>" class="btn btn-outline-danger">Đăng xuất</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="<c:url value='/assets/js/bootstrap.bundle.min.js'/>" ></script>
</body>
</html>
