<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
</head>

<body>
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

    <!-- Danh sách sản phẩm -->
    <c:choose>
        <c:when test="${not empty medicines}">
            <div class="row g-4">
                <c:forEach var="m" items="${medicines}">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="product-card text-center p-3 d-flex flex-column">
                            <img src="<c:out value='${m.imageUrl}'/>"
                                 alt="<c:out value='${m.medicineName}'/>"
                                 class="product-img w-100"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/img/no-image.png';"
                                 onclick="window.location.href='${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'"
                                 style="cursor:pointer;">

                            <div class="mt-3 flex-grow-1 d-flex flex-column justify-content-between">
                                <div>
                                    <div class="product-name mb-2">
                                        <c:out value="${m.medicineName}"/>
                                    </div>

                                    <p class="product-price mb-1">
                                        <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫
                                        <span class="text-muted fs-6"> / <c:out value="${m.unit}"/></span>
                                    </p>
                                </div>

                                <a href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}"
                                   class="btn btn-buy mt-2">
                                    <i class="bi bi-cart3 me-1"></i> Chọn mua
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <c:otherwise>
            <div class="text-center py-5">
                <p class="text-muted fs-5">Không có sản phẩm nào trong danh mục này.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
