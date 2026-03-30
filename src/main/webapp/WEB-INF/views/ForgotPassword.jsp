<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Forgot Password</title>
    <style>
        .container { width: 400px; margin: 100px auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="email"] { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn { background-color: #007bff; color: white; padding: 10px; border: none; width: 100%; cursor: pointer; }
        .error { color: red; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Forgot Password</h2>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>
            <button type="submit" class="btn">Send OTP</button>
        </form>
        <p style="margin-top: 15px; text-align: center;">
            <a href="${pageContext.request.contextPath}/login">Back to Login</a>
        </p>
    </div>
</body>
</html>