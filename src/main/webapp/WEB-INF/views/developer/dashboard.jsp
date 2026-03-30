<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        /* Your existing styles (copy from admin/manager dashboard) */
        /* We'll reuse the layout and card styling */
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
        .content { flex: 1; padding: 40px 44px; overflow-x: auto; }
        .page-header { margin-bottom: 36px; }
        .page-header h2 { font-size: 24px; font-weight: 700; color: #111; }
        .page-header p { font-size: 13px; color: #999; margin-top: 5px; }
        .section-label {
            font-size: 10px;
            font-weight: 600;
            letter-spacing: 0.14em;
            text-transform: uppercase;
            color: #bbb;
            margin-bottom: 14px;
        }
        .manager-grid {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 40px;
        }
        .manager-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            width: 200px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .manager-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #3b82f6, #1d4ed8);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
            font-size: 24px;
            font-weight: bold;
            color: white;
        }
        .manager-name {
            font-weight: 600;
            margin-bottom: 4px;
        }
        .manager-email {
            font-size: 12px;
            color: #666;
        }
        .divider { height: 1px; background: #eeeeee; margin: 36px 0; }

        /* Task grouping styles (same as admin tasks) */
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
        .filter-btn.active { background: #111; color: #fff; border-color: #111; }
        .status-group {
            background: #fff;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            margin-bottom: 16px;
            overflow: hidden;
        }
        .status-group.hidden { display: none; }
        .status-header {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px 22px;
            background: #fafafa;
            cursor: pointer;
            font-weight: 600;
            border-bottom: 1px solid #eee;
        }
        .status-header::before {
            content: '▾';
            font-size: 14px;
            color: #666;
            transition: transform 0.2s;
            display: inline-block;
        }
        .status-header.collapsed::before { transform: rotate(-90deg); }
        .status-badge {
            margin-left: auto;
            background: #e8e8e8;
            padding: 3px 12px;
            border-radius: 99px;
        }
        .status-content { overflow: hidden; transition: max-height 0.2s; }
        .status-content.collapsed { max-height: 0 !important; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px 16px; text-align: left; border-bottom: 1px solid #f0f0f0; }
        th { background: #fff; font-weight: 700; color: #555; text-transform: uppercase; font-size: 12px; }
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
        .empty-state { text-align: center; padding: 80px 20px; background: #fff; border-radius: 8px; border: 1px dashed #ccc; }
 		.manager-task-group {
			    background: #fff;
			    border-radius: 12px;
			    margin-bottom: 24px;
			    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
			}
			.manager-header {
			    padding: 16px 20px;
			    background: #f8f9fa;
			    border-bottom: 1px solid #eee;
			    font-weight: 600;
			    border-radius: 12px 12px 0 0;
			}
			.manager-header-info {
			    display: flex;
			    align-items: center;
			    gap: 12px;
			}
			.manager-avatar-small {
			    width: 32px;
			    height: 32px;
			    background: linear-gradient(135deg, #3b82f6, #1d4ed8);
			    border-radius: 50%;
			    display: inline-flex;
			    align-items: center;
			    justify-content: center;
			    font-size: 14px;
			    font-weight: bold;
			    color: white;
			}
			.task-count {
			    font-size: 12px;
			    color: #666;
			    margin-left: 8px;
			}
			.tasks-for-manager {
			    padding: 16px;
			}
			.task-card {
			    background: #fff;
			    border: 1px solid #e9ecef;
			    border-radius: 8px;
			    padding: 12px 16px;
			    margin-bottom: 12px;
			}
			.task-card:last-child {
			    margin-bottom: 0;
			}
			.task-title {
			    display: flex;
			    justify-content: space-between;
			    align-items: center;
			    margin-bottom: 8px;
			}
			.task-details {
			    display: flex;
			    gap: 20px;
			    font-size: 12px;
			    color: #666;
			    margin-bottom: 12px;
			}
			.task-actions {
			    text-align: right;
			}
			.btn-log {
			    background-color: #28a745;
			    color: white;
			    padding: 4px 12px;
			    text-decoration: none;
			    border-radius: 4px;
			    font-size: 12px;
			}
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="layout">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <div class="page-header">
                <h2>Welcome, ${sessionScope.loggedInUser.firstName}!</h2>
                <p>Your tasks grouped by manager</p>
            </div>

            <div class="divider"></div>

            <!-- Tasks Grouped by Manager -->
            <div class="section-label">Tasks by Manager</div>
            <c:choose>
                <c:when test="${empty tasksByManager}">
                    <div class="empty-state">No tasks assigned to you yet.</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="entry" items="${tasksByManager}">
                        <div class="manager-task-group">
                            <div class="manager-header">
                                <div class="manager-header-info">
                                    <c:choose>
                                        <c:when test="${entry.key != null}">
                                            <span class="manager-avatar-small">
                                                ${fn:substring(entry.key.firstName, 0, 1)}${fn:substring(entry.key.lastName, 0, 1)}
                                            </span>
                                            ${entry.key.firstName} ${entry.key.lastName}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="manager-avatar-small">❓</span>
                                            Unassigned Manager
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="task-count">(${fn:length(entry.value)} tasks)</span>
                                </div>
                            </div>
                            <div class="tasks-for-manager">
                                <c:forEach var="taskItem" items="${entry.value}">
                                    <div class="task-card">
                                        <div class="task-title">
                                            <strong>${taskItem.task.title}</strong>
                                            <span class="status-label ${statusClass[taskItem.task.status]}">${statusMap[taskItem.task.status]}</span>
                                        </div>
                                        <div class="task-details">
                                            <span>📁 ${taskItem.projectTitle}</span>
                                            <span>📦 ${taskItem.moduleName}</span>
                                            <span>⏱ Est: ${taskItem.task.estimatedHours}</span>
                                            <span>📊 Util: ${taskItem.task.totalUtilizedHours}</span>
                                        </div>
                                        <div class="task-actions">
                                            <a href="${pageContext.request.contextPath}/developer/tasks/${taskItem.task.taskId}/log" class="btn-log">Log Efforts</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <jsp:include page="../admin/footer.jsp" />
</body>
</html>