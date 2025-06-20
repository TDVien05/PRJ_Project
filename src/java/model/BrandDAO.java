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

public class BrandDAO {
    public void insert(BrandDTO brand) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO brand(brand_name, description, status) VALUES (?, ?, ?)";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, brand.getBrandName());
            stmt.setString(2, brand.getDescription());
            stmt.setString(3, brand.getStatus());
            stmt.executeUpdate();
        }
    }

    public BrandDTO getById(Long id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM brand WHERE id = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                BrandDTO brand = new BrandDTO();
                brand.setId(rs.getLong("id"));
                brand.setBrandName(rs.getString("brand_name"));
                brand.setDescription(rs.getString("description"));
                brand.setStatus(rs.getString("status"));
                return brand;
            }
        }
        return null;
    }

    public List<BrandDTO> getAll() throws SQLException, ClassNotFoundException {
        List<BrandDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM brand";
        try (Connection conn = DbUtils.getConnection(); Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                BrandDTO brand = new BrandDTO();
                brand.setId(rs.getLong("id"));
                brand.setBrandName(rs.getString("brand_name"));
                brand.setDescription(rs.getString("description"));
                brand.setStatus(rs.getString("status"));
                list.add(brand);
            }
        }
        return list;
    }

    public void update(BrandDTO brand) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE brand SET brand_name=?, description=?, status=? WHERE id=?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, brand.getBrandName());
            stmt.setString(2, brand.getDescription());
            stmt.setString(3, brand.getStatus());
            stmt.setLong(4, brand.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(Long id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM brand WHERE id=?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }
}
