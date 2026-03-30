<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; }
        .content { flex: 1; padding: 30px; }
        .form-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 30px;
            max-width: 500px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: 600; color: #555; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .checkbox-group { display: flex; align-items: center; }
        .checkbox-group input { width: auto; margin-right: 10px; }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-save { background-color: #28a745; color: white; }
        .btn-cancel { background-color: #6c757d; color: white; margin-left: 10px; }
        .error { color: red; font-size: 12px; margin-top: 5px; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <h2>${pageTitle}</h2>
            <div class="form-card">
                <form:form action="${pageContext.request.contextPath}/admin/users/update/${user.userId}" method="post" modelAttribute="user">
                    <div class="form-group">
                        <label>First Name:</label>
                        <form:input path="firstName" required="true"/>
                    </div>
                    <div class="form-group">
                        <label>Last Name:</label>
                        <form:input path="lastName" required="true"/>
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <form:input path="email" type="email" required="true"/>
                    </div>
                    <div class="form-group">
                        <label>Gender:</label>
                        <form:select path="gender">
                            <form:option value="" label="-- Select --"/>
                            <form:option value="Male" label="Male"/>
                            <form:option value="Female" label="Female"/>
                            <form:option value="Other" label="Other"/>
                        </form:select>
                    </div>
                    <div class="form-group">
                        <label>Contact Number:</label>
                        <form:input path="contactNum"/>
                    </div>
                    <div class="form-group">
                        <label>Role:</label>
                        <form:select path="role">
                            <form:option value="ADMIN" label="Admin"/>
                            <form:option value="MANAGER" label="Manager"/>
                            <form:option value="DEVELOPER" label="Developer"/>
                            <form:option value="USER" label="User"/>
                        </form:select>
                    </div>
                    <div class="form-group">
                        <div class="checkbox-group">
                            <form:checkbox path="active"/>
                            <label style="margin:0;">Active</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Save Changes" class="btn btn-save"/>
                        <a href="${pageContext.request.contextPath}/admin/developers" class="btn btn-cancel">Cancel</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>