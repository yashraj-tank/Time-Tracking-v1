<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        .btn-save { background-color: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; }
        .manager-checkbox { margin-right: 10px; }
        .container {
 		 margin-top: 70px;
		}
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <h2>${pageTitle}</h2>
            <form action="${pageContext.request.contextPath}/admin/project-managers/assign" method="post">
                <table>
                    <thead>
                        <tr>
                            <th>Project ID</th>
                            <th>Project Title</th>
                            <th>Assign Managers</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="project" items="${projects}">
                            <tr>
                                <td>${project.projectId}</td>
                                <td>${project.title}</td>
                                <td>
                                    <c:forEach var="manager" items="${managers}">
                                        <c:set var="isChecked" value="false" />
                                        <c:forEach var="assignedId" items="${assignedMap[project.projectId]}">
                                            <c:if test="${assignedId == manager.userId}">
                                                <c:set var="isChecked" value="true" />
                                            </c:if>
                                        </c:forEach>
                                        <label style="display: inline-block; margin-right: 15px;">
                                            <input type="checkbox" name="project_${project.projectId}" value="${manager.userId}" 
                                                <c:if test="${isChecked}">checked</c:if> />
                                            ${manager.firstName} ${manager.lastName}
                                        </label>
                                    </c:forEach>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div style="margin-top: 20px;">
                    <input type="submit" value="Save Assignments" class="btn-save" />
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>