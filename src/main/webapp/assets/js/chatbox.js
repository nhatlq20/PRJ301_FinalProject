document.addEventListener("DOMContentLoaded", function () {
  console.log("✅ chatbox.js loaded!");

  const chatBtn = document.getElementById("chat-launcher");
  const chatBox = document.getElementById("chat-window");
  const closeBtn = document.getElementById("close-chat");
  const sendBtn = document.getElementById("send-btn");
  const input = document.getElementById("chat-input");
  const chatBody = document.getElementById("chat-body");

  // 🔹 Kiểm tra phần tử có tồn tại không
  if (!chatBtn || !chatBox) {
    console.error("❌ Không tìm thấy chat-launcher hoặc chat-window trong DOM");
    return;
  }

  // 🔹 Click icon để bật/tắt khung chat
  chatBtn.addEventListener("click", () => {
    chatBox.classList.toggle("hidden");
    chatBox.classList.toggle("show");
  });

  // 🔹 Nút đóng
  closeBtn.addEventListener("click", () => {
    chatBox.classList.add("hidden");
    chatBox.classList.remove("show");
  });

  // 🔹 Gửi tin nhắn bằng nút hoặc Enter
  sendBtn.addEventListener("click", sendMessage);
  input.addEventListener("keypress", (e) => {
    if (e.key === "Enter") sendMessage();
  });

  // ==========================================================
  // ✅ HÀM GỬI TIN NHẮN
  // ==========================================================
  function sendMessage() {
  const text = input.value.trim();
  if (!text) return;

  // 🔹 Tạm khóa nút gửi để tránh spam
  sendBtn.disabled = true;
  input.disabled = true;

  appendMessage("user", text);
  input.value = "";

  // Hiệu ứng AI đang gõ
  const typing = showTyping();

  // Gửi tin nhắn đến servlet AI
  fetch("ai?message=" + encodeURIComponent(text))
    .then((res) => res.text())
    .then((data) => {
      removeTyping(typing);
      appendMessage("ai", data);
    })
    .catch((err) => {
      console.error("AI fetch error:", err);
      removeTyping(typing);
      appendMessage("ai", "Xin lỗi, tôi chưa thể trả lời ngay bây giờ 😥.");
    })
    .finally(() => {
      // 🔹 Mở lại nút gửi sau 2 giây
      setTimeout(() => {
        sendBtn.disabled = false;
        input.disabled = false;
        input.focus();
      }, 2000);
    });
}


  // ==========================================================
  // ✅ HÀM HIỂN THỊ TIN NHẮN DƯỚI DẠNG BONG BÓNG
  // ==========================================================
  function appendMessage(sender, message) {
    const msgDiv = document.createElement("div");
    msgDiv.classList.add("chat-message", sender);

    const bubble = document.createElement("div");
    bubble.classList.add("bubble");
    bubble.textContent = message;

    msgDiv.appendChild(bubble);
    chatBody.appendChild(msgDiv);

    // Cuộn xuống cuối
    chatBody.scrollTop = chatBody.scrollHeight;
  }

  // ==========================================================
  // ✅ HIỆU ỨNG “AI đang gõ...”
  // ==========================================================
  function showTyping() {
    const typingDiv = document.createElement("div");
    typingDiv.classList.add("chat-message", "ai");
    typingDiv.innerHTML = `
      <div class="bubble">
        <span class="chat-typing"></span>
        <span class="chat-typing" style="animation-delay:0.2s"></span>
        <span class="chat-typing" style="animation-delay:0.4s"></span>
      </div>`;
    chatBody.appendChild(typingDiv);
    chatBody.scrollTop = chatBody.scrollHeight;
    return typingDiv;
  }

  function removeTyping(typingDiv) {
    typingDiv.remove();
  }
});
