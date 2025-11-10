<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết đơn hàng - PharmacyLife</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/header.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8fafc;
                font-family: "Inter", "Helvetica Neue", Arial, sans-serif;
                padding-top: 115px !important; /* Khoảng cách cho header fixed */
            }
            .order-detail-container {
                max-width: 1000px;
                margin: 24px auto;
                padding: 0 16px;
            }
            .page-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 24px;
            }
            .page-title {
                font-size: 1.75rem;
                font-weight: 700;
                color: #0f172a;
            }
            .detail-card {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                padding: 24px;
                margin-bottom: 20px;
            }
            .card-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #0f172a;
                margin-bottom: 20px;
                padding-bottom: 12px;
                border-bottom: 2px solid #eef2f7;
            }
            .order-info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 16px;
            }
            .info-item {
                display: flex;
                flex-direction: column;
            }
            .info-label {
                color: #64748b;
                font-size: 0.85rem;
                margin-bottom: 6px;
            }
            .info-value {
                color: #0f172a;
                font-weight: 600;
                font-size: 1rem;
            }
            .order-status {
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 600;
                display: inline-block;
            }
            .status-pending {
                background: #fef3c7;
                color: #92400e;
            }
            .status-confirmed, .status-paid {
                background: #dbeafe;
                color: #1e40af;
            }
            .status-shipping, .status-shipped {
                background: #e0e7ff;
                color: #3730a3;
            }
            .status-delivered, .status-completed {
                background: #d1fae5;
                color: #065f46;
            }
            .status-cancelled {
                background: #fee2e2;
                color: #991b1b;
            }
            .product-item {
                display: flex;
                align-items: center;
                padding: 16px;
                border-bottom: 1px solid #eef2f7;
            }
            .product-item:last-child {
                border-bottom: none;
            }
            .product-img {
                width: 80px;
                height: 80px;
                object-fit: contain;
                border-radius: 8px;
                background: #f8fafc;
                margin-right: 16px;
                flex-shrink: 0;
            }
            .product-info {
                flex: 1;
            }
            .product-name {
                font-weight: 600;
                color: #0f172a;
                margin-bottom: 8px;
                font-size: 1rem;
            }
            .product-details {
                display: flex;
                gap: 24px;
                color: #64748b;
                font-size: 0.9rem;
            }
            .product-price {
                text-align: right;
                min-width: 120px;
            }
            .price-value {
                font-weight: 700;
                font-size: 1.1rem;
                color: #2a60e8;
            }
            .price-quantity {
                color: #64748b;
                font-size: 0.85rem;
                margin-top: 4px;
            }
            .total-section {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 20px;
                background: #f8fafc;
                border-radius: 8px;
                margin-top: 20px;
            }
            .total-label {
                font-size: 1.1rem;
                font-weight: 600;
                color: #0f172a;
            }
            .total-value {
                font-size: 1.5rem;
                font-weight: 700;
                color: #2a60e8;
            }
            .btn-back {
                background: #f1f5f9;
                color: #475569;
                border: 1px solid #cbd5e1;
                padding: 10px 20px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.2s;
            }
            .btn-back:hover {
                background: #e2e8f0;
                color: #334155;
            }
        </style>
    </head>
    <body>
        <%@ include file="../common/header.jsp" %>

        <div class="order-detail-container">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-file-invoice me-2"></i>
                    Chi tiết đơn hàng
                </h1>
                <a href="${pageContext.request.contextPath}/order" class="btn-back">
                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                </a>
            </div>

            <c:if test="${not empty order}">
                <!-- Thông tin đơn hàng -->
                <div class="detail-card">
                    <h3 class="card-title">Thông tin đơn hàng</h3>
                    <div class="order-info-grid">
                        <div class="info-item">
                            <span class="info-label">Mã đơn hàng</span>
                            <span class="info-value">#${order.orderID}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Ngày đặt</span>
                            <span class="info-value">
                                ${order.formattedOrderDate}
                            </span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Trạng thái</span>
                            <span class="order-status status-${fn:toLowerCase(order.status)}">
                                <c:choose>
                                    <c:when test="${order.status == 'Pending'}">Đang chờ</c:when>
                                    <c:when test="${order.status == 'Paid'}">Đã xác nhận</c:when>
                                    <c:when test="${order.status == 'Shipped'}">Đang giao</c:when>
                                    <c:when test="${order.status == 'Completed'}">Đã giao</c:when>
                                    <c:when test="${order.status == 'Cancelled'}">Đã hủy</c:when>
                                    <c:otherwise>${order.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Thông tin giao hàng -->
                <div class="detail-card">
                    <h3 class="card-title">Thông tin giao hàng</h3>
                    <div class="order-info-grid">
                        <div class="info-item">
                            <span class="info-label">Người nhận</span>
                            <span class="info-value">${order.shippingName}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Số điện thoại</span>
                            <span class="info-value">${order.shippingPhone}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Địa chỉ</span>
                            <span class="info-value">${order.shippingAddress}</span>
                        </div>
                    </div>
                </div>

                <!-- Danh sách sản phẩm -->
                <div class="detail-card">
                    <h3 class="card-title">Sản phẩm đã đặt</h3>
                    <c:forEach var="item" items="${orderItems}">
                        <div class="product-item">
                            <c:set var="rawUrl" value="${item.imageUrl}" />
                            <c:choose>
                                <c:when test="${fn:startsWith(rawUrl, 'http') || fn:startsWith(rawUrl, '/')}">
                                    <img src="${rawUrl}" 
                                         alt="${item.medicineName}" 
                                         class="product-img"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/img/default.png'">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/img/${rawUrl}" 
                                         alt="${item.medicineName}" 
                                         class="product-img"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/img/default.png'">
                                </c:otherwise>
                            </c:choose>
                            <div class="product-info">
                                <div class="product-name">${item.medicineName}</div>
                                <div class="product-details">
                                    <span>Mã SP: ${item.medicineID}</span>
                                    <span>Số lượng: ${item.quantity}</span>
                                </div>
                            </div>
                            <div class="product-price">
                                <div class="price-value">
                                    <fmt:formatNumber value="${item.unitPrice * item.quantity}" type="number" groupingUsed="true"/>₫
                                </div>
                                <div class="price-quantity">
                                    <fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/>₫ x ${item.quantity}
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="total-section">
                        <span class="total-label">Tổng thanh toán:</span>
                        <span class="total-value">
                            <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                        </span>
                    </div>
                </div>
            </c:if>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

