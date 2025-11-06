
<<<<<<< HEAD
<%@page pageEncoding="UTF-8" %>
=======
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
>>>>>>> origin/HuyTung

<link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../../assets/css/header.css">
<link rel="stylesheet" type="text/css" href="../../assets/css/home.css">


<header class="header">
    <!-- Logo Section -->
    <div class="logo-section">

<<<<<<< HEAD
            <a href="${pageContext.request.contextPath}/home" class="logo-link">
                <img src="${pageContext.request.contextPath}/assets/img/PharmacyLife_1.png" alt="PharmacyLife Logo"
                    class="site-logo">
                <div class="logo-text">
                    PharmacyLife<br>
                    <span class="logo-subtitle">Your Health - Your Life</span>
                </div>
            </a>
        </div>

        <!-- Search Section -->
        <div class="search-section">
            <form action="${pageContext.request.contextPath}/search" method="GET" style="width: 100%;">
                <input type="text" class="search-bar" placeholder="Tìm kiếm sản phẩm..." name="q" id="searchInput">
            </form>
        </div>

        <!-- Navigation Section -->
        <div class="nav-section">
            <% if (session.getAttribute("user") != null) { %>
                <div class="user-menu">
                    <a class="user-trigger" href="${pageContext.request.contextPath}/profile">
                        <span class="avatar"><i class="fas fa-user"></i></span>
                        <span class="name">${sessionScope.user.fullName}</span>
                        <i class="fas fa-chevron-down caret"></i>
                    </a>
                    <div class="user-dropdown">
                        <a class="user-item" href="${pageContext.request.contextPath}/profile">Thông tin cá nhân</a>
                        <% if ("admin".equalsIgnoreCase((String)session.getAttribute("roleName"))) { %>
                            <div style="border-top:1px solid #eef2f7; margin:6px 6px 8px;"></div>
                            <a class="user-item" href="${pageContext.request.contextPath}/product">Quản lí sản phẩm</a>
                            <a class="user-item" href="${pageContext.request.contextPath}/staff">Quản lí nhân viên</a>
                        <% } %>
                        <a class="user-item" href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a>
                    </div>
                </div>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/auth" class="login-btn">
                    <i class="fas fa-user-circle"></i>
                    Đăng nhập
                </a>
            <% } %>
            <a href="${pageContext.request.contextPath}/cart" class="cart-btn">
                <i class="fas fa-shopping-cart"></i>
=======
        <a href="home" class="logo-link">
            <img src="${pageContext.request.contextPath}/assets/img/PharmacyLife_1.png" alt="PharmacyLife Logo"
                 class="site-logo">
            <div class="logo-text">
                PharmacyLife<br>
                <span class="logo-subtitle">Your Health - Your Life</span>
            </div>
        </a>
    </div>

    <!-- Search Section -->
    <div class="search-section">
        <input type="text" class="search-bar" placeholder="Tìm kiếm sản phẩm..." name="search">
    </div>

    <!-- Navigation Section -->
    <div class="nav-section">
        <a href="auth" class="login-btn">
            <i class="fas fa-user-circle"></i>
            <% if (session.getAttribute("user") != null) { %>
            ${sessionScope.user.fullName}
            <% } else { %>
            Đăng nhập
            <% }%>
        </a>
        <!-- Cart Dropdown -->
        <div class="cart-wrapper">
            <a href="cart" class="cart-btn">
                <i class="fas fa-shopping-cart position-relative">
                    <span class="cart-badge" id="cartCount">
                        <c:out value="${cartCount != null ? cartCount : 0}" />
                    </span>
                </i>
>>>>>>> origin/HuyTung
                Giỏ hàng
            </a>

            <!-- Dropdown -->
            <div class="cart-dropdown shadow-sm" id="cartDropdown">
                <div class="cart-header fw-semibold px-3 py-2 border-bottom">Giỏ hàng</div>
                <div class="cart-items" id="miniCartItems">
                    <c:choose>
                        <c:when test="${empty cartItems}">
                            <div class="text-center text-muted py-3 small">Giỏ hàng trống</div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="it" items="${cartItems}">
                                <div class="cart-item d-flex align-items-center p-2 border-bottom">
                                    <img src="${it.imageUrl}" alt="${it.medicineName}" class="cart-img me-2">
                                    <div class="flex-grow-1">
                                        <div class="cart-name text-truncate">${it.medicineName}</div>
                                        <div class="cart-price text-primary fw-semibold">
                                            <fmt:formatNumber value="${it.price}" type="number" groupingUsed="true"/>₫
                                            <small class="text-muted">x${it.quantity}</small>
                                        </div>
                                    </div>
                                    <a href="cart?action=remove&id=${it.medicineID}"
                                       class="text-danger small ms-2"><i class="fas fa-trash"></i></a>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="cart-footer text-center p-2">
                    <a href="cart" class="btn btn-primary btn-sm px-3">Xem giỏ hàng</a>
                </div>
            </div>
        </div>

    </div>
</header>
<script src="${pageContext.request.contextPath}/assets/js/header.js"></script>


    