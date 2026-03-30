<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <style>
        body { font-family: Arial; margin: 50px; }
        .container { width: 400px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        input, select { width: 100%; padding: 8px; margin: 5px 0; box-sizing: border-box; }
        button { background: #4CAF50; color: white; padding: 10px; width: 100%; border: none; cursor: pointer; }
        .error { color: red; }
        .message { color: green; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Sign Up</h2>
        <c:if test="${not empty error}"><p class="error">${error}</p></c:if>
        <c:if test="${not empty message}"><p class="message">${message}</p></c:if>
        <form action="signup" method="post">
            <label>First Name</label>
            <input type="text" name="firstName" required>
            
            <label>Last Name</label>
            <input type="text" name="lastName" required>
            
            <label>Email</label>
            <input type="email" name="email" required>
            
            <label>Password</label>
            <input type="password" name="password" required>
            
            <label>Gender</label>
            <select name="gender" required>
                <option value="">Select</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
            
            <label>Contact Number</label>
            <input type="text" name="contactNum" required>
            
            <button type="submit">Register</button>
        </form>
        <p>Already have an account? <a href="login">Login here</a></p>
    </div>
</body>
</html>