/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.UserDAO;
import model.UserDTO;
import utils.DbUtils;

/**
 *
 * @author HOME-MACPRO
 */
@WebServlet(name = "UserController", urlPatterns = {"/user-controller"})
public class UserController extends HttpServlet {

    private static final String LOGIN = "Authentication/loginForm.jsp";
    private static final String REGISTER = "Authentication/registerForm.jsp";
    private static final String WELCOME = "welcome.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN;
        try {
            String action = request.getParameter("action");
            if ("login".equals(action)) {
                url = handleLogin(request, response);
            } else if ("logout".equals(action)) {
                url = handleLogout(request, response);
            } else if ("register".equals(action)) {
                url = handleRegister(request, response);
            } else {
                request.setAttribute("message", "Invalid action: " + action);
                url = LOGIN;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "System error occurred!");
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private String handleLogin(HttpServletRequest request, HttpServletResponse response) {
        String url = LOGIN;
        HttpSession session = request.getSession();
        String strUsername = request.getParameter("strUsername");
        String strPassword = request.getParameter("strPassword");
        
        // Debug log
        System.out.println("Login attempt - Username: " + strUsername);
        
        UserDAO userDAO = new UserDAO();
        if (userDAO.login(strUsername, strPassword)) {
            UserDTO user = userDAO.getUserByUsername(strUsername);
            if (user != null) {
                // Set both user object and userId in session
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());
                
                System.out.println("Login successful for user: " + user.getUsername());
                url = WELCOME;
            } else {
                System.out.println("User object is null");
                request.setAttribute("message", "Login failed - user data not found!");
                url = LOGIN;
            }
        } else {
            System.out.println("Login failed for username: " + strUsername);
            request.setAttribute("message", "Username or Password incorrect!");
            url = LOGIN;
        }
        
        System.out.println("Redirecting to: " + url);
        return url;
    }

    private String handleLogout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return LOGIN;
    }

    private String handleRegister(HttpServletRequest request, HttpServletResponse response) {
        String url = REGISTER;
        try {
            // Lấy dữ liệu từ form
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String address = request.getParameter("address");

            // Kiểm tra dữ liệu đầu vào
            if (username == null || username.trim().isEmpty()) {
                request.setAttribute("usernameError", "Username không được để trống!");
                return url;
            }
            if (password == null || password.trim().isEmpty()) {
                request.setAttribute("passwordError", "Password không được để trống!");
                return url;
            }
            if (email == null || email.trim().isEmpty() || !email.contains("@")) {
                request.setAttribute("emailError", "Email không hợp lệ!");
                return url;
            }

            // Gọi UserDAO để xử lý đăng ký
            UserDAO userDAO = new UserDAO();
            boolean isRegistered = userDAO.register(username, password, email, address);

            if (isRegistered) {
                request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
                url = LOGIN;
            } else {
                if (username != null && !username.trim().isEmpty()) {
                    request.setAttribute("message", "Đăng ký thất bại! Vui lòng kiểm tra lại.");
                    // Kiểm tra lỗi cụ thể
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        conn = DbUtils.getConnection();
                        String checkSql = "SELECT COUNT(*) FROM users WHERE username = ?";
                        pstmt = conn.prepareStatement(checkSql);
                        pstmt.setString(1, username);
                        rs = pstmt.executeQuery();
                        if (rs.next() && rs.getInt(1) > 0) {
                            request.setAttribute("usernameError", "Username đã tồn tại!");
                        }
                        pstmt.close();

                        checkSql = "SELECT COUNT(*) FROM users WHERE email = ?";
                        pstmt = conn.prepareStatement(checkSql);
                        pstmt.setString(1, email);
                        rs = pstmt.executeQuery();
                        if (rs.next() && rs.getInt(1) > 0) {
                            request.setAttribute("emailError", "Email đã tồn tại!");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi không xác định: " + e.getMessage());
        }
        return url;
    }
}