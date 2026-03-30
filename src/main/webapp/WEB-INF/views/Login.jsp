<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body { font-family: Arial; margin: 50px; }
        .container { width: 400px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        input { width: 100%; padding: 8px; margin: 5px 0; box-sizing: border-box; }
        button { background: #4CAF50; color: white; padding: 10px; width: 100%; border: none; cursor: pointer; }
        .error { color: red; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <c:if test="${not empty error}"><p class="error">${error}</p></c:if>
        <c:if test="${not empty success}">
        	<div style="color: green; margin-bottom: 10px;">${success}</div>
        </c:if>
        <form action="login" method="post">
            <label>Email</label>
            <input type="email" name="email" required>
            
            <label>Password</label>
            <input type="password" name="password" required>
            
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="signup">Sign up here</a></p>
        <p style="margin-top: 15px; text-align: center;"><a href="${pageContext.request.contextPath}/forgot-password">Forgot Password?</a></p>
    </div>
</body>
</html>