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


public class ShippingInfoDAO {
    public void insert(ShippingInfoDTO info) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO shipping_info(order_id, recipient_name, address, phone_number) VALUES (?, ?, ?, ?)";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, info.getOrderId());
            stmt.setString(2, info.getRecipientName());
            stmt.setString(3, info.getAddress());
            stmt.setString(4, info.getPhoneNumber());
            stmt.executeUpdate();
        }
    }

    public ShippingInfoDTO getById(Long id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM shipping_info WHERE id = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                ShippingInfoDTO info = new ShippingInfoDTO();
                info.setId(rs.getLong("id"));
                info.setOrderId(rs.getLong("order_id"));
                info.setRecipientName(rs.getString("recipient_name"));
                info.setAddress(rs.getString("address"));
                info.setPhoneNumber(rs.getString("phone_number"));
                return info;
            }
        }
        return null;
    }

    public List<ShippingInfoDTO> getAll() throws SQLException, ClassNotFoundException {
        List<ShippingInfoDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM shipping_info";
        try (Connection conn = DbUtils.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                ShippingInfoDTO info = new ShippingInfoDTO();
                info.setId(rs.getLong("id"));
                info.setOrderId(rs.getLong("order_id"));
                info.setRecipientName(rs.getString("recipient_name"));
                info.setAddress(rs.getString("address"));
                info.setPhoneNumber(rs.getString("phone_number"));
                list.add(info);
            }
        }
        return list;
    }

    public void update(ShippingInfoDTO info) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE shipping_info SET order_id = ?, recipient_name = ?, address = ?, phone_number = ? WHERE id = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, info.getOrderId());
            stmt.setString(2, info.getRecipientName());
            stmt.setString(3, info.getAddress());
            stmt.setString(4, info.getPhoneNumber());
            stmt.setLong(5, info.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(Long id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM shipping_info WHERE id = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }
}

