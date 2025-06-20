/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;
import java.util.*;
import utils.DbUtils;

public class OrderDAO {

    public void insert(OrderDTO order) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO orders(user_id, total_amount, status, order_date) VALUES (?, ?, ?, ?)";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, order.getUserId());
            stmt.setDouble(2, order.getTotalAmount());
            stmt.setString(3, order.getStatus());
            stmt.setDate(4, java.sql.Date.valueOf(order.getOrderDate()));
            stmt.executeUpdate();
        }
    }

    public OrderDTO getById(Long id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM orders WHERE id = ?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setId(rs.getLong("id"));
                order.setUserId(rs.getLong("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setOrderDate(rs.getDate("order_date").toLocalDate());
                return order;
            }
        }
        return null;
    }

    public List<OrderDTO> getAll() throws SQLException, ClassNotFoundException {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM orders";
        try ( Connection conn = DbUtils.getConnection();  Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setId(rs.getLong("id"));
                order.setUserId(rs.getLong("user_id"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setOrderDate(rs.getDate("order_date").toLocalDate());
                list.add(order);
            }
        }
        return list;
    }

    public void update(OrderDTO order) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE orders SET user_id = ?, total_amount = ?, status = ?, order_date = ? WHERE id = ?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, order.getUserId());
            stmt.setDouble(2, order.getTotalAmount());
            stmt.setString(3, order.getStatus());
            stmt.setDate(4, java.sql.Date.valueOf(order.getOrderDate()));
            stmt.setLong(5, order.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(Long id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM orders WHERE id = ?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }
}
