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


public class OrderDetailDAO {
    public void insert(OrderDetailDTO d) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO order_details(order_id, product_id, quantity, price_at_order) VALUES (?, ?, ?, ?)";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, d.getOrderId());
            stmt.setLong(2, d.getProductId());
            stmt.setInt(3, d.getQuantity());
            stmt.setDouble(4, d.getPriceAtOrder());
            stmt.executeUpdate();
        }
    }

    public OrderDetailDTO getById(Long id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM order_details WHERE id = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                OrderDetailDTO d = new OrderDetailDTO();
                d.setId(rs.getLong("id"));
                d.setOrderId(rs.getLong("order_id"));
                d.setProductId(rs.getLong("product_id"));
                d.setQuantity(rs.getInt("quantity"));
                d.setPriceAtOrder(rs.getDouble("price_at_order"));
                return d;
            }
        }
        return null;
    }

    public List<OrderDetailDTO> getAll() throws SQLException, ClassNotFoundException {
        List<OrderDetailDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM order_details";
        try (Connection conn = DbUtils.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                OrderDetailDTO d = new OrderDetailDTO();
                d.setId(rs.getLong("id"));
                d.setOrderId(rs.getLong("order_id"));
                d.setProductId(rs.getLong("product_id"));
                d.setQuantity(rs.getInt("quantity"));
                d.setPriceAtOrder(rs.getDouble("price_at_order"));
                list.add(d);
            }
        }
        return list;
    }

    public void update(OrderDetailDTO d) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE order_details SET order_id = ?, product_id = ?, quantity = ?, price_at_order = ? WHERE id = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, d.getOrderId());
            stmt.setLong(2, d.getProductId());
            stmt.setInt(3, d.getQuantity());
            stmt.setDouble(4, d.getPriceAtOrder());
            stmt.setLong(5, d.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(Long id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM order_details WHERE id = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }
}

