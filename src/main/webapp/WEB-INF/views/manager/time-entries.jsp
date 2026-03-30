<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            margin-top: 70px;
            min-height: calc(100vh - 70px);
            background: #f5f5f5;
        }
        .sidebar {
            width: 260px;
            height: auto;
            background: #1a3d2b;
        }
        .content {
            flex: 1;
            padding: 30px;
            overflow-x: auto;
            background: #f5f5f5;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background: #f8f9fa;
            font-weight: 600;
            color: #555;
        }
        .btn {
            padding: 5px 10px;
            text-decoration: none;
            color: white;
            border-radius: 4px;
            background-color: #28a745;
        }
        .btn-verify {
            background-color: #17a2b8;
        }
        .filter-bar {
            margin-bottom: 20px;
        }
        .filter-bar a {
            margin-right: 10px;
            text-decoration: none;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background: white;
        }
        .empty-message {
            text-align: center;
            padding: 40px;
            color: #999;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <h2>${pageTitle}</h2>
            <div class="filter-bar">
                <a href="${pageContext.request.contextPath}/manager/time-entries?showAll=false">Unverified Only</a>
                <a href="${pageContext.request.contextPath}/manager/time-entries?showAll=true">Show All</a>
            </div>

            <c:choose>
                <c:when test="${not empty entries}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Task</th>
                                <th>Project</th>
                                <th>User</th>
                                <th>Date</th>
                                <th>Hours</th>
                                <th>Notes</th>
                                <th>Verified</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${entries}">
                                <c:set var="entry" value="${item.entry}" />
                                <tr>
                                    <td>${entry.timeEntryId}</td>
                                    <td>${item.taskTitle}</td>
                                    <td>${item.projectTitle}</td>
                                    <td>${item.userName}</td>
                                    <td>${entry.entryDate}</td>
                                    <td>${entry.hours}</td>
                                    <td>${entry.notes}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${entry.verified}">✅ Verified</c:when>
                                            <c:otherwise>❌ Not Verified</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${not entry.verified}">
                                            <form action="${pageContext.request.contextPath}/manager/time-entries/verify/${entry.timeEntryId}" method="post" style="display:inline;">
                                                <button type="submit" class="btn btn-verify">Verify</button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-message">No time entries found for your projects.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <jsp:include page="../admin/footer.jsp" />
</body>
</html>