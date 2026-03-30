<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${pageTitle}</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { margin: 0; font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { display: flex; margin-top: 70px; }
        .content { flex: 1; padding: 30px; }
        .chart-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .chart-card h2 {
            margin-bottom: 20px;
            font-size: 20px;
            color: #333;
        }
        canvas {
            max-height: 400px;
            width: 100%;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="container">
        <jsp:include page="sidebar.jsp" />
        <div class="content">
            <h1>Analytics & Charts</h1>

            <div class="chart-card">
                <h2>Task Status Distribution</h2>
                <canvas id="taskChart"></canvas>
            </div>

            <div class="chart-card">
                <h2>Project Status Distribution</h2>
                <canvas id="projectChart"></canvas>
            </div>

            <div class="chart-card">
                <h2>Tasks per Project</h2>
                <canvas id="projectTasksChart"></canvas>
            </div>
        </div>
    </div>
    <jsp:include page="footer.jsp" />

    <script>
        // Task Bar Chart
        const taskCtx = document.getElementById('taskChart').getContext('2d');
        new Chart(taskCtx, {
            type: 'bar',
            data: {
                labels: [
                    <c:forEach var="label" items="${taskStatusLabels}" varStatus="loop">
                        "${label}"<c:if test="${not loop.last}">,</c:if>
                    </c:forEach>
                ],
                datasets: [{
                    label: 'Number of Tasks',
                    data: [
                        <c:forEach var="count" items="${taskStatusData}" varStatus="loop">
                            ${count}<c:if test="${not loop.last}">,</c:if>
                        </c:forEach>
                    ],
                    backgroundColor: ['#ffc107', '#007bff', '#28a745', '#dc3545'],
                    borderColor: '#fff',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } }
            }
        });

        // Project Pie Chart
        const projectCtx = document.getElementById('projectChart').getContext('2d');
        new Chart(projectCtx, {
            type: 'pie',
            data: {
                labels: [
                    <c:forEach var="label" items="${projectStatusLabels}" varStatus="loop">
                        "${label}"<c:if test="${not loop.last}">,</c:if>
                    </c:forEach>
                ],
                datasets: [{
                    data: [
                        <c:forEach var="count" items="${projectStatusData}" varStatus="loop">
                            ${count}<c:if test="${not loop.last}">,</c:if>
                        </c:forEach>
                    ],
                    backgroundColor: ['#ffc107', '#007bff', '#28a745', '#dc3545']
                }]
            },
            options: { responsive: true, maintainAspectRatio: true }
        });

        // Tasks per Project (horizontal bar chart)
        const projectTasksCtx = document.getElementById('projectTasksChart').getContext('2d');
        new Chart(projectTasksCtx, {
            type: 'bar',
            data: {
                labels: [
                    <c:forEach var="name" items="${projectNames}" varStatus="loop">
                        "${name}"<c:if test="${not loop.last}">,</c:if>
                    </c:forEach>
                ],
                datasets: [{
                    label: 'Number of Tasks',
                    data: [
                        <c:forEach var="count" items="${taskCounts}" varStatus="loop">
                            ${count}<c:if test="${not loop.last}">,</c:if>
                        </c:forEach>
                    ],
                    backgroundColor: 'rgba(54, 162, 235, 0.6)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                indexAxis: 'y',  // horizontal bar
                responsive: true,
                maintainAspectRatio: true,
                scales: {
                    x: {
                        beginAtZero: true,
                        ticks: { stepSize: 1 }
                    }
                }
            }
        });
    </script>
</body>
</html>