<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Inter', sans-serif;
            background: #f7f8fa;
            color: #222;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .layout {
            display: flex;
            flex: 1;
            margin-top: 70px; /* offset for fixed header */
        }

        .content {
            flex: 1;
            padding: 40px 44px;
            overflow-x: auto;
        }

        .page-header { margin-bottom: 36px; }
        .page-header h2 {
            font-size: 24px;
            font-weight: 700;
            color: #111;
            letter-spacing: -0.03em;
        }
        .page-header p {
            font-size: 13px;
            color: #999;
            margin-top: 5px;
        }

        .section-label {
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: #bbb;
            margin-bottom: 14px;
        }

        .divider {
            height: 1px;
            background: #eeeeee;
            margin: 36px 0;
        }

        /* Cards */
        .card-container {
            display: flex;
            gap: 16px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .card {
            flex: 1 1 200px;
            min-width: 200px;
            border-radius: 12px;
            padding: 26px 28px;
            display: flex;
            flex-direction: column;
            gap: 12px;
            position: relative;
            overflow: hidden;
            transition: transform 0.15s, box-shadow 0.15s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.13);
        }

        .card-projects { background: linear-gradient(135deg, #3b82f6, #1d4ed8); }
        .card-completed { background: linear-gradient(135deg, #10b981, #047857); }

        .card-icon {
            font-size: 28px;
            opacity: 0.85;
            line-height: 1;
        }

        .card-label {
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: rgba(255,255,255,0.75);
        }

        .card-value {
            font-size: 42px;
            font-weight: 700;
            color: #fff;
            letter-spacing: -0.04em;
            line-height: 1;
        }

        .card-shine {
            position: absolute;
            top: -30px; right: -30px;
            width: 100px; height: 100px;
            border-radius: 50%;
            background: rgba(255,255,255,0.08);
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #eee;
            padding: 12px 16px;
            text-align: left;
        }
        th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #555;
        }
        .btn {
            padding: 5px 10px;
            text-decoration: none;
            color: white;
            border-radius: 4px;
            background-color: #007bff;
        }
        .empty-value { color: #999; font-style: italic; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="layout">
        <jsp:include page="sidebar.jsp" />

        <div class="content">
            <div class="page-header">
                <h2>Welcome back, ${sessionScope.loggedInUser.firstName}!</h2>
                <p>Here's a snapshot of your assigned projects.</p>
            </div>

            <!-- Two score cards -->
            <div class="card-container">
                <div class="card card-projects">
                    <div class="card-shine"></div>
                    <div class="card-icon">📁</div>
                    <div class="card-label">Total Projects</div>
                    <div class="card-value">${totalProjects}</div>
                </div>

                <div class="card card-completed">
                    <div class="card-shine"></div>
                    <div class="card-icon">✅</div>
                    <div class="card-label">Completed</div>
                    <div class="card-value">${completed}</div>
                </div>
            </div>

            <div class="divider"></div>

            <!-- Assigned projects list -->
            <h3 style="margin-bottom: 20px;">Your Projects</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Start Date</th>
                        <th>Status</th>
                        <th>Est. Hours</th>
                        <th>Utilized</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="project" items="${assignedProjects}">
                        <tr>
                            <td>${project.projectId}</td>
                            <td>${project.title}</td>
                            <td>${project.description}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty project.projectStartDate}">${project.projectStartDate}</c:when>
                                    <c:otherwise><span class="empty-value">—</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${project.projectStatusId == 1}">Not Started</c:when>
                                    <c:when test="${project.projectStatusId == 2}">In Progress</c:when>
                                    <c:when test="${project.projectStatusId == 3}">Completed</c:when>
                                    <c:when test="${project.projectStatusId == 4}">On Hold</c:when>
                                    <c:otherwise>Unknown</c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatNumber value="${project.estimatedHours}" pattern="#.#"/></td>
                            <td><fmt:formatNumber value="${project.totalUtilizedHours}" pattern="#.#"/></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/manager/projects/view/${project.projectId}" class="btn">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty assignedProjects}">
                        <tr><td colspan="8" style="text-align:center;">No projects assigned to you.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <jsp:include page="../admin/footer.jsp" />
</body>
</html>