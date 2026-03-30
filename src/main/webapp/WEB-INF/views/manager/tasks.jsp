<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%
    Map<Integer, String> statusMap = new HashMap<>();
    statusMap.put(1, "Not Started");
    statusMap.put(2, "In Progress");
    statusMap.put(3, "Completed");
    statusMap.put(4, "On Hold");
    request.setAttribute("statusMap", statusMap);
%>
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

        .layout { display: flex; flex: 1; margin-top: 70px; }

        .content {
            flex: 1;
            padding: 40px 44px;
            overflow-x: auto;
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 28px;
        }

        /* Filter buttons */
        .filter-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 28px;
        }
        .filter-btn {
            font-size: 14px;
            font-weight: 500;
            padding: 8px 18px;
            border-radius: 99px;
            border: 1px solid #ccc;
            background: #fff;
            color: #555;
            cursor: pointer;
        }
        .filter-btn:hover {
            border-color: #888;
            color: #222;
        }
        .filter-btn.active {
            background: #111;
            border-color: #111;
            color: #fff;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: #fff;
            border-radius: 8px;
            border: 1px dashed #ccc;
            color: #666;
        }

        /* Status group */
        .status-group {
            background: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            margin-bottom: 16px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .status-group.hidden { display: none; }

        .status-header {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px 22px;
            background: #fafafa;
            cursor: pointer;
            user-select: none;
            font-size: 16px;
            font-weight: 600;
            color: #111;
            transition: background 0.1s;
            border-bottom: 1px solid #eee;
        }
        .status-header:hover { background: #f0f0f0; }
        .status-header::before {
            content: '▾';
            font-size: 14px;
            color: #666;
            transition: transform 0.2s ease;
            display: inline-block;
        }
        .status-header.collapsed::before { transform: rotate(-90deg); }
        .status-badge {
            margin-left: auto;
            font-size: 13px;
            background: #e8e8e8;
            color: #444;
            padding: 3px 12px;
            border-radius: 99px;
            border: 1px solid #d0d0d0;
        }

        .status-content {
            overflow: hidden;
            transition: max-height 0.2s ease;
        }
        .status-content.collapsed { max-height: 0 !important; }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        th {
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            color: #555;
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
            background: #fff;
        }
        td {
            padding: 12px 16px;
            color: #333;
            border-bottom: 1px solid #f0f0f0;
        }
        .status-label {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 99px;
            font-size: 12px;
            font-weight: 600;
        }
        .status-label.not-started { background: #fff3cd; color: #856404; }
        .status-label.in-progress { background: #cce5ff; color: #004085; }
        .status-label.completed { background: #d4edda; color: #155724; }
        .status-label.on-hold { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="layout">
        <jsp:include page="sidebar.jsp" />

        <div class="content">
            <h2 class="page-title">${pageTitle}</h2>

            <div class="filter-buttons">
                <button class="filter-btn active" onclick="filterStatus('all', this)">All Tasks</button>
                <c:forEach var="statusEntry" items="${tasksByStatus}">
                    <button class="filter-btn" onclick="filterStatus(${statusEntry.key}, this)">
                        ${statusMap[statusEntry.key]}
                    </button>
                </c:forEach>
            </div>

            <c:choose>
                <c:when test="${empty tasksByStatus}">
                    <div class="empty-state">
                        No tasks found in your projects.
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="statusEntry" items="${tasksByStatus}">
                        <div id="group-${statusEntry.key}" class="status-group" data-status="${statusEntry.key}">
                            <div class="status-header" onclick="toggleGroup(this)">
                                ${statusMap[statusEntry.key]}
                                <span class="status-badge">${fn:length(statusEntry.value)} task${fn:length(statusEntry.value) != 1 ? 's' : ''}</span>
                            </div>
                            <div class="status-content">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Description</th>
                                            <th>Module</th>
                                            <th>Project</th>
                                            <th>Status</th>
                                            <th>Est. Hours</th>
                                            <th>Utilized</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${statusEntry.value}">
                                            <tr>
                                                <td>${item.task.taskId}</td>
                                                <td>${item.task.title}</td>
                                                <td>${item.task.description}</td>
                                                <td>${item.moduleName}</td>
                                                <td>${item.projectTitle}</td>
                                                <td>
                                                    <span class="status-label 
                                                        <c:choose>
                                                            <c:when test="${item.task.status == 1}">not-started</c:when>
                                                            <c:when test="${item.task.status == 2}">in-progress</c:when>
                                                            <c:when test="${item.task.status == 3}">completed</c:when>
                                                            <c:when test="${item.task.status == 4}">on-hold</c:when>
                                                        </c:choose>">
                                                        ${statusMap[item.task.status]}
                                                    </span>
                                                </td>
                                                <td><fmt:formatNumber value="${item.task.estimatedHours}" pattern="#.#"/></td>
                                                <td><fmt:formatNumber value="${item.task.totalUtilizedHours}" pattern="#.#"/></td>
                                                <td>
   												 <a href="${pageContext.request.contextPath}/manager/tasks/${item.task.taskId}/log" class="btn btn-log">Log Efforts</a>
											</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>


    <script>
        function filterStatus(status, btn) {
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            document.querySelectorAll('.status-group').forEach(group => {
                group.classList.toggle('hidden', status !== 'all' && group.dataset.status !== String(status));
            });
        }

        function toggleGroup(header) {
            header.classList.toggle('collapsed');
            const content = header.nextElementSibling;
            if (content.classList.contains('collapsed')) {
                content.style.maxHeight = content.scrollHeight + 'px';
                content.classList.remove('collapsed');
            } else {
                content.style.maxHeight = content.scrollHeight + 'px';
                requestAnimationFrame(() => {
                    content.style.maxHeight = '0';
                    content.classList.add('collapsed');
                });
            }
        }

        document.querySelectorAll('.status-content').forEach(el => {
            el.style.maxHeight = el.scrollHeight + 'px';
        });
    </script>
</body>
</html>