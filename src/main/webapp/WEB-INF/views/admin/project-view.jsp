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
                    <span class="detail-label">ID:</span>
                    <span class="detail-value">${project.projectId}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Title:</span>
                    <span class="detail-value">${project.title}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Description:</span>
                    <span class="detail-value">${project.description}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Status:</span>
                    <span class="detail-value">
                        <c:choose>
                            <c:when test="${project.projectStatusId == 1}">Not Started</c:when>
                            <c:when test="${project.projectStatusId == 2}">In Progress</c:when>
                            <c:when test="${project.projectStatusId == 3}">Completed</c:when>
                            <c:when test="${project.projectStatusId == 4}">On Hold</c:when>
                            <c:otherwise>${project.projectStatusId}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Document URL:</span>
                    <span class="detail-value">
                        <c:if test="${not empty project.docURL}">
                            <a href="${project.docURL}" target="_blank">${project.docURL}</a>
                        </c:if>
                        <c:if test="${empty project.docURL}">—</c:if>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Estimated Hours:</span>
                    <span class="detail-value">${project.estimatedHours}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Utilized Hours:</span>
                    <span class="detail-value">${project.totalUtilizedHours}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Start Date:</span>
                    <span class="detail-value">
                        <c:if test="${not empty project.projectStartDate}">${project.projectStartDate}</c:if>
                        <c:if test="${empty project.projectStartDate}">—</c:if>
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Completion Date:</span>
                    <span class="detail-value">
                        <c:if test="${not empty project.projectCompletionDate}">${project.projectCompletionDate}</c:if>
                        <c:if test="${empty project.projectCompletionDate}">—</c:if>
                    </span>
                </div>

                <div style="margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/admin/projects" class="btn btn-back">Back to List</a>
                    <a href="${pageContext.request.contextPath}/admin/projects/edit/${project.projectId}" class="btn btn-edit">Edit</a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>