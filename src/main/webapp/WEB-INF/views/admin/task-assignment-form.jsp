<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; }
        .content { flex: 1; padding: 30px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, select { width: 300px; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        .btn { padding: 8px 16px; background-color: #007bff; color: white; border: none; cursor: pointer; border-radius: 4px; }
        .btn-cancel { background-color: #6c757d; margin-left: 10px; }
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

            <c:choose>
                <c:when test="${assignment.taskUserId == null}">
                    <c:set var="actionUrl" value="${pageContext.request.contextPath}/admin/tasks/${taskId}/assignments/save" />
                </c:when>
                <c:otherwise>
                    <c:set var="actionUrl" value="${pageContext.request.contextPath}/admin/tasks/${taskId}/assignments/update/${assignment.taskUserId}" />
                </c:otherwise>
            </c:choose>

            <form:form action="${actionUrl}" method="post" modelAttribute="assignment">
                <div class="form-group">
                    <label>User:</label>
                    <form:select path="userId" required="true">
                        <form:option value="" label="-- Select User --"/>
                        <form:options items="${users}" itemValue="userId" itemLabel="email" />
                    </form:select>
                </div>
                <div class="form-group">
                    <label>Assign Status:</label>
                    <form:select path="assignStatus">
                        <form:option value="1" label="Assigned"/>
                        <form:option value="2" label="Revoked"/>
                    </form:select>
                </div>
                <div class="form-group">
                    <label>Utilized Hours:</label>
                    <form:input path="utitlizedHours" type="number" step="0.01"/>
                </div>
                <div class="form-group">
                    <input type="submit" value="Save" class="btn"/>
                    <a href="${pageContext.request.contextPath}/admin/tasks/${taskId}/assignments" class="btn btn-cancel">Cancel</a>
                </div>
            </form:form>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>