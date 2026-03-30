<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Reset Password</title>
    <style>
        .container { width: 400px; margin: 100px auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="password"] { width: 100%; padding: 8px; box-sizing: border-box; }
        .btn { background-color: #007bff; color: white; padding: 10px; border: none; width: 100%; cursor: pointer; }
        .error { color: red; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Reset Password</h2>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/reset-password" method="post">
            <input type="hidden" name="email" value="${email}">
            <div class="form-group">
                <label>New Password:</label>
                <input type="password" name="newPassword" required>
            </div>
            <div class="form-group">
                <label>Confirm Password:</label>
                <input type="password" name="confirmPassword" required>
            </div>
            <button type="submit" class="btn">Reset Password</button>
        </form>
    </div>
</body>
</html>