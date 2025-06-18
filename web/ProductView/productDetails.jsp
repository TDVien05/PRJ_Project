<%-- 
    Document   : productDetails
    Created on : Jun 14, 2025, 11:04:18 PM
    Author     : HOME-MACPRO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Product p = (Product) request.getAttribute("product");
%>
<html>
<head><title>Product Detail</title></head>
<body>
    <h2><%= p.getName() %></h2>
    <img src="images/products/<%= p.getImage() %>" width="200"><br><br>
    <p> $<%= p.getPrice() %></p>
    <p><strong>THÔNG TIN SẢN PHẨM </strong> <%= p.getDescription() %></p>

    <form action="AddToCartController" method="post">
        <input type="hidden" name="productId" value="<%= p.getId() %>">
        Số lượng <input type="number" name="quantity" value="1" min="1"><br><br>
        <input type="submit" value="THÊM VÀO GIỎ">
    </form>
</body>
</html>
