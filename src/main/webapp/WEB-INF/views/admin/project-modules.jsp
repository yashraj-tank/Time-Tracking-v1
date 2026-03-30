<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; margin-top: 70px; } /* offset for fixed header */
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
        .btn-tasks { background-color: #17a2b8; }
        .btn-back { background-color: #6c757d; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <h2>${pageTitle}</h2>
            <div style="margin-bottom: 20px;">
                <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/new" class="btn btn-add">+ Add Module</a>
                <a href="${pageContext.request.contextPath}/admin/projects" class="btn btn-back">Back to Projects</a>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Module Name</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Est. Hours</th>
                        <th>Utilized Hours</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="module" items="${modules}">
                        <tr>
                            <td>${module.moduleId}</td>
                            <td>${module.moduleName}</td>
                            <td>${module.description}</td>
                            <td>${module.status}</td>
                            <td>${module.estimatedHours}</td>
                            <td>${module.totalUtilizedHours}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/view/${module.moduleId}" class="btn btn-view">View</a>
                                <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/edit/${module.moduleId}" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/${module.moduleId}/tasks" class="btn btn-tasks">Tasks</a>
                                <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/delete/${module.moduleId}" class="btn btn-delete" onclick="return confirm('Delete this module?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty modules}">
                        <tr><td colspan="7" style="text-align:center;">No modules found for this project.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>