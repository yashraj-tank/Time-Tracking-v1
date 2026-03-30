<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        /* Layout styles */
        body { margin: 0; font-family: Arial, sans-serif; }
        .container { display: flex; }
        .content { flex: 1; padding: 20px; }

        /* Table styles */
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }

        /* Button styles */
        .btn { padding: 5px 10px; text-decoration: none; color: white; border-radius: 3px; display: inline-block; margin: 0 2px; }
        .btn-view { background-color: #007bff; }
        .btn-edit { background-color: #ffc107; color: black; }
        .btn-delete { background-color: #dc3545; }
        .btn-tasks { background-color: #17a2b8; }
        .btn-new { background-color: #28a745; margin-bottom: 10px; display: inline-block; }
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
            <h2>${pageTitle}</h2>
            <a href="${pageContext.request.contextPath}/admin/projects/new" class="btn btn-new">+ New Project</a>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Start Date</th>
                        <th>Completion Date</th>
                        <th>Status ID</th>
                        <th>Est. Hours</th>
                        <th>Utilized Hours</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="project" items="${projects}">
                        <tr>
                            <td>${project.projectId}</td>
                            <td>${project.title}</td>
                            <td>${project.description}</td>
                            <td>${project.projectStartDate}</td>
                            <td>${project.projectCompletionDate}</td>
                            <td>${project.projectStatusId}</td>
                            <td>${project.estimatedHours}</td>
                            <td>${project.totalUtilizedHours}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/projects/view/${project.projectId}" class="btn btn-view">View</a>
                                <a href="${pageContext.request.contextPath}/admin/projects/edit/${project.projectId}" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/projects/${project.projectId}/modules" class="btn btn-tasks">Modules</a>
                                <a href="${pageContext.request.contextPath}/admin/projects/delete/${project.projectId}" class="btn btn-delete" onclick="return confirm('Delete this project?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>