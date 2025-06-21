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
    private static final String CREATE_PRODUCT = "INSERT INTO products (id, name, price, description, image_url, category_id, stock_quantity, status, brand_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_PRODUCT = "UPDATE products SET name = ?, price = ?, description = ?, image_url = ?, category = ?, stock_quantity = ?, status = ? WHERE id = ?";
    private static final String DELETE_PRODUCT = "DELETE FROM products WHERE id = ?";
    private static final String GET_ACTIVE_PRODUCTS_BY_NAME = "SELECT * FROM products WHERE name LIKE ? AND status = 1";

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
                product.setImageUrl(rs.getString("image_url"));
                product.setCategoryId(rs.getString("category_id"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setStatus(rs.getBoolean("status"));
                product.setBrandId(rs.getInt("brand_id"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
                product = new ProductDTO(); // Initialize the product object here!
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImageUrl(rs.getString("image_url"));
                product.setCategoryId(rs.getString("category_id"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setStatus(rs.getBoolean("status"));
                product.setBrandId(rs.getInt("brand_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
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
            ps.setString(5, product.getImageUrl());
            ps.setString(6, product.getCategoryId());
            ps.setInt(7, product.getStockQuantity());
            ps.setBoolean(8, product.isStatus());
            ps.setInt(9, product.getBrandId());

            int rowAffected = ps.executeUpdate();
            if (rowAffected > 0) {
                success = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }

    public boolean update(ProductDTO product) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(UPDATE_PRODUCT);

            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getDescription());
            ps.setString(4, product.getImageUrl());
            ps.setString(5, product.getCategoryId());
            ps.setInt(6, product.getStockQuantity());
            ps.setBoolean(7, product.isStatus());
            ps.setInt(8, product.getBrandId());
            ps.setString(9, product.getId()); // ID goes last for WHERE clause

            int rowAffected = ps.executeUpdate();
            if (rowAffected > 0) {
                success = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }

    public boolean delete(String id) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(DELETE_PRODUCT);
            ps.setString(1, id);

            int rowAffected = ps.executeUpdate();
            if (rowAffected > 0) {
                success = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
        return success;
    }

    public List<ProductDTO> getProductByName(String name) {
        List<ProductDTO> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String query = GET_ALL_PRODUCTS + " WHERE name LIKE ?";
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImageUrl(rs.getString("image_url"));
                product.setCategoryId(rs.getString("category_id"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setStatus(rs.getBoolean("status"));
                product.setBrandId(rs.getInt("brand_id"));

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return products;
    }

    /**
     * Get active products by name (status = 1)
     *
     * @param name Product name to search
     * @return List of active products matching the name
     */
    public List<ProductDTO> getActiveProductByName(String name) {
        List<ProductDTO> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_ACTIVE_PRODUCTS_BY_NAME);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImageUrl(rs.getString("image_url"));
                product.setCategoryId(rs.getString("category_id"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setStatus(rs.getBoolean("status"));
                product.setBrandId(rs.getInt("brand_id"));

                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return products;
    }

    public boolean isProductExists(String id) {
        return getProductById(id) != null;
    }

    public List<ProductDTO> getProductsByStatus(boolean status) {
        List<ProductDTO> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String query = GET_ALL_PRODUCTS + " WHERE status = ?";

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
                product.setImageUrl(rs.getString("image_url"));
                product.setCategoryId(rs.getString("category_id"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setStatus(rs.getBoolean("status"));
                product.setBrandId(rs.getInt("brand_id"));

                products.add(product);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return products;
    }

    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
