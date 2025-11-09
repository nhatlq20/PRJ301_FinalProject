<%-- Document : list Created on : Oct 22, 2025, 11:08:04 PM Author : qnhat --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <!-- Main Content -->
        <div class="main-content">
            <!-- Categories Section -->
            <section class="categories-section">
                <h2 class="section-title">Danh Mục Sản Phẩm</h2>
                <div class="categories-grid">
                    <!-- Category 1 -->
                    <div class="category-card" onclick="viewCategory('CAT001')">
                        <img src="<c:url value='/assets/img/category/1.png'/>"
                             alt="Thuốc dị ứng" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc dị ứng</div>
                            <div class="category-count">139 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 2 -->
                    <div class="category-card" onclick="viewCategory('CAT002')">
                        <img src="<c:url value='/assets/img/category/2.png'/>"
                             alt="Thuốc giải độc" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc giải độc, khử độc và hỗ trợ cai nghiện</div>
                            <div class="category-count">7 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 3 -->
                    <div class="category-card" onclick="viewCategory('CAT003')">
                        <img src="<c:url value='/assets/img/category/3.png'/>"
                             alt="Thuốc da liễu" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc da liễu</div>
                            <div class="category-count">289 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 4 -->
                    <div class="category-card" onclick="viewCategory('CAT004')">
                        <img src="<c:url value='/assets/img/category/4.png'/>"
                             alt="Miếng dán" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Miếng dán, cao xoa, dầu</div>
                            <div class="category-count">51 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 5 -->
                    <div class="category-card" onclick="viewCategory('CAT005')">
                        <img src="<c:url value='/assets/img/category/5.png'/>"
                             alt="Cơ xương khớp" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Cơ - xương - khớp</div>
                            <div class="category-count">175 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 6 -->
                    <div class="category-card" onclick="viewCategory('CAT006')">
                        <img src="<c:url value='/assets/img/category/6.png'/>"
                             alt="Thuốc bổ" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc bổ & vitamin</div>
                            <div class="category-count">281 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 7 -->
                    <div class="category-card" onclick="viewCategory('CAT007')">
                        <img src="<c:url value='/assets/img/category/7.png'/>"
                             alt="Thuốc ung thư" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc ung thư</div>
                            <div class="category-count">130 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 8 -->
                    <div class="category-card" onclick="viewCategory('CAT008')">
                        <img src="<c:url value='/assets/img/category/8.png'/>"
                             alt="Thuốc giảm đau" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc giảm đau, hạ sốt, kháng
                                viêm</div>
                            <div class="category-count">384 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 9 -->
                    <div class="category-card" onclick="viewCategory('CAT009')">
                        <img src="<c:url value='/assets/img/category/9.png'/>"
                             alt="Thuốc hô hấp" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc hô hấp</div>
                            <div class="category-count">310 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 10 -->
                    <div class="category-card" onclick="viewCategory('CAT010')">
                        <img src="<c:url value='/assets/img/category/10.png'/>"
                             alt="Thuốc kháng sinh" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc kháng sinh, kháng nấm</div>
                            <div class="category-count">556 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 11 -->
                    <div class="category-card" onclick="viewCategory('CAT011')">
                        <img src="<c:url value='/assets/img/category/11.png'/>"
                             alt="Thuốc Mắt Tai Mũi Họng" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc Mắt, Tai, Mũi, Họng</div>
                            <div class="category-count">225 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 12 -->
                    <div class="category-card" onclick="viewCategory('CAT012')">
                        <img src="<c:url value='/assets/img/category/12.png'/>"
                             alt="Thuốc hệ thần kinh" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc hệ thần kinh</div>
                            <div class="category-count">324 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 13 -->
                    <div class="category-card" onclick="viewCategory('CAT013')">
                        <img src="<c:url value='/assets/img/category/13.png'/>"
                             alt="Thuốc tiêm chích" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc tiêm chích & dịch truyền
                            </div>
                            <div class="category-count">143 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 14 -->
                    <div class="category-card" onclick="viewCategory('CAT014')">
                        <img src="<c:url value='/assets/img/category/14.png'/>"
                             alt="Thuốc tiêu hoá" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc tiêu hoá & gan mật</div>
                            <div class="category-count">650 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 15 -->
                    <div class="category-card" onclick="viewCategory('CAT015')">
                        <img src="<c:url value='/assets/img/category/15.png'/>"
                             alt="Thuốc tim mạch" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc tim mạch & máu</div>
                            <div class="category-count">858 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 16 -->
                    <div class="category-card" onclick="viewCategory('CAT016')">
                        <img src="<c:url value='/assets/img/category/16.png'/>"
                             alt="Thuốc tiết niệu" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc tiết niệu - sinh dục</div>
                            <div class="category-count">248 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 17 -->
                    <div class="category-card" onclick="viewCategory('CAT017')">
                        <img src="<c:url value='/assets/img/category/17.png'/>"
                             alt="Thuốc tê bôi" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc tê bôi</div>
                            <div class="category-count">1 sản phẩm</div>
                        </div>
                    </div>

                    <!-- Category 18 -->
                    <div class="category-card" onclick="viewCategory('CAT018')">
                        <img src="<c:url value='/assets/img/category/18.png'/>"
                             alt="Thuốc trị tiểu đường" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc trị tiểu đường</div>
                            <div class="category-count">186 sản phẩm</div>
                        </div>
                    </div>
                </div>
            </section>
        </div>

        <!-- Sản phẩm bán chạy nhất -->
        <section class="featured-products py-5">
            <div id="bestsellers" class="container">
                <div class="text-center mb-4">
                    <h3 class="fw-bold text-danger">
                        <i class="bi bi-star-fill me-2 fs-4"></i>
                        Sản phẩm bán chạy nhất
                    </h3>
                </div>
                <div class="bestsellers-grid">
                    <c:if test="${not empty bestSellers}">
                        <c:forEach var="m" items="${bestSellers}" varStatus="vs">
                            <c:choose>
                                <c:when test="${vs.index == 0}">
                                    <!-- 1 - Card lớn -->
                                    <div class="bestseller-card bestseller-card-large">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="<c:out value='${m.imageUrl}'/>"
                                                 alt="<c:out value='${m.medicineName}'/>"
                                                 class="card-img-top p-3 product-img"
                                                 onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
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
                                </c:when>
                                <c:otherwise>
                                    <!-- Small cards -->
                                    <div class="bestseller-card bestseller-card-small">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="<c:out value='${m.imageUrl}'/>"
                                                 alt="<c:out value='${m.medicineName}'/>"
                                                 class="card-img-top p-3 product-img"
                                                 onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
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
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </section>

        <!-- Danh mục nổi bật -->
        <section class="featured-products py-5 bg-light">
            <div id="featured-categories" class="container">
                <div class="d-flex align-items-center mb-4">
                    <i class="bi bi-grid-fill text-primary me-2 fs-4"></i>
                    <h3 class="fw-bold m-0">Danh mục nổi bật</h3>
                </div>
                <div class="row g-4 text-center">
                    <c:forEach var="m" items="${featuredProducts}">
                        <div class="col-12 col-sm-6 col-lg-2">
                            <div class="card product-card h-100 border-0 shadow-sm">
                                <img src="<c:out value='${m.imageUrl}'/>"
                                     alt="<c:out value='${m.medicineName}'/>"
                                     class="card-img-top p-3 product-img"
                                     onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
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
                                <img src="<c:out value='${m.imageUrl}'/>"
                                     alt="<c:out value='${m.medicineName}'/>"
                                     class="card-img-top p-3 product-img"
                                     onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
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

        <!-- Bệnh theo mùa -->
        <section class="featured-products py-5 bg-light">
            <div id="seasonal" class="container">
                <div class="d-flex align-items-center mb-4">
                    <i class="bi bi-calendar-fill text-primary me-2 fs-4"></i>
                    <h3 class="fw-bold m-0">Bệnh theo mùa</h3>
                </div>
                <div class="row g-4 text-center">
                    <c:forEach var="m" items="${seasonalProducts}">
                        <div class="col-12 col-sm-6 col-lg-2">
                            <div class="card product-card h-100 border-0 shadow-sm">
                                <img src="<c:out value='${m.imageUrl}'/>"
                                     alt="<c:out value='${m.medicineName}'/>"
                                     class="card-img-top p-3 product-img"
                                     onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
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
                                <img src="<c:out value='${m.imageUrl}'/>"
                                     alt="<c:out value='${m.medicineName}'/>"
                                     class="card-img-top p-3 product-img"
                                     onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
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
                                <img src="<c:out value='${m.imageUrl}'/>"
                                     alt="<c:out value='${m.medicineName}'/>"
                                     class="card-img-top p-3 product-img"
                                     onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
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
                                <img src="<c:out value='${m.imageUrl}'/>"
                                     alt="<c:out value='${m.medicineName}'/>"
                                     class="card-img-top p-3 product-img"
                                     onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
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
                // Redirect to product page with category filter
                window.location.href = 'product?category=' + categoryId;
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
    </body>

