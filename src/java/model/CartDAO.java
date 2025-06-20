/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

/**
 *
 * @author DELL
 */
public class CartDAO {

    public void insert(CartDTO cart) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO cart(user_id, created_date) VALUES (?, ?)";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, cart.getUserId());
            stmt.setDate(2, Date.valueOf(cart.getCreatedDate()));
            stmt.executeUpdate();
        }
    }

    public CartDTO getById(Long id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM cart WHERE id = ?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                CartDTO cart = new CartDTO();
                cart.setId(rs.getLong("id"));
                cart.setUserId(rs.getLong("user_id"));
                cart.setCreatedDate(rs.getDate("created_date").toLocalDate());
                return cart;
            }
        }
        return null;
    }

    public List<CartDTO> getAll() throws SQLException, ClassNotFoundException {
        List<CartDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM cart";
        try ( Connection conn = DbUtils.getConnection();  Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                CartDTO cart = new CartDTO();
                cart.setId(rs.getLong("id"));
                cart.setUserId(rs.getLong("user_id"));
                cart.setCreatedDate(rs.getDate("created_date").toLocalDate());
                list.add(cart);
            }
        }
        return list;
    }

    public void update(CartDTO cart) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE cart SET user_id = ?, created_date = ? WHERE id = ?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, cart.getUserId());
            stmt.setDate(2, Date.valueOf(cart.getCreatedDate()));
            stmt.setLong(3, cart.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(Long id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM cart WHERE id = ?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }
}
