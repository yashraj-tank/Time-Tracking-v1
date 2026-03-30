<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; }
        .content { flex: 1; padding: 30px; }
        table { border-collapse: collapse; width: 100%; background: white; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .btn {
            padding: 5px 10px; text-decoration: none; color: white; border-radius: 3px;
            display: inline-block; margin: 2px;
        }
        .btn-add { background-color: #28a745; }
        .btn-edit { background-color: #ffc107; color: black; }
        .btn-delete { background-color: #dc3545; }
        .btn-back { background-color: #6c757d; }
        .badge {
            padding: 3px 8px; border-radius: 12px; font-size: 12px; font-weight: bold;
        }
        .badge-assigned { background-color: #d4edda; color: #155724; }
        .badge-revoked { background-color: #f8d7da; color: #721c24; }
        .container {
  		margin-top: 70px; /* same as header height */
		}
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <h2>Assignments for Task: ${task.title}</h2>
            <p>Task ID: ${task.taskId}</p>

            <a href="${pageContext.request.contextPath}/admin/tasks/${taskId}/assignments/new" class="btn btn-add">+ Assign User</a>
            <a href="${pageContext.request.contextPath}/admin/tasks" class="btn btn-back">Back to Tasks</a>

            <table style="margin-top:20px;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Assign Status</th>
                        <th>Utilized Hours</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${assignments}">
                        <tr>
                            <td>${item.assignment.taskUserId}</td>
                            <td>${item.userName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.assignment.assignStatus == 1}">
                                        <span class="badge badge-assigned">Assigned</span>
                                    </c:when>
                                    <c:when test="${item.assignment.assignStatus == 2}">
                                        <span class="badge badge-revoked">Revoked</span>
                                    </c:when>
                                    <c:otherwise>
                                        Unknown
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatNumber value="${item.assignment.utitlizedHours}" pattern="#.##"/></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/tasks/${taskId}/assignments/edit/${item.assignment.taskUserId}" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/tasks/${taskId}/assignments/delete/${item.assignment.taskUserId}" class="btn btn-delete" onclick="return confirm('Delete this assignment?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty assignments}">
                        <tr><td colspan="5" style="text-align:center;">No assignments found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>