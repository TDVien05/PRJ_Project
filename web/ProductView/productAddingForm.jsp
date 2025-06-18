<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="utils.AuthUtils"%>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { width: 50%; margin: auto; }
        select, input, textarea { width: 100%; padding: 8px; margin: 5px 0; }
        input[type="submit"] { width: auto; background: #4CAF50; color: white; padding: 10px 20px; cursor: pointer; }
        input[type="file"] { padding: 3px; }
        input[type="checkbox"] { width: auto; margin-right: 5px; }
        .form-section { display: none; margin-top: 20px; }
        .active { display: block; }
        .error { color: red; }
    </style>
    <script>
        function toggleForm() {
            const action = document.getElementById("action").value;
            document.getElementById("addForm").classList.remove("active");
            document.getElementById("updateIdForm").classList.remove("active");
            document.getElementById("updateForm").classList.remove("active");
            if (action === "addProduct") {
                document.getElementById("addForm").classList.add("active");
            } else if (action === "updateProduct") {
                document.getElementById("updateIdForm").classList.add("active");
            }
        }
        function validateFile(input) {
            const maxSize = 5 * 1024 * 1024; // 5MB
            for (let file of input.files) {
                if (file.size > maxSize) {
                    alert("File " + file.name + " so big. Only choose < 5MB");
                    input.value = "";
                }
                if (!file.type.startsWith("image/")) {
                    alert("File " + file.name + " not image!");
                    input.value = "";
                }
            }
        }
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function(e) {
                const price = form.querySelector('input[name="price"]');
                const stock = form.querySelector('input[name="stock_quantity"]');
                if (price && parseFloat(price.value) <= 0) {
                    alert('Price must be greater than 0!');
                    e.preventDefault();
                }
                if (stock && parseInt(stock.value) < 0) {
                    alert('Stock cannot be negative');
                    e.preventDefault();
                }
            });
        });
    </script>
