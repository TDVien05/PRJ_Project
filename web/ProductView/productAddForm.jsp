<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="utils.AuthUtils"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Product</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { width: 60%; margin: auto; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, textarea, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        input[type="submit"], input[type="reset"] { width: auto; background: #4CAF50; color: white; padding: 12px 24px; cursor: pointer; margin-right: 10px; }
        input[type="reset"] { background: #f44336; }
        input[type="file"] { padding: 5px; }
        input[type="checkbox"] { width: auto; margin-right: 10px; }
        .error-message { color: red; font-size: 14px; margin-top: 5px; }
        .success-message { color: green; font-size: 14px; margin-top: 5px; }
        .back-link { display: inline-block; margin-bottom: 20px; color: #2196F3; text-decoration: none; }
        .back-link:hover { text-decoration: underline; }
        .button-group { margin-top: 20px; }
        textarea { resize: vertical; min-height: 100px; }
    </style>
    <script>
        function validateFile(input) {
            const maxSize = 5 * 1024 * 1024; // 5MB
            for (let file of input.files) {
                if (file.size > maxSize) {
                    alert("File " + file.name + " is too big. Please choose a file smaller than 5MB");
                    input.value = "";
                    return;
                }
                if (!file.type.startsWith("image/")) {
                    alert("File " + file.name + " is not an image!");
                    input.value = "";
                    return;
                }
            }
        }

        function validateForm(form) {
            const price = form.querySelector('input[name="price"]');
            const stock = form.querySelector('input[name="stockQuantity"]');
            
            if (price && parseFloat(price.value) <= 0) {
                alert('Price must be greater than 0!');
                return false;
            }
            if (stock && parseInt(stock.value) < 0) {
                alert('Stock quantity cannot be negative!');
                return false;
            }
            return true;
        }

        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('addProductForm');
            if (form) {
                form.addEventListener('submit', function(e) {
                    if (!validateForm(this)) {
                        e.preventDefault();
                    }
                });
            }
        });
    </script>
</head>
<body>
    <%
        if(AuthUtils.isAdmin(request)){
    %>
    <div class="container">
        <a href="productManagementForm.jsp" class="back-link">← Back to Product Management</a>
        
        <h2>Add New Product</h2>
        
        <form id="addProductForm" action="ProductController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="addProduct">
            
            <div class="form-group">
                <label for="id">Product ID:</label>
                <input type="text" id="id" name="id" 
                       value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>" required>
                <%
                    String idError = (String) request.getAttribute("idError");
                    if (idError != null && !idError.isEmpty()) {
                %>
                    <div class="error-message"><%= idError %></div>
                <% } %>
            </div>

            <div class="form-group">
                <label for="name">Product Name:</label>
                <input type="text" id="name" name="name" 
                       value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>" required>
                <%
                    String nameError = (String) request.getAttribute("nameError");
                    if (nameError != null && !nameError.isEmpty()) {
                %>
                    <div class="error-message"><%= nameError %></div>
                <% } %>
            </div>

            <div class="form-group">
                <label for="price">Price (VND):</label>
                <input type="number" id="price" name="price" step="0.01" min="0.01" 
                       value="<%= request.getParameter("price") != null ? request.getParameter("price") : "" %>" required>
                <%
                    String priceError = (String) request.getAttribute("priceError");
                    if (priceError != null && !priceError.isEmpty()) {
                %>
                    <div class="error-message"><%= priceError %></div>
                <% } %>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" placeholder="Enter product description..."><%= request.getParameter("description") != null ? request.getParameter("description") : "" %></textarea>
                <%
                    String descriptionError = (String) request.getAttribute("descriptionError");
                    if (descriptionError != null && !descriptionError.isEmpty()) {
                %>
                    <div class="error-message"><%= descriptionError %></div>
                <% } %>
            </div>

            <div class="form-group">
                <label for="category">Category:</label>
                <input type="text" id="category" name="category" 
                       value="<%= request.getParameter("category") != null ? request.getParameter("category") : "" %>" required>
                <%
                    String categoryError = (String) request.getAttribute("categoryError");
                    if (categoryError != null && !categoryError.isEmpty()) {
                %>
                    <div class="error-message"><%= categoryError %></div>
                <% } %>
            </div>

            <div class="form-group">
                <label for="stockQuantity">Stock Quantity:</label>
                <input type="number" id="stockQuantity" name="stockQuantity" min="0" 
                       value="<%= request.getParameter("stockQuantity") != null ? request.getParameter("stockQuantity") : "" %>" required>
                <%
                    String stockQuantityError = (String) request.getAttribute("stockQuantityError");
                    if (stockQuantityError != null && !stockQuantityError.isEmpty()) {
                %>
                    <div class="error-message"><%= stockQuantityError %></div>
                <% } %>
            </div>

            <div class="form-group">
                <label for="image">Product Image:</label>
                <input type="file" id="image" name="image" accept="image/*" required onchange="validateFile(this)">
                <%
                    String imageError = (String) request.getAttribute("imageError");
                    if (imageError != null && !imageError.isEmpty()) {
                %>
                    <div class="error-message"><%= imageError %></div>
                <% } %>
            </div>

            <div class="form-group">
                <label>
                    <input type="checkbox" name="status" <%= "on".equals(request.getParameter("status")) ? "checked" : "" %>>
                    Active Status
                </label>
            </div>

            <div class="button-group">
                <input type="submit" value="Add Product">
                <input type="reset" value="Reset Form">
            </div>
        </form>

        <!-- Messages -->
        <%
            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (successMessage != null && !successMessage.isEmpty()) {
        %>
                <div class="success-message" style="padding: 10px; border: 1px solid green; background: #f0fff0; margin-top: 20px;">
                    <%= successMessage %>
                </div>
        <%  }
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
                <div class="error-message" style="padding: 10px; border: 1px solid red; background: #fff0f0; margin-top: 20px;">
                    <%= errorMessage %>
                </div>
        <%  } %>
    </div>

    <%
        } else {
    %>
        <div class="container">
            <h2>Access Denied</h2>
            <p>You don't have permission to access this page.</p>
        </div>
    <%
        }
    %>
</body>
</html>