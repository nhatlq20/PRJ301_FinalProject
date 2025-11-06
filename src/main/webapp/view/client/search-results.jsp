<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết quả tìm kiếm - PharmacyLife</title>
    <link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/header.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/footer.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/home.css'/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .search-results-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }
        .search-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 30px;
            border-radius: 12px;
            margin-bottom: 20px;
        }
        .search-header h2 {
            margin: 0;
            font-size: 1.5rem;
        }
        .search-info {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 20px;
        }
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.15);
        }
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: #f8f9fa;
        }
        .product-info {
            padding: 15px;
        }
        .product-name {
            font-weight: 600;
            font-size: 0.95rem;
            color: #333;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .product-price {
            color: #28a745;
            font-weight: 700;
            font-size: 1.1rem;
        }
        .product-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.85rem;
            margin-top: 8px;
        }
        .status-in-stock {
            background: #d4edda;
            color: #155724;
        }
        .status-low-stock {
            background: #fff3cd;
            color: #856404;
        }
        .status-out-of-stock {
            background: #f8d7da;
            color: #721c24;
        }
        .no-results {
            text-align: center;
            padding: 60px 20px;
        }
        .no-results i {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 20px;
        }
        .no-results h3 {
            color: #6c757d;
            margin-bottom: 10px;
        }
        .no-results p {
            color: #adb5bd;
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="search-results-container" style="margin-top: 20px; min-height: calc(100vh - 300px);">
        <div class="search-header">
            <h2><i class="fas fa-search me-2"></i>Kết quả tìm kiếm</h2>
        </div>
        
        <c:if test="${not empty searchQuery}">
            <div class="search-info">
                Tìm thấy <strong>${resultCount}</strong> sản phẩm cho từ khóa "<strong>${searchQuery}</strong>"
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty searchResults || searchResults.size() == 0}">
                <div class="no-results">
                    <i class="fas fa-search"></i>
                    <h3>Không tìm thấy sản phẩm nào</h3>
                    <p>Vui lòng thử lại với từ khóa khác</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="products-grid">
                    <c:forEach var="medicine" items="${searchResults}">
                        <div class="product-card" onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${medicine.medicineID}'">
                            <img src="<c:out value='${medicine.imageUrl}'/>" 
                                 alt="<c:out value='${medicine.medicineName}'/>" class="product-image">
                            <div class="product-info">
                                <div class="product-name">${medicine.medicineName}</div>
                                <div class="product-price">
                                    <c:if test="${medicine.sellingPrice != null}">
                                        <fmt:formatNumber value="${medicine.sellingPrice}" type="number" groupingUsed="true" />₫
                                    </c:if>
                                    <c:if test="${medicine.sellingPrice == null}">Liên hệ</c:if>
                                </div>
                                <span class="product-status 
                                    <c:choose>
                                        <c:when test="${medicine.remainingQuantity > 20}">status-in-stock</c:when>
                                        <c:when test="${medicine.remainingQuantity > 0}">status-low-stock</c:when>
                                        <c:otherwise>status-out-of-stock</c:otherwise>
                                    </c:choose>">
                                    <c:choose>
                                        <c:when test="${medicine.remainingQuantity > 20}">Còn hàng</c:when>
                                        <c:when test="${medicine.remainingQuantity > 0}">Sắp hết</c:when>
                                        <c:otherwise>Hết hàng</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
    
    <script src="<c:url value='/assets/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>

