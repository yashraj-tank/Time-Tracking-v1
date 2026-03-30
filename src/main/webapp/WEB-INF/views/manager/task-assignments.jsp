<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f5f5;
        }
        .container {
            display: flex;
            margin-top: 70px;               /* offset fixed header */
            min-height: calc(100vh - 70px); /* fill remaining viewport height */
            background: #f5f5f5;
        }
        .sidebar {
            width: 260px;
            height: auto;                   /* let it stretch to parent height */
            background: #1a3d2b;            /* sidebar background (its own CSS defines more) */
        }
        .content {
            flex: 1;
            padding: 30px;
            overflow-x: auto;
            background: #f5f5f5;
        }
        .assignment-card {
            background: white;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .task-header {
            padding: 16px 20px;
            background: #f8f9fa;
            border-bottom: 1px solid #eee;
            font-weight: 600;
            border-radius: 8px 8px 0 0;
        }
        .task-header a {
            color: #007bff;
            text-decoration: none;
        }
        .user-list {
            padding: 16px 20px;
        }
        .user-badge {
            display: inline-block;
            background: #e9ecef;
            padding: 4px 10px;
            border-radius: 20px;
            margin-right: 8px;
            margin-bottom: 8px;
            font-size: 13px;
        }
        .empty-message {
            text-align: center;
            padding: 40px;
            color: #999;
        }
        .task-meta {
            font-size: 13px;
            color: #666;
            margin-top: 8px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <h2>${pageTitle}</h2>
            <p>Users assigned to tasks in your projects.</p>

            <c:choose>
                <c:when test="${not empty taskAssignments}">
                    <c:forEach var="item" items="${taskAssignments}">
                        <div class="assignment-card">
                            <div class="task-header">
                                Task: ${item.task.title} (ID: ${item.task.taskId})
                                <span class="task-meta">
                                    Project: ${item.projectTitle} | Module: ${item.moduleName}
                                    | Est: <fmt:formatNumber value="${item.task.estimatedHours}" pattern="#.#"/>h
                                    | Utilized: <fmt:formatNumber value="${item.task.totalUtilizedHours}" pattern="#.#"/>h
                                </span>
                            </div>
                            <div class="user-list">
                                <strong>Assigned Developers:</strong><br/>
                                <c:forEach var="user" items="${item.assignedUsers}">
                                    <span class="user-badge">${user.firstName} ${user.lastName}</span>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-message">No task assignments found for your projects.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <jsp:include page="../admin/footer.jsp" />
</body>
</html>