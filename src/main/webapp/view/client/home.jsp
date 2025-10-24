<%-- 
    Document   : list
    Created on : Oct 22, 2025, 11:08:04 PM
    Author     : qnhat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PharmacyLife - Your Health Your Life</title>
        <link href="<c:url value='/assets/css/header.css'/>" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                margin: 0;
                padding: 0;
                font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", "Noto Sans", "Liberation Sans", Arial, sans-serif;
                background-color: #f8f9fa;
            }
            
            .main-content {
                margin-top: 115px; /* Height of header */
                padding: 0;
                width: 100%;
                position: relative;
            }
            
            .categories-section {
                padding: 40px 20px;
                background-color: #f8f9fa;
                min-height: calc(100vh - 115px);
                width: 100%;
                margin: 0;
            }
            
            .section-title {
                text-align: center;
                margin-bottom: 40px;
                font-size: 2.5rem;
                font-weight: bold;
                color: #1e3c72;
            }
            
            .categories-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 20px;
                max-width: 1200px;
                margin: 0 auto;
                width: 100%;
            }
            
            .category-card {
                background: white;
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 15px;
            }
            
            .category-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            }
            
            .category-image {
                width: 60px;
                height: 60px;
                border-radius: 10px;
                object-fit: cover;
                flex-shrink: 0;
            }
            
            .category-info {
                flex: 1;
            }
            
            .category-name {
                font-size: 1.1rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 5px;
                line-height: 1.3;
            }
            
            .category-count {
                font-size: 0.9rem;
                color: #666;
            }
            
            @media (max-width: 768px) {
                .categories-grid {
                    grid-template-columns: 1fr;
                }
                
                .section-title {
                    font-size: 2rem;
                }
                
                .categories-section {
                    padding: 20px 15px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="../common/header.jsp" %>
        
        <!-- Main Content -->
        <div class="main-content">
            <!-- Categories Section -->
            <section class="categories-section">
                <h2 class="section-title">Danh Mục Sản Phẩm</h2>
                <div class="categories-grid">
                    <!-- Category 1 -->
                    <div class="category-card" onclick="viewCategory('CAT001')">
                        <img src="<c:url value='/assets/img/category/1.png'/>" alt="Thuốc dị ứng" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc dị ứng</div>
                            <div class="category-count">139 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 2 -->
                    <div class="category-card" onclick="viewCategory('CAT002')">
                        <img src="<c:url value='/assets/img/category/2.png'/>" alt="Thuốc giải độc" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc giải độc, khử độc và hỗ trợ cai nghiện</div>
                            <div class="category-count">7 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 3 -->
                    <div class="category-card" onclick="viewCategory('CAT003')">
                        <img src="<c:url value='/assets/img/category/3.png'/>" alt="Thuốc da liễu" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc da liễu</div>
                            <div class="category-count">289 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 4 -->
                    <div class="category-card" onclick="viewCategory('CAT004')">
                        <img src="<c:url value='/assets/img/category/4.png'/>" alt="Miếng dán" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Miếng dán, cao xoa, dầu</div>
                            <div class="category-count">51 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 5 -->
                    <div class="category-card" onclick="viewCategory('CAT005')">
                        <img src="<c:url value='/assets/img/category/5.png'/>" alt="Cơ xương khớp" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Cơ - xương - khớp</div>
                            <div class="category-count">175 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 6 -->
                    <div class="category-card" onclick="viewCategory('CAT006')">
                        <img src="<c:url value='/assets/img/category/6.png'/>" alt="Thuốc bổ" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc bổ & vitamin</div>
                            <div class="category-count">281 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 7 -->
                    <div class="category-card" onclick="viewCategory('CAT007')">
                        <img src="<c:url value='/assets/img/category/7.png'/>" alt="Thuốc ung thư" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc ung thư</div>
                            <div class="category-count">130 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 8 -->
                    <div class="category-card" onclick="viewCategory('CAT008')">
                        <img src="<c:url value='/assets/img/category/8.png'/>" alt="Thuốc giảm đau" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc giảm đau, hạ sốt, kháng viêm</div>
                            <div class="category-count">384 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 9 -->
                    <div class="category-card" onclick="viewCategory('CAT009')">
                        <img src="<c:url value='/assets/img/category/9.png'/>" alt="Thuốc hô hấp" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc hô hấp</div>
                            <div class="category-count">310 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 10 -->
                    <div class="category-card" onclick="viewCategory('CAT010')">
                        <img src="<c:url value='/assets/img/category/10.png'/>" alt="Thuốc kháng sinh" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc kháng sinh, kháng nấm</div>
                            <div class="category-count">556 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 11 -->
                    <div class="category-card" onclick="viewCategory('CAT011')">
                        <img src="<c:url value='/assets/img/category/11.png'/>" alt="Thuốc Mắt Tai Mũi Họng" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc Mắt, Tai, Mũi, Họng</div>
                            <div class="category-count">225 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 12 -->
                    <div class="category-card" onclick="viewCategory('CAT012')">
                        <img src="<c:url value='/assets/img/category/12.png'/>" alt="Thuốc hệ thần kinh" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc hệ thần kinh</div>
                            <div class="category-count">324 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 13 -->
                    <div class="category-card" onclick="viewCategory('CAT013')">
                        <img src="<c:url value='/assets/img/category/13.png'/>" alt="Thuốc tiêm chích" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc tiêm chích & dịch truyền</div>
                            <div class="category-count">143 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 14 -->
                    <div class="category-card" onclick="viewCategory('CAT014')">
                        <img src="<c:url value='/assets/img/category/14.png'/>" alt="Thuốc tiêu hoá" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc tiêu hoá & gan mật</div>
                            <div class="category-count">650 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 15 -->
                    <div class="category-card" onclick="viewCategory('CAT015')">
                        <img src="<c:url value='/assets/img/category/15.png'/>" alt="Thuốc tim mạch" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc tim mạch & máu</div>
                            <div class="category-count">858 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 16 -->
                    <div class="category-card" onclick="viewCategory('CAT016')">
                        <img src="<c:url value='/assets/img/category/16.png'/>" alt="Thuốc tiết niệu" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc tiết niệu - sinh dục</div>
                            <div class="category-count">248 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 17 -->
                    <div class="category-card" onclick="viewCategory('CAT017')">
                        <img src="<c:url value='/assets/img/category/17.png'/>" alt="Thuốc tê bôi" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc tê bôi</div>
                            <div class="category-count">1 sản phẩm</div>
                        </div>
                    </div>
                    
                    <!-- Category 18 -->
                    <div class="category-card" onclick="viewCategory('CAT018')">
                        <img src="<c:url value='/assets/img/category/18.png'/>" alt="Thuốc trị tiểu đường" class="category-image">
                        <div class="category-info">
                            <div class="category-name">Thuốc trị tiểu đường</div>
                            <div class="category-count">186 sản phẩm</div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        
        <script>
            function viewCategory(categoryId) {
                // Redirect to product page with category filter
                window.location.href = 'product?category=' + categoryId;
            }
        </script>
    </body>
</html>
