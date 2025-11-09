<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lí đơn hàng - PharmacyLife</title>
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
                max-width: 1200px;
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
            .order-pending {
                border-left: 4px solid #f59e0b;
                background: #fffbeb;
            }
            .badge-new {
                background: #ef4444;
                color: #fff;
                font-size: 0.7rem;
                font-weight: 700;
                padding: 2px 8px;
                border-radius: 12px;
                margin-left: 8px;
                text-transform: uppercase;
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
            .order-details {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 16px;
                margin-bottom: 16px;
            }
            .detail-item {
                display: flex;
                flex-direction: column;
            }
            .detail-label {
                color: #64748b;
                font-size: 0.85rem;
                margin-bottom: 4px;
            }
            .detail-value {
                color: #0f172a;
                font-weight: 600;
            }
            .order-total {
                text-align: right;
                font-size: 1.25rem;
                font-weight: 700;
                color: #2a60e8;
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
                padding: 8px 16px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                transition: background 0.2s;
            }
            .btn-view:hover {
                background: #1c4fd6;
                color: #fff;
            }
            .btn-status {
                background: #f1f5f9;
                color: #475569;
                border: 1px solid #cbd5e1;
                padding: 8px 16px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.2s;
            }
            .btn-status:hover {
                background: #e2e8f0;
                color: #334155;
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
            .alert-success {
                background: #d1fae5;
                color: #065f46;
                border: 1px solid #a7f3d0;
            }
            .alert-danger {
                background: #fee2e2;
                color: #991b1b;
                border: 1px solid #fecaca;
            }
            .btn-confirm {
                background: #10b981;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: background 0.2s;
                display: inline-flex;
                align-items: center;
            }
            .btn-confirm:hover {
                background: #059669;
                color: #fff;
            }
            .btn-confirm i {
                font-size: 1rem;
            }
        </style>
    </head>
    <body>
        <%@ include file="../common/header.jsp" %>

        <div class="order-container">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-shopping-bag me-2"></i>
                    Quản lí đơn hàng
                </h1>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                    <i class="fas fa-home me-2"></i>Về trang chủ
                </a>
            </div>

            <c:if test="${not empty param.msg}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>${param.msg}
                </div>
            </c:if>

            <c:if test="${not empty param.error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>${param.error}
                </div>
            </c:if>

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
                        <div class="order-card ${order.status == 'Pending' ? 'order-pending' : ''}">
                            <div class="order-header">
                                <div class="order-info">
                                    <div class="order-id">
                                        Đơn hàng #${order.orderID}
                                        <c:if test="${order.status == 'Pending'}">
                                            <span class="badge-new">MỚI</span>
                                        </c:if>
                                    </div>
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

                            <div class="order-details">
                                <div class="detail-item">
                                    <span class="detail-label">Người nhận</span>
                                    <span class="detail-value">${order.shippingName}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">Số điện thoại</span>
                                    <span class="detail-value">${order.shippingPhone}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">Địa chỉ</span>
                                    <span class="detail-value">${order.shippingAddress}</span>
                                </div>
                            </div>

                            <div class="order-total">
                                Tổng tiền: <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>₫
                            </div>

                            <div class="order-actions">
                                <a href="${pageContext.request.contextPath}/order?action=detail&id=${order.orderID}" 
                                   class="btn-view">
                                    <i class="fas fa-eye me-2"></i>Xem chi tiết
                                </a>
                                <c:if test="${isAdmin}">
                                    <c:if test="${order.status == 'Pending'}">
                                        <button type="button" onclick="confirmOrder('${order.orderID}')" 
                                                class="btn-confirm">
                                            <i class="fas fa-check-circle me-2"></i>Xác nhận đơn
                                        </button>
                                    </c:if>
                                    <select class="form-select" style="width: auto;" 
                                            onchange="updateStatus('${order.orderID}', this.value, this)"
                                            data-previous-value="${order.status}">  
                                        <option value="Pending" ${order.status == 'Pending' ? 'selected' : ''}>Đang chờ</option>
                                        <option value="Paid" ${order.status == 'Paid' ? 'selected' : ''}>Đã xác nhận</option>
                                        <option value="Shipped" ${order.status == 'Shipped' ? 'selected' : ''}>Đang giao</option>
                                        <option value="Completed" ${order.status == 'Completed' ? 'selected' : ''}>Đã giao</option>
                                        <option value="Cancelled" ${order.status == 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
                                    </select>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script>
            function updateStatus(orderID, status, selectElement) {
                console.log('updateStatus called with orderID:', orderID, 'status:', status);
                if (confirm('Bạn có chắc muốn cập nhật trạng thái đơn hàng?')) {
                    var url = '${pageContext.request.contextPath}/order?action=updateStatus&id=' + encodeURIComponent(orderID) + '&status=' + encodeURIComponent(status);
                    console.log('Redirecting to:', url);
                    window.location.href = url;
                } else {
                    console.log('User cancelled status update');
                    // Reset select to previous value
                    if (selectElement) {
                        var previousValue = selectElement.getAttribute('data-previous-value') || '';
                        selectElement.value = previousValue;
                    }
                }
            }
            
            function confirmOrder(orderID) {
                console.log('confirmOrder called with orderID:', orderID);
                if (confirm('Bạn có chắc muốn xác nhận đơn hàng này?')) {
                    var url = '${pageContext.request.contextPath}/order?action=updateStatus&id=' + encodeURIComponent(orderID) + '&status=' + encodeURIComponent('Paid');
                    console.log('Redirecting to:', url);
                    window.location.href = url;
                } else {
                    console.log('User cancelled confirmation');
                }
            }
        </script>
    </body>
</html>

