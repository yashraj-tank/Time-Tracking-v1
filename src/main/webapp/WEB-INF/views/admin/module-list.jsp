<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; }
        .container { display: flex; }
        .content { flex: 1; padding: 20px; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .project-group { margin-bottom: 20px; border: 1px solid #ccc; border-radius: 5px; }
        .project-header { background-color: #e9ecef; padding: 10px; cursor: pointer; font-weight: bold; }
        .project-content { padding: 10px; display: block; }
        .filter-buttons { margin-bottom: 20px; }
        .filter-btn { padding: 5px 10px; margin-right: 5px; cursor: pointer; background-color: #007bff; color: white; border: none; border-radius: 3px; }
        .filter-btn.active { background-color: #0056b3; }
        .container {
  		margin-top: 70px; /* same as header height */
  		.container {
  		margin-top: 70px; /* same as header height */
		}
}
    </style>
    <script>
        function filterProject(projectName, event) {
            var groups = document.querySelectorAll('.project-group');
            groups.forEach(function(group) {
                group.style.display = 'none';
            });
            if (projectName === 'all') {
                groups.forEach(function(group) {
                    group.style.display = 'block';
                });
            } else {
                var selected = document.getElementById('project-' + projectName.replace(/\s+/g, '-'));
                if (selected) selected.style.display = 'block';
            }
            var buttons = document.querySelectorAll('.filter-btn');
            buttons.forEach(function(btn) {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
        }

        function toggleGroup(header) {
            var content = header.nextElementSibling;
            content.style.display = (content.style.display === 'none') ? 'block' : 'none';
        }
    </script>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <h2>${pageTitle}</h2>

            <div class="filter-buttons">
                <button class="filter-btn active" onclick="filterProject('all', event)">All Projects</button>
                <c:forEach var="entry" items="${modulesByProject}">
                    <button class="filter-btn" onclick="filterProject('${entry.key}', event)">${entry.key}</button>
                </c:forEach>
            </div>

            <c:forEach var="entry" items="${modulesByProject}">
                <c:set var="projectName" value="${entry.key}" />
                <div id="project-${fn:replace(projectName, ' ', '-')}" class="project-group">
                    <div class="project-header" onclick="toggleGroup(this)">
                        ${projectName} (${fn:length(entry.value)} modules)
                    </div>
                    <div class="project-content">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Module Name</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                    <th>Est. Hours</th>
                                    <th>Utilized Hours</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${entry.value}">
                                    <tr>
                                        <td>${item.module.moduleId}</td>
                                        <td>${item.module.moduleName}</td>
                                        <td>${item.module.description}</td>
                                        <td>${item.module.status}</td>
                                        <td>${item.module.estimatedHours}</td>
                                        <td>${item.module.totalUtilizedHours}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>