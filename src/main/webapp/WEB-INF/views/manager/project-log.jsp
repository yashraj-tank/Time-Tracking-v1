<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; margin-top: 70px; min-height: calc(100vh - 70px); }
        .content { flex: 1; padding: 30px; }
        .form-card {
            background: white;
            border-radius: 8px;
            padding: 30px;
            max-width: 500px;
            margin: 0 auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-cancel {
            background-color: #6c757d;
            margin-left: 10px;
            text-decoration: none;
            display: inline-block;
            padding: 10px 20px;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <jsp:include page="../admin/header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <div class="form-card">
                <h2>Log Time for Project: ${projectTitle}</h2>
                <form action="${pageContext.request.contextPath}/manager/projects/${projectId}/log" method="post">
                    <div class="form-group">
                        <label>Date:</label>
                        <input type="date" name="entryDate" required />
                    </div>
                    <div class="form-group">
                        <label>Hours:</label>
                        <input type="number" step="0.1" name="hours" required />
                    </div>
                    <div class="form-group">
                        <label>Notes (optional):</label>
                        <textarea name="notes" rows="3"></textarea>
                    </div>
                    <div>
                        <button type="submit" class="btn">Save</button>
                        <a href="${pageContext.request.contextPath}/manager/projects" class="btn-cancel">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="../admin/footer.jsp" />
</body>
</html>