
<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../assets/css/header.css">
    <link rel="stylesheet" type="text/css" href="../../assets/css/home.css">


    <header class="header">
        <!-- Logo Section -->
        <div class="logo-section">

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
            <% if (session.getAttribute("user") != null) { %>
                <div class="user-menu">
                    <a class="user-trigger" href="${pageContext.request.contextPath}/profile">
                        <span class="avatar"><i class="fas fa-user"></i></span>
                        <span class="name">${sessionScope.user.fullName}</span>
                        <i class="fas fa-chevron-down caret"></i>
                    </a>
                    <div class="user-dropdown">
                        <a class="user-item" href="${pageContext.request.contextPath}/profile">Thông tin cá nhân</a>
                        <a class="user-item" href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a>
                    </div>
                </div>
            <% } else { %>
                <a href="auth" class="login-btn">
                    <i class="fas fa-user-circle"></i>
                    Đăng nhập
                </a>
            <% } %>
            <a href="cart" class="cart-btn">
                <i class="fas fa-shopping-cart"></i>
                Giỏ hàng
            </a>
        </div>
    </header>

    