<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lí khách hàng - PharmacyLife</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/header.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
      body {
        padding-top: 115px !important;
        background-color: #f8fafc;
        font-family: "Inter", "Helvetica Neue", Arial, sans-serif;
      }
      .admin-container { 
        max-width: 1200px; 
        margin: 24px auto; 
        padding: 0 16px; 
      }
      .page-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 24px;
      }
      .page-title {
        font-size: 1.75rem;
        font-weight: 700;
        color: #0f172a;
        margin: 0;
      }
      .card { 
        border: 0; 
        border-radius: 14px; 
        box-shadow: 0 6px 24px rgba(0,0,0,.08); 
        background: #fff;
      }
      .table {
        margin-bottom: 0;
      }
      .table thead th {
        background-color: #f8fafc;
        border-bottom: 2px solid #eef2f7;
        font-weight: 600;
        color: #475569;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 0.5px;
        padding: 16px;
      }
      .table tbody td {
        padding: 16px;
        vertical-align: middle;
        border-bottom: 1px solid #eef2f7;
      }
      .table tbody tr:hover {
        background-color: #f8fafc;
      }
      .badge-role {
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 0.75rem;
        font-weight: 600;
        text-transform: uppercase;
      }
      .badge-customer {
        background-color: #dbeafe;
        color: #1e40af;
      }
      .badge-active {
        background-color: #d1fae5;
        color: #065f46;
      }
      .badge-inactive {
        background-color: #fee2e2;
        color: #991b1b;
      }
      .empty-state {
        text-align: center;
        padding: 60px 20px;
      }
      .empty-state i {
        font-size: 4rem;
        color: #cbd5e1;
        margin-bottom: 16px;
      }
      .empty-state h3 {
        color: #475569;
        margin-bottom: 8px;
      }
      .empty-state p {
        color: #64748b;
        margin-bottom: 24px;
      }
      .alert {
        padding: 12px 16px;
        border-radius: 8px;
        margin-bottom: 20px;
      }
      .alert-danger {
        background: #fee2e2;
        color: #991b1b;
        border: 1px solid #fecaca;
      }
    </style>
  </head>
  <body>
    <%@ include file="../common/header.jsp" %>
    <div class="admin-container">
      <div class="page-header">
        <h1 class="page-title">
          <i class="fas fa-users me-2"></i>
          Quản lí khách hàng
        </h1>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
          <i class="fas fa-home me-2"></i>Về trang chủ
        </a>
      </div>

      <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
          <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
        </div>
      </c:if>

      <div class="card">
        <div class="card-body p-0">
          <c:choose>
            <c:when test="${empty customers}">
              <div class="empty-state">
                <i class="fas fa-users"></i>
                <h3>Chưa có khách hàng nào</h3>
                <p>Hiện tại chưa có khách hàng nào trong hệ thống.</p>
              </div>
            </c:when>
            <c:otherwise>
              <div class="table-responsive">
                <table class="table table-hover">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Họ tên</th>
                      <th>Username</th>
                      <th>Email</th>
                      <th>Số điện thoại</th>
                      <th>Vai trò</th>
                      <th>Trạng thái</th>
                      <th>Ngày tạo</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="customer" items="${customers}">
                      <tr>
                        <td><strong>#${customer.userID}</strong></td>
                        <td>${customer.fullName}</td>
                        <td>${customer.username}</td>
                        <td>${customer.email}</td>
                        <td>${customer.phoneNumber != null ? customer.phoneNumber : 'N/A'}</td>
                        <td>
                          <span class="badge-role badge-customer">
                            <c:choose>
                              <c:when test="${not empty customer.roles}">
                                ${customer.roles[0]}
                              </c:when>
                              <c:otherwise>Customer</c:otherwise>
                            </c:choose>
                          </span>
                        </td>
                        <td>
                          <span class="badge-role ${customer.isActive ? 'badge-active' : 'badge-inactive'}">
                            ${customer.isActive ? 'Hoạt động' : 'Không hoạt động'}
                          </span>
                        </td>
                        <td>${customer.formattedCreatedDate}</td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
  </body>
</html>


