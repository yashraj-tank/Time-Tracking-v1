<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; margin-top: 70px; }
        .content { flex: 1; padding: 30px; }

        table { border-collapse: collapse; width: 100%; background: white; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .btn {
            padding: 5px 10px;
            text-decoration: none;
            color: white;
            border-radius: 3px;
            display: inline-block;
            margin: 0 2px;
        }
        .btn-view { background-color: #007bff; }
        .btn-edit { background-color: #ffc107; color: black; }
        .btn-delete { background-color: #dc3545; }
        .btn-add { background-color: #28a745; }
        .btn-back { background-color: #6c757d; }
        .status-label {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-not-started { background-color: #fff3cd; color: #856404; }
        .status-in-progress { background-color: #cce5ff; color: #004085; }
        .status-completed { background-color: #d4edda; color: #155724; }
        .status-on-hold { background-color: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <h2>${pageTitle}</h2>
            <div style="margin-bottom: 20px;">
                <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/${moduleId}/tasks/new" class="btn btn-add">+ Add Task</a>
                <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules" class="btn btn-back">Back to Modules</a>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Est. Hours</th>
                        <th>Utilized Hours</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="task" items="${tasks}">
                        <tr>
                            <td>${task.taskId}</td>
                            <td>${task.title}</td>
                            <td>${task.description}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${task.status == 1}">
                                        <span class="status-label status-not-started">Not Started</span>
                                    </c:when>
                                    <c:when test="${task.status == 2}">
                                        <span class="status-label status-in-progress">In Progress</span>
                                    </c:when>
                                    <c:when test="${task.status == 3}">
                                        <span class="status-label status-completed">Completed</span>
                                    </c:when>
                                    <c:when test="${task.status == 4}">
                                        <span class="status-label status-on-hold">On Hold</span>
                                    </c:when>
                                    <c:otherwise>${task.status}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${task.estimatedHours}</td>
                            <td>${task.totalUtilizedHours}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/${moduleId}/tasks/view/${task.taskId}" class="btn btn-view">View</a>
                                <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/${moduleId}/tasks/edit/${task.taskId}" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/${moduleId}/tasks/delete/${task.taskId}" class="btn btn-delete" onclick="return confirm('Delete this task?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty tasks}">
                        <tr><td colspan="7" style="text-align:center;">No tasks found for this module.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>