/*
 * Click nfs://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nfs://SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
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
        try {
            UserDTO user = getUserByUsername(username);
            if (user != null) {
                if (user.getPassword().equals(password)) {
                    if (user.isStatus()) {
                        return true;
                    }
                }
            } 
        } catch (Exception e) {
        }
        return false;
    }

    public UserDTO getUserByUsername(String username) {
        try {
            String sql = "SELECT * FROM users WHERE username=?";
            // B1 - Kết nối
            Connection conn = DbUtils.getConnection();
            //
            // B2 - Tạo công cụ thực thi câu lệnh
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();

            // B3 - Duyệt bảng
            while (rs.next()) {
                String id = rs.getString("id");
                String username1 = rs.getString("username");
                String password1 = rs.getString("password");
                String email = rs.getString("email");
                String address = rs.getString("address");
                String roleID = rs.getString("roleID");
                boolean status = rs.getBoolean("status");

                UserDTO userDTO = new UserDTO(id, username, password1, email, address, roleID, status);
                return userDTO;
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }

    public boolean register(String username, String password, String email, String address) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {

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
            ResultSet rs = pstmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                System.out.println("Error: Username " + username + " already exists.");
                return false; // Username đã tồn tại
            }
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
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (Exception e) {
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                }
            }
        }
        return result;
    }
}
