package controllers;

import dao.MedicineDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import models.AIService;
import utils.DBContext;

public class AIController extends HttpServlet {

   
    // private static final String API_KEY = "sk-xxxxx";
    //private static final String API_KEY = "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"; // TODO: đổi bằng key của bạn
    private static final String GEMINI_API_KEY = "AIzaSyD1GOAIoY_rQX32Jb1xAKaEFefFcXgc1p8";           // AIzaSyD1GOAIoY_rQX32Jb1xAKaEFefFcXgc1p8

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userMessage = request.getParameter("message");
        if (userMessage == null || userMessage.trim().isEmpty()) {
            response.getWriter().write("Xin chào! Tôi là trợ lý PharmacyLife 👩‍⚕️");
            return;
        }

        // 🔹 Gọi API OpenAI (hoặc tạo trả lời mô phỏng)
        String reply = getAIReply(userMessage);

        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(reply);
    }

    private String getAIReply(String prompt) {
        prompt = prompt.toLowerCase();

        // ✅ 1️⃣ Gọi phản hồi nhanh trong AIService
        AIService service = new AIService();
        String quickReply = service.getSimpleResponse(prompt);
        if (!quickReply.contains("Tôi chưa hiểu rõ")) {
            // 👉 Nếu AIService đã hiểu câu hỏi, trả lời luôn — không cần gọi API
            return quickReply;
        }
        // ==========================================================
        // 🧠 BƯỚC 1: TÌM TRONG DATABASE (nếu người dùng hỏi về thuốc)
        // ==========================================================
        try {
            // 👉 Nếu bạn đã lưu DBConnection vào ServletContext:
            Connection conn = (Connection) getServletContext().getAttribute("DBConnection");

            // ✅ Hoặc bạn có thể tạo mới từ DBContext:
            // Connection conn = new DBContext().getConnection();
            if (conn != null) {
                MedicineDAO dao = new MedicineDAO(new DBContext());
                String found = dao.searchMedicineByKeyword(prompt);

                if (found != null) {
                    return "Một vài sản phẩm phù hợp với yêu cầu của bạn:\n\n" + found;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ==========================================================
        // 🧠 BƯỚC 2: KHÔNG CÓ THUỐC → GỌI OpenAI (GPT-3.5)
        // ==========================================================    
        try {
            // 1️⃣ Tạo URL API Gemini
            URL url = new URL("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=" + GEMINI_API_KEY);

            // 2️⃣ Tạo kết nối HTTP
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setDoOutput(true);

            // 3️⃣ Dữ liệu gửi đi theo định dạng Gemini
            String inputJson = String.format("""
            {
              "contents": [
                { "parts": [ { "text": "%s" } ] }
              ]
            }
        """, prompt.replace("\"", "\\\"")); // escape dấu ngoặc kép

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = inputJson.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // 4️⃣ Đọc phản hồi trả về
            int status = conn.getResponseCode();
            BufferedReader reader;
            if (status == 200) {
                reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
            } else {
                reader = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
            }

            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();

            // 5️⃣ Phân tích phản hồi JSON
            String json = response.toString();
            // ✅ CHUẨN JSON cho Gemini 2.5: tìm "candidates"[0]."content"."parts"[0]."text"
            if (json.contains("\"candidates\"")) {
                int textIndex = json.indexOf("\"text\":");
                if (textIndex != -1) {
                    int start = json.indexOf("\"", textIndex + 7) + 1;
                    int end = json.indexOf("\"", start);
                    if (start > 0 && end > start) {
                        String result = json.substring(start, end)
                                .replace("\\n", "\n")
                                .replace("\\\"", "\"")
                                .trim();
                        if (!result.isEmpty()) {
                            return result;
                        }
                    }
                }
            }

            if (status != 200) {
                return "⚠️ Gemini trả lỗi: " + json;
            }

            return "Xin lỗi 😅, tôi chưa hiểu câu hỏi của bạn. Bạn có thể nói lại rõ hơn được không?";

        } catch (Exception e) {
            e.printStackTrace();
            return "⚠️ Lỗi khi gọi Gemini API: " + e.getMessage();
        }
    }

}
