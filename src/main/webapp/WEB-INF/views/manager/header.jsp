<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
  /* Fixed header styles */
  .admin-header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 70px; /* fixed height */
    background-color: #343a40;
    color: white;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 1000;
    box-sizing: border-box;
  }
</style>

<header class="admin-header">
  <div><h2>Manager Dashboard</h2></div>
  <div style="display: flex; align-items: center;">
    <c:choose>
      <c:when test="${not empty sessionScope.loggedInUser}">
        <c:choose>
          <c:when test="${not empty sessionScope.loggedInUser.profilePicURL}">
            <img src="${sessionScope.loggedInUser.profilePicURL}" alt="Profile" style="width: 40px; height: 40px; border-radius: 50%; margin-right: 10px;">
          </c:when>
          <c:otherwise>
            <div style="width: 40px; height: 40px; border-radius: 50%; background-color: #6c757d; color: white; display: flex; align-items: center; justify-content: center; margin-right: 10px;">
              ${sessionScope.loggedInUser.firstName.charAt(0)}${sessionScope.loggedInUser.lastName.charAt(0)}
            </div>
          </c:otherwise>
        </c:choose>
        <span style="margin-right: 20px;">${sessionScope.loggedInUser.firstName} ${sessionScope.loggedInUser.lastName}</span>
        <a href="${pageContext.request.contextPath}/logout" style="color: white; text-decoration: none; background-color: #dc3545; padding: 5px 10px; border-radius: 3px;">Logout</a>
      </c:when>
      <c:otherwise>
        <span style="margin-right: 20px;">Not logged in</span>
        <a href="${pageContext.request.contextPath}/login" style="color: white; text-decoration: none; background-color: #007bff; padding: 5px 10px; border-radius: 3px;">Login</a>
      </c:otherwise>
    </c:choose>
  </div>
</header>