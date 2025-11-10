// header.js
document.addEventListener("DOMContentLoaded", function () {
    const badge = document.getElementById("cartCount");
    const cartDropdown = document.querySelector(".cart-dropdown");
    const viewCartBtn = document.querySelector(".cart-footer .btn");

    // --- Hàm cập nhật số lượng hiển thị trên badge ---
    function updateCartCount(newCount) {
        if (!badge) return;
        badge.textContent = newCount;
        badge.style.display = newCount > 0 ? "inline-block" : "none";
    }

    // --- Lắng nghe sự kiện "cartUpdated" để cập nhật số lượng ---
    document.addEventListener("cartUpdated", function (e) {
        updateCartCount(e.detail.count);
    });

    // --- Fix lỗi hover ảo trên giỏ hàng (dropdown mở sẵn khi load) ---
//    if (cartDropdown) {
//        cartDropdown.style.display = "none";
//        cartDropdown.style.opacity = "0";
//        cartDropdown.style.visibility = "hidden";
//    }

    // ✅ (Gợi ý dùng trong ProductServlet hoặc JS khác khi thêm sản phẩm)
    // document.dispatchEvent(new CustomEvent("cartUpdated", { detail: { count: 5 } }));

    // Ripple effect on "Xem giỏ hàng" button
    if (viewCartBtn) {
        viewCartBtn.addEventListener("click", function (e) {
            const rect = viewCartBtn.getBoundingClientRect();
            const ripple = document.createElement("span");
            ripple.className = "btn-ripple";
            ripple.style.left = (e.clientX - rect.left) + "px";
            ripple.style.top = (e.clientY - rect.top) + "px";
            viewCartBtn.appendChild(ripple);
            setTimeout(() => ripple.remove(), 650);
        });
    }
});
