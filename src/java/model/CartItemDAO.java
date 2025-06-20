/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;
import java.util.*;
import utils.DbUtils;

public class CartItemDAO {
    public void insert(CartItemDTO item) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO cart_items(cart_id, product_id, quantity) VALUES (?, ?, ?)";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, item.getCartId());
            stmt.setLong(2, item.getProductId());
            stmt.setInt(3, item.getQuantity());
            stmt.executeUpdate();
        }
    }

    public CartItemDTO getById(Long id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM cart_items WHERE id = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                CartItemDTO item = new CartItemDTO();
                item.setId(rs.getLong("id"));
                item.setCartId(rs.getLong("cart_id"));
                item.setProductId(rs.getLong("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                return item;
            }
        }
        return null;
    }

    public List<CartItemDTO> getAll() throws SQLException, ClassNotFoundException {
        List<CartItemDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM cart_items";
        try (Connection conn = DbUtils.getConnection(); Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                CartItemDTO item = new CartItemDTO();
                item.setId(rs.getLong("id"));
                item.setCartId(rs.getLong("cart_id"));
                item.setProductId(rs.getLong("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                list.add(item);
            }
        }
        return list;
    }

    public void update(CartItemDTO item) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE cart_items SET cart_id = ?, product_id = ?, quantity = ? WHERE id = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, item.getCartId());
            stmt.setLong(2, item.getProductId());
            stmt.setInt(3, item.getQuantity());
            stmt.setLong(4, item.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(Long id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM cart_items WHERE id = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }
}
