<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đơn hàng của tôi - PharmacyLife</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/header.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8fafc;
                font-family: "Inter", "Helvetica Neue", Arial, sans-serif;
                padding-top: 115px !important; /* Khoảng cách cho header fixed */
            }
            .order-container {
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
            .order-card {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                padding: 20px;
                margin-bottom: 16px;
                transition: box-shadow 0.2s;
            }
            .order-card:hover {
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }
            .order-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 16px;
                padding-bottom: 16px;
                border-bottom: 1px solid #eef2f7;
            }
            .order-info {
                flex: 1;
            }
            .order-id {
                font-weight: 600;
                font-size: 1.1rem;
                color: #0f172a;
                margin-bottom: 4px;
            }
            .order-date {
                color: #64748b;
                font-size: 0.9rem;
            }
            .order-status {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.85rem;
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
            .order-total {
                text-align: right;
                font-size: 1.25rem;
                font-weight: 700;
                color: #2a60e8;
                margin-bottom: 16px;
            }
            .order-actions {
                display: flex;
                gap: 10px;
                margin-top: 16px;
                padding-top: 16px;
                border-top: 1px solid #eef2f7;
            }
            .btn-view {
                background: #2a60e8;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                transition: background 0.2s;
            }
            .btn-view:hover {
                background: #1c4fd6;
                color: #fff;
            }
            .empty-state {
                text-align: center;
                padding: 60px 20px;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            }
            .empty-state i {
                font-size: 4rem;
                color: #cbd5e1;
                margin-bottom: 16px;
            }
            .empty-state h3 {
                color: #475569;
                margin-bottom: 8px;
            }
            .empty-state p {
                color: #64748b;
                margin-bottom: 24px;
            }
            .alert {
                padding: 12px 16px;
                border-radius: 8px;
                margin-bottom: 20px;
            }
            .alert-danger {
                background: #fee2e2;
                color: #991b1b;
                border: 1px solid #fecaca;
            }
        </style>
    </head>
    <body>
        <%@ include file="../common/header.jsp" %>

        <div class="order-container">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-shopping-bag me-2"></i>
                    Đơn hàng của tôi
                </h1>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                    <i class="fas fa-home me-2"></i>Về trang chủ
                </a>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                </div>
            </c:if>

            <!-- Debug info -->
            <c:if test="${not empty orders}">
                <div style="background: #e0f2fe; padding: 10px; margin-bottom: 10px; border-radius: 4px; font-size: 0.9rem;">
                    <strong>Debug:</strong> Found ${orders.size()} orders
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty orders}">
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h3>Chưa có đơn hàng nào</h3>
                        <p>Bạn chưa có đơn hàng nào. Hãy bắt đầu mua sắm ngay!</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-view">
                            <i class="fas fa-shopping-cart me-2"></i>Mua sắm ngay
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="order" items="${orders}">
                        <div class="order-card">
                            <div class="order-header">
                                <div class="order-info">
                                    <div class="order-id">Đơn hàng #${order.orderID}</div>
                                    <div class="order-date">
                                        <i class="far fa-calendar me-1"></i>
                                        ${order.formattedOrderDate}
                                    </div>
                                </div>
                                <div>
                                    <span class="order-status status-${fn:toLowerCase(order.status)}">
                                        <c:choose>
                                            <c:when test="${order.status == 'Pending'}">⏳ Đang chờ duyệt</c:when>
                                            <c:when test="${order.status == 'Paid'}">✅ Đã xác nhận</c:when>
                                            <c:when test="${order.status == 'Shipped'}">🚚 Đang giao</c:when>
                                            <c:when test="${order.status == 'Completed'}">✓ Đã giao</c:when>
                                            <c:when test="${order.status == 'Cancelled'}">❌ Đã hủy</c:when>
                                            <c:otherwise>${order.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>

                            <div class="order-total">
                                Tổng tiền: <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                            </div>

                            <div class="order-actions">
                                <a href="${pageContext.request.contextPath}/my-orders?action=detail&id=${order.orderID}" 
                                   class="btn-view">
                                    <i class="fas fa-eye me-2"></i>Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

