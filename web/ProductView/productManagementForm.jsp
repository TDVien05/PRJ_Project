<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="utils.AuthUtils"%>
<%@page import="model.ProductDTO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { width: 80%; margin: auto; }
        .search-section { margin-bottom: 30px; padding: 20px; border: 1px solid #ddd; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin-top: 20px; }
        .product-card { border: 1px solid #ddd; padding: 15px; border-radius: 5px; }
        .product-card img { max-width: 100px; height: auto; }
        .add-product-btn { background: #4CAF50; color: white; padding: 15px 30px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 20px 0; }
        .search-form { display: flex; gap: 10px; align-items: center; }
        .search-form input[type="text"] { padding: 10px; flex: 1; }
        .search-form input[type="submit"] { padding: 10px 20px; background: #2196F3; color: white; border: none; cursor: pointer; }
        .no-results { text-align: center; color: #666; margin: 20px 0; }
        .status-active { color: green; font-weight: bold; }
        .status-inactive { color: red; font-weight: bold; }
    </style>
</head>
<body>
    <%
        if(AuthUtils.isAdmin(request)){
            List<ProductDTO> list = (List<ProductDTO>) request.getAttribute("list");
            String keyword = (String) request.getAttribute("keyword");
    %>
    <div class="container">
        <h2>Product Management System</h2>
        
        <!-- Search Section -->
        <div class="search-section">
            <h3>Search Products</h3>
            <form action="${pageContext.request.contextPath}/ProductController" method="post" class="search-form">
                <input type="hidden" name="action" value="searchProduct">
                <input type="text" name="searchKeyword" placeholder="Enter product name..." 
                       value="<%= keyword != null ? keyword : "" %>" required>
                <input type="submit" value="Search">
            </form>
        </div>

        <!-- Add Product Button -->
        <a href="ProductView/productAddForm.jsp" class="add-product-btn">+ Add New Product</a>

        <!-- Search Results -->
        <%
            if (list != null) {
                if (list.isEmpty()) {
        %>
                    <div class="no-results">
                        <h3>No active products found for "<%= keyword %>"</h3>
                    </div>
        <%      } else { %>
                    <h3>Search Results for "<%= keyword %>" (<%= list.size() %> products found)</h3>
                    <div class="product-grid">
        <%              for (ProductDTO product : list) { %>
                            <div class="product-card">
                                <h4><%= product.getName() %></h4>
                                <p><strong>ID:</strong> <%= product.getId() %></p>
                                <p><strong>Price:</strong> $<%= product.getPrice() %>VND</p>
                                <p><strong>Category:</strong> <%= product.getCategoryId() %></p>
                                <p><strong>Stock:</strong> <%= product.getStockQuantity() %></p>
                                <p><strong>Status:</strong> 
                                    <span class="<%= product.isStatus() ? "status-active" : "status-inactive" %>">
                                        <%= product.isStatus() ? "Active" : "Inactive" %>
                                    </span>
                                </p>
                                <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
                                    <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                                <% } %>
                                <p><strong>Description:</strong> <%= product.getDescription() != null ? product.getDescription() : "No description" %></p>
                            </div>
        <%              } %>
                    </div>
        <%      }
            }
        %>

        <!-- Messages -->
        <%
            String successMessage = (String) request.getAttribute("successMessage");
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (successMessage != null && !successMessage.isEmpty()) {
        %>
                <div style="color: green; margin: 20px 0; padding: 10px; border: 1px solid green; background: #f0fff0;">
                    <%= successMessage %>
                </div>
        <%  }
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
                <div style="color: red; margin: 20px 0; padding: 10px; border: 1px solid red; background: #fff0f0;">
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