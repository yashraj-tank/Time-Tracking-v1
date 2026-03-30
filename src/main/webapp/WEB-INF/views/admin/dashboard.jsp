<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

    .layout { display: flex; flex: 1; }

    .content {
      flex: 1;
      padding: 40px 44px;
      overflow-x: auto;
    }

    /* Page header */
    .page-header { margin-bottom: 36px; }
    .page-header h2 {
      font-size: 24px;
      font-weight: 700;
      color: #111;
      letter-spacing: -0.03em;
    }
    .page-header p {
      font-size: 13px;
      color: #999;
      margin-top: 5px;
    }

    .section-label {
      font-size: 10px;
      font-weight: 600;
      letter-spacing: 0.14em;
      text-transform: uppercase;
      color: #bbb;
      margin-bottom: 14px;
    }

    .divider {
      height: 1px;
      background: #eeeeee;
      margin: 36px 0;
    }

    /* ── Overview cards ── */
    .card-container {
      display: flex;
      gap: 16px;
      margin-bottom: 0;
      flex-wrap: wrap;
    }

    .card {
      flex: 1 1 160px;
      min-width: 160px;
      border-radius: 12px;
      padding: 26px 28px;
      display: flex;
      flex-direction: column;
      gap: 12px;
      position: relative;
      overflow: hidden;
      transition: transform 0.15s, box-shadow 0.15s;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }

    .card:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 24px rgba(0,0,0,0.13);
    }

    .card-projects { background: linear-gradient(135deg, #3b82f6, #1d4ed8); }
    .card-modules  { background: linear-gradient(135deg, #8b5cf6, #6d28d9); }
    .card-tasks    { background: linear-gradient(135deg, #10b981, #047857); }

    .card-icon {
      font-size: 28px;
      opacity: 0.85;
      line-height: 1;
    }

    .card-label {
      font-size: 11px;
      font-weight: 600;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: rgba(255,255,255,0.75);
    }

    .card-value {
      font-size: 42px;
      font-weight: 700;
      color: #fff;
      letter-spacing: -0.04em;
      line-height: 1;
    }

    .card-shine {
      position: absolute;
      top: -30px; right: -30px;
      width: 100px; height: 100px;
      border-radius: 50%;
      background: rgba(255,255,255,0.08);
    }

    /* ── Status grid ── */
    .status-grid {
      display: flex;
      gap: 14px;
      flex-wrap: wrap;
    }

    .status-item {
      flex: 1 1 160px;
      min-width: 160px;
      border-radius: 12px;
      padding: 22px 24px;
      position: relative;
      overflow: hidden;
      transition: transform 0.15s, box-shadow 0.15s;
      box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    }

    .status-item:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 24px rgba(0,0,0,0.13);
    }

    .status-item.not-started { background: linear-gradient(135deg, #fbbf24, #d97706); }
    .status-item.in-progress { background: linear-gradient(135deg, #60a5fa, #2563eb); }
    .status-item.completed   { background: linear-gradient(135deg, #34d399, #059669); }
    .status-item.on-hold     { background: linear-gradient(135deg, #f87171, #dc2626); }

    .status-shine {
      position: absolute;
      top: -25px; right: -25px;
      width: 90px; height: 90px;
      border-radius: 50%;
      background: rgba(255,255,255,0.1);
    }

    .status-name {
      font-size: 11px;
      font-weight: 600;
      letter-spacing: 0.1em;
      text-transform: uppercase;
      color: rgba(255,255,255,0.8);
      margin-bottom: 12px;
    }

    .status-count {
      font-size: 38px;
      font-weight: 700;
      color: #fff;
      letter-spacing: -0.03em;
      line-height: 1;
    }
    .container {
  	margin-top: 70px; /* same as header height */
	}
	.layout {
  display: flex;
  flex: 1;
  margin-top: 70px; /* offset for fixed header */
}

/* Remove or ignore the .container rule */
  </style>
</head>
<body>

  <jsp:include page="header.jsp" />

  <div class="layout">
    <jsp:include page="sidebar.jsp" />

    <div class="content">

      <div class="page-header">
        <h2>Welcome back, ${sessionScope.loggedInUser.firstName}!</h2>
        <p>Here's a snapshot of your workspace. Use the sidebar to navigate.</p>
      </div>

      <!-- Overview Cards -->
      <div class="section-label">Overview</div>
      <div class="card-container">

        <div class="card card-projects">
          <div class="card-shine"></div>
          <div class="card-icon">📁</div>
          <div class="card-label">Total Projects</div>
          <div class="card-value">${projectCount}</div>
        </div>

        <div class="card card-modules">
          <div class="card-shine"></div>
          <div class="card-icon">📦</div>
          <div class="card-label">Total Modules</div>
          <div class="card-value">${moduleCount}</div>
        </div>

        <div class="card card-tasks">
          <div class="card-shine"></div>
          <div class="card-icon">✅</div>
          <div class="card-label">Total Tasks</div>
          <div class="card-value">${taskCount}</div>
        </div>

      </div>

      <div class="divider"></div>

      <!-- Status Breakdown -->
      <div class="section-label">Tasks by Status</div>
      <div class="status-grid">

        <div class="status-item not-started">
          <div class="status-shine"></div>
          <div class="status-name">Not Started</div>
          <div class="status-count">${statusCounts['Not Started']}</div>
        </div>

        <div class="status-item in-progress">
          <div class="status-shine"></div>
          <div class="status-name">In Progress</div>
          <div class="status-count">${statusCounts['In Progress']}</div>
        </div>

        <div class="status-item completed">
          <div class="status-shine"></div>
          <div class="status-name">Completed</div>
          <div class="status-count">${statusCounts['Completed']}</div>
        </div>

        <div class="status-item on-hold">
          <div class="status-shine"></div>
          <div class="status-name">On Hold</div>
          <div class="status-count">${statusCounts['On Hold']}</div>
        </div>

      </div>

    </div>
  </div>

  <jsp:include page="footer.jsp" />

</body>
</html>