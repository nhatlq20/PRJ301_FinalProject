<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Xác nhận thanh toán - PharmacyLife</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
        <!-- CSS riêng cho trang checkout -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/checkout.css">
    </head>

    <body>
        <main class="container checkout-container">
            <!-- Cột trái: Danh sách sản phẩm -->
            <div class="checkout-left">
                <h5 class="mb-4">🛍️ Danh sách sản phẩm</h5>
                <c:forEach var="item" items="${selectedItems}">
                    <div class="cart-item">
                        <c:choose>
                            <c:when test="${not empty item.imageUrl}">
                                <c:set var="imageUrlTrimmed" value="${fn:trim(item.imageUrl)}"/>
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
                                     alt="${item.medicineName}" 
                                     class="product-img"
                                     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/img/no-image.png"
                                     alt="${item.medicineName}" 
                                     class="product-img">
                            </c:otherwise>
                        </c:choose>

                        <div class="cart-info">
                            <p class="product-name">${item.medicineName}</p>
                            <small>Đơn vị: ${item.unit}</small><br>
                            <small>Số lượng: ${item.quantity}</small>
                        </div>

                        <div class="cart-price">
                            <fmt:formatNumber value="${item.total}" type="number" groupingUsed="true"/>₫
                        </div>
                    </div>
                </c:forEach>

            </div>

            <!-- Cột phải: Thanh toán -->
            <div class="checkout-right">
                <form action="${pageContext.request.contextPath}/placeOrder" method="post">
                <h5 class="mb-4">Chọn phương thức thanh toán</h5>
                <form action="placeOrder" method="post">
                    <div class="payment-option">
                        <input type="radio" name="paymentMethod" value="COD" required>
                        <img src="${pageContext.request.contextPath}/assets/img/payment/cash.png" alt="COD">
                        <span>Thanh toán tiền mặt khi nhận hàng</span>
                    </div>

                    <div class="payment-option">
                        <input type="radio" name="paymentMethod" value="QR">
                        <img src="${pageContext.request.contextPath}/assets/img/payment/qr.png" alt="QR">
                        <span>Thanh toán bằng chuyển khoản (QR Code)</span>
                    </div>

                    <div class="payment-option">
                        <input type="radio" name="paymentMethod" value="ATM">
                        <img src="${pageContext.request.contextPath}/assets/img/payment/atm.png" alt="ATM">
                        <span>Thanh toán bằng thẻ ATM nội địa</span>
                    </div>

                    <div class="payment-option">
                        <input type="radio" name="paymentMethod" value="Visa">
                        <img src="${pageContext.request.contextPath}/assets/img/payment/visa.png" alt="Visa">
                        <span>Thanh toán bằng thẻ quốc tế (Visa, Master...)</span>
                    </div>

                    <div class="payment-option">
                        <input type="radio" name="paymentMethod" value="ZaloPay">
                        <img src="${pageContext.request.contextPath}/assets/img/payment/zalopay.png" alt="ZaloPay">
                        <span>Thanh toán bằng ví ZaloPay</span>
                    </div>

                    <div class="payment-option">
                        <input type="radio" name="paymentMethod" value="MoMo">
                        <img src="${pageContext.request.contextPath}/assets/img/payment/momo.png" alt="MoMo">
                        <span>Thanh toán bằng ví MoMo</span>
                    </div>

                    <hr>
                    <h5 class="mb-3">Thông tin giao hàng</h5>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Người nhận</label>
                        <input type="text" class="form-control bg-light"
                               value="${user.fullName}" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Số điện thoại</label>
                        <input type="text" class="form-control bg-light"
                               value="${user.phoneNumber}" readonly>
                    </div>

                    <div class="mb-4">
                        <label for="shippingAddress" class="form-label fw-semibold">Địa chỉ giao hàng</label>
                        <textarea id="shippingAddress" name="shippingAddress" rows="3"
                                  class="form-control" placeholder="Nhập địa chỉ giao hàng đầy đủ" required></textarea>
                    </div>
                    <div class="summary">
                        <p><span>Tổng tiền:</span> <span>${total}đ</span></p>
                        <p><span>Giảm giá trực tiếp:</span> <span>-0đ</span></p>
                        <p><span>Phí vận chuyển:</span> <span>Miễn phí</span></p>
                        <p class="total">
                            <span>Thành tiền:</span>
                            <span>
                                <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/>₫
                            </span>
                        </p>
                    </div>

                    <input type="hidden" name="total" value="${total}">
                    <c:forEach var="item" items="${selectedItems}">
                        <input type="hidden" name="selectedIds" value="${item.medicineID}">
                    </c:forEach>

                    <button type="submit" class="btn btn-primary checkout-btn mt-3">Hoàn tất đặt hàng</button>
                </form>
            </div>
        </main>
    </body>
</html>
