# PRJ301_FinalProject

```text
PharmacyLife/
├── pom.xml
├── src/main/java/
│   └── com/example/pharmacyshop/
│       ├── config/
│       │   ├── EmmailInformation.java     (Bạn đang làm)
│       │
│       ├── controller/
│       │   ├── AuthController.java        (Bạn đang làm)
│       │   ├── HomeController.java        (Hiển thị trang chủ)
│       │   ├── ProductController.java     (Xử lý xem SP, filter, pagination)
│       │   ├── CartController.java        (Xử lý thêm/sửa/xóa giỏ hàng)
│       │   ├── OrderController.java       (Xử lý đặt hàng, xem lịch sử)
│       │   └── AdminController.java       (Xử lý CRUD sản phẩm, quản lý user)
│       │
│       ├── dao/
│       │   ├── UserDAO.java              (Bạn đã có)
│       │   ├── MedicineDAO.java          (CRUD sản phẩm, get sản phẩm, filter, pagination)
│       │   ├── CategoryDAO.java         (Lấy danh mục sản phẩm)
│       │   └── OrderDAO.java            (Lưu đơn hàng, chi tiết đơn hàng)
│       │
│       ├── model/
│       │   ├── User.java                (Bạn đã có)
│       │   ├── Role.java                (Bạn đã có)
│       │   ├── Medicine.java             
│       │   ├── Category.java            (id, name)
│       │   ├── Cart.java                (Chứa danh sách các 'Item')
│       │   ├── Item.java                (Chứa 'Product' và 'quantity')
│       │   ├── Order.java               (id, userID, orderDate, total, status)
│       │   └── OrderDetail.java         (orderID, productID, quantity, price)
│       │
│       ├── util/
│       │   ├── DBContext.java             (Bạn đã có)
│       │   ├── HashUtil.java              (Bạn đã có)
│       │   └── Validator.java             (Bạn đã có)
│       │   ├── OptService.java            (Bạn đã có)
│       │   ├── EmailServide.java          (Bạn đã có)
│       │
│       └── filter/
│           ├── AuthFilter.java            (Bạn đã có - Chặn khi chưa login)
│           └── AdminFilter.java           (Chặn vào trang admin nếu role != ADMIN)
│
└── src/main/webapp/
    ├── WEB-INF/
    │   ├── views/
    │   │   ├── auth/
    │   │   │   ├── login.jsp                    (Bạn đã có)
    │   │   │   └── register.jsp                 (Bạn đã có)
    │   │   │   └── forgot-password.jsp
    │   │   │   └── reset-password.jsp        
    │   │   │   └── reset-password-simple.jsp
    │   │   │   └── verify-otp.jsp     
    │   │   │
    │   │   ├── client/                  (Các trang cho người dùng)
    │   │   │   ├── home.jsp
    │   │   │   ├── products.jsp         (Trang danh sách sản phẩm, có filter/pagination)
    │   │   │   ├── product-detail.jsp
    │   │   │   ├── cart.jsp             (Trang giỏ hàng)
    │   │   │   ├── checkout.jsp         (Trang thanh toán)
    │   │   │   └── order-history.jsp    (Lịch sử đơn hàng của cá nhân)
    │   │   │
    │   │   ├── admin/                   (Các trang quản trị - CRUD)
    │   │   │   ├── dashboard.jsp
    │   │   │   ├── manage-products.jsp  (Bảng list sản phẩm + nút Add/Edit/Delete)
    │   │   │   ├── product-form.jsp     (Form để Add/Edit sản phẩm)
    │   │   │   └── manage-orders.jsp
    │   │   │
    │   │   └── common/                  (Các thành phần dùng chung)
    │   │       ├── header.jsp
    │   │       ├── footer.jsp
    │   │       └── sidebar.jsp          (Thanh bên chứa danh mục/filter)
    │   │
    │   └── web.xml
    │
    └── assets/
        ├── css/
        ├── js/
        └── images/                      (Để chứa ảnh sản phẩm)

```





