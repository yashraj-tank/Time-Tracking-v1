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
        .btn-view { background-color: #007bff; }
        .btn-edit { background-color: #ffc107; color: black; }
        .btn-toggle { background-color: #17a2b8; }
        .badge {
            padding: 3px 8px; border-radius: 12px; font-size: 12px; font-weight: bold;
        }
        .badge-active { background-color: #d4edda; color: #155724; }
        .badge-inactive { background-color: #f8d7da; color: #721c24; }
        .empty-value { color: #999; font-style: italic; }
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
            <table style="margin-top:20px;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Gender</th>
                        <th>Contact</th>
                        <th>Created At</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="dev" items="${developers}">
                        <tr>
                            <td>${dev.userId}</td>
                            <td>${dev.firstName} ${dev.lastName}</td>
                            <td>${dev.email}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty dev.gender}">${dev.gender}</c:when>
                                    <c:otherwise><span class="empty-value">—</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty dev.contactNum}">${dev.contactNum}</c:when>
                                    <c:otherwise><span class="empty-value">—</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty dev.createdAt}">
                                        ${dev.createdAt} <!-- LocalDate directly outputs yyyy-MM-dd -->
                                    </c:when>
                                    <c:otherwise><span class="empty-value">—</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${dev.active}">
                                        <span class="badge badge-active">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-inactive">Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/users/view/${dev.userId}" class="btn btn-view">View</a>
                                <a href="${pageContext.request.contextPath}/admin/users/edit/${dev.userId}" class="btn btn-edit">Edit</a>
                                <a href="${pageContext.request.contextPath}/admin/users/toggle/${dev.userId}" class="btn btn-toggle" onclick="return confirm('Toggle active status for ${dev.firstName}?')">Toggle</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty developers}">
                        <tr><td colspan="8" style="text-align:center;">No developers found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>