<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Giỏ hàng</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/cart.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="../common/header.jsp" %>

        <div class="container py-4">
            <a href="${pageContext.request.contextPath}/home" class="text-decoration-none back-link">← Tiếp tục mua sắm</a>
            <h4 class="fw-bold mt-3 mb-4">Giỏ hàng của bạn</h4>

            <c:set var="items" value="${empty cart ? cartItems : cart.items}" />

            <c:choose>
                <c:when test="${empty items}">
                    <div class="alert alert-info text-center py-4 rounded shadow-sm">
                        Giỏ hàng trống. <a href="${pageContext.request.contextPath}/home" class="fw-semibold">Tiếp tục mua sắm</a>
                    </div>
                </c:when>

                <c:otherwise>
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <div class="cart-container">
                            <!-- DANH SÁCH SẢN PHẨM -->
                            <div class="cart-list">
                                <div class="d-flex align-items-center mb-3">
                                    <input type="checkbox" id="selectAll" class="form-check-input checkbox-large me-2" checked>
                                    <label for="selectAll" class="fw-semibold">
                                        Chọn tất cả (<c:out value='${fn:length(items)}'/>)
                                    </label>
                                </div>

                                <c:forEach var="it" items="${items}">
                                    <div class="cart-item d-flex align-items-center" data-id="${it.medicineID}">
                                        <!-- Checkbox -->
                                        <input type="checkbox" 
                                               class="form-check-input item-check checkbox-large me-3"
                                               name="selectedIds"
                                               value="${it.medicineID}"
                                               checked>

                                        <!-- Ảnh sản phẩm -->
                                        <c:choose>
                                            <c:when test="${not empty it.imageUrl}">
                                                <c:set var="imageUrlTrimmed" value="${fn:trim(it.imageUrl)}"/>
                                                <c:choose>
                                                    <c:when test="${fn:startsWith(imageUrlTrimmed, 'http://') or fn:startsWith(imageUrlTrimmed, 'https://')}">
                                                        <c:set var="imgSrc" value="${imageUrlTrimmed}"/>
                                                    </c:when>
                                                    <c:when test="${fn:startsWith(imageUrlTrimmed, '/')}">
                                                        <c:set var="imgSrc" value="${pageContext.request.contextPath}${imageUrlTrimmed}"/>
                                                    </c:when>
                                                    <c:when test="${fn:contains(imageUrlTrimmed, 'assets/img')}">
                                                        <c:choose>
                                                            <c:when test="${fn:startsWith(imageUrlTrimmed, 'assets/img')}">
                                                                <c:set var="imgSrc" value="${pageContext.request.contextPath}/${imageUrlTrimmed}"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set var="imgSrc" value="${pageContext.request.contextPath}/${imageUrlTrimmed}"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="imgSrc" value="${pageContext.request.contextPath}/assets/img/${imageUrlTrimmed}"/>
                                                    </c:otherwise>
                                                </c:choose>
                                                <img src="<c:out value='${imgSrc}'/>"
                                                     alt="<c:out value='${it.medicineName}'/>"
                                                     class="product-img me-3"
                                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/img/no-image.png"
                                                     alt="<c:out value='${it.medicineName}'/>"
                                                     class="product-img me-3">
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Tên + Giá -->
                                        <div class="flex-grow-1">
                                            <a href="${pageContext.request.contextPath}/product/detail?id=${it.medicineID}"
                                               class="product-name d-block mb-1">${it.medicineName}</a>
                                            <div class="price text-primary fw-semibold" data-price="${it.price}">
                                                <fmt:formatNumber value="${it.price}" type="number" groupingUsed="true"/>₫
                                            </div>
                                        </div>

                                        <!-- Nhóm tăng giảm số lượng -->
                                        <div class="quantity-group d-flex align-items-center me-3">
                                            <button type="button" class="btn btn-outline-secondary btn-minus px-2">-</button>
                                            <input type="text" class="form-control text-center quantity-input" value="${it.quantity}">
                                            <button type="button" class="btn btn-outline-secondary btn-plus px-2">+</button>
                                        </div>

                                        <!-- Thành tiền -->
                                        <div class="item-total text-end me-3 fw-semibold">
                                            <fmt:formatNumber value="${it.price * it.quantity}" type="number" groupingUsed="true"/>₫
                                        </div>

                                        <!-- Nút xóa -->
                                        <a href="${pageContext.request.contextPath}/cart?action=remove&id=${it.medicineID}"
                                           class="btn btn-sm btn-outline-danger delete-btn">🗑</a>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- TỔNG KẾT -->
                            <div class="cart-summary">
                                <div class="discount-banner">Áp dụng ưu đãi để được giảm giá</div>
                                <div class="summary-content">
                                    <h6 class="fw-bold mb-3">Tổng thanh toán</h6>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Tổng tiền:</span>
                                        <span id="cartTotal" class="fw-semibold text-primary">
                                            <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/>₫
                                        </span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2 text-muted">
                                        <span>Giảm giá trực tiếp:</span>
                                        <span>0₫</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3 text-muted">
                                        <span>Giảm giá voucher:</span>
                                        <span>0₫</span>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between fw-bold mb-3">
                                        <span>Thành tiền:</span>
                                        <span id="cartFinal" class="text-primary fs-5">
                                            <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/>₫
                                        </span>
                                    </div>

                                    <!-- ✅ Nút mua hàng thực sự gửi form -->
                                    <button type="submit" class="btn-buy">Mua hàng</button>
                                </div>
                            </div>
                        </div>
                    </form>

                </c:otherwise>
            </c:choose>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
    </body>
</html>
