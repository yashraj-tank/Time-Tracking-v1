<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
			  margin-top: 70px;               /* offset fixed header */
			  min-height: calc(100vh - 70px); /* fill remaining viewport height */
			  background: #f5f5f5;
			}
			.sidebar {
			  width: 260px;
			  height: auto;                   /* let it stretch to parent */
			  background: #1a3d2b;           /* sidebar background set in its own CSS, but ensure no fixed height */
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
			  background-color: #17a2b8;
			}
			.empty-state {
			  text-align: center;
			  padding: 60px 20px;
			  background: white;
			  border-radius: 8px;
			  border: 1px dashed #ccc;
			  color: #666;
			}
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <jsp:include page="sidebar.jsp" />

        <div class="content">
            <h2>${pageTitle}</h2>
            <p>Tasks currently in progress across your projects.</p>

            <c:choose>
                <c:when test="${not empty tasks}">
                     <table>
                        <thead>
                             <tr>
                                 <th>ID</th>
                                 <th>Title</th>
                                 <th>Description</th>
                                 <th>Module</th>
                                 <th>Project</th>
                                 <th>Est. Hours</th>
                                 <th>Utilized</th>
                             </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${tasks}">
                                 <tr>
                                     <td>${item.task.taskId}</td>
                                     <td>${item.task.title}</td>
                                     <td>${item.task.description}</td>
                                     <td>${item.moduleName}</td>
                                     <td>${item.projectTitle}</td>
                                     <td><fmt:formatNumber value="${item.task.estimatedHours}" pattern="#.#"/></td>
                                     <td><fmt:formatNumber value="${item.task.totalUtilizedHours}" pattern="#.#"/></td>
                                 </tr>
                            </c:forEach>
                        </tbody>
                     </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">No in‑progress tasks found in your projects.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="../admin/footer.jsp" />
</body>
</html>