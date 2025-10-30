package config;

public class EmailInformation {
    private static final String EMAIL_HOST = "smtp.gmail.com";
    private static final String EMAIL_PORT = "587";
    private static final String EMAIL_USERNAME = "nhatlq11a2.c3truonglongtay@gmail.com";
    private static final String EMAIL_NAME = "PharmacyLife";
    private static final String APP_PASSWORD = "grna anvr uljc mgvy"; // App password

    public static String getEmailHost() {
        return EMAIL_HOST;
    }

    public static String getEmailPort() {
        return EMAIL_PORT;
    }

    public static String getEmailUsername() {
        return EMAIL_USERNAME;
    }

    public static String getEmailName() {
        return EMAIL_NAME;
    }

    public static String getAppPassword() {
        return APP_PASSWORD;
    }
}
