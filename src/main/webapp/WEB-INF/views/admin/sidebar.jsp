<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500;600&family=IBM+Plex+Sans:wght@300;400;500;600&display=swap');

	  .sidebar {
	  width: 260px;
	  height: auto;                 /* ← was height: calc(100vh - 70px) */
	  background: #1a3d2b;
	  padding: 0;
	  display: flex;
	  flex-direction: column;
	  font-family: 'IBM Plex Sans', sans-serif;
	  border-right: 1px solid #1e4a32;
	  position: relative;
	  /* overflow: hidden; ← remove */
	}

  .sidebar::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 3px;
    background: linear-gradient(90deg, #52e09c, #00d4aa, #a8f0c6);
    z-index: 1;
  }

  .sidebar-header {
    padding: 28px 24px 20px;
    border-bottom: 1px solid #1e4a32;
    flex-shrink: 0; /* prevent shrinking */
  }

  .sidebar-logo {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 11px;
    font-weight: 600;
    letter-spacing: 0.22em;
    text-transform: uppercase;
    color: #52e09c;
  }

  .sidebar-subtitle {
    font-size: 11.5px;
    color: #4d8c66;
    margin-top: 4px;
    font-weight: 300;
    letter-spacing: 0.03em;
  }

  /* Scrollable nav container */
  .sidebar-nav {
    flex: 1; /* take remaining space */
    overflow-y: auto; /* enable scrolling if content overflows */
    padding: 8px 16px;
    scrollbar-width: thin;
    scrollbar-color: #3a6b4d #1a3d2b;
  }

  .sidebar-nav::-webkit-scrollbar {
    width: 5px;
  }

  .sidebar-nav::-webkit-scrollbar-track {
    background: #1a3d2b;
  }

  .sidebar-nav::-webkit-scrollbar-thumb {
    background: #3a6b4d;
    border-radius: 10px;
  }

  .sidebar-nav::-webkit-scrollbar-thumb:hover {
    background: #4d8c66;
  }

  .sidebar-section {
    margin-bottom: 12px;
  }

  .sidebar-section-label {
    font-family: 'IBM Plex Mono', monospace;
    font-size: 9px;
    font-weight: 600;
    letter-spacing: 0.25em;
    text-transform: uppercase;
    color: #3a6b4d;
    padding: 0 8px;
    margin-bottom: 6px;
  }

  .nav-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 10px 12px;
    border-radius: 8px;
    text-decoration: none;
    color: #a8d4b8;
    font-size: 13.5px;
    font-weight: 400;
    transition: all 0.15s ease;
    margin-bottom: 2px;
    position: relative;
  }

  .nav-item:hover {
    background: #1e4a32;
    color: #d4f0e0;
  }

  .nav-item.active {
    background: #1e4a32;
    color: #52e09c;
    font-weight: 500;
  }

  .nav-item.active::before {
    content: '';
    position: absolute;
    left: 0; top: 25%; bottom: 25%;
    width: 3px;
    border-radius: 0 3px 3px 0;
    background: #52e09c;
  }

  .nav-icon {
    width: 28px;
    height: 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 6px;
    background: #1e4a32;
    font-size: 13px;
    flex-shrink: 0;
    transition: background 0.15s;
  }

  .nav-item:hover .nav-icon,
  .nav-item.active .nav-icon {
    background: #245a3a;
  }

  .nav-badge {
    margin-left: auto;
    font-size: 10px;
    background: #1e4a32;
    color: #4d8c66;
    padding: 2px 8px;
    border-radius: 99px;
    font-family: 'IBM Plex Mono', monospace;
    white-space: nowrap;
  }

  .nav-divider {
    height: 1px;
    background: #1e4a32;
    margin: 10px 16px;
  }

  .sidebar-footer {
    padding: 16px;
    border-top: 1px solid #1e4a32;
    flex-shrink: 0; /* prevent shrinking */
  }

  .auth-btn {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 12px;
    border-radius: 8px;
    text-decoration: none;
    font-size: 13px;
    font-weight: 500;
    margin-bottom: 6px;
    transition: all 0.15s ease;
  }

  .auth-btn-signup {
    background: #245a3a;
    color: #52e09c;
    border: 1px solid #2d6e47;
  }

  .auth-btn-signup:hover {
    background: #2a6642;
    border-color: #3a8058;
  }

  .auth-btn-login {
    background: transparent;
    color: #6aaa84;
    border: 1px solid #1e4a32;
  }

  .auth-btn-login:hover {
    background: #1e4a32;
    color: #a8d4b8;
  }

  .auth-icon { font-size: 14px; }
