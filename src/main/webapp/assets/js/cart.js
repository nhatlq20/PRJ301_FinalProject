document.addEventListener("DOMContentLoaded", function () {
    const selectAll = document.getElementById("selectAll");
    const totalDisplay = document.getElementById("cartTotal");
    const finalDisplay = document.getElementById("cartFinal");
    const rows = document.querySelectorAll(".cart-item");

    // --- Cập nhật tổng tiền ---
    function updateTotal() {
        let total = 0;
        rows.forEach(row => {
            const check = row.querySelector(".item-check");
            if (check && check.checked) {
                const price = parseFloat(row.querySelector(".price")?.dataset.price || 0);
                const qty = parseInt(row.querySelector(".quantity-input")?.value || 1);
                total += price * qty;
            }
        });
        const formatted = total.toLocaleString("vi-VN") + "₫";
        if (totalDisplay) totalDisplay.innerText = formatted;
        if (finalDisplay) finalDisplay.innerText = formatted;
    }

    // --- Tick chọn tất cả ---
    if (selectAll) {
        selectAll.addEventListener("change", () => {
            rows.forEach(row => {
                const check = row.querySelector(".item-check");
                if (check) check.checked = selectAll.checked;
            });
            updateTotal();
        });
    }

    // --- Tick từng dòng ---
    rows.forEach(row => {
        const check = row.querySelector(".item-check");
        if (check) {
            check.addEventListener("change", () => {
                const allChecked = Array.from(document.querySelectorAll(".item-check"))
                    .every(c => c.checked);
                if (selectAll) selectAll.checked = allChecked;
                updateTotal();
            });
        }
    });

    // --- Nút + / - ---
    rows.forEach(row => {
        const minus = row.querySelector(".btn-minus");
        const plus = row.querySelector(".btn-plus");
        const input = row.querySelector(".quantity-input");
        const id = row.dataset.id;

        // Chỉ thêm listener nếu các phần tử tồn tại
        if (minus && plus && input) {
            const updateQty = (newQty) => {
                if (newQty < 1) newQty = 1;
                input.value = newQty;

                const price = parseFloat(row.querySelector(".price")?.dataset.price || 0);
                const itemTotal = row.querySelector(".item-total");
                if (itemTotal) itemTotal.innerText = (price * newQty).toLocaleString("vi-VN") + "₫";

                updateTotal();

                // Gửi request cập nhật về server
                fetch(`cart?action=update&id=${id}&qty=${newQty}`)
                    .then(res => res.ok && console.log(`Updated ${id} → ${newQty}`))
                    .catch(err => console.error(err));
            };

            minus.addEventListener("click", () => updateQty(parseInt(input.value) - 1));
            plus.addEventListener("click", () => updateQty(parseInt(input.value) + 1));
        }
    });

    // --- Khởi tạo tổng tiền ban đầu ---
    updateTotal();
});
