<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sản phẩm - PharmacyLife</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="<c:url value='/assets/css/header.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/home.css'/>" rel="stylesheet">
    <style>
        .category-sidebar {
            position: sticky;
            top: 100px;
        }
        .category-link {
            display: block;
            padding: 10px 15px;
            border-radius: 8px;
            text-decoration: none;
            color: #333;
            transition: all 0.2s;
        }
        .category-link:hover {
            background-color: #f0f4ff;
            color: #2563eb;
        }
        .category-link.active {
            background-color: #2563eb;
            color: white;
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="container py-4">
        <div class="row">
            <!-- Sidebar Categories -->
            <div class="col-12 col-md-3 mb-4">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">
                            <i class="bi bi-grid-3x3-gap me-2"></i>Danh mục sản phẩm
                        </h5>
                        <div class="d-flex flex-column gap-1">
                            <a href="${pageContext.request.contextPath}/products" 
                               class="category-link ${currentCategory == null ? 'active' : ''}">
                                <i class="bi bi-list-ul me-2"></i>Tất cả sản phẩm
                            </a>
                            <c:forEach var="cat" items="${allCategories}">
                                <a href="${pageContext.request.contextPath}/products?category=${cat.categoryID}" 
                                   class="category-link ${currentCategory != null && currentCategory.categoryID == cat.categoryID ? 'active' : ''}">
                                    <i class="bi bi-circle-fill me-2"></i><c:out value="${cat.categoryName}"/>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Products Grid -->
            <div class="col-12 col-md-9">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <h3 class="fw-bold m-0">
                        <c:choose>
                            <c:when test="${currentCategory != null}">
                                <i class="bi bi-collection me-2"></i><c:out value="${currentCategory.categoryName}"/>
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-box-seam me-2"></i>Tất cả sản phẩm
                            </c:otherwise>
                        </c:choose>
                    </h3>
                    <span class="text-muted">
                        <c:choose>
                            <c:when test="${medicines != null && medicines.size() > 0}">
                                Tìm thấy <strong><c:out value="${medicines.size()}"/></strong> sản phẩm
                            </c:when>
                            <c:otherwise>
                                Không có sản phẩm
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                
                <c:choose>
                    <c:when test="${medicines != null && medicines.size() > 0}">
                        <div class="row g-4">
                            <c:forEach var="m" items="${medicines}">
                                <div class="col-6 col-md-4 col-lg-3">
                                    <div class="card product-card h-100 border-0 shadow-sm">
                                        <img src="<c:out value='${m.imageUrl}'/>"
                                             alt="<c:out value='${m.medicineName}'/>"
                                             class="card-img-top p-3 product-img"
                                             onclick="window.location.href='${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'"
                                             style="cursor:pointer; height: 180px; object-fit: contain;">
                                        <div class="card-body"
                                             onclick="window.location.href='${pageContext.request.contextPath}/product/detail?id=${m.medicineID}'"
                                             style="cursor:pointer;">
                                            <h6 class="card-title mb-2">
                                                <c:out value='${m.medicineName}'/>
                                            </h6>
                                            <c:choose>
                                                <c:when test="${m.sellingPrice != null && m.sellingPrice > 0}">
                                                    <p class="text-primary fw-semibold mb-2">
                                                        <fmt:formatNumber value="${m.sellingPrice}" type="number" groupingUsed="true"/>₫ /
                                                        <c:out value='${m.unit}'/>
                                                    </p>
                                                    <a class="btn btn-primary w-100"
                                                       href="${pageContext.request.contextPath}/cart?action=add&id=${m.medicineID}"
                                                       onclick="event.stopPropagation();">
                                                        <i class="bi bi-cart-plus me-1"></i>Chọn mua
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="text-muted small mb-2">Cần được sự tư vấn của bác sĩ</p>
                                                    <a class="btn btn-outline-primary w-100"
                                                       href="${pageContext.request.contextPath}/product/detail?id=${m.medicineID}"
                                                       onclick="event.stopPropagation();">
                                                        <i class="bi bi-info-circle me-1"></i>Xem chi tiết
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
                            <i class="bi bi-inbox display-1 text-muted"></i>
                            <h5 class="text-muted mt-3">Không tìm thấy sản phẩm nào</h5>
                            <p class="text-muted">Danh mục này hiện chưa có sản phẩm.</p>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-3">
                                <i class="bi bi-arrow-left me-1"></i>Xem tất cả sản phẩm
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>

