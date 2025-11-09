/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener("DOMContentLoaded", function () {
  const chatBtn = document.getElementById("ai-chat-button");
  const chatBox = document.getElementById("ai-chat-box");
  const closeBtn = document.getElementById("close-chat");
  const sendBtn = document.getElementById("send-btn");
  const input = document.getElementById("user-input");
  const chatBody = document.getElementById("chat-body");

  chatBtn.addEventListener("click", () => chatBox.classList.toggle("hidden"));
  closeBtn.addEventListener("click", () => chatBox.classList.add("hidden"));

  sendBtn.addEventListener("click", sendMessage);

  function sendMessage() {
    const text = input.value.trim();
    if (!text) return;
    appendMessage("Bạn", text);
    input.value = "";

    fetch("ai?message=" + encodeURIComponent(text))
      .then(res => res.text())
      .then(data => appendMessage("AI", data))
      .catch(() => appendMessage("AI", "Xin lỗi, tôi chưa thể trả lời ngay bây giờ."));
  }

  function appendMessage(sender, message) {
    const div = document.createElement("div");
    div.innerHTML = `<strong>${sender}:</strong> ${message}`;
    chatBody.appendChild(div);
    chatBody.scrollTop = chatBody.scrollHeight;
  }
});

