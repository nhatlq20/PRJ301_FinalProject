<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="../../assets/css/header.css">
<link rel="stylesheet" type="text/css" href="../../assets/css/home.css">
<link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">



<header class="header">
    <!-- Logo Section -->
    <div class="logo-section">

    <a href="home" class="logo-link">
        <img src="${pageContext.request.contextPath}/assets/img/PharmacyLife_1.png" alt="PharmacyLife Logo" class="site-logo">
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
        <a href="auth" class="nav-link">
            <i class="fas fa-user-circle"></i>
            Login
        </a>
        <a href="cart" class="nav-link cart-link">
            <i class="fas fa-shopping-cart"></i>
            Giỏ hàng
        </a>
    </div>
</header>
