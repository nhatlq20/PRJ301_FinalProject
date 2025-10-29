<%-- Document : list Created on : Oct 22, 2025, 11:08:04 PM Author : qnhat --%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>PharmacyLife - Your Health Your Life</title>
                    <link href="<c:url value='/assets/css/header.css'/>" rel="stylesheet">
                    <style>
                        html {
                            scroll-behavior: smooth;
                        }

                        /* Add styles for alternating section backgrounds */
                        .featured-products.bg-light {
                            background-color: #f8f9fa;
                        }

                        .featured-products {
                            transition: background-color 0.3s ease;
                        }

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

                        .nav-categories {
                            background-color: #ffffff;
                            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                            padding: 15px 0;
                            /* Keep nav in normal document flow so it moves together with header */
                            position: static;
                            width: 100%;
                            z-index: 10;
                        }

                        .nav-categories ul {
                            display: flex;
                            justify-content: center;
                            list-style: none;
                            margin: 0;
                            padding: 0 10px;
                            gap: 12px;
                            /* smaller spacing between items */
                            white-space: nowrap;
                            /* keep items on one line when possible */
                            overflow-x: auto;
                            /* allow horizontal scroll on small screens */
                            -webkit-overflow-scrolling: touch;
                        }

                        .nav-categories li a {
                            text-decoration: none;
                            color: #ffffff;
                            /* white text for contrast */
                            font-weight: 500;
                            padding: 8px 14px;
                            /* smaller paddings */
                            border-radius: 8px;
                            transition: background-color 0.15s ease, transform 0.15s ease;
                            background-color: #1e88e5;
                            /* uniform blue background */
                            display: inline-block;
                        }

                        .nav-categories li a:hover {
                            background-color: #1669b2;
                            /* slightly darker on hover */
                            color: #fff;
                            transform: translateY(-1px);
                        }

                        .nav-categories li a.active {
                            /* make active same as other items */
                            background-color: #1e88e5;
                            color: #fff;
                            box-shadow: none;
                        }

                        .main-content {
                            /* header + nav are in normal flow, no extra top margin needed */
                            margin-top: 0;
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
                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                            transition: all 0.3s ease;
                            cursor: pointer;
                            display: flex;
                            align-items: center;
                            gap: 15px;
                        }

                        .category-card:hover {
                            transform: translateY(-5px);
                            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
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

                        /* Welcome bar styles */
                        .welcome-bar {
                            width: 100%;
                            background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
                            padding: 14px 10px;
                            position: relative;
                            z-index: 5;
                        }

                        .welcome-container {
                            max-width: 1200px;
                            margin: 0 auto;
                            display: flex;
                            align-items: center;
                            gap: 20px;
                            justify-content: space-between;
                        }

                        .name-form input[type="text"] {
                            padding: 10px 12px;
                            border-radius: 8px;
                            border: 1px solid rgba(0, 0, 0, 0.1);
                            width: 260px;
                            outline: none;
                        }

                        .name-form button {
                            padding: 10px 12px;
                            border-radius: 8px;
                            border: none;
                            background: #0a66ff;
                            color: white;
                            cursor: pointer;
                            margin-left: 6px;
                        }

                        .greeting {
                            color: white;
                            font-weight: 600;
                            font-size: 1.1rem;
                        }
                    </style>
                </head>

                <body>
                    <%@ include file="../common/header.jsp" %>
                        <nav class="nav-categories">
                            <ul>
                                <!-- data-duration values are milliseconds; adjust per-section below -->
                                <li><a href="#bestsellers" class="active" data-duration="700">Sản phẩm bán chạy nhất</a>
                                </li>
                                <li><a href="#featured-categories" data-duration="800">Danh mục nổi bật</a></li>
                                <li><a href="#favorite-brands" data-duration="1500">Thương hiệu yêu thích</a></li>
                                <li><a href="#seasonal" data-duration="1750">Bệnh theo mùa</a></li>
                                <li><a href="#health-corner" data-duration="1900">Góc sức khỏe</a></li>
                                <li><a href="#cardio" data-duration="2100">Thuốc tim mạch</a></li>
                                <li><a href="#supplements" data-duration="2500">Thuốc bổ &amp; vitamin</a></li>
                                <li><a href="#today-featured" data-duration="3100">Sản phẩm nổi bật hôm nay</a></li>
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
                                        <img src="<c:url value='/assets/img/category/1.png'/>" alt="Thuốc dị ứng"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc dị ứng</div>
                                            <div class="category-count">139 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 2 -->
                                    <div class="category-card" onclick="viewCategory('CAT002')">
                                        <img src="<c:url value='/assets/img/category/2.png'/>" alt="Thuốc giải độc"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc giải độc, khử độc và hỗ trợ cai nghiện
                                            </div>
                                            <div class="category-count">7 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 3 -->
                                    <div class="category-card" onclick="viewCategory('CAT003')">
                                        <img src="<c:url value='/assets/img/category/3.png'/>" alt="Thuốc da liễu"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc da liễu</div>
                                            <div class="category-count">289 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 4 -->
                                    <div class="category-card" onclick="viewCategory('CAT004')">
                                        <img src="<c:url value='/assets/img/category/4.png'/>" alt="Miếng dán"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Miếng dán, cao xoa, dầu</div>
                                            <div class="category-count">51 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 5 -->
                                    <div class="category-card" onclick="viewCategory('CAT005')">
                                        <img src="<c:url value='/assets/img/category/5.png'/>" alt="Cơ xương khớp"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Cơ - xương - khớp</div>
                                            <div class="category-count">175 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 6 -->
                                    <div class="category-card" onclick="viewCategory('CAT006')">
                                        <img src="<c:url value='/assets/img/category/6.png'/>" alt="Thuốc bổ"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc bổ & vitamin</div>
                                            <div class="category-count">281 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 7 -->
                                    <div class="category-card" onclick="viewCategory('CAT007')">
                                        <img src="<c:url value='/assets/img/category/7.png'/>" alt="Thuốc ung thư"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc ung thư</div>
                                            <div class="category-count">130 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 8 -->
                                    <div class="category-card" onclick="viewCategory('CAT008')">
                                        <img src="<c:url value='/assets/img/category/8.png'/>" alt="Thuốc giảm đau"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc giảm đau, hạ sốt, kháng viêm</div>
                                            <div class="category-count">384 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 9 -->
                                    <div class="category-card" onclick="viewCategory('CAT009')">
                                        <img src="<c:url value='/assets/img/category/9.png'/>" alt="Thuốc hô hấp"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc hô hấp</div>
                                            <div class="category-count">310 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 10 -->
                                    <div class="category-card" onclick="viewCategory('CAT010')">
                                        <img src="<c:url value='/assets/img/category/10.png'/>" alt="Thuốc kháng sinh"
                                            class="category-image">
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
                                        <img src="<c:url value='/assets/img/category/12.png'/>" alt="Thuốc hệ thần kinh"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc hệ thần kinh</div>
                                            <div class="category-count">324 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 13 -->
                                    <div class="category-card" onclick="viewCategory('CAT013')">
                                        <img src="<c:url value='/assets/img/category/13.png'/>" alt="Thuốc tiêm chích"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc tiêm chích & dịch truyền</div>
                                            <div class="category-count">143 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 14 -->
                                    <div class="category-card" onclick="viewCategory('CAT014')">
                                        <img src="<c:url value='/assets/img/category/14.png'/>" alt="Thuốc tiêu hoá"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc tiêu hoá & gan mật</div>
                                            <div class="category-count">650 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 15 -->
                                    <div class="category-card" onclick="viewCategory('CAT015')">
                                        <img src="<c:url value='/assets/img/category/15.png'/>" alt="Thuốc tim mạch"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc tim mạch & máu</div>
                                            <div class="category-count">858 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 16 -->
                                    <div class="category-card" onclick="viewCategory('CAT016')">
                                        <img src="<c:url value='/assets/img/category/16.png'/>" alt="Thuốc tiết niệu"
                                            class="category-image">
                                        <div class="category-info">
                                            <div class="category-name">Thuốc tiết niệu - sinh dục</div>
                                            <div class="category-count">248 sản phẩm</div>
                                        </div>
                                    </div>

                                    <!-- Category 17 -->
                                    <div class="category-card" onclick="viewCategory('CAT017')">
                                        <img src="<c:url value='/assets/img/category/17.png'/>" alt="Thuốc tê bôi"
                                            class="category-image">
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
                                <div class="row g-4 text-center">
                                    <!-- 1 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tim-mach/1.png"
                                                alt="Sản phẩm tim mạch 1" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Sản phẩm tim mạch 1</h6>
                                                <p class="text-primary fw-semibold mb-1">890.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 2 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tim-mach/2.png"
                                                alt="Sản phẩm tim mạch 2" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Sản phẩm tim mạch 2</h6>
                                                <p class="text-primary fw-semibold mb-1">750.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 3 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tim-mach/3.png"
                                                alt="Sản phẩm tim mạch 3" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Sản phẩm tim mạch 3</h6>
                                                <p class="text-primary fw-semibold mb-1">920.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 4 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tim-mach/4.png"
                                                alt="Sản phẩm tim mạch 4" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Sản phẩm tim mạch 4</h6>
                                                <p class="text-primary fw-semibold mb-1">680.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 5 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tim-mach/5.png"
                                                alt="Sản phẩm tim mạch 5" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Sản phẩm tim mạch 5</h6>
                                                <p class="text-primary fw-semibold mb-1">850.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 6 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tim-mach/6.png"
                                                alt="Sản phẩm tim mạch 6" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Sản phẩm tim mạch 6</h6>
                                                <p class="text-primary fw-semibold mb-1">790.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>
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
                                    <!-- 1 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-da-lieu/dl1.png"
                                                alt="Thuốc da liễu 1" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc da liễu 1</h6>
                                                <p class="text-primary fw-semibold mb-1">420.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 2 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-da-lieu/dl2.png"
                                                alt="Thuốc da liễu 2" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc da liễu 2</h6>
                                                <p class="text-primary fw-semibold mb-1">380.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 3 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-da-lieu/dl3.png"
                                                alt="Thuốc da liễu 3" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc da liễu 3</h6>
                                                <p class="text-primary fw-semibold mb-1">450.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 4 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-da-lieu/dl4.png"
                                                alt="Thuốc da liễu 4" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc da liễu 4</h6>
                                                <p class="text-primary fw-semibold mb-1">520.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 5 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-da-lieu/dl5.png"
                                                alt="Thuốc da liễu 5" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc da liễu 5</h6>
                                                <p class="text-primary fw-semibold mb-1">480.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 6 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-da-lieu/dl6.png"
                                                alt="Thuốc da liễu 6" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc da liễu 6</h6>
                                                <p class="text-primary fw-semibold mb-1">550.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>
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
                                    <!-- 1 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-ho-hap/HH1.png"
                                                alt="Thuốc hô hấp 1" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc hô hấp 1</h6>
                                                <p class="text-primary fw-semibold mb-1">320.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 2 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-ho-hap/HH2.png"
                                                alt="Thuốc hô hấp 2" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc hô hấp 2</h6>
                                                <p class="text-primary fw-semibold mb-1">280.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 3 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-ho-hap/HH3.png"
                                                alt="Thuốc hô hấp 3" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc hô hấp 3</h6>
                                                <p class="text-primary fw-semibold mb-1">350.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 4 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-ho-hap/HH4.png"
                                                alt="Thuốc hô hấp 4" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc hô hấp 4</h6>
                                                <p class="text-primary fw-semibold mb-1">420.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 5 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-ho-hap/HH5.png"
                                                alt="Thuốc hô hấp 5" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc hô hấp 5</h6>
                                                <p class="text-primary fw-semibold mb-1">380.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 6 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-ho-hap/HH6.png"
                                                alt="Thuốc hô hấp 6" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc hô hấp 6</h6>
                                                <p class="text-primary fw-semibold mb-1">450.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>
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
                                    <!-- 1 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-di-ung/tdu1.png"
                                                alt="Thuốc dị ứng 1" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc dị ứng 1</h6>
                                                <p class="text-primary fw-semibold mb-1">220.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 2 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-di-ung/tdu2.png"
                                                alt="Thuốc dị ứng 2" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc dị ứng 2</h6>
                                                <p class="text-primary fw-semibold mb-1">180.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 3 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-di-ung/tdu3.png"
                                                alt="Thuốc dị ứng 3" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc dị ứng 3</h6>
                                                <p class="text-primary fw-semibold mb-1">250.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 4 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-di-ung/tdu4.png"
                                                alt="Thuốc dị ứng 4" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc dị ứng 4</h6>
                                                <p class="text-primary fw-semibold mb-1">320.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 5 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-di-ung/tdu5.png"
                                                alt="Thuốc dị ứng 5" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc dị ứng 5</h6>
                                                <p class="text-primary fw-semibold mb-1">280.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 6 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-di-ung/tdu6.png"
                                                alt="Thuốc dị ứng 6" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc dị ứng 6</h6>
                                                <p class="text-primary fw-semibold mb-1">350.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
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
                                    <!-- 1 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-khang-sinh/1.png"
                                                alt="Thuốc kháng sinh 1" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc kháng sinh 1</h6>
                                                <p class="text-primary fw-semibold mb-1">620.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 2 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-khang-sinh/2.png"
                                                alt="Thuốc kháng sinh 2" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc kháng sinh 2</h6>
                                                <p class="text-primary fw-semibold mb-1">580.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 3 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-khang-sinh/3.png"
                                                alt="Thuốc kháng sinh 3" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc kháng sinh 3</h6>
                                                <p class="text-primary fw-semibold mb-1">650.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 4 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-khang-sinh/4.png"
                                                alt="Thuốc kháng sinh 4" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc kháng sinh 4</h6>
                                                <p class="text-primary fw-semibold mb-1">720.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 5 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-khang-sinh/5.png"
                                                alt="Thuốc kháng sinh 5" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc kháng sinh 5</h6>
                                                <p class="text-primary fw-semibold mb-1">680.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 6 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-khang-sinh/6.png"
                                                alt="Thuốc kháng sinh 6" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc kháng sinh 6</h6>
                                                <p class="text-primary fw-semibold mb-1">750.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>
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
                                    <!-- 1 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tieu-hoa/1.png"
                                                alt="Thuốc tiêu hóa 1" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc tiêu hóa 1</h6>
                                                <p class="text-primary fw-semibold mb-1">420.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 2 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tieu-hoa/2.png"
                                                alt="Thuốc tiêu hóa 2" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc tiêu hóa 2</h6>
                                                <p class="text-primary fw-semibold mb-1">380.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 3 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tieu-hoa/3.png"
                                                alt="Thuốc tiêu hóa 3" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc tiêu hóa 3</h6>
                                                <p class="text-primary fw-semibold mb-1">450.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 4 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tieu-hoa/4.png"
                                                alt="Thuốc tiêu hóa 4" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc tiêu hóa 4</h6>
                                                <p class="text-primary fw-semibold mb-1">520.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 5 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tieu-hoa/5.png"
                                                alt="Thuốc tiêu hóa 5" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc tiêu hóa 5</h6>
                                                <p class="text-primary fw-semibold mb-1">480.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 6 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-tieu-hoa/6.png"
                                                alt="Thuốc tiêu hóa 6" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc tiêu hóa 6</h6>
                                                <p class="text-primary fw-semibold mb-1">550.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>
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
                                    <!-- 1 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-giam-dau/gd1.png"
                                                alt="Thuốc giảm đau 1" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc giảm đau 1</h6>
                                                <p class="text-primary fw-semibold mb-1">320.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 2 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-giam-dau/gd2.png"
                                                alt="Thuốc giảm đau 2" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc giảm đau 2</h6>
                                                <p class="text-primary fw-semibold mb-1">280.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 3 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-giam-dau/gd3.png"
                                                alt="Thuốc giảm đau 3" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc giảm đau 3</h6>
                                                <p class="text-primary fw-semibold mb-1">350.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 4 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-giam-dau/gd4.png"
                                                alt="Thuốc giảm đau 4" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc giảm đau 4</h6>
                                                <p class="text-primary fw-semibold mb-1">420.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 5 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-giam-dau/gd5.png"
                                                alt="Thuốc giảm đau 5" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc giảm đau 5</h6>
                                                <p class="text-primary fw-semibold mb-1">380.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 6 -->
                                    <div class="col-12 col-sm-6 col-lg-2">
                                        <div class="card product-card h-100 border-0 shadow-sm">
                                            <img src="${pageContext.request.contextPath}/assets/img/thuoc-giam-dau/gd6.png"
                                                alt="Thuốc giảm đau 6" class="card-img-top p-3 product-img">
                                            <div class="card-body">
                                                <h6 class="card-title">Thuốc giảm đau 6</h6>
                                                <p class="text-primary fw-semibold mb-1">450.000₫ / Hộp</p>
                                                <button class="btn btn-primary w-100 mt-2">Chọn mua</button>
                                            </div>
                                        </div>
                                    </div>
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
                                    if (startTime === null) startTime = currentTime;
                                    var timeElapsed = currentTime - startTime;
                                    var run = ease(timeElapsed, startPosition, distance, duration);
                                    window.scrollTo(0, run);
                                    if (timeElapsed < duration) requestAnimationFrame(animation);
                                }

                                // Easing function
                                function ease(t, b, c, d) {
                                    t /= d / 2;
                                    if (t < 1) return c / 2 * t * t + b;
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
                                    // Read per-link duration (ms) from data-duration attribute; fallback to 1000ms
                                    const duration = parseInt(this.dataset.duration, 10) || 1000;
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
                                        target.scrollIntoView({ behavior: 'smooth' });
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










                <!-- ===================================== -->
                <!-- 🔹 SẢN PHẨM NỔI BẬT HÔM NAY (6 ảnh thật) -->
                <!-- ===================================== -->
                <section class="featured-products py-5">
                    <div id="today-featured" class="container">
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