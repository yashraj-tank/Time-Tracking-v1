<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; margin-top: 70px; }
        .content { flex: 1; padding: 30px; }
        .form-card {
            background: white;
            border-radius: 8px;
            padding: 30px;
            max-width: 600px;
            margin: 0 auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: 600; color: #555; }
        input, select, textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        .btn-cancel {
            background-color: #6c757d;
            margin-left: 10px;
            text-decoration: none;
            display: inline-block;
            padding: 8px 16px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <div class="form-card">
                <h2>${pageTitle}</h2>

                <c:choose>
                    <c:when test="${task.taskId == null}">
                        <c:set var="actionUrl" value="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/${moduleId}/tasks/save" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="actionUrl" value="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/${moduleId}/tasks/update/${task.taskId}" />
                    </c:otherwise>
                </c:choose>

                <form:form action="${actionUrl}" method="post" modelAttribute="task">
                    <div class="form-group">
                        <label>Title:</label>
                        <form:input path="title" required="true"/>
                    </div>
                    <div class="form-group">
                        <label>Description:</label>
                        <form:textarea path="description" rows="3" cols="30"/>
                    </div>
                    <div class="form-group">
                        <label>Status:</label>
                        <form:select path="status">
                            <form:option value="" label="-- Select Status --"/>
                            <form:options items="${statuses}" itemValue="id" itemLabel="name"/>
                        </form:select>
                    </div>
                    <div class="form-group">
                        <label>Document URL:</label>
                        <form:input path="docURL"/>
                    </div>
                    <div class="form-group">
                        <label>Estimated Hours:</label>
                        <form:input path="estimatedHours" type="number" step="0.1"/>
                    </div>
                    <form:hidden path="totalUtilizedHours"/>
                    <form:hidden path="projectId"/>
                    <form:hidden path="moduleId"/>

                    <div class="form-group">
                        <input type="submit" value="Save" class="btn"/>
                        <a href="${pageContext.request.contextPath}/admin/projects/${projectId}/modules/${moduleId}/tasks" class="btn-cancel">Cancel</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>