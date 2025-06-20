<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login</title>
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
        .login-container {
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
            font-size: 35px;
            
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
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 5px;
            background-color: #c68e17; /* Nâu vàng cho nút */
            color: white;
            cursor: pointer;
            font-size: 14px;
        }
        
        .loginButton{
            margin: 24px 120px 0;
        }
        
        input[type="submit"]:hover {
            background-color: #a67b17; /* Nâu đậm hơn khi hover */
        }
        .error-message {
            color: #a52a2a; /* Nâu đỏ cho lỗi */
            font-size: 12px;
            margin-top: 5px;
            text-align: center;
        }
        .register-link {
            margin-top: 15px;
            color: #6b8e23; /* Olive xanh lá nhạt */
            text-align: center;
        }
        .register-link a {
            color: #6b8e23;
            text-decoration: none;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form action="${pageContext.request.contextPath}/user-controller" method="post">
            <input type="hidden" name="action" value="login" />
            <div class="form-group">
                <label for="strUsername">Username:</label>
                <input type="text" name="strUsername" id="strUsername" value="<%= request.getParameter("strUsername") != null ? request.getParameter("strUsername") : "" %>" required />
            </div>
            <div class="form-group">
                <label for="strPassword">Password:</label>
                <input type="password" name="strPassword" id="strPassword" value="" required />
            </div>
            <div class="loginButton">
                <input type="submit" value="Login" />
            </div>
            <div class="error-message"><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %></div>
            <div class="register-link">
                Don't have an account yet? <a style="color: #EA483A" href="${pageContext.request.contextPath}/Authentication/registerForm.jsp" target="target">Register now</a>
            </div>
        </form>
    </div>
</body>
</html>