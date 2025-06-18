/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

/**
 *
 * @author tungi
 */
public class ProductDAO {

    //sql queries
    private static final String GET_ALL_PRODUCTS = "SELECT * FROM products";
    private static final String GET_PRODUCT_BY_ID = "SELECT * FROM products WHERE id = ?";
    private static final String GET_PRODUCT_BY_NAME = "SELECT * FROM products WHERE name = ?";
    private static final String CREATE_PRODUCT = "INSERT INTO products (id, name, price, description, price, size, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_PRODUCT = "UPDATE products SET name = ?, image = ?, description = ?, price = ?, size = ?, status = ? WHERE id = ?";
    private static final String DELETE_PRODUCT = "DELETE FROM products WHERE id = ?";

    public ProductDAO() {
    }

    public List<ProductDTO> getAll() {
        List<ProductDTO> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_PRODUCTS);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image_url"));
                product.setCategory(rs.getString("category"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setStatus(rs.getBoolean("status"));

                products.add(product);
            }
        } catch (Exception e) {
        } finally {
            closeResources(conn, ps, rs);
        }

        return products;
    }

    public ProductDTO getProductById(String id) {
        ProductDTO product = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_PRODUCT_BY_ID);
            ps.setString(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image_url"));
                product.setCategory(rs.getString("category"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setStatus(rs.getBoolean("status"));
            }

        } catch (Exception e) {
        } finally {
            closeResources(conn, ps, rs);
        }

        return product;
    }

    public boolean create(ProductDTO product) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(CREATE_PRODUCT);

            ps.setString(1, product.getId());
            ps.setString(2, product.getName());
            ps.setDouble(3, product.getPrice());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getImage());
            ps.setString(6, product.getCategory());
            ps.setInt(7, product.getStockQuantity());
            ps.setBoolean(8, product.isStatus());
            
            int rowAffected = ps.executeUpdate();
            if(rowAffected > 0) {
                success = true;
            }
            
        } catch (Exception e) {
            
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
        
    }
    
    
    public boolean update (ProductDTO product) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(UPDATE_PRODUCT);

            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getDescription());
            ps.setString(4, product.getImage());
            ps.setString(5, product.getCategory());
            ps.setInt(6, product.getStockQuantity());
            ps.setBoolean(7, product.isStatus());
            ps.setString(8, product.getId()); //Vì UPDATE_PRODUCT có "id = ?" at the end of the query
            
            
            int rowAffected = ps.executeUpdate();
            if(rowAffected > 0) {
                success = true;
            }
            
        } catch (Exception e) {
            
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }

    
    public boolean delete (String id) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(DELETE_PRODUCT);
            ps.setString(1, id); //Vì DELETE_PRODUCT = "DELETE FROM tblProducts WHERE id = ?"

            int rowAffected = ps.executeUpdate();
            if(rowAffected > 0) {
                success = true;
            }
            
        } catch (Exception e) {
            
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }
    
    
    public List<ProductDTO> getProductByName (String name){
        //need a list to add products have the same name
        List<ProductDTO> products = new ArrayList<>();
        
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = GET_ALL_PRODUCTS + "where name like ?";
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image_url"));
                product.setCategory(rs.getString("category"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setStatus(rs.getBoolean("status"));
                
                products.add(product);
            }
            
            
            
        } catch (Exception e) {
            
        } finally {
            closeResources(conn, ps, rs);
        }
        return products;
    }
    
    
    
    public boolean isProductExists(String id) {
        return getProductById(id) != null;
    }

    
    
    public List<ProductDTO> getProductsByStatus (boolean status){
        List<ProductDTO> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = GET_ALL_PRODUCTS + "where status = ?";
        
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setBoolean(1, status);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImage(rs.getString("image_url"));
                product.setCategory(rs.getString("category"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setStatus(rs.getBoolean("status"));
                
                products.add(product);
                
            }
        } catch (Exception e) {
        } finally {
            closeResources(conn, ps, rs);
        }
        
        return products;
    }
    
    
    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (conn != null) {
                conn.close();
            }

            if (ps != null) {
                ps.close();
            }

            if (rs != null) {
                rs.close();
            }
        } catch (Exception e) {
        }
    }
}
