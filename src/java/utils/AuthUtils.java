package utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.UserDTO;

/*
 * Click nfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nfs://SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author HOME-MACPRO
 */
public class AuthUtils {
    // REGEX constants
    public static final String USERNAME_REGEX = "^[a-zA-Z0-9]+$";
    public static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$";
    public static final String EMAIL_REGEX = "^[a-zA-Z0-9._%+-]+@gmail\\.com$";

    public static UserDTO getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession();
        if (session != null) {
            return (UserDTO) session.getAttribute("user");
        }
        return null;
    }

    public static boolean isLoggedIn(HttpServletRequest request) {
        return AuthUtils.getCurrentUser(request) != null;
    }

    public static boolean hasRole(HttpServletRequest request, String role) {
        UserDTO user = getCurrentUser(request);
        if (user != null) {
            String userRole = user.getRoleID();
            return userRole != null && userRole.equals(role);
        }
        return false;
    }

    public static boolean isAdmin(HttpServletRequest request) {
        return hasRole(request, "AD");
    }

    public static boolean isCustomer(HttpServletRequest request) {
        return hasRole(request, "CS");
    }

    public static String getLoginURL() {
        return "MainController?action=login";
    }

    public static String getAccessDeniedMessage(String action) {
        return "You don't have permission to access " + action + ". Please contact administrator.";
    }

    public static String validateCredentials(String username, String password, String email) {
        // Username: Only letters and numbers, no special characters
        if (!username.matches(USERNAME_REGEX)) {
            return "Username must contain only letters and numbers, no special characters.";
        }

        // Password: At least 8 characters, including lowercase, uppercase, digit, and special character
        if (!password.matches(PASSWORD_REGEX)) {
            return "Password must be at least 8 characters long, including lowercase, uppercase, digit, and special character (@#$%^&+=!).";
        }

        // Email: Must contain @gmail.com
        if (!email.matches(EMAIL_REGEX)) {
            return "Email must be a valid @gmail.com address.";
        }

        return null;
    }
}