<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; margin-top: 70px; }
        .content { flex: 1; padding: 30px; }
        .detail-card {
            background: white;
            border-radius: 8px;
            padding: 30px;
            max-width: 600px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .detail-row {
            display: flex;
            margin-bottom: 12px;
            border-bottom: 1px solid #eee;
            padding-bottom: 8px;
        }
        .detail-label {
            width: 150px;
            font-weight: 600;
            color: #555;
        }
        .detail-value {
            flex: 1;
            color: #222;
        }
        .btn {
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-right: 10px;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
        }
        .btn-edit {
            background-color: #ffc107;
            color: black;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <div class="detail-card">
                <h2>${pageTitle}</h2>

                <div class="detail-row">
                    <span class="detail-label">Task ID:</span>
                    <span class="detail-value">${task.taskId}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Title:</span>
                    <span class="detail-value">${task.title}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Description:</span>
                    <span class="detail-value">${task.description}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Status:</span>
                    <span class="detail-value">
                        <c:choose>
                            <c:when test="${task.status == 1}">Not Started</c:when>
                            <c:when test="${task.status == 2}">In Progress</c:when>
                            <c:when test="${task.status == 3}">Completed</c:when>
                            <c:when test="${task.status == 4}">On Hold</c:when>
                            <c:otherwise>${task.status}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Document URL:</span>
                    <span class="detail-value">
                        <c:if test="${not empty task.docURL}">
                            <a href="${task.docURL}" target="_blank">${task.docURL}</a>
                        </c:if>
                        <c:if test="${empty task.docURL}">—</c:if>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Estimated Hours:</span>
                    <span class="detail-value">${task.estimatedHours}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Utilized Hours:</span>
                    <span class="detail-value">${task.totalUtilizedHours}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Module ID:</span>
                    <span class="detail-value">${task.moduleId}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Project ID:</span>
                    <span class="detail-value">${task.projectId}</span>
                </div>

                <div style="margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/admin/projects/${task.projectId}/modules/${task.moduleId}/tasks" class="btn btn-back">Back to Tasks</a>
                    <a href="${pageContext.request.contextPath}/admin/projects/${task.projectId}/modules/${task.moduleId}/tasks/edit/${task.taskId}" class="btn btn-edit">Edit</a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>