
package utils;

import java.util.regex.Pattern;

public class Validator {
    
    // Email regex pattern
    private static final String EMAIL_PATTERN = 
        "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
    
    // Phone number regex pattern (Vietnamese format)
    private static final String PHONE_PATTERN = 
        "^(\\+84|84|0)[1-9][0-9]{8,9}$";
    
    private static final Pattern emailPattern = Pattern.compile(EMAIL_PATTERN);
    private static final Pattern phonePattern = Pattern.compile(PHONE_PATTERN);
    
    /**
     * Validate login form input
     * @param usernameOrEmail username or email
     * @param password password
     * @return ValidationResult containing validation status and error message
     */
    public static ValidationResult validateLogin(String usernameOrEmail, String password) {
        if (isNullOrEmpty(usernameOrEmail) || isNullOrEmpty(password)) {
            return new ValidationResult(false, "Vui lòng điền đầy đủ thông tin!");
        }
        
        return new ValidationResult(true, null);
    }
    
    /**
     * Validate registration form input
     * @param username username
     * @param email email
     * @param password password
     * @param confirmPassword confirm password
     * @param fullName full name
     * @param phoneNumber phone number
     * @return ValidationResult containing validation status and error message
     */
    public static ValidationResult validateRegistration(String username, String email, String password, 
                                                      String confirmPassword, String fullName, String phoneNumber) {
        // Check required fields
        if (isNullOrEmpty(username) || isNullOrEmpty(email) || isNullOrEmpty(password)) {
            return new ValidationResult(false, "Vui lòng điền đầy đủ thông tin bắt buộc!");
        }
        
        // Validate email format
        if (!isValidEmail(email)) {
            return new ValidationResult(false, "Email không hợp lệ!");
        }
        
        // Validate password confirmation
        if (!password.equals(confirmPassword)) {
            return new ValidationResult(false, "Mật khẩu xác nhận không khớp!");
        }
        
        // Validate password strength
        ValidationResult passwordResult = validatePassword(password);
        if (!passwordResult.isValid()) {
            return passwordResult;
        }
        
        // Validate phone number if provided
        if (!isNullOrEmpty(phoneNumber) && !isValidPhoneNumber(phoneNumber)) {
            return new ValidationResult(false, "Số điện thoại không hợp lệ!");
        }
        
        return new ValidationResult(true, null);
    }
    
    /**
     * Validate password strength
     * @param password password to validate
     * @return ValidationResult containing validation status and error message
     */
    public static ValidationResult validatePassword(String password) {
        if (isNullOrEmpty(password)) {
            return new ValidationResult(false, "Mật khẩu không được để trống!");
        }
        
        if (password.length() < 6) {
            return new ValidationResult(false, "Mật khẩu phải có ít nhất 6 ký tự!");
        }
        
        if (password.length() > 50) {
            return new ValidationResult(false, "Mật khẩu không được vượt quá 50 ký tự!");
        }
        
        return new ValidationResult(true, null);
    }
    
    /**
     * Validate email format
     * @param email email to validate
     * @return true if email is valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        if (isNullOrEmpty(email)) {
            return false;
        }
        return emailPattern.matcher(email.trim()).matches();
    }
    
    /**
     * Validate phone number format
     * @param phoneNumber phone number to validate
     * @return true if phone number is valid, false otherwise
     */
    public static boolean isValidPhoneNumber(String phoneNumber) {
        if (isNullOrEmpty(phoneNumber)) {
            return true; // Phone number is optional
        }
        return phonePattern.matcher(phoneNumber.trim()).matches();
    }
    
    /**
     * Validate username format
     * @param username username to validate
     * @return ValidationResult containing validation status and error message
     */
    public static ValidationResult validateUsername(String username) {
        if (isNullOrEmpty(username)) {
            return new ValidationResult(false, "Tên đăng nhập không được để trống!");
        }
        
        if (username.length() < 3) {
            return new ValidationResult(false, "Tên đăng nhập phải có ít nhất 3 ký tự!");
        }
        
        if (username.length() > 30) {
            return new ValidationResult(false, "Tên đăng nhập không được vượt quá 30 ký tự!");
        }
        
        // Check for valid characters (alphanumeric and underscore only)
        if (!username.matches("^[a-zA-Z0-9_]+$")) {
            return new ValidationResult(false, "Tên đăng nhập chỉ được chứa chữ cái, số và dấu gạch dưới!");
        }
        
        return new ValidationResult(true, null);
    }
    
    /**
     * Check if string is null or empty
     * @param str string to check
     * @return true if string is null or empty, false otherwise
     */
    public static boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }
    
    /**
     * Sanitize input string
     * @param input input string
     * @return sanitized string
     */
    public static String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        return input.trim();
    }
    
    /**
     * Result class for validation operations
     */
    public static class ValidationResult {
        private final boolean valid;
        private final String errorMessage;
        
        public ValidationResult(boolean valid, String errorMessage) {
            this.valid = valid;
            this.errorMessage = errorMessage;
        }
        
        public boolean isValid() {
            return valid;
        }
        
        public String getErrorMessage() {
            return errorMessage;
        }
        
        public boolean hasError() {
            return !valid;
        }
    }
}
