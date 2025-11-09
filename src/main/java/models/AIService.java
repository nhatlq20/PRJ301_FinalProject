/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author ADMIN
 */
import java.io.*;
import java.net.*;

public class AIService {
    // 🔹 API URL & KEY
    private static final String API_URL =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=";

    private static final String API_KEY = "AIzaSyD1GOAIoY_rQX32Jb1xAKaEFefFcXgc1p8"; // 👉 Dán key bạn tạo ở Google AI Studio

    /**
     * Gửi prompt tới Gemini và nhận phản hồi.
     */
    public String askAI(String prompt) throws IOException {
        // Mở kết nối
        URL url = new URL(API_URL + API_KEY);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
        conn.setDoOutput(true);

        // JSON body gửi đến Gemini
        String jsonInput = """
        {
          "contents": [{
            "parts": [{"text": "%s"}]
          }]
        }
        """.formatted(prompt);

        // Gửi request
        try (OutputStream os = conn.getOutputStream()) {
            os.write(jsonInput.getBytes("UTF-8"));
        }

        // Đọc phản hồi
        BufferedReader br;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() < 300) {
            br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        } else {
            br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
        }

        StringBuilder response = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            response.append(line);
        }
        br.close();

        // Trích văn bản trả về
        return parseResponse(response.toString());
    }

    /**
     * Tách phần nội dung text từ JSON phản hồi của Gemini.
     */
    private String parseResponse(String json) {
        try {
            int idx = json.indexOf("\"text\"");
            if (idx != -1) {
                String cut = json.substring(idx + 8);
                int end = cut.indexOf("\"");
                return cut.substring(0, end).replace("\\n", "\n");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "⚠️ Gemini trả lời lỗi: " + json;
    }

    /**
     * Trả về phản hồi đơn giản (fallback nếu không gọi API).
     */
    public String getSimpleResponse(String input) {
    input = input.toLowerCase();

    // ========== 🔹 CHÀO HỎI / GIỚI THIỆU ==========
    if (input.contains("xin chào") || input.contains("chào buổi sáng") || input.contains("chào buổi tối")) {
        return "Chào bạn 👋! Tôi là Dược sĩ ảo của PharmacyLife 💊. Bạn muốn hỏi về thuốc hay sức khỏe hôm nay ạ?";
    }
    if (input.contains("bạn là ai") || input.contains("ai vậy") || input.contains("là gì")) {
        return "Tôi là Dược sĩ ảo của PharmacyLife 👩‍⚕️, luôn sẵn sàng hỗ trợ bạn tra cứu thuốc và tư vấn sức khỏe 24/7!";
    }
    if (input.contains("cảm ơn")) {
        return "Rất vui được giúp bạn 😊. Nếu bạn cần hỗ trợ thêm, tôi luôn sẵn sàng nhé!";
    }
    if (input.contains("tạm biệt") || input.contains("bye")) {
        return "Tạm biệt bạn 👋, chúc bạn nhiều sức khỏe và niềm vui nhé!";
    }

    // ========== 🔹 CÁC BỆNH PHỔ BIẾN ==========
    if (input.contains("đau đầu") || input.contains("nhức đầu")) {
        return "Với cơn đau đầu nhẹ, bạn có thể dùng Paracetamol hoặc Panadol 💊. Hãy nghỉ ngơi, uống đủ nước, tránh stress và ánh sáng mạnh nhé.";
    }
    if (input.contains("đau bụng")) {
        return "Nếu bạn chỉ đau bụng nhẹ, có thể do rối loạn tiêu hóa. Hãy uống nước ấm, tránh đồ cay và dầu mỡ. Nếu đau nhiều hoặc kèm sốt, nên đi khám sớm nhé 🏥.";
    }
    if (input.contains("đau họng") || input.contains("viêm họng")) {
        return "Bạn có thể dùng thuốc ngậm Strepsils hoặc nước muối sinh lý để giảm đau họng 💧. Uống nhiều nước ấm và tránh nói to nhé.";
    }
    if (input.contains("ho") || input.contains("thuốc ho")) {
        return "Bạn có thể tham khảo các sản phẩm như Prospan, Acemuc hoặc Toplexil 💊. Nếu ho kéo dài trên 7 ngày, nên đi khám để loại trừ viêm phế quản nhé.";
    }
    if (input.contains("cảm cúm")) {
        return "Khi bị cảm cúm, bạn nên nghỉ ngơi, uống đủ nước, bổ sung vitamin C 🍊 và có thể dùng thuốc như Tiffy hoặc Decolgen theo hướng dẫn.";
    }
    if (input.contains("sốt")) {
        return "Bạn có thể dùng Paracetamol hạ sốt (500mg mỗi 4–6 giờ, tối đa 4 viên/ngày) 💊. Uống nhiều nước và lau mát cơ thể nhé.";
    }
    if (input.contains("viêm mũi") || input.contains("nghẹt mũi")) {
        return "Hãy rửa mũi bằng nước muối sinh lý 💧 và có thể dùng xịt Otrivin hoặc Coldi-B để giảm nghẹt mũi nhé.";
    }
    if (input.contains("đau răng")) {
        return "Nếu chỉ đau nhẹ, bạn có thể dùng Paracetamol giảm đau 💊 hoặc nước muối ấm súc miệng. Nếu đau kéo dài, nên đi nha sĩ để kiểm tra nhé 🦷.";
    }
    if (input.contains("đau lưng") || input.contains("đau khớp") || input.contains("nhức mỏi")) {
        return "Bạn có thể dùng Salonpas, Voltaren hoặc thuốc giảm đau nhẹ như Efferalgan 💊. Nghỉ ngơi và tránh mang vác nặng nhé.";
    }
    if (input.contains("đau bụng kinh") || input.contains("đau kỳ kinh")) {
        return "Bạn có thể dùng thuốc giảm đau như Ibuprofen hoặc Buscopan 💊. Uống nước ấm và nghỉ ngơi sẽ giúp bạn dễ chịu hơn 💕.";
    }

    // ========== 🔹 DƯỠNG CHẤT / VITAMIN ==========
    if (input.contains("vitamin c")) {
        return "Vitamin C giúp tăng sức đề kháng, chống oxy hóa và làm đẹp da 🍊. Uống 500–1000mg mỗi ngày, sau bữa ăn là tốt nhất nhé.";
    }
    if (input.contains("vitamin d")) {
        return "Vitamin D giúp hấp thụ canxi và duy trì xương chắc khỏe 🌤️. Bạn nên phơi nắng sáng 15 phút mỗi ngày hoặc dùng viên uống 1000 IU nếu thiếu.";
    }
    if (input.contains("vitamin b") || input.contains("b1") || input.contains("b12")) {
        return "Vitamin nhóm B giúp giảm mệt mỏi, căng thẳng và hỗ trợ thần kinh 💪. Bạn có thể dùng viên tổng hợp như Becozyme hoặc Neurobion.";
    }
    if (input.contains("canxi")) {
        return "Canxi giúp xương và răng chắc khỏe 🦴. Uống canxi sau bữa sáng hoặc trưa, kết hợp với vitamin D để hấp thu tốt hơn nhé.";
    }
    if (input.contains("omega 3") || input.contains("dha") || input.contains("epa")) {
        return "Omega-3 giúp tim mạch khỏe mạnh và tăng trí nhớ 🧠. Có nhiều trong dầu cá, cá hồi hoặc viên dầu cá Fish Oil.";
    }

    // ========== 🔹 CÂU HỎI ĐẶC BIỆT ==========
    if (input.contains("uống thuốc khi nào") || input.contains("trước ăn") || input.contains("sau ăn")) {
        return "Phần lớn thuốc nên uống sau ăn khoảng 15–30 phút 🍽️, nhưng một số thuốc dạ dày (như Omeprazol) cần uống trước ăn. Hãy đọc kỹ hướng dẫn hoặc hỏi dược sĩ khi mua nhé.";
    }
    if (input.contains("thuốc tránh thai")) {
        return "Thuốc tránh thai hằng ngày cần uống đều đặn vào cùng thời điểm mỗi ngày ⏰. Nếu quên dưới 12h, hãy uống ngay khi nhớ ra nhé.";
    }
    if (input.contains("bị mất ngủ")) {
        return "Bạn nên hạn chế caffeine, không dùng điện thoại trước ngủ, và có thể dùng viên uống Melatonin hoặc trà hoa cúc 🌙.";
    }
    if (input.contains("tiêu chảy")) {
        return "Bạn nên uống bù nước Oresol và tránh đồ ăn dầu mỡ 💧. Nếu tiêu chảy kéo dài trên 2 ngày hoặc có sốt, hãy đi khám nhé.";
    }
    if (input.contains("táo bón")) {
        return "Bạn nên ăn nhiều rau xanh, uống 2 lít nước mỗi ngày 💧, và có thể dùng Duphalac hoặc thực phẩm chứa chất xơ hòa tan nhé.";
    }
    if (input.contains("trẻ em") && input.contains("ho")) {
        return "Trẻ nhỏ bị ho nên dùng siro ho Prospan Kids hoặc Ích Nhi, kèm xông hơi ấm nhẹ để thông mũi cho bé nhé 👶.";
    }
    if (input.contains("bà bầu") && (input.contains("vitamin") || input.contains("thuốc"))) {
        return "Bà bầu nên dùng vitamin tổng hợp chứa sắt, canxi và DHA như Elevit hoặc Obimin 🌸. Hạn chế tự ý dùng thuốc không kê đơn nhé.";
    }

    // ========== 🔹 NGOÀI CHỦ ĐỀ ==========
    if (input.contains("người yêu") || input.contains("chatbot") || input.contains("ai tạo ra bạn")) {
        return "Haha 😄, tôi là Dược sĩ ảo của PharmacyLife, chỉ giỏi tư vấn thuốc và sức khỏe thôi ạ 💊.";
    }
    if (input.contains("tên gì")) {
        return "Tôi là Dược sĩ ảo PharmacyLife 👩‍⚕️, rất vui được hỗ trợ bạn!";
    }
    if (input.contains("bao nhiêu tuổi") || input.contains("ở đâu")) {
        return "Tôi không có tuổi hay địa chỉ cụ thể, nhưng luôn sẵn sàng giúp bạn ở bất kỳ đâu 🌍.";
    }

    // ========== 🔹 MẶC ĐỊNH ==========
    return "Tôi chưa hiểu rõ câu hỏi, bạn có thể nói lại cụ thể hơn không? 😊";
}

}