</style>

<div class="sidebar">
  <div class="sidebar-header">
    <div class="sidebar-logo">Admin Panel</div>
    <div class="sidebar-subtitle">Project Management System</div>
  </div>

  <div class="sidebar-nav">
    <div class="sidebar-section">
      <div class="sidebar-section-label">Workspace</div>

		 <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
		    <span class="nav-icon">🏠</span>
		    Dashboard
		</a>
		      
      <a href="${pageContext.request.contextPath}/admin/projects" class="nav-item">
        <span class="nav-icon">📁</span>
        Projects
      </a>

      <a href="${pageContext.request.contextPath}/admin/modules" class="nav-item">
        <span class="nav-icon">📦</span>
        Modules
      </a>

      <a href="${pageContext.request.contextPath}/admin/tasks" class="nav-item">
        <span class="nav-icon">✅</span>
        Tasks
        <span class="nav-badge">by status</span>
      </a>

      <a href="${pageContext.request.contextPath}/admin/assignments" class="nav-item">
        <span class="nav-icon">👥</span>
        Assignments
        <span class="nav-badge">all</span>
      </a>

      <a href="${pageContext.request.contextPath}/admin/developers" class="nav-item">
        <span class="nav-icon">👨‍💻</span>
        Developers
        <span class="nav-badge">all</span>
      </a>

      <a href="${pageContext.request.contextPath}/admin/managers" class="nav-item">
        <span class="nav-icon">👔</span>
        Managers
        <span class="nav-badge">all</span>
      </a>
      <a href="${pageContext.request.contextPath}/admin/project-managers" class="nav-item">
    	<span class="nav-icon">📋</span>
   		 Project Managers
   	 	<span class="nav-badge">assign</span>
	  </a>
	  <a href="${pageContext.request.contextPath}/admin/project-time-entries" class="nav-item">
   		 <span class="nav-icon">📊</span>
    		Project Time Logs
   		 <span class="nav-badge">verify</span>
		</a>
	  <a href="${pageContext.request.contextPath}/admin/time-entries" class="nav-item">
    	<span class="nav-icon">⏱️</span>
   		 Time Logs
   		 <span class="nav-badge">verify</span>
		</a>
	  <a href="${pageContext.request.contextPath}/admin/charts" class="nav-item">
    	<span class="nav-icon">📊</span>
    	Analytics
	 </a>
    </div>

    <div class="nav-divider"></div>

    <div class="sidebar-section">
      <div class="sidebar-section-label">Auth</div>
      <a href="${pageContext.request.contextPath}/signup" class="nav-item">
        <span class="nav-icon">📝</span>
        Sign Up
      </a>
      <a href="${pageContext.request.contextPath}/login" class="nav-item">
        <span class="nav-icon">🔐</span>
        Login
      </a>
      <a href="${pageContext.request.contextPath}/developer/profile" class="nav-item">
    	<span class="nav-icon">👤</span>
   		 My Profile
	</a>
    </div>
  </div>

  <!-- Optional footer removed, now auth links are inside scrollable area -->
  <!-- If you want a fixed footer, you can keep sidebar-footer separate but then it won't scroll -->
  <!-- Keeping all nav items in scrollable area is more consistent -->
</div>