<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm theo danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f7fa;
        }

        .breadcrumb {
            background: none;
            padding-left: 0;
        }

        .category-title {
            font-weight: 700;
            color: #2a60e8;
        }

        .product-card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            background: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            height: 100%;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
        }

        .product-img {
            height: 180px;
            object-fit: contain;
            margin-top: 10px;
        }

        .product-name {
            font-size: 15px;
            font-weight: 600;
            color: #222;
            height: 45px;
            overflow: hidden;
        }

        .product-price {
            color: #1d4ed8;
            font-weight: 700;
            font-size: 16px;
        }

        .btn-buy {
            background-color: #2a60e8;
            border: none;
            font-weight: 600;
            width: 100%;
            padding: 10px 0;
            border-radius: 10px;
            transition: background 0.2s ease;
        }

        .btn-buy:hover {
            background-color: #1746c9;
        }
    </style>
    <link href="${pageContext.request.contextPath}/assets/css/header.css" rel="stylesheet">
</head>

<body>
    <%@ include file="../common/header.jsp" %>
<div class="container py-5">

    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/home" class="text-decoration-none text-muted">
                    Trang chủ
                </a>
            </li>
            <li class="breadcrumb-item active text-primary fw-semibold" aria-current="page">
                <c:out value="${category.categoryName}" default="Danh mục"/>
            </li>
        </ol>
    </nav>

    <!-- Tiêu đề -->
    <div class="text-center mb-5">
        <h3 class="category-title">
            <i class="bi bi-box-seam me-2"></i>
            Danh mục: <c:out value="${category.categoryName}" default="Danh mục"/>
        </h3>
    </div>

    <!-- Debug info -->
    <c:if test="${not empty category}">
        <div style="background:#fff3cd;padding:10px;margin:10px 0;border:1px solid #ffc107;">
            <strong>Debug Info:</strong><br>
            Category: <c:out value="${category.categoryID}"/> - <c:out value="${category.categoryName}"/><br>
            Medicines list is empty?: ${empty medicines}<br>
            Medicines is null?: ${medicines == null}<br>
            Medicines count: <c:choose><c:when test="${medicines != null}">${medicines.size()}</c:when><c:otherwise>null</c:otherwise></c:choose>
        </div>
    </c:if>

    <!-- Danh sách sản phẩm -->
    <c:choose>
        <c:when test="${medicines != null && not empty medicines}">
            <div class="row g-4">
                <c:forEach var="m" items="${medicines}">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="product-card text-center p-3 d-flex flex-column">
                            <c:choose>
                                <c:when test="${not empty m.imageUrl}">
                                    <c:set var="imageUrlTrimmed" value="${fn:trim(m.imageUrl)}"/>
                                    <c:set var="imgSrc" value=""/>
                                    
                                    <c:choose>
                                        <c:when test="${fn:startsWith(imageUrlTrimmed, 'http://') or fn:startsWith(imageUrlTrimmed, 'https://')}">
                                            <%-- imageUrl là URL đầy đủ --%>
                                            <c:set var="imgSrc" value="${imageUrlTrimmed}"/>
                                        </c:when>
                                        <c:when test="${fn:startsWith(imageUrlTrimmed, '/')}">
                                            <%-- imageUrl bắt đầu bằng /, cần thêm context path --%>
                                            <c:set var="imgSrc" value="${pageContext.request.contextPath}${imageUrlTrimmed}"/>
                                        </c:when>
                                        <c:when test="${fn:contains(imageUrlTrimmed, 'assets/img')}">
                                            <%-- imageUrl chứa assets/img nhưng chưa có context path --%>
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
                                            <%-- imageUrl chỉ là tên file hoặc đường dẫn tương đối, cần thêm đường dẫn --%>
                                            <c:set var="imgSrc" value="${pageContext.request.contextPath}/assets/img/${imageUrlTrimmed}"/>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <img src="<c:out value='${imgSrc}'/>"
                                         alt="<c:out value='${m.medicineName}'/>"
                                         class="product-img w-100"
                                         onerror="console.error('Image load error:', this.src); this.onerror=null; this.src='${pageContext.request.contextPath}/assets/img/no-image.png';"
                                         onclick="window.location.href='${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'"
                                         style="cursor:pointer;background:#f0f0f0;"
                                         onload="this.style.background='transparent'; console.log('Image loaded:', this.src);"/>
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/img/no-image.png"
                                         alt="<c:out value='${m.medicineName}'/>"
                                         class="product-img w-100"
                                         onclick="window.location.href='${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'"
                                         style="cursor:pointer;">
                                </c:otherwise>
                            </c:choose>

                            <div class="mt-3 flex-grow-1 d-flex flex-column justify-content-between">
                                <div>
                                    <div class="product-name mb-2">
                                        <c:out value="${m.medicineName}"/>
                                    </div>

                                    <c:choose>
                                        <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                            <p class="product-price mb-1">
                                                <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫
                                                <span class="text-muted fs-6"> / <c:out value="${m.unit}"/></span>
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted fw-semibold mb-1">Cần được sự tư vấn của bác sĩ</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <c:choose>
                                    <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                        <a href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}"
                                           class="btn btn-buy mt-2">
                                            <i class="bi bi-cart3 me-1"></i> Chọn mua
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}"
                                           class="btn btn-buy mt-2">
                                            <i class="bi bi-info-circle me-1"></i> Xem chi tiết
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <c:otherwise>
            <div class="text-center py-5">
                <i class="bi bi-inbox fs-1 text-muted mb-3"></i>
                <p class="text-muted fs-5">Không có sản phẩm nào trong danh mục "<c:out value="${category.categoryName}" default="này"/>".</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-3">
                    <i class="bi bi-arrow-left me-2"></i>Quay lại trang chủ
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

    <%@ include file="../common/footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
