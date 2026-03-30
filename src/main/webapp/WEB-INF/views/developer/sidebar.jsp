<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap');

		 .sidebar {
	  width: 260px;
	  height: auto;               /* changed from calc(100vh - 70px) */
	  background: #1a3d2b;
	  padding: 0;
	  display: flex;
	  flex-direction: column;
	  font-family: 'IBM Plex Sans', sans-serif;
	  border-right: 1px solid #1e4a32;
	  position: relative;
	  /* overflow: hidden; <- remove if present */
	}
  /* Profile section */
  .profile-section {
    padding: 24px 20px 20px;
    border-bottom: 1px solid #1e4a32;
    margin-bottom: 8px;
  }
  .profile-avatar {
    width: 48px;
    height: 48px;
    background: linear-gradient(135deg, #52e09c, #00d4aa);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    font-weight: 600;
    color: #1a3d2b;
    margin-bottom: 12px;
  }
  .profile-name {
    font-size: 15px;
    font-weight: 600;
    color: #d4f0e0;
    margin-bottom: 2px;
  }
  .profile-email {
    font-size: 11px;
    color: #6aaa84;
    word-break: break-word;
  }

  /* Navigation items */
  .nav-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 10px 20px;
    text-decoration: none;
    color: #a8d4b8;
    font-size: 13.5px;
    font-weight: 500;
    transition: all 0.15s ease;
    margin: 2px 8px;
    border-radius: 8px;
  }
  .nav-item:hover {
    background: #1e4a32;
    color: #d4f0e0;
  }
  .nav-item.active {
    background: #1e4a32;
    color: #52e09c;
  }
  .nav-icon {
    width: 28px;
    text-align: center;
    font-size: 16px;
  }
  .layout {
  display: flex;
  flex: 1;
  min-height: calc(100vh - 70px); /* matches header offset */
  margin-top: 70px;               /* push down below fixed header */
}
  .logout .nav-item {
    color: #f8a5a5;
  }
  .logout .nav-item:hover {
    background: #2c5a3e;
    color: #ffcccc;
  }
</style>

<div class="sidebar">
  <div class="profile-section">
    <div class="profile-avatar">
      <c:set var="firstInitial" value="${fn:substring(sessionScope.loggedInUser.firstName, 0, 1)}" />
      <c:set var="lastInitial" value="" />
      <c:if test="${not empty sessionScope.loggedInUser.lastName}">
        <c:set var="lastInitial" value="${fn:substring(sessionScope.loggedInUser.lastName, 0, 1)}" />
      </c:if>
      ${firstInitial}${lastInitial}
    </div>
    <div class="profile-name">${sessionScope.loggedInUser.firstName} ${sessionScope.loggedInUser.lastName}</div>
    <div class="profile-email">${sessionScope.loggedInUser.email}</div>
  </div>

  <div class="nav-section">
    <a href="${pageContext.request.contextPath}/developer/dashboard" class="nav-item ${param.page == 'dashboard' ? 'active' : ''}">
      <span class="nav-icon">📊</span> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/developer/tasks" class="nav-item ${param.page == 'tasks' ? 'active' : ''}">
      <span class="nav-icon">✅</span> My Tasks
    </a>
    <a href="${pageContext.request.contextPath}/developer/profile" class="nav-item">
    <span class="nav-icon">👤</span>
    My Profile
	</a>
  </div>

  <div class="logout">
    <a href="${pageContext.request.contextPath}/logout" class="nav-item" onclick="return confirm('Log out?');">
      <span class="nav-icon">🚪</span> Logout
    </a>
  </div>
</div>