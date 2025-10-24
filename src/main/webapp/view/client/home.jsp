<%-- 
    Document   : list
    Created on : Oct 22, 2025, 11:08:04 PM
    Author     : qnhat
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ include file="../common/header.jsp" %>

<main class="container py-5">
    <h1 class="mb-3">Welcome to PharmacyLife</h1> 
    <p class="text-muted mb-5">Your Health - Your Life</p>

    <section class="category-section">
        <div class="category-grid">
            <c:choose>
                <c:when test="${not empty listCategory}">
                    <c:forEach var="cat" items="${listCategory}">
                <div class="category-card">
                    <c:choose>
                        <c:when test="${not empty cat.image}">
                            <img src="${pageContext.request.contextPath}/assets/img/${cat.image}" alt="${cat.categoryName}" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/assets/img/.png" alt="${cat.categoryName}" />
                        </c:otherwise>
                    </c:choose>
                    <div>
                        <h3>${cat.categoryName}</h3>
                        <div class="text-muted small">${cat.count != null ? cat.count : 0} sản phẩm</div>
                    </div>
                </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="grid-column:1/-1;padding:24px;background:#fff;border-radius:8px;box-shadow:0 2px 6px rgba(0,0,0,0.06);">
                        <p class="mb-0">Hiện chưa có danh mục nào. Vui lòng kiểm tra dữ liệu hoặc thử tải lại trang.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
    
    
    
    
    
    
    
<!-- ===================================== -->
<!-- 🔹 SẢN PHẨM NỔI BẬT HÔM NAY (6 ảnh thật) -->
<!-- ===================================== -->
<section class="featured-products py-5">
    <div class="container">
        <div class="d-flex align-items-center mb-4">
            <i class="bi bi-plus-circle-fill text-primary me-2 fs-4"></i>
            <h3 class="fw-bold m-0">Sản phẩm nổi bật hôm nay</h3>
        </div>

        <div class="row g-4 text-center">
            <!-- 1 -->
            <div class="col-12 col-sm-6 col-lg-2">
                <div class="card product-card h-100 border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/assets/img/thuoc-bo-vitamin/T&V1.png" 
                         alt="Sản phẩm 1" class="card-img-top p-3 product-img">
                    <div class="card-body">
                        <h6 class="card-title">Sản phẩm 1</h6>
                        <p class="text-primary fw-semibold mb-1">960.000₫ / Hộp</p>
                        <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                    </div>
                </div>
            </div>

            <!-- 2 -->
            <div class="col-12 col-sm-6 col-lg-2">
                <div class="card product-card h-100 border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/assets/img/thuoc-bo-vitamin/T&V2.png" 
                         alt="Sản phẩm 2" class="card-img-top p-3 product-img">
                    <div class="card-body">
                        <h6 class="card-title">Sản phẩm 2</h6>
                        <p class="text-primary fw-semibold mb-1">295.000₫ / Hộp</p>
                        <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                    </div>
                </div>
            </div>

            <!-- 3 -->
            <div class="col-12 col-sm-6 col-lg-2">
                <div class="card product-card h-100 border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/assets/img/thuoc-bo-vitamin/T&V3.png" 
                         alt="Sản phẩm 3" class="card-img-top p-3 product-img">
                    <div class="card-body">
                        <h6 class="card-title">Sản phẩm 3</h6>
                        <p class="text-primary fw-semibold mb-1">838.000₫ / Hộp</p>
                        <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                    </div>
                </div>
            </div>

            <!-- 4 -->
            <div class="col-12 col-sm-6 col-lg-2">
                <div class="card product-card h-100 border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/assets/img/thuoc-bo-vitamin/T&V4.png" 
                         alt="Sản phẩm 4" class="card-img-top p-3 product-img">
                    <div class="card-body">
                        <h6 class="card-title">Sản phẩm 4</h6>
                        <p class="text-primary fw-semibold mb-1">460.000₫ / Hộp</p>
                        <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                    </div>
                </div>
            </div>

            <!-- 5 -->
            <div class="col-12 col-sm-6 col-lg-2">
                <div class="card product-card h-100 border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/assets/img/thuoc-bo-vitamin/T&V5.png" 
                         alt="Sản phẩm 5" class="card-img-top p-3 product-img">
                    <div class="card-body">
                        <h6 class="card-title">Sản phẩm 5</h6>
                        <p class="text-primary fw-semibold mb-1">364.000₫ / Hộp</p>
                        <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                    </div>
                </div>
            </div>

            <!-- 6 -->
            <div class="col-12 col-sm-6 col-lg-2">
                <div class="card product-card h-100 border-0 shadow-sm">
                    <img src="${pageContext.request.contextPath}/assets/img/thuoc-bo-vitamin/T&V6.png" 
                         alt="Sản phẩm 6" class="card-img-top p-3 product-img">
                    <div class="card-body">
                        <h6 class="card-title">Sản phẩm 6</h6>
                        <p class="text-primary fw-semibold mb-1">575.000₫ / Hộp</p>
                        <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>



<%@ include file="../common/footer.jsp" %>

