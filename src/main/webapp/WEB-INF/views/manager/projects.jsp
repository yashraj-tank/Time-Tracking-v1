<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
         .layout {
		  display: flex;
		  flex: 1;
		  min-height: calc(100vh - 70px); /* fill remaining viewport height after header */
		  margin-top: 70px;               /* offset fixed header */
		}
		
		.sidebar {
		  width: 260px;
		  height: auto;                   /* let it stretch to parent height */
		  background: #1a3d2b;
		  /* ... other styles ... */
		}
		
		.content {
		  flex: 1;                        /* take remaining width and full height */
		  padding: 30px;
		  overflow-x: auto;
		}
			        body {
			  margin: 0;
			  font-family: Arial, sans-serif;
			  background: #f5f5f5;
			}
			
			.container {
			  display: flex;
			  margin-top: 70px;               /* offset fixed header */
			  min-height: calc(100vh - 70px); /* fill remaining viewport height */
			  background: #f5f5f5;            /* match body background */
			}
			
			.sidebar {
			  width: 260px;
			  height: auto;                   /* let it stretch to parent */
			  background: #1a3d2b;
			  /* sidebar-specific styles are in sidebar.jsp, but we ensure height:auto */
			}
			
			.content {
			  flex: 1;                        /* take remaining width */
			  padding: 30px;
			  overflow-x: auto;
			  background: #f5f5f5;
			}
			
			/* Table styles */
			table {
			  width: 100%;
			  border-collapse: collapse;
			  background: white;
			}
			th, td {
			  border: 1px solid #ddd;
			  padding: 10px;
			  text-align: left;
			}
			th {
			  background-color: #f2f2f2;
			}
			.btn {
			  padding: 5px 10px;
			  text-decoration: none;
			  color: white;
			  border-radius: 3px;
			  background-color: #007bff;
 			}
 			td:last-child {
 			 white-space: nowrap;
			}
			.btn-log {
				 background-color: #28a745;
				  color: white;
				  padding: 6px 12px;      /* slightly larger padding */
				  text-decoration: none;
				  border-radius: 4px;
				  display: inline-block;
				  font-size: 12px;
				  text-align: center;
				  min-width: 80px;        /* ensure minimum width */
				}
				.btn-log {
				  width: 90px;            /* adjust as needed */
				  text-align: center;
				}
			.empty-value { color: #999; font-style: italic; }	
        .badge-pending { color: #ffc107; font-weight: 600; }
        .badge-verified { color: #28a745; font-weight: 600; }
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
                        <th>Title</th>
                        <th>Description</th>
                        <th>Start Date</th>
                        <th>Completion Date</th>
                        <th>Status</th>
                        <th>Est. Hours</th>
                        <th>Utilized Hours</th>
                        <th>Verification</th>
                        <th>Actions</th>
                    </thead>
                     <tbody>
                        <c:forEach var="item" items="${projectsWithStatus}">
                            <c:set var="project" value="${item.project}" />
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
                                        <c:when test="${not empty project.projectCompletionDate}">${project.projectCompletionDate}</c:when>
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
                                    <c:choose>
                                        <c:when test="${item.hasUnverifiedProjectLogs}">
                                            <span class="badge-pending">⏳ Pending</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-verified">✅ Verified</span>
                                        </c:otherwise>
                                    </c:choose>
                                 </td>
                                 <td>
                                    <a href="${pageContext.request.contextPath}/manager/projects/${project.projectId}/log" class="btn btn-log">Log Efforts</a>
                                 </td>
                             </tr>
                         </c:forEach>
                         <c:if test="${empty projectsWithStatus}">
                             <tr><td colspan="10" style="text-align:center;">No projects assigned to you.</td></tr>
                         </c:if>
                     </tbody>
                 </table>
        </div>
    </div>
    <jsp:include page="../admin/footer.jsp" />
</body>
</html>