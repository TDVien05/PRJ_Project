<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bagshop.models.Product" %>
<%@ page import="utils.AuthUtils" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cập Nhật Sản Phẩm</title>
    <style>
        .error-message { color: red; font-size: 0.9em; }
        .success-message { color: green; font-size: 0.9em; }
    </style>
</head>
<body>
    <%
        if (AuthUtils.isAdmin(request)) {
            Product product = (Product) request.getAttribute("product");
            boolean hasError = request.getAttribute("errorMessage") != null;
    %>
    <form action="ProductServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="updateProduct"/>
        <div>
            <label for="id">ID*</label>
            <input type="text" name="id" id="id" value="<%= hasError ? request.getParameter("id") != null ? request.getParameter("id") : "" : (product != null ? String.valueOf(product.getId()) : "") %>" required="required"/>
            <%
                String idError = (String) request.getAttribute("idError");
                if (idError != null && !idError.isEmpty()) {
            %>
                <div class="error-message"><%= idError %></div>
            <% } %>
        </div>
        <div>
            <label for="name">Name*</label>
            <input type="text" name="name" id="name" value="<%= hasError ? request.getParameter("name") != null ? request.getParameter("name") : "" : (product != null ? product.getName() != null ? product.getName() : "" : "") %>" required="required"/>
            <%
                String nameError = (String) request.getAttribute("nameError");
                if (nameError != null && !nameError.isEmpty()) {
            %>
                <div class="error-message"><%= nameError %></div>
            <% } %>
        </div>
        <div>
            <label for="price">Price</label>
            <input type="number" name="price" id="price" min="0" step="0.01" value="<%= hasError ? request.getParameter("price") != null ? request.getParameter("price") : "" : (product != null ? String.valueOf(product.getPrice()) : "") %>" required="required"/>
            <%
                String priceError = (String) request.getAttribute("priceError");
                if (priceError != null && !priceError.isEmpty()) {
            %>
                <div class="error-message"><%= priceError %></div>
            <% } %>
        </div>
        <div>
            <label for="description">Description</label>
            <textarea name="description" id="description"><%= hasError ? request.getParameter("description") != null ? request.getParameter("description") : "" : (product != null ? product.getDescription() != null ? product.getDescription() : "" : "") %></textarea>
            <%
                String descriptionError = (String) request.getAttribute("descriptionError");
                if (descriptionError != null && !descriptionError.isEmpty()) {
            %>
                <div class="error-message"><%= descriptionError %></div>
            <% } %>
        </div>
        <div>
            <label for="categoryId">Category</label>
            <%
                String selectedCategory = hasError ? request.getParameter("categoryId") != null ? request.getParameter("categoryId") : "" : (product != null ? String.valueOf(product.getCategoryId()) : "");
            %>
            <select name="categoryId" required>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        conn = DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=BagShopDB", "sa", "your_password");
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT id, category_name FROM categories");
                        while (rs.next()) {
                            int categoryId = rs.getInt("id");
                            String categoryName = rs.getString("category_name");
                %>
                            <option value="<%= categoryId %>" <%= selectedCategory.equals(String.valueOf(categoryId)) ? "selected" : "" %>><%= categoryName %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </select>
            <%
                String categoryError = (String) request.getAttribute("categoryError");
                if (categoryError != null && !categoryError.isEmpty()) {
            %>
                <div class="error-message"><%= categoryError %></div>
            <% } %>
        </div>
        <div>
            <label for="stock_quantity">Quantity</label>
            <input type="number" name="stock_quantity" id="stock_quantity" value="<%= hasError ? request.getParameter("stock_quantity") != null ? request.getParameter("stock_quantity") : "" : (product != null ? String.valueOf(product.getStockQuantity()) : "") %>" required="required"/>
            <%
                String stockQuantityError = (String) request.getAttribute("stockQuantityError");
                if (stockQuantityError != null && !stockQuantityError.isEmpty()) {
            %>
                <div class="error-message"><%= stockQuantityError %></div>
            <% } %>
        </div>
        <div>
            <label for="image">Image</label>
            <input type="file" id="image" name="image" accept="image/*">
            <%
                if (product != null && product.getImageUrl() != null && !product.getImageUrl().isEmpty()) {
            %>
                <img src="<%= product.getImageUrl() %>" alt="Ảnh hiện tại" style="max-width: 100px;">
            <% } %>
            <%
                String imageError = (String) request.getAttribute("imageError");
                if (imageError != null && !imageError.isEmpty()) {
            %>
                <div class="error-message"><%= imageError %></div>
            <% } %>
        </div>
        <div>
            <label for="status">Status (Active Product)</label>
            <input type="checkbox" name="status" id="status" <%= hasError && "on".equals(request.getParameter("status")) ? "checked" : (product != null && product.getStatus() ? "checked" : "") %> value="true"/>
            <%
                String statusError = (String) request.getAttribute("statusError");
                if (statusError != null && !statusError.isEmpty()) {
            %>
                <div class="error-message"><%= statusError %></div>
            <% } %>
        </div>
        <div>
            <input type="submit" value="Cập Nhật Sản Phẩm"/>
            <input type="reset" value="Reset"/>
        </div>
    </form>

    <!-- Thông Báo Tổng Quát -->
    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (successMessage != null || errorMessage != null) {
    %>
        <div>
            <%
                if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
                <div class="error-message"><%= errorMessage %></div>
            <% } %>
            <%
                if (successMessage != null && !successMessage.isEmpty()) {
            %>
                <div class="success-message"><%= successMessage %></div>
            <% } %>
        </div>
    <% } %>
    <%
        } else {
    %>
        <%= AuthUtils.getAccessDeniedMessage("update-product-form page") %>
    <% } %>
</body>
</html>