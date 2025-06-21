/*
 * Click nfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nfs://SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DbUtils;
import model.UserDTO;

/**
 *
 * @author tungi
 */
public class UserDAO {

    public UserDAO() {
    }

    public boolean login(String username, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            System.out.println("Attempting login for username: " + username);
            
            UserDTO user = getUserByUsername(username);
            if (user != null) {
                System.out.println("User found: " + user.getUsername());
                System.out.println("User status: " + user.isStatus());
                System.out.println("Password check: " + user.getPassword().equals(password));
                
                if (user.getPassword().equals(password)) {
                    if (user.isStatus()) {
                        System.out.println("Login successful");
                        return true;
                    } else {
                        System.out.println("User account is inactive");
                    }
                } else {
                    System.out.println("Password mismatch");
                }
            } else {
                System.out.println("User not found");
            }
        } catch (Exception e) {
            System.out.println("Error in login: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public UserDTO getUserByUsername(String username) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            String sql = "SELECT * FROM users WHERE username=?";
            System.out.println("Executing query: " + sql + " with username: " + username);
            
            // B1 - Kết nối
            conn = DbUtils.getConnection();
            System.out.println("Database connection established");
            
            // B2 - Tạo công cụ thực thi câu lệnh
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            // B3 - Duyệt bảng
            if (rs.next()) {
                String id = rs.getString("id");
                String username1 = rs.getString("username");
                String password1 = rs.getString("password");
                String email = rs.getString("email");
                String address = rs.getString("address");
                String roleID = rs.getString("roleID");
                boolean status = rs.getBoolean("status");

                UserDTO userDTO = new UserDTO(id, username1, password1, email, address, roleID, status);
                System.out.println("User found: " + userDTO.toString());
                return userDTO;
            } else {
                System.out.println("No user found with username: " + username);
            }
            
        } catch (Exception e) {
            System.out.println("Error in getUserByUsername: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public boolean register(String username, String password, String email, String address) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            System.out.println("Starting registration for username: " + username);

            // Kết nối cơ sở dữ liệu
            conn = DbUtils.getConnection();

            // Kiểm tra các trường đầu vào
            if (username == null || username.trim().isEmpty()) {
                System.out.println("Error: Username is empty.");
                return false;
            }
            if (password == null || password.trim().isEmpty()) {
                System.out.println("Error: Password is empty.");
                return false;
            }
            if (email == null || email.trim().isEmpty() || !email.contains("@")) {
                System.out.println("Error: Email is invalid.");
                return false;
            }

            // Kiểm tra username đã tồn tại chưa
            String checkSql = "SELECT COUNT(*) FROM users WHERE username = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("Error: Username " + username + " already exists.");
                return false; // Username đã tồn tại
            }
            rs.close();
            pstmt.close();

            // Kiểm tra email đã tồn tại chưa
            checkSql = "SELECT COUNT(*) FROM users WHERE email = ?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("Error: Email " + email + " already exists.");
                return false; // Email đã tồn tại
            }
            rs.close();
            pstmt.close();

            // Thêm người dùng mới với roleID mặc định là 'CS'
            String insertSql = "INSERT INTO users (username, password, email, address, roleID, status) VALUES (?, ?, ?, ?, 'CS', 1)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, email);
            pstmt.setString(4, address != null ? address : "");
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);

            result = rowsAffected > 0;
            if (result) {
                System.out.println("Registration successful for username: " + username);
            } else {
                System.out.println("Registration failed for username: " + username);
            }

        } catch (Exception e) {
            System.out.println("Error during registration: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}