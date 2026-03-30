<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; }
        .content { flex: 1; padding: 30px; }
        .detail-card {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 30px;
            max-width: 600px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .detail-row {
            display: flex;
            margin-bottom: 15px;
            border-bottom: 1px solid #f0f0f0;
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
        .badge {
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
        }
        .badge-active { background-color: #d4edda; color: #155724; }
        .badge-inactive { background-color: #f8d7da; color: #721c24; }
        .btn {
            padding: 8px 16px;
            text-decoration: none;
            color: white;
            border-radius: 4px;
            display: inline-block;
            margin-right: 10px;
        }
        .btn-edit { background-color: #ffc107; color: black; }
        .btn-back { background-color: #6c757d; }
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
            <div class="detail-card">
                <c:if test="${not empty user}">
                    <div class="detail-row">
                        <span class="detail-label">ID:</span>
                        <span class="detail-value">${user.userId}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Name:</span>
                        <span class="detail-value">${user.firstName} ${user.lastName}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Email:</span>
                        <span class="detail-value">${user.email}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Gender:</span>
                        <span class="detail-value">${user.gender}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Contact:</span>
                        <span class="detail-value">${user.contactNum}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Role:</span>
                        <span class="detail-value">${user.role}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Created At:</span>
                        <span class="detail-value">
                            <c:choose>
                                <c:when test="${not empty user.createdAt}">${user.createdAt}</c:when>
                                <c:otherwise>—</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Status:</span>
                        <span class="detail-value">
                            <c:choose>
                                <c:when test="${user.active}">
                                    <span class="badge badge-active">Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-inactive">Inactive</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </c:if>
                <c:if test="${empty user}">
                    <p>User not found.</p>
                </c:if>
                <div style="margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/admin/users/edit/${user.userId}" class="btn btn-edit">Edit</a>
                    <a href="${pageContext.request.contextPath}/admin/developers" class="btn btn-back">Back to Developers</a>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" />
</body>
</html>