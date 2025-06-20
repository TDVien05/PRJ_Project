/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */
import java.sql.*;
import java.util.*;
import utils.DbUtils;

public class InventoryLogDAO {

    public void insert(InventoryLogDTO log) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO inventory_logs(product_id, quantity_changed, change_date, reason) VALUES (?, ?, ?, ?)";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, log.getProductId());
            stmt.setInt(2, log.getQuantityChanged());
            stmt.setDate(3, java.sql.Date.valueOf(log.getChangeDate()));
            stmt.setString(4, log.getReason());
            stmt.executeUpdate();
        }
    }

    public InventoryLogDTO getById(Long id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM inventory_logs WHERE id = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                InventoryLogDTO log = new InventoryLogDTO();
                log.setId(rs.getLong("id"));
                log.setProductId(rs.getLong("product_id"));
                log.setQuantityChanged(rs.getInt("quantity_changed"));
                log.setChangeDate(rs.getDate("change_date").toLocalDate());
                log.setReason(rs.getString("reason"));
                return log;
            }
        }
        return null;
    }

    public List<InventoryLogDTO> getAll() throws SQLException, ClassNotFoundException {
        List<InventoryLogDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM inventory_logs";
        try (Connection conn = DbUtils.getConnection(); Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                InventoryLogDTO log = new InventoryLogDTO();
                log.setId(rs.getLong("id"));
                log.setProductId(rs.getLong("product_id"));
                log.setQuantityChanged(rs.getInt("quantity_changed"));
                log.setChangeDate(rs.getDate("change_date").toLocalDate());
                log.setReason(rs.getString("reason"));
                list.add(log);
            }
        }
        return list;
    }

    public void update(InventoryLogDTO log) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE inventory_logs SET product_id = ?, quantity_changed = ?, change_date = ?, reason = ? WHERE id = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, log.getProductId());
            stmt.setInt(2, log.getQuantityChanged());
            stmt.setDate(3, java.sql.Date.valueOf(log.getChangeDate()));
            stmt.setString(4, log.getReason());
            stmt.setLong(5, log.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(Long id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM inventory_logs WHERE id = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }
}
