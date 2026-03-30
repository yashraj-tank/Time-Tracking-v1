<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; margin-top: 70px; }
        .content { flex: 1; padding: 30px; }
        .project-section {
            background: white;
            border-radius: 8px;
            margin-bottom: 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .project-header {
            padding: 16px 20px;
            border-bottom: 1px solid #eee;
            background: #fafafa;
            font-weight: 600;
            font-size: 16px;
            border-radius: 8px 8px 0 0;
        }
        .user-table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }
        th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #555;
        }
        .empty-message {
            padding: 20px;
            text-align: center;
            color: #999;
        }
    </style>
</head>
<body>
    <jsp:include page="../admin/header.jsp" />

    <div class="container">
        <jsp:include page="sidebar.jsp" />

        <div class="content">
            <h2>Project Users</h2>
            <p>Users assigned to your projects.</p>

            <c:forEach var="item" items="${projectsWithUsers}">
                <div class="project-section">
                    <div class="project-header">
                        📁 ${item.project.title} (ID: ${item.project.projectId})
                    </div>
                    <c:choose>
                        <c:when test="${not empty item.users}">
                            <table class="user-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Contact</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="user" items="${item.users}">
                                        <tr>
                                            <td>${user.userId}</td>
                                            <td>${user.firstName} ${user.lastName}</td>
                                            <td>${user.email}</td>
                                            <td>${user.role}</td>
                                            <td>${user.contactNum}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-message">No users assigned to this project.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>

            <c:if test="${empty projectsWithUsers}">
                <div class="empty-message" style="background: white; border-radius: 8px; padding: 40px;">
                    You have no projects assigned.
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="../admin/footer.jsp" />
</body>
</html>