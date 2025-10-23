package utils;

import config.EmailInformation;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {

    private Session session;
    private String from;

    public EmailService() {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", EmailInformation.getEmailHost());
        properties.put("mail.smtp.port", EmailInformation.getEmailPort());
        properties.put("mail.smtp.ssl.trust", EmailInformation.getEmailHost());
        
        this.session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(
                    EmailInformation.getEmailUsername(), 
                    EmailInformation.getAppPassword()
                );
            }
        });
        
        this.from = EmailInformation.getEmailUsername();
    }

    public boolean sendOtpEmail(String toEmail, String otp) {
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from, EmailInformation.getEmailName()));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã OTP đặt lại mật khẩu - PharmacyLife");
            
            String htmlContent = buildOtpEmailContent(otp);
            message.setContent(htmlContent, "text/html; charset=utf-8");
            
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private String buildOtpEmailContent(String otp) {
        return "<!DOCTYPE html>" +
               "<html>" +
               "<head>" +
               "<meta charset='UTF-8'>" +
               "<style>" +
               "body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4; }" +
               ".container { max-width: 600px; margin: 0 auto; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }" +
               ".header { text-align: center; color: #2c5aa0; margin-bottom: 30px; }" +
               ".otp-box { background-color: #f8f9fa; border: 2px dashed #2c5aa0; padding: 20px; text-align: center; margin: 20px 0; border-radius: 8px; }" +
               ".otp-code { font-size: 32px; font-weight: bold; color: #2c5aa0; letter-spacing: 5px; }" +
               ".warning { background-color: #fff3cd; border: 1px solid #ffeaa7; padding: 15px; border-radius: 5px; margin: 20px 0; color: #856404; }" +
               ".footer { text-align: center; margin-top: 30px; color: #666; font-size: 14px; }" +
               "</style>" +
               "</head>" +
               "<body>" +
               "<div class='container'>" +
               "<div class='header'>" +
               "<h1>🔐 Đặt lại mật khẩu</h1>" +
               "<h2>PharmacyLife</h2>" +
               "</div>" +
               "<p>Xin chào,</p>" +
               "<p>Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản của mình. Vui lòng sử dụng mã OTP bên dưới để tiếp tục:</p>" +
               "<div class='otp-box'>" +
               "<div class='otp-code'>" + otp + "</div>" +
               "</div>" +
               "<div class='warning'>" +
               "<strong>⚠️ Lưu ý quan trọng:</strong><br>" +
               "• Mã OTP này có hiệu lực trong 5 phút<br>" +
               "• Không chia sẻ mã này với bất kỳ ai<br>" +
               "• Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này" +
               "</div>" +
               "<p>Nếu bạn gặp bất kỳ vấn đề nào, vui lòng liên hệ với chúng tôi.</p>" +
               "<div class='footer'>" +
               "<p>Trân trọng,<br>Đội ngũ PharmacyLife</p>" +
               "</div>" +
               "</div>" +
               "</body>" +
               "</html>";
    }
}
