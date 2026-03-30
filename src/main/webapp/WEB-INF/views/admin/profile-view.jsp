<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; margin-top: 70px; }
        .content { flex: 1; padding: 30px; }
        .profile-card {
            background: white;
            border-radius: 8px;
            padding: 30px;
            max-width: 500px;
            margin: 0 auto;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .profile-pic {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 20px;
        }
        .profile-info {
            text-align: left;
            margin-top: 20px;
        }
        .info-row {
            display: flex;
            margin-bottom: 10px;
            border-bottom: 1px solid #eee;
            padding-bottom: 5px;
        }
        .info-label {
            width: 120px;
            font-weight: bold;
        }
        .btn-edit {
            background-color: #007bff;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <div class="profile-card">
                <c:choose>
                    <c:when test="${not empty user.profilePicURL}">
                        <img src="${user.profilePicURL}" class="profile-pic">
                    </c:when>
                    <c:otherwise>
                        <div style="width: 120px; height: 120px; border-radius: 50%; background-color: #6c757d; color: white; display: inline-flex; align-items: center; justify-content: center; font-size: 48px; margin-bottom: 20px;">
                            ${user.firstName.charAt(0)}${user.lastName.charAt(0)}
                        </div>
                    </c:otherwise>
                </c:choose>
                <h2>${user.firstName} ${user.lastName}</h2>
                <div class="profile-info">
                    <div class="info-row"><span class="info-label">Email:</span> ${user.email}</div>
                    <div class="info-row"><span class="info-label">Gender:</span> ${user.gender}</div>
                    <div class="info-row"><span class="info-label">Contact:</span> ${user.contactNum}</div>
                    <div class="info-row"><span class="info-label">Role:</span> ${user.role}</div>
                    <div class="info-row"><span class="info-label">Joined:</span> ${user.createdAt}</div>
                </div>
                <a href="${pageContext.request.contextPath}/developer/profile/edit" class="btn-edit">Edit Profile</a>
            </div>
        </div>
    </div>
</body>
</html>