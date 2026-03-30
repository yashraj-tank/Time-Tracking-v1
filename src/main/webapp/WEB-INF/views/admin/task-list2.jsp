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
      background: #f5f5f5;
      color: #222; /* darker base text */
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .layout {
      display: flex;
      flex: 1;
    }

    .content {
      flex: 1;
      padding: 32px 36px;
      overflow-x: auto;
    }

    .page-title {
      font-size: 28px; /* increased */
      font-weight: 600;
      color: #000;
      letter-spacing: -0.02em;
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
      font-family: 'Inter', sans-serif;
      font-size: 14px; /* increased */
      font-weight: 500;
      padding: 8px 18px; /* larger */
      border-radius: 99px;
      border: 1px solid #ccc;
      background: #fff;
      color: #555; /* darker */
      cursor: pointer;
      transition: all 0.1s ease;
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
      font-size: 16px;
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
      padding: 16px 22px; /* more padding */
      background: #fafafa;
      cursor: pointer;
      user-select: none;
      font-size: 16px; /* increased */
      font-weight: 600; /* bolder */
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
      font-size: 13px; /* increased */
      background: #e8e8e8;
      color: #444;
      padding: 3px 12px;
      border-radius: 99px;
      border: 1px solid #d0d0d0;
      font-weight: 500;
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
      font-size: 15px; /* increased */
    }

    th {
      font-size: 13px; /* increased */
      font-weight: 700; /* bolder */
      letter-spacing: 0.05em;
      text-transform: uppercase;
      color: #555;
      padding: 14px 20px;
      text-align: left;
      white-space: nowrap;
      border-bottom: 1px solid #e0e0e0;
      background: #fff;
    }

    td {
      padding: 14px 20px;
      color: #333; /* darker */
      border-bottom: 1px solid #f0f0f0;
      vertical-align: middle;
    }

    tbody tr:last-child td { border-bottom: none; }

    tbody tr:hover td {
      background: #f5f5f5;
      color: #000;
    }

    td:first-child {
      font-size: 13px; /* increased */
      color: #888;
      font-weight: 500;
    }

    td:nth-last-child(-n+2) {
      color: #111;
      font-weight: 600;
      text-align: right;
    }

    th:nth-last-child(-n+2) { text-align: right; }

    /* Status label in table */
    .status-label {
      display: inline-block;
      padding: 4px 12px;
      border-radius: 99px;
      font-size: 13px;
      font-weight: 600;
      background: #f0f0f0;
      color: #333;
    }
    .status-label.not-started { background: #fff3cd; color: #856404; }
    .status-label.in-progress { background: #cce5ff; color: #004085; }
    .status-label.completed { background: #d4edda; color: #155724; }
    .status-label.on-hold { background: #f8d7da; color: #721c24; }
    .container {
  	margin-top: 70px; /* same as header height */
	}
	.layout {
		  display: flex;
		  flex: 1;
		  padding-top: 70px; /* offset for fixed header */
		}
		
		.sidebar {
		  /* ensure sidebar height is viewport minus header */
		  height: calc(100vh - 70px);
		  /* existing styles */
		}
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
            No tasks found. Create a new task to get started.
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
 					    <a href="${pageContext.request.contextPath}/admin/tasks/${item.task.taskId}/assignments" class="btn btn-assignments">Assignments</a>
  					    <!-- other buttons -->
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

  <jsp:include page="footer.jsp" />

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