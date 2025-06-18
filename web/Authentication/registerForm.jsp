<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5e8c7; /* Be nhạt làm nền */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .register-container {
            background-color: #ffffff; /* Trắng làm nền form */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }
        h1 {
            color: #8b4513; /* Nâu đậm cho tiêu đề */
            margin-bottom: 25px;
            font-size: 34px;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        label {
            display: block;
            color: #6b4e31; /* Nâu nhạt cho nhãn */
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #d2b48c; /* Nâu sáng viền */
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
            background-color: #fafafa; /* Be rất nhạt */
        }
        input[type="submit"] {
            width: 48%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            background-color: #c68e17; /* Nâu vàng cho nút */
            color: white;
            cursor: pointer;
            margin-right: 4%;
            font-size: 14px;
        }
        
        .registerButton {
            margin: 10px 50px 0;
        }
        
        input[type="submit"]:hover, input[type="reset"]:hover {
            background-color: #a67b17; /* Nâu đậm hơn khi hover */
        }
        .error-message {
            color: #a52a2a; /* Nâu đỏ cho lỗi */
            font-size: 12px;
            margin-top: 5px;
            text-align: left;
        }
        .success-message {
            color: #6b8e23; /* Olive xanh lá nhạt cho thành công */
            font-size: 14px;
            margin-top: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h1>Register</h1>
        <form action="${pageContext.request.contextPath}/user-controller" method="post">
            <input type="hidden" name="action" value="register" />
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" name="username" id="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" required />
                <div class="error-message"><%= request.getAttribute("usernameError") != null ? request.getAttribute("usernameError") : "" %></div>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="password" id="password" value="" required />
                <div class="error-message"><%= request.getAttribute("passwordError") != null ? request.getAttribute("passwordError") : "" %></div>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" name="email" id="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" required />
                <div class="error-message"><%= request.getAttribute("emailError") != null ? request.getAttribute("emailError") : "" %></div>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" name="address" id="address" value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>" />
            </div>
            <div class="registerButton">
                <input type="submit" value="Register" />
            </div>
            <div class="success-message"><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %></div>
        </form>
    </div>
</body>
</html>