/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.concurrent.ConcurrentHashMap;

/**
 *
 * @author qnhat
 */
public class OtpService {

    private static final ConcurrentHashMap<String, OtpData> otpStorage = new ConcurrentHashMap<>();
    private static final SecureRandom random = new SecureRandom();
    private static final int OTP_LENGTH = 6;
    private static final int OTP_EXPIRY_MINUTES = 5;

    public static class OtpData {

        private String otp;
        private LocalDateTime expiryTime;
        private String email;

        public OtpData(String otp, LocalDateTime expiryTime, String email) {
            this.otp = otp;
            this.expiryTime = expiryTime;
            this.email = email;
        }

        public String getOtp() {
            return otp;
        }

        public LocalDateTime getExpiryTime() {
            return expiryTime;
        }

        public String getEmail() {
            return email;
        }

        public boolean isExpired() {
            return LocalDateTime.now().isAfter(expiryTime);
        }
    }

    /**
     * Tạo mã OTP mới cho email
     */
    public static String generateOtp(String email) {
        // Xóa OTP cũ nếu có
        otpStorage.remove(email);

        // Tạo OTP mới
        String otp = generateRandomOtp();
        LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(OTP_EXPIRY_MINUTES);

        // Lưu vào storage
        otpStorage.put(email, new OtpData(otp, expiryTime, email));

        return otp;
    }

    /**
     * Xác thực mã OTP
     */
    public static boolean verifyOtp(String email, String inputOtp) {
        OtpData otpData = otpStorage.get(email);

        if (otpData == null) {
            return false; // Không tìm thấy OTP
        }

        if (otpData.isExpired()) {
            otpStorage.remove(email); // Xóa OTP hết hạn
            return false;
        }

        boolean isValid = otpData.getOtp().equals(inputOtp);

        if (isValid) {
            otpStorage.remove(email); // Xóa OTP sau khi sử dụng thành công
        }

        return isValid;
    }

    /**
     * Kiểm tra OTP có tồn tại và chưa hết hạn không
     */
    public static boolean hasValidOtp(String email) {
        OtpData otpData = otpStorage.get(email);
        return otpData != null && !otpData.isExpired();
    }

    /**
     * Xóa OTP (dùng khi cần thiết)
     */
    public static void removeOtp(String email) {
        otpStorage.remove(email);
    }

    /**
     * Tạo mã OTP ngẫu nhiên
     */
    private static String generateRandomOtp() {
        StringBuilder otp = new StringBuilder(OTP_LENGTH);
        for (int i = 0; i < OTP_LENGTH; i++) {
            otp.append(random.nextInt(10));
        }
        return otp.toString();
    }

    /**
     * Dọn dẹp các OTP hết hạn (có thể gọi định kỳ)
     */
    public static void cleanupExpiredOtps() {
        otpStorage.entrySet().removeIf(entry -> entry.getValue().isExpired());
    }
}
