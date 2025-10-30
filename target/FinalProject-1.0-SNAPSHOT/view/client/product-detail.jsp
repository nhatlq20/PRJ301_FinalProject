<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${medicine.medicineName}"/></title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/assets/css/header.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/home.css'/>" rel="stylesheet">
</head>
<body>
    <%@ include file="../common/header.jsp" %>

    <div class="container py-4">
        <div class="row g-4">
            <div class="col-12 col-lg-5">
                <div class="card border-0 shadow-sm p-4 h-100 d-flex align-items-center justify-content-center">
                    <img src="<c:out value='${medicine.imageUrl}'/>" alt="<c:out value='${medicine.medicineName}'/>" style="max-width:100%;max-height:340px;object-fit:contain;"/>
                </div>
            </div>
            <div class="col-12 col-lg-7">
                <h3 class="fw-bold mb-2"><c:out value='${medicine.medicineName}'/></h3>
                <div class="h4 text-primary fw-bold mb-3">
                    <fmt:formatNumber value="${medicine.sellingPrice}" type="number" groupingUsed="true"/>₫ / <c:out value='${medicine.unit}'/>
                </div>
                <p class="text-secondary">Mô tả ngắn: <c:out value='${medicine.shortDescription}'/></p>
                <div class="row gy-2 small">
                    <div class="col-6"><strong>Danh mục:</strong> <c:out value='${medicine.category.categoryName}'/></div>
                    <div class="col-6"><strong>Đăng ký:</strong> <c:out value='${medicine.registrationNumber}'/></div>
                    <div class="col-6"><strong>Dạng bào chế:</strong> <c:out value='${medicine.dosageForm}'/></div>
                    <div class="col-6"><strong>Quy cách:</strong> <c:out value='${medicine.packDescription}'/></div>
                    <div class="col-6"><strong>NSX:</strong> <c:out value='${medicine.manufacturer}'/></div>
                    <div class="col-6"><strong>Xuất xứ:</strong> <c:out value='${medicine.countryOfOrigin}'/></div>
                </div>
                <div class="mt-3 d-flex gap-2">
                    <a class="btn btn-primary px-4" href="${pageContext.request.contextPath}/cart?action=add&id=${medicine.medicineID}">Chọn mua</a>
                    <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/home">Quay lại</a>
                </div>
            </div>
        </div>

        <div class="row mt-5 g-4">
            <div class="col-12 col-lg-6">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">Thành phần</h5>
                        <p class="mb-2"><c:out value='${medicine.ingredients}'/></p>
                        <h5 class="fw-bold mt-4 mb-3">Công dụng</h5>
                        <p class="mb-0"><c:out value='${medicine.indications}'/></p>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-6">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">Cách dùng</h5>
                        <p class="mb-2"><c:out value='${medicine.directions}'/></p>
                        <h5 class="fw-bold mt-4 mb-3">Tác dụng phụ</h5>
                        <p class="mb-2"><c:out value='${medicine.sideEffects}'/></p>
                        <h5 class="fw-bold mt-4 mb-3">Lưu ý</h5>
                        <p class="mb-2"><c:out value='${medicine.precautions}'/></p>
                        <h5 class="fw-bold mt-4 mb-3">Bảo quản</h5>
                        <p class="mb-0"><c:out value='${medicine.storage}'/></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>
