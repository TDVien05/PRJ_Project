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


public class CategoryDAO {
    public void insert(CategoryDTO c) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO categories(category_name, category_description) VALUES (?, ?)";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getCategoryName());
            stmt.setString(2, c.getCategoryDescription());
            stmt.executeUpdate();
        }
    }

    public CategoryDTO getById(Long id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM categories WHERE id = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                CategoryDTO c = new CategoryDTO();
                c.setId(rs.getLong("id"));
                c.setCategoryName(rs.getString("category_name"));
                c.setCategoryDescription(rs.getString("category_description"));
                return c;
            }
        }
        return null;
    }

    public List<CategoryDTO> getAll() throws SQLException, ClassNotFoundException {
        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        try (Connection conn = DbUtils.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                CategoryDTO c = new CategoryDTO();
                c.setId(rs.getLong("id"));
                c.setCategoryName(rs.getString("category_name"));
                c.setCategoryDescription(rs.getString("category_description"));
                list.add(c);
            }
        }
        return list;
    }

    public void update(CategoryDTO c) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE categories SET category_name = ?, category_description = ? WHERE id = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getCategoryName());
            stmt.setString(2, c.getCategoryDescription());
            stmt.setLong(3, c.getId());
            stmt.executeUpdate();
        }
    }

    public void delete(Long id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM categories WHERE id = ?";
        try (Connection conn = DbUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            stmt.executeUpdate();
        }
    }
}