</html>


<section class="featured-products py-5">
    <div id="today-featured" class="container">
        <div class="d-flex align-items-center mb-4">
            <i class="bi bi-plus-circle-fill text-primary me-2 fs-4"></i>
            <h3 class="fw-bold m-0">Sản phẩm nổi bật hôm nay</h3>
        </div>

        <div class="row g-4 text-center">
            <c:forEach var="m" items="${todayFeaturedProducts}">
                <div class="col-12 col-sm-6 col-lg-2">
                    <div class="card product-card h-100 border-0 shadow-sm">
                        <img src="<c:out value='${m.imageUrl}'/>"
                             alt="<c:out value='${m.medicineName}'/>" class="card-img-top p-3 product-img"
                             onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
                        <div class="card-body" onclick="window.location.href = '${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'" style="cursor:pointer;">
                            <h6 class="card-title"><c:out value='${m.medicineName}'/></h6>
                            <c:choose>
                                <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                    <p class="text-primary fw-semibold mb-1"><fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ / <c:out value='${m.unit}'/></p>
                                    <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}">Chọn mua</a>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted fw-semibold mb-1">Cần được sự tư vấn của bác sĩ</p>
                                    <a class="btn btn-primary w-100 mt-2" href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}">Xem chi tiết</a>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                    <p class="text-primary fw-semibold mb-1"><fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ / <c:out value='${m.unit}'/></p>
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
    <%@ include file="../common/footer.jsp" %>
</body>

</html>