</head>
<body>
    <%
        if(AuthUtils.isAdmin(request)){
        ProductDTO product = (ProductDTO) request.getAttribute("product");
    %>
    <div class="container">
        <h2>Product Manager</h2>
        <label for="action">Choose Action:</label>
        <select id="action" name="action" onchange="toggleForm()">
            <option value="">-- Choose Action --</option>
            <option value="addProduct">Add new product</option>
            <option value="updateProduct">Update product</option>
        </select>

        <!-- Form Thêm Sản Phẩm -->
        <div id="addForm" class="form-section">
            <h3>Add New Product</h3>
            <form action="ProductController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="addProduct">
                <div>
                    <label for="name">ID:</label>
                    <input type="text" name="name" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>" required>
                    <%
                        String idError = (String) request.getAttribute("idError");
                        if (idError != null && !idError.isEmpty()) {
                    %>
                        <div class="error-message"><%= idError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="name">Name:</label>
                    <input type="text" name="name" value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>" required>
                    <%
                        String nameError = (String) request.getAttribute("nameError");
                        if (nameError != null && !nameError.isEmpty()) {
                    %>
                        <div class="error-message"><%= nameError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="price">Price:</label>
                    <input type="number" name="price" value="<%= request.getParameter("price") != null ? request.getParameter("price") : "" %>" required>
                    <%
                        String priceError = (String) request.getAttribute("priceError");
                        if (priceError != null && !priceError.isEmpty()) {
                    %>
                        <div class="error-message"><%= priceError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="description">Description:</label>
                    <textarea name="description"><%= request.getParameter("description") != null ? request.getParameter("description") : "" %></textarea>
                    <%
                        String descriptionError = (String) request.getAttribute("descriptionError");
                        if (descriptionError != null && !descriptionError.isEmpty()) {
                    %>
                        <div class="error-message"><%= descriptionError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="category">Category:</label>
                    <input type="text" name="category" value="<%= request.getParameter("category") != null ? request.getParameter("category") : "" %>" required>
                    <%
                        String categoryError = (String) request.getAttribute("categoryError");
                        if (categoryError != null && !categoryError.isEmpty()) {
                    %>
                        <div class="error-message"><%= categoryError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="stock_quantity">Stock Quantity:</label>
                    <input type="number" name="stock_quantity" value="<%= request.getParameter("stock_quantity") != null ? request.getParameter("stock_quantity") : "" %>" required>
                    <%
                        String stockQuantityError = (String) request.getAttribute("stockQuantityError");
                        if (stockQuantityError != null && !stockQuantityError.isEmpty()) {
                    %>
                        <div class="error-message"><%= stockQuantityError %></div>
                    <% } %>
                </div>
                
                <div>
                    <label for="mainImage">Main Image:</label>
                    <input type="file" name="mainImage" accept="image/*" required onchange="validateFile(this)">
                    <%
                        String mainImageError = (String) request.getAttribute("mainImageError");
                        if (mainImageError != null && !mainImageError.isEmpty()) {
                    %>
                        <div class="error-message"><%= mainImageError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="extraImages">Additional Images:</label>
                    <input type="file" name="extraImages" accept="image/*" multiple onchange="validateFile(this)">
                </div>
                <div>
                    <label for="status">Status:</label>
                    <input type="checkbox" name="status" <%= "on".equals(request.getParameter("status")) ? "checked" : "" %>> Active
                </div>
                <div>
                    <input type="submit" value="Add New Product">
                    <input type="reset" value="Reset Form">
                </div>
            </form>
        </div>

        <!-- Form Nhập ID Sản Phẩm Cần Cập Nhật -->
        <div id="updateIdForm" class="form-section">
            <h3>Type In Product's ID</h3>
            <form action="ProductController" method="post">
                <input type="hidden" name="action" value="checkProductId">
                <div>
                    <label for="productId">ID:</label>
                    <input type="number" name="productId" required>
                    <%
                        String idError = (String) request.getAttribute("idError");
                        if (idError != null && !idError.isEmpty()) {
                    %>
                        <div class="error-message"><%= idError %></div>
                    <% } %>
                </div>
                <div>
                    <input type="submit" value="Check ID">
                </div>
            </form>
        </div>

        <!-- Form Cập Nhật Sản Phẩm -->
        <%
            List<Image> extraImages = (List<Image>) request.getAttribute("extraImages");
            boolean showUpdateForm = product != null;
        %>
        <div id="updateForm" class="form-section <%= showUpdateForm ? "active" : "" %>">
            <h3>Update Product</h3>
            <form action="ProductController" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="updateProduct">
                <input type="hidden" name="productId" value="<%= product != null ? String.valueOf(product.getId()) : "" %>">
                <div>
                    <label for="name">Name:</label>
                    <input type="text" name="name" value="<%= product != null ? (product.getName() != null ? product.getName() : "") : "" %>" required>
                    <%
                        String nameError = (String) request.getAttribute("nameError");
                        if (nameError != null && !nameError.isEmpty()) {
                    %>
                        <div class="error-message"><%= nameError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="price">Price:</label>
                    <input type="number" name="price" value="<%= product != null ? String.valueOf(product.getPrice()) : "" %>" required>
                    <%
                        String priceError = (String) request.getAttribute("priceError");
                        if (priceError != null && !priceError.isEmpty()) {
                    %>
                        <div class="error-message"><%= priceError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="description">Description:</label>
                    <textarea name="description"><%= product != null ? (product.getDescription() != null ? product.getDescription() : "") : "" %></textarea>
                    <%
                        String descriptionError = (String) request.getAttribute("descriptionError");
                        if (descriptionError != null && !descriptionError.isEmpty()) {
                    %>
                        <div class="error-message"><%= descriptionError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="category">Category:</label>
                    <input type="text" name="category" value="<%= product != null ? (product.getCategory() != null ? product.getCategory() : "") : "" %>" required>
                    <%
                        String categoryError = (String) request.getAttribute("categoryError");
                        if (categoryError != null && !categoryError.isEmpty()) {
                    %>
                        <div class="error-message"><%= categoryError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="stock_quantity">Stock Quantity:</label>
                    <input type="number" name="stock_quantity" value="<%= product != null ? String.valueOf(product.getStockQuantity()) : "" %>" required>
                    <%
                        String stockQuantityError = (String) request.getAttribute("stockQuantityError");
                        if (stockQuantityError != null && !stockQuantityError.isEmpty()) {
                    %>
                        <div class="error-message"><%= stockQuantityError %></div>
                    <% } %>
                </div>
                
                <div>
                    <label for="mainImage">New Main Image (Leave BLANK To Keep The Old One):</label>
                    <% if (product != null && product.getImageUrl() != null) { %>
                        <img src="<%= product.getImageUrl() %>" alt="currentImage" style="max-width: 100px;">
                    <% } %>
                    <input type="file" name="mainImage" accept="image/*" onchange="validateFile(this)">
                    <%
                        String mainImageError = (String) request.getAttribute("mainImageError");
                        if (mainImageError != null && !mainImageError.isEmpty()) {
                    %>
                        <div class="error-message"><%= mainImageError %></div>
                    <% } %>
                </div>
                <div>
                    <label for="extraImages">New Additional Images (Leave BLANK To Keep The Old One):</label>
                    <%
                        if (extraImages != null && !extraImages.isEmpty()) {
                            for (Image extraImage : extraImages) {
                                if (extraImage.getAdditionalImageUrl() != null) {
                    %>
                        <img src="<%= extraImage.getAdditionalImageUrl() %>" alt="additionalImage" style="max-width: 100px;">
                    <%          }
                            }
                        }
                    %>
                    <input type="file" name="extraImages" accept="image/*" multiple onchange="validateFile(this)">
                </div>
                <div>
                    <input type="submit" value="Update Product">
                    <input type="reset" value="Reset Form">
                </div>
            </form>
        </div>

        <!-- Thông Báo Tổng Quát -->
        <%
            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (successMessage != null && !successMessage.isEmpty() || errorMessage != null && !errorMessage.isEmpty()) {
        %>
            <div class="message-container">
                <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                    <div class="error-message"><%= errorMessage %></div>
                <% } %>
                <% if (successMessage != null && !successMessage.isEmpty()) { %>
                    <div class="success-message"><%= successMessage %></div>
                <% } %>
            </div>
        <% } %>
        <%
            }%>
</body>
</html>