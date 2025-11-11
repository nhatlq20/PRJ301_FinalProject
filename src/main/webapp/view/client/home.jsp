<%-- Document : list Created on : Oct 22, 2025, 11:08:04 PM Author : qnhat --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PharmacyLife - Your Health Your Life</title>
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
        <link href="<c:url value='/assets/css/header.css'/>" rel="stylesheet">
        <link href="<c:url value='/assets/css/home.css'/>" rel="stylesheet">
        <link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">
        <link href="<c:url value='/assets/css/season-section.css'/>" rel="stylesheet">
    </head>


    <body>
        <%@ include file="../common/header.jsp" %>
        <nav class="nav-categories">
            <ul>
                <!-- data-duration values are milliseconds; adjust per-section below -->
                <li><a href="#bestsellers" class="active" data-duration="500">Sản phẩm bán chạy nhất</a></li>
                <li><a href="#featured-categories" data-duration="550">Danh mục nổi bật</a></li>
                <li><a href="#favorite-brands" data-duration="600">Thương hiệu yêu thích</a></li>
                <li><a href="#health-corner" data-duration="650">Góc sức khỏe</a></li>
                <li><a href="#cardio" data-duration="700">Thuốc tim mạch</a></li>
                <li><a href="#supplements" data-duration="750">Thuốc bổ &amp; vitamin</a></li>
                <li><a href="#today-featured" data-duration="800">Sản phẩm nổi bật hôm nay</a></li>
            </ul>
        </nav>

        <!-- 🔹 Banner quảng cáo dưới thanh danh mục -->
        <!-- 🔹 Banner ngang: 1 to bên trái, 2 nhỏ bên phải -->
        <section class="main-banner">
            <!-- Banner bên trái (slider) -->
            <div id="mainBannerCarousel" class="carousel slide banner-left" data-bs-ride="carousel" data-bs-interval="4000">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="<c:url value='/assets/img/banner-left-1.png'/>" 
                             alt="Banner 1" class="banner-img">
                    </div>
                    <div class="carousel-item">
                        <img src="<c:url value='/assets/img/banner-left-2.png'/>" 
                             alt="Banner 2" class="banner-img">
                    </div>
                    <div class="carousel-item">
                        <img src="<c:url value='/assets/img/banner-left-3.png'/>" 
                             alt="Banner 3" class="banner-img">
                        </div>
                    </div>

                <!-- Nút điều hướng -->
                <button class="carousel-control-prev" type="button" data-bs-target="#mainBannerCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#mainBannerCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
                    </div>

            <div class="banner-right">
                <div class="banner-small">
                    <img src="<c:url value='/assets/img/banner-top.png'/>"
                         alt="Banner nhỏ trên" class="banner-img">
                        </div>
                <div class="banner-small">
                    <img src="<c:url value='/assets/img/banner-bot.png'/>"
                         alt="Banner nhỏ dưới" class="banner-img">
                        </div>
                    </div>
        </section>




        <!-- Main Content -->
        <div class="main-content">
            <section class="categories-section">
                <h2 class="section-title">Danh Mục Sản Phẩm</h2>
                <div class="categories-grid">
                    <c:forEach var="c" items="${listCategory}" varStatus="loop">
                        <div class="category-card" onclick="viewCategory('<c:out value="${c.categoryID}"/>')">
                            <img src="<c:url value='/assets/img/category/${loop.index + 1}.png'/>"
                                 alt="<c:out value='${c.categoryName}'/>" class="category-image">
                        <div class="category-info">
                                <div class="category-name"><c:out value="${c.categoryName}"/></div>
                                <div class="category-count">${c.productCount} sản phẩm</div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </section>
        </div>



        <section class="bestseller-section">
            <div class="bestseller-header">
                <h3><i class="bi bi-star-fill"></i> Sản phẩm bán chạy</h3>
                </div>

            <div class="bestseller-layout">
                <!-- 🔹 Sản phẩm đầu tiên (to) -->
                    <c:if test="${not empty bestSellers}">
                    <div class="bestseller-left">
                        <c:set var="firstProduct" value="${bestSellers[0]}" />
                        <div class="bestseller-card bestseller-big">
                            <div class="card-top" 
                                 onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${firstProduct.medicineID}'">
                                <c:choose>
                                    <c:when test="${not empty firstProduct.imageUrl}">
                                        <c:set var="imageUrlTrimmed" value="${fn:trim(firstProduct.imageUrl)}"/>
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
                                             alt="<c:out value='${firstProduct.medicineName}'/>" 
                                             class="bestseller-img-big"
                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/img/no-image.png"
                                             alt="<c:out value='${firstProduct.medicineName}'/>" 
                                             class="bestseller-img-big">
                                    </c:otherwise>
                                </c:choose>
                                <h5 class="bestseller-name"><c:out value='${firstProduct.medicineName}'/></h5>
                            </div>
                            <div class="card-bottom">
                                <c:choose>
                                    <c:when test="${firstProduct.sellingPrice != null && firstProduct.sellingPrice > 0}">
                                        <p class="bestseller-price">
                                            <fmt:formatNumber value="${firstProduct.sellingPrice}" type="number" groupingUsed="true"/>₫ /
                                            <c:out value='${firstProduct.unit}'/>
                                        </p>
                                        <a class="btn-buy-blue" 
                                           href="${pageContext.request.contextPath}/cart?action=add&id=${firstProduct.medicineID}">
                                            Chọn mua
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="bestseller-price text-muted">Cần được sự tư vấn của bác sĩ</p>
                                        <a class="btn-buy-blue" 
                                           href="${pageContext.request.contextPath}/product/detail?id=${firstProduct.medicineID}">
                                            Xem chi tiết
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                </c:if>

                <!-- 🔹 4 sản phẩm nhỏ kế tiếp -->
                <div class="bestseller-right">
                    <c:forEach var="m" items="${bestSellers}" varStatus="vs" begin="1" end="4">
                        <div class="bestseller-card">
                            <div class="card-top" 
                                 onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'">
                                <c:choose>
                                    <c:when test="${not empty m.imageUrl}">
                                        <c:set var="imageUrlTrimmed" value="${fn:trim(m.imageUrl)}"/>
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
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="bestseller-img"
                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/img/no-image.png"
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="bestseller-img">
                                    </c:otherwise>
                                </c:choose>
                                <h6 class="bestseller-name"><c:out value='${m.medicineName}'/></h6>
                            </div>
                            <div class="card-bottom">
                                <c:choose>
                                    <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                        <p class="bestseller-price">
                                            <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ /
                                            <c:out value='${m.unit}'/>
                                        </p>
                                        <a class="btn-buy-blue" 
                                           href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}">
                                            Chọn mua
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="bestseller-price text-muted">Cần được sự tư vấn của bác sĩ</p>
                                        <a class="btn-buy-blue" 
                                           href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}">
                                            Xem chi tiết
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                        </div>
                                    </div>
                        </c:forEach>
                </div>
            </div>
        </section>







        <!-- Danh mục nổi bật -->
        <section class="featured-wrapper py-5">
            <div class="featured-products container">
                <div class="d-flex align-items-center justify-content-start mb-4">
                    <h3 class="fw-bold m-0 text-primary">🌟 Sản phẩm nổi bật</h3>
                </div>
                <div class="row g-4 text-center">
                    <c:forEach var="m" items="${featuredProducts}">
                        <div class="col-12 col-sm-6 col-lg-2">
                            <div class="card product-card h-100 border-0 shadow-sm">
                                <c:choose>
                                    <c:when test="${not empty m.imageUrl}">
                                        <c:set var="imageUrlTrimmed" value="${fn:trim(m.imageUrl)}"/>
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
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" 
                                             style="cursor:pointer;"
                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/img/no-image.png"
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" 
                                             style="cursor:pointer;">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body" onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
                                    <h6 class="card-title"><c:out value='${m.medicineName}'/></h6>
                                    <c:choose>
                                        <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                            <p class="text-primary fw-semibold mb-1">
                                                <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ / <c:out value='${m.unit}'/>
                                            </p>
                                            <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}">Chọn mua</a>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted fw-semibold mb-1">Cần được sự tư vấn của bác sĩ</p>
                                            <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}">Xem chi tiết</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>


        <!-- Thương hiệu yêu thích -->
        <section class="featured-products py-5">
            <div id="favorite-brands" class="container">
                <div class="d-flex align-items-center mb-4">
                    <i class="bi bi-heart-fill text-primary me-2 fs-4"></i>
                    <h3 class="fw-bold m-0">Thương hiệu yêu thích</h3>
                </div>
                <div class="row g-4 text-center">
                    <c:forEach var="m" items="${favoriteBrandsProducts}">
                        <div class="col-12 col-sm-6 col-lg-2">
                            <div class="card product-card h-100 border-0 shadow-sm">
                                <c:choose>
                                    <c:when test="${not empty m.imageUrl}">
                                        <c:set var="imageUrlTrimmed" value="${fn:trim(m.imageUrl)}"/>
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
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" 
                                             style="cursor:pointer;"
                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/img/no-image.png"
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" 
                                             style="cursor:pointer;">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body" onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
                                    <h6 class="card-title"><c:out value='${m.medicineName}'/></h6>
                                    <c:choose>
                                        <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                            <p class="text-primary fw-semibold mb-1">
                                                <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ / <c:out value='${m.unit}'/>
                                            </p>
                                            <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}">Chọn mua</a>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted fw-semibold mb-1">Cần được sự tư vấn của bác sĩ</p>
                                            <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}">Xem chi tiết</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>




        <section class="season-section py-5">
            <div class="container">
                <h3 class="fw-bold text-primary mb-4">
                    <i class="bi bi-calendar-heart me-2"></i>Bệnh theo mùa
                </h3>

                <!-- Tabs -->
                <ul class="nav nav-tabs mb-4" id="diseaseTabs">
                    <li class="nav-item">
                        <a class="nav-link active fw-semibold" data-bs-toggle="tab" href="#tab-dengue">Sốt xuất huyết</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" data-bs-toggle="tab" href="#tab-flu">Cúm mùa</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" data-bs-toggle="tab" href="#tab-skin">Da liễu & Dị ứng</a>
                    </li>
                </ul>

                <!-- Nội dung 3 tab -->
                <div class="tab-content">

                    <!-- 🩸 Sốt xuất huyết -->
                    <div class="tab-pane fade show active" id="tab-dengue">
                        <div class="row align-items-center g-4">
                            <!-- Ảnh bên trái -->
                            <div class="col-lg-3 col-md-12 text-center">
                                <img src="${pageContext.request.contextPath}/assets/img/benh-sot-xuat-huyet.png"
                                     alt="Sốt xuất huyết" class="img-fluid disease-left-img">
                            </div>

                            <!-- Sản phẩm bên phải -->
                            <div class="col-lg-9 col-md-12">
                                <div class="row g-3">
                                    <c:forEach var="m" items="${dengueMedicines}" varStatus="vs" end="3">
                                        <div class="col-md-3 col-sm-6">
                                            <div class="disease-card">
                                                <!-- Phần trên: ảnh + tên -->
                                                <div class="card-top"
                                                     onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'">
                                                    <c:choose>
                                                        <c:when test="${not empty m.imageUrl}">
                                                            <c:set var="imageUrlTrimmed" value="${fn:trim(m.imageUrl)}"/>
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
                                                            <img src="<c:out value='${imgSrc}'/>" alt="${m.medicineName}" class="disease-img"
                                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/assets/img/no-image.png" alt="${m.medicineName}" class="disease-img">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <p class="name">${m.medicineName}</p>
                                                </div>

                                                <!-- Phần dưới: giá + nút -->
                                                <div class="card-bottom">
                                                    <c:choose>
                                                        <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                                            <p class="price">
                                                                <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ / ${m.unit}
                                                            </p>
                                                            <a href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}"
                                                               class="btn-buy-blue">Chọn mua</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="price text-muted">Cần được sự tư vấn của bác sĩ</p>
                                                            <a href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}"
                                                               class="btn-buy-blue">Xem chi tiết</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 🤧 Cúm mùa -->
                    <div class="tab-pane fade" id="tab-flu">
                        <div class="row align-items-center g-4">
                            <!-- Ảnh bên trái -->
                            <div class="col-lg-3 col-md-12 text-center">
                                <img src="${pageContext.request.contextPath}/assets/img/benh-cum-mua.png"
                                     alt="Cúm mùa" class="img-fluid disease-left-img">
                            </div>

                            <!-- Sản phẩm bên phải -->
                            <div class="col-lg-9 col-md-12">
                                <div class="row g-3">
                                    <c:forEach var="m" items="${fluMedicines}" varStatus="vs" end="3">
                                        <div class="col-md-3 col-sm-6">
                                            <div class="disease-card">
                                                <!-- Phần trên: ảnh + tên -->
                                                <div class="card-top"
                                                     onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'">
                                                    <c:choose>
                                                        <c:when test="${not empty m.imageUrl}">
                                                            <c:set var="imageUrlTrimmed" value="${fn:trim(m.imageUrl)}"/>
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
                                                            <img src="<c:out value='${imgSrc}'/>" alt="${m.medicineName}" class="disease-img"
                                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/assets/img/no-image.png" alt="${m.medicineName}" class="disease-img">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <p class="name">${m.medicineName}</p>
                                                </div>

                                                <!-- Phần dưới: giá + nút -->
                                                <div class="card-bottom">
                                                    <c:choose>
                                                        <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                                            <p class="price">
                                                                <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ / ${m.unit}
                                                            </p>
                                                            <a href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}"
                                                               class="btn-buy-blue">Chọn mua</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="price text-muted">Cần được sự tư vấn của bác sĩ</p>
                                                            <a href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}"
                                                               class="btn-buy-blue">Xem chi tiết</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 🌿 Da liễu & Dị ứng -->
                    <div class="tab-pane fade" id="tab-skin">
                        <div class="row align-items-center g-4">
                            <!-- Ảnh bên trái -->
                            <div class="col-lg-3 col-md-12 text-center">
                                <img src="${pageContext.request.contextPath}/assets/img/benh-da-lieu.png"
                                     alt="Da liễu & Dị ứng" class="img-fluid disease-left-img">
                            </div>

                            <!-- Sản phẩm bên phải -->
                            <div class="col-lg-9 col-md-12">
                                <div class="row g-3">
                                    <c:forEach var="m" items="${skinMedicines}" varStatus="vs" end="3">
                                        <div class="col-md-3 col-sm-6">
                                            <div class="disease-card">
                                                <!-- Phần trên: ảnh + tên -->
                                                <div class="card-top"
                                                     onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'">
                                                    <c:choose>
                                                        <c:when test="${not empty m.imageUrl}">
                                                            <c:set var="imageUrlTrimmed" value="${fn:trim(m.imageUrl)}"/>
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
                                                            <img src="<c:out value='${imgSrc}'/>" alt="${m.medicineName}" class="disease-img"
                                                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/assets/img/no-image.png" alt="${m.medicineName}" class="disease-img">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <p class="name">${m.medicineName}</p>
                                                </div>

                                                <!-- Phần dưới: giá + nút -->
                                                <div class="card-bottom">
                                                    <c:choose>
                                                        <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                                            <p class="price">
                                                                <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ / ${m.unit}
                                                            </p>
                                                            <a href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}"
                                                               class="btn-buy-blue">Chọn mua</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="price text-muted">Cần được sự tư vấn của bác sĩ</p>
                                                            <a href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}"
                                                               class="btn-buy-blue">Xem chi tiết</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                        </div>
                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>





        <!-- Góc sức khỏe -->
        <section class="featured-products py-5">
            <div id="health-corner" class="container">
                <div class="d-flex align-items-center mb-4">
                    <i class="bi bi-heart-pulse-fill text-primary me-2 fs-4"></i>
                    <h3 class="fw-bold m-0">Góc sức khỏe</h3>
                </div>
                <div class="row g-4 text-center">
                    <c:forEach var="m" items="${healthCornerProducts}">
                        <div class="col-12 col-sm-6 col-lg-2">
                            <div class="card product-card h-100 border-0 shadow-sm">
                                <c:choose>
                                    <c:when test="${not empty m.imageUrl}">
                                        <c:set var="imageUrlTrimmed" value="${fn:trim(m.imageUrl)}"/>
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
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" 
                                             style="cursor:pointer;"
                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/img/no-image.png"
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" 
                                             style="cursor:pointer;">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body" onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
                                    <h6 class="card-title"><c:out value='${m.medicineName}'/></h6>
                                    <c:choose>
                                        <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                            <p class="text-primary fw-semibold mb-1">
                                                <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ / <c:out value='${m.unit}'/>
                                            </p>
                                            <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}">Chọn mua</a>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted fw-semibold mb-1">Cần được sự tư vấn của bác sĩ</p>
                                            <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}">Xem chi tiết</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- Thuốc tim mạch -->
        <section class="featured-products py-5 bg-light">
            <div id="cardio" class="container">
                <div class="d-flex align-items-center mb-4">
                    <i class="bi bi-heart-fill text-primary me-2 fs-4"></i>
                    <h3 class="fw-bold m-0">Thuốc tim mạch</h3>
                </div>
                <div class="row g-4 text-center">
                    <c:forEach var="m" items="${cardioProducts}">
                        <div class="col-12 col-sm-6 col-lg-2">
                            <div class="card product-card h-100 border-0 shadow-sm">
                                <c:choose>
                                    <c:when test="${not empty m.imageUrl}">
                                        <c:set var="imageUrlTrimmed" value="${fn:trim(m.imageUrl)}"/>
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
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" 
                                             style="cursor:pointer;"
                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/img/no-image.png"
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" 
                                             style="cursor:pointer;">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body" onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
                                    <h6 class="card-title"><c:out value='${m.medicineName}'/></h6>
                                    <c:choose>
                                        <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                            <p class="text-primary fw-semibold mb-1">
                                                <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ / <c:out value='${m.unit}'/>
                                            </p>
                                            <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}">Chọn mua</a>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted fw-semibold mb-1">Cần được sự tư vấn của bác sĩ</p>
                                            <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}">Xem chi tiết</a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- Thuốc bổ & vitamin -->
        <section class="featured-products py-5">
            <div id="supplements" class="container">
                <div class="d-flex align-items-center mb-4">
                    <i class="bi bi-capsule text-primary me-2 fs-4"></i>
                    <h3 class="fw-bold m-0">Thuốc bổ & vitamin</h3>
                </div>
                <div class="row g-4 text-center">
                    <c:forEach var="m" items="${supplementsProducts}">
                        <div class="col-12 col-sm-6 col-lg-2">
                            <div class="card product-card h-100 border-0 shadow-sm">
                                <c:choose>
                                    <c:when test="${not empty m.imageUrl}">
                                        <c:set var="imageUrlTrimmed" value="${fn:trim(m.imageUrl)}"/>
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
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" 
                                             style="cursor:pointer;"
                                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/img/no-image.png"
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" 
                                             style="cursor:pointer;">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body" onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
                                    <h6 class="card-title"><c:out value='${m.medicineName}'/></h6>
                                    <p class="text-primary fw-semibold mb-1">
                                        <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ / <c:out value='${m.unit}'/>
                                    </p>
                                    <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}">Chọn mua</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <script>
            function viewCategory(categoryId) {
                console.log('viewCategory called with categoryId:', categoryId);
                console.log('categoryId type:', typeof categoryId);
                console.log('categoryId length:', categoryId ? categoryId.length : 0);
                
                // Redirect to product page with category filter
                if (categoryId && categoryId.trim() !== '') {
                    var contextPath = '${pageContext.request.contextPath}';
                    var url = contextPath + '/product?category=' + encodeURIComponent(categoryId.trim());
                    console.log('Redirecting to URL:', url);
                    window.location.href = url;
                } else {
                    console.error('Invalid categoryId:', categoryId);
                }
            }

            // Smooth scroll function
            function smoothScroll(target, duration) {
                var targetElement = document.querySelector(target);
                var targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset;
                var startPosition = window.pageYOffset;
                var distance = targetPosition - startPosition;
                var startTime = null;

                function animation(currentTime) {
                    if (startTime === null)
                        startTime = currentTime;
                    var timeElapsed = currentTime - startTime;
                    var run = ease(timeElapsed, startPosition, distance, duration);
                    window.scrollTo(0, run);
                    if (timeElapsed < duration)
                        requestAnimationFrame(animation);
                }

                // Easing function
                function ease(t, b, c, d) {
                    t /= d / 2;
                    if (t < 1)
                        return c / 2 * t * t + b;
                    t--;
                    return -c / 2 * (t * (t - 2) - 1) + b;
                }

                requestAnimationFrame(animation);
            }

            // Add click event listeners to all nav links
            document.querySelectorAll('.nav-categories a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const targetId = this.getAttribute('href');
                    // Read per-link duration (ms) from data-duration attribute; fallback to 500ms, clamp 200-900ms
                    const raw = parseInt(this.dataset.duration, 10) || 500;
                    const duration = Math.min(Math.max(raw, 200), 900);
                    smoothScroll(targetId, duration);

                    // Update active state
                    document.querySelectorAll('.nav-categories a').forEach(a => a.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            document.addEventListener('DOMContentLoaded', function () {
                var nameInput = document.getElementById('nameInput');
                var saveBtn = document.getElementById('saveNameBtn');
                var clearBtn = document.getElementById('clearNameBtn');
                var greeting = document.getElementById('greeting');
                var userNameSpan = document.getElementById('userName');

                function showGreeting(name) {
                    if (!name)
                        return;
                    userNameSpan.textContent = name;
                    greeting.style.display = 'block';
                }

                // Load saved name from localStorage
                var saved = null;
                try {
                    saved = localStorage.getItem('pharmacy_user_name');
                } catch (e) {
                    console.warn('localStorage not available', e);
                }
                if (saved) {
                    nameInput.value = saved;
                    showGreeting(saved);
                }

                saveBtn.addEventListener('click', function () {
                    var val = nameInput.value && nameInput.value.trim();
                    if (!val)
                        return;
                    try {
                        localStorage.setItem('pharmacy_user_name', val);
                    } catch (e) {
                        console.warn('Could not save name', e);
                    }
                    showGreeting(val);
                    // Smooth scroll down to categories
                    var target = document.querySelector('.categories-section');
                    if (target && typeof target.scrollIntoView === 'function') {
                        target.scrollIntoView({behavior: 'smooth'});
                    }
                });

                clearBtn.addEventListener('click', function () {
                    nameInput.value = '';
                    try {
                        localStorage.removeItem('pharmacy_user_name');
                    } catch (e) {
                    }
                    greeting.style.display = 'none';
                });
            });
        </script>



<section class="featured-products py-5">


    <!-- 🔹 Floating AI Chat Icon -->
    <div id="chat-launcher">
                <img src="${pageContext.request.contextPath}/assets/img/banner/chatbox.png" alt="Chatbot" />
    </div>

    <!-- Chat Window -->
    <div id="chat-window" class="hidden">
        <div class="chat-header">
                    <img src="${pageContext.request.contextPath}/assets/img/banner/chatbox.png" alt="Logo" class="chat-logo">
            <span>Chat với Dược Sĩ Pharmacy</span>
            <button id="close-chat">&times;</button>
        </div>

        <div class="chat-body" id="chat-body">
            <div class="chat-placeholder">
                <p>Xin chào 👋<br>Bạn cần hỗ trợ gì hôm nay?</p>
            </div>
        </div>

        <div class="chat-footer">
            <input type="text" id="chat-input" placeholder="Nhập tin nhắn..." />
            <button id="send-btn"><i class="bi bi-send-fill"></i></button>
        </div>
    </div>

    <%@ include file="../common/footer.jsp" %>
    </body>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/ai.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/chatbox.js"></script>

</html>

