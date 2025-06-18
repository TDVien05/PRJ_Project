<%-- 
    Document   : productAddForm
    Created on : Jun 11, 2025, 8:28:59 PM
    Author     : HOME-MACPRO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.UserDTO"%>
<%@page import="utils.AuthUtils"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management</title>
    </head>
    <body>
        <%
            if(AuthUtils.isAdmin(request)){
        %>
        <form action="ProductController" method="post">
            <input type="hidden" name="action" value="addProduct"/>
            <div>
                <label for="id">ID*</label> 
                <input type="text" name="id" id="id" required="required"/>
            </div>
            <div>
                <label for="name">Name*</label> 
                <input type="text" name="name" id="name" required="required"/>
            </div>
            <div>
                <label for="price">Price</label> 
                <input type="number" name="price" id="price" min="0" step="0.01" required="required"/>
            </div>
            <div>
                <label for="description">Description</label> 
                <textarea type="text" name="description" id="description">
                </textarea>
            </div>
            <div>
                <label for="category">Category</label> 
                <input type="text" name="size" id="size"/>
            </div>
            <div>
                <label for="stock_quantity">Quantity</label> 
                <input type="text" name="size" id="size"/>
            </div>
            <div>
                <label for="image">Image</label> 
                <input type="file" id="image" name="image" accept="image/*">
            </div>
            <div>
                <label for="status">Status (Active Product)</label> 
                <input type="checkbox" name="status" id="status" value="true"/>
            </div>
            <div>
                <input type="submit" value="Add Product"/>
            </div>
        </form>
        <%
    }else{
        %>
        <%=AuthUtils.getAccessDeniedMessage(" profuct-form page ")%>
        <%
    }
        %>
    </body>
</html>
