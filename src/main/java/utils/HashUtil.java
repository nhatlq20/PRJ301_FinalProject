package utils;

import org.mindrot.jbcrypt.BCrypt;


public class HashUtil {

    /**
     * Hash a password using BCrypt
     *
     * @param password the plain text password to hash
     * @return the hashed password
     */
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    /**
     * Check if a password matches a hashed password
     *
     * @param password the plain text password to check
     * @param hashedPassword the hashed password to compare against
     * @return true if the password matches, false otherwise
     */
    public static boolean checkPassword(String password, String hashedPassword) {
        if (hashedPassword == null) {
            return false;
        }

        hashedPassword = hashedPassword.trim();

        try {
            return BCrypt.checkpw(password, hashedPassword);
        } catch (IllegalArgumentException ex) {
            // stored password is not a valid bcrypt hash (legacy plaintext). 
            // Fallback to plaintext compare
            return hashedPassword.equals(password);
        }
    }

    /**
     * Check if a password matches a hashed password and rehash if needed This
     * method handles legacy plaintext passwords by rehashing them
     *
     * @param password the plain text password to check
     * @param hashedPassword the hashed password to compare against
     * @return PasswordCheckResult containing the match result and new hash if
     * rehashed
     */
    public static PasswordCheckResult checkPasswordAndRehash(String password, String hashedPassword) {
        if (hashedPassword == null) {
            return new PasswordCheckResult(false, null);
        }

        hashedPassword = hashedPassword.trim();

        try {
            boolean matches = BCrypt.checkpw(password, hashedPassword);
            return new PasswordCheckResult(matches, null);
        } catch (IllegalArgumentException ex) {
            // stored password is not a valid bcrypt hash (legacy plaintext). 
            // Fallback to plaintext compare
            if (hashedPassword.equals(password)) {
                // rehash with bcrypt
                String newHash = BCrypt.hashpw(password, BCrypt.gensalt());
                return new PasswordCheckResult(true, newHash);
            }
            return new PasswordCheckResult(false, null);
        }
    }

    /**
     * Result class for password checking with optional rehashing
     */
    public static class PasswordCheckResult {

        private final boolean matches;
        private final String newHash;

        public PasswordCheckResult(boolean matches, String newHash) {
            this.matches = matches;
            this.newHash = newHash;
        }

        public boolean isMatches() {
            return matches;
        }

        public String getNewHash() {
            return newHash;
        }

        public boolean needsRehash() {
            return newHash != null;
        }
    }
}
