<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công - PharmacyLife</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/order-success.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>

<body>
    <%@ include file="../common/header.jsp" %>

    <main class="success-container">
        <div class="success-icon">
            <i class="bi bi-check-lg"></i>
        </div>

        <h2 class="success-title">Đặt hàng thành công!</h2>
        <p class="success-message">Cảm ơn bạn đã tin tưởng PharmacyLife 💙</p>

        <div class="order-info mt-4">
            <p><strong>Mã đơn hàng:</strong> #${param.orderId}</p>
            <p><strong>Tổng tiền:</strong> 
                <c:out value="${param.total != null ? param.total : 'Đang xử lý'}"/> ₫
            </p>
            <p><strong>Trạng thái:</strong> Đang chờ xác nhận</p>
            <p><strong>Thời gian:</strong> 
                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy HH:mm" />
            </p>
        </div>

        <div class="btn-wrap">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Về trang chủ</a>
            <a href="${pageContext.request.contextPath}/order" class="btn btn-outline">Xem đơn hàng</a>
        </div>
    </main>

    <%@ include file="../common/footer.jsp" %>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>
