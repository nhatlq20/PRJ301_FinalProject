<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="../common/header.jsp" %>

    <div class="container py-4">
        <h3 class="fw-bold mb-4">Giỏ hàng của bạn</h3>

        <c:set var="items" value="${empty cart ? cartItems : cart.items}"/>

        <c:choose>
            <c:when test="${empty items}">
                <div class="alert alert-info">Giỏ hàng trống. <a href="${pageContext.request.contextPath}/home">Tiếp tục mua sắm</a></div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Đơn giá</th>
                                <th class="text-center" style="width:160px;">Số lượng</th>
                                <th>Thành tiền</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0"/>
                            <c:forEach var="it" items="${items}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <img src="<c:out value='${it.imageUrl}'/>" alt="<c:out value='${it.medicineName}'/>" style="width:64px;height:64px;object-fit:contain;">
                                            <div>
                                                <div class="fw-semibold"><a href="${pageContext.request.contextPath}/product/detail?id=${it.medicineID}" class="text-decoration-none">${it.medicineName}</a></div>
                                                <small class="text-muted">ĐVT: ${it.unit}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${it.price}" type="number" groupingUsed="true"/>₫
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/cart?action=update&id=${it.medicineID}&qty=${it.quantity - 1}">-</a>
                                            <span class="btn btn-light disabled" style="width:60px;">${it.quantity}</span>
                                            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/cart?action=update&id=${it.medicineID}&qty=${it.quantity + 1}">+</a>
                                        </div>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${it.price * it.quantity}" type="number" groupingUsed="true"/>₫
                                        <c:set var="total" value="${total + (it.price * it.quantity)}"/>
                                    </td>
                                    <td class="text-end">
                                        <a href="${pageContext.request.contextPath}/cart?action=remove&id=${it.medicineID}" class="btn btn-sm btn-outline-danger">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/home">Tiếp tục mua sắm</a>
                    <div class="h5 m-0">Tổng cộng: <strong class="text-primary">
                        <c:choose>
                            <c:when test="${not empty cart}"><fmt:formatNumber value="${cart.totalPrice}" type="number" groupingUsed="true"/>₫</c:when>
                            <c:otherwise><fmt:formatNumber value="${total}" type="number" groupingUsed="true"/>₫</c:otherwise>
                        </c:choose>
                    </strong></div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>
