<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; margin-top: 70px; }
        .content { flex: 1; padding: 30px; }
        .form-card {
            background: white;
            border-radius: 8px;
            padding: 30px;
            max-width: 500px;
            margin: 0 auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-cancel {
            background-color: #6c757d;
            margin-left: 10px;
        }
        .current-photo {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <div class="form-card">
                <h2>Edit Profile</h2>
                <form action="${pageContext.request.contextPath}/developer/profile/update" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label>First Name:</label>
                        <input type="text" name="firstName" value="${user.firstName}" required>
                    </div>
                    <div class="form-group">
                        <label>Last Name:</label>
                        <input type="text" name="lastName" value="${user.lastName}" required>
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" value="${user.email}" required>
                    </div>
                    <div class="form-group">
                        <label>Gender:</label>
                        <select name="gender">
                            <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Contact Number:</label>
                        <input type="text" name="contactNum" value="${user.contactNum}">
                    </div>
                    <div class="form-group">
                        <label>Profile Picture:</label>
                        <c:if test="${not empty user.profilePicURL}">
                            <img src="${user.profilePicURL}" class="current-photo"><br>
                        </c:if>
                        <input type="file" name="profilePic" accept="image/*">
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn">Save Changes</button>
                        <a href="${pageContext.request.contextPath}/developer/profile" class="btn btn-cancel">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>