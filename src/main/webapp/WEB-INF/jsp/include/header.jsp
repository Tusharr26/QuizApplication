<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="site-header">
    <div class="container">
        <div class="logo">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
            <style>
            /* Professional Header Styling for Quiz App */

/* Reset and Base Styles */
.site-header * {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

/* Header Container */
.site-header {
  background-color: #ffffff;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
  width: 100%;
  transition: all 0.3s ease;
}

.site-header .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.8rem 1.5rem;
  max-width: 1200px;
  margin: 0 auto;
}

/* Logo Styling */
.site-header .logo a {
  display: flex;
  align-items: center;
  text-decoration: none;
  color: #333;
  font-weight: 700;
  font-size: 1.5rem;
}

.site-header .logo img {
  height: 2.5rem;
  margin-right: 0.5rem;
  transition: transform 0.3s ease;
}

.site-header .logo a:hover img {
  transform: scale(1.05);
}

.site-header .logo span {
  background: linear-gradient(90deg, #4776E6 0%, #8E54E9 100%);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  font-weight: 800;
}

/* Main Navigation */
.site-header .main-nav ul {
  display: flex;
  list-style: none;
  gap: 1.5rem;
}

.site-header .main-nav a {
  color: #555;
  text-decoration: none;
  font-weight: 500;
  font-size: 1rem;
  padding: 0.5rem 0;
  position: relative;
  transition: color 0.3s ease;
}

.site-header .main-nav a:hover {
  color: #4776E6;
}

.site-header .main-nav a::after {
  content: '';
  position: absolute;
  width: 0;
  height: 2px;
  bottom: 0;
  left: 0;
  background: linear-gradient(90deg, #4776E6 0%, #8E54E9 100%);
  transition: width 0.3s ease;
}

.site-header .main-nav a:hover::after,
.site-header .main-nav a.active::after {
  width: 100%;
}

.site-header .main-nav a.active {
  color: #4776E6;
  font-weight: 600;
}

/* Auth Navigation */
.site-header .auth-nav {
  display: flex;
  align-items: center;
  gap: 1rem;
}

/* Button Styles */
.site-header .btn {
  padding: 0.5rem 1.2rem;
  border-radius: 4px;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.3s ease;
  font-size: 0.9rem;
}

.site-header .btn.primary {
  background: linear-gradient(90deg, #4776E6 0%, #8E54E9 100%);
  color: white;
  border: none;
}

.site-header .btn.primary:hover {
  box-shadow: 0 4px 12px rgba(71, 118, 230, 0.3);
  transform: translateY(-2px);
}

.site-header .btn.secondary {
  color: #4776E6;
  background: rgba(71, 118, 230, 0.1);
  border: none;
}

.site-header .btn.secondary:hover {
  background: rgba(71, 118, 230, 0.2);
}

/* User Menu */
.site-header .user-menu {
  position: relative;
}

.site-header .user-menu-toggle {
  display: flex;
  align-items: center;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0.5rem;
  border-radius: 4px;
  transition: background-color 0.3s ease;
}

.site-header .user-menu-toggle:hover {
  background-color: rgba(0, 0, 0, 0.05);
}

.site-header .user-name {
  margin-right: 0.75rem;
  font-weight: 500;
  color: #333;
}

.site-header .avatar {
  width: 2.2rem;
  height: 2.2rem;
  border-radius: 50%;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #4776E6 0%, #8E54E9 100%);
  color: white;
  font-weight: bold;
}

.site-header .avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.site-header .default-avatar {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1rem;
}

/* Dropdown Menu */
.site-header .dropdown-menu {
  position: absolute;
  right: 0;
  top: 3.3rem;
  background: white;
  border-radius: 4px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
  min-width: 180px;
  display: none;
  z-index: 1001;
  animation: fadeIn 0.2s ease-out;
  overflow: hidden;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}

.site-header .dropdown-menu.active {
  display: block;
}

.site-header .dropdown-menu a {
  display: flex;
  align-items: center;
  padding: 0.75rem 1rem;
  color: #333;
  text-decoration: none;
  transition: background-color 0.3s ease;
}

.site-header .dropdown-menu a:hover {
  background-color: #f5f7fa;
}

.site-header .dropdown-menu svg {
  margin-right: 0.75rem;
  color: #6c757d;
}

.site-header .dropdown-menu a:last-child {
  border-top: 1px solid #eee;
  color: #dc3545;
}

.site-header .dropdown-menu a:last-child svg {
  color: #dc3545;
}

/* Mobile Menu Toggle */
.site-header .mobile-menu-toggle {
  display: none;
  flex-direction: column;
  justify-content: space-between;
  width: 1.8rem;
  height: 1.3rem;
  background: transparent;
  border: none;
  cursor: pointer;
  padding: 0;
  z-index: 10;
}

.site-header .mobile-menu-toggle span {
  display: block;
  width: 100%;
  height: 2px;
  background-color: #333;
  transition: all 0.3s ease;
}

.site-header .mobile-menu-toggle.active span:nth-child(1) {
  transform: translateY(8px) rotate(45deg);
}

.site-header .mobile-menu-toggle.active span:nth-child(2) {
  opacity: 0;
}

.site-header .mobile-menu-toggle.active span:nth-child(3) {
  transform: translateY(-8px) rotate(-45deg);
}

/* Responsive Styles */
@media (max-width: 992px) {
  .site-header .container {
    padding: 0.8rem 1rem;
  }
  
  .site-header .main-nav ul {
    gap: 1rem;
  }
}

@media (max-width: 768px) {
  .site-header .mobile-menu-toggle {
    display: flex;
  }
  
  .site-header .main-nav {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    background-color: white;
    padding-top: 5rem;
    z-index: 9;
    transform: translateX(-100%);
    transition: transform 0.3s ease;
  }
  
  .site-header .main-nav.active {
    transform: translateX(0);
  }
  
  .site-header .main-nav ul {
    flex-direction: column;
    align-items: center;
    gap: 2rem;
  }
  
  .site-header .main-nav a {
    font-size: 1.2rem;
  }
  
  .site-header .auth-nav {
    margin-right: 3rem;
  }
  
  .site-header .btn {
    padding: 0.4rem 1rem;
    font-size: 0.85rem;
  }
  
  .site-header .user-name {
    display: none;
  }
}

@media (max-width: 480px) {
  .site-header .logo span {
    display: none;
  }
  
  .site-header .auth-nav {
    gap: 0.5rem;
  }
  
  .site-header .btn {
    padding: 0.4rem 0.8rem;
    font-size: 0.8rem;
  }
}
            </style>
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/pics/logo.png" alt="Logo">



                <span>Quiz App</span>
            </a>
        </div>
        
        <nav class="main-nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/" class="${pageContext.request.servletPath eq '/WEB-INF/jsp/quiz/index.jsp' ? 'active' : ''}">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/quizzes" class="${pageContext.request.servletPath eq '/WEB-INF/jsp/quiz/list.jsp' ? 'active' : ''}">Quizzes</a></li>
                <li><a href="${pageContext.request.contextPath}/leaderboard" class="${pageContext.request.servletPath eq '/WEB-INF/jsp/leaderboard.jsp' ? 'active' : ''}">Leaderboard</a></li>
                <li><a href="${pageContext.request.contextPath}/about" class="${pageContext.request.servletPath eq '/WEB-INF/jsp/about.jsp' ? 'active' : ''}">About</a></li>
            </ul>
        </nav>
        
        <div class="auth-nav">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn secondary">Sign In</a>
                    <a href="${pageContext.request.contextPath}/auth/register" class="btn primary">Register</a>
                </c:when>
                <c:otherwise>
                    <div class="user-menu">
                        <button class="user-menu-toggle">
                            <span class="user-name">${sessionScope.user.username}</span>
                            <span class="avatar">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.avatarUrl}">
                                        <img src="${sessionScope.user.avatarUrl}" alt="${sessionScope.user.username}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="default-avatar">${sessionScope.user.username.substring(0, 1).toUpperCase()}</div>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </button>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/dashboard">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                    <polyline points="9 22 9 12 15 12 15 22"></polyline>
                                </svg>
                                Dashboard
                            </a>
                            <a href="${pageContext.request.contextPath}/profile">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                                Profile
                            </a>
                            <a href="${pageContext.request.contextPath}/my-quizzes">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                    <polyline points="14 2 14 8 20 8"></polyline>
                                    <line x1="16" y1="13" x2="8" y2="13"></line>
                                    <line x1="16" y1="17" x2="8" y2="17"></line>
                                    <polyline points="10 9 9 9 8 9"></polyline>
                                </svg>
                                My Quizzes
                            </a>
                            <a href="${pageContext.request.contextPath}/auth/logout">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                                    <polyline points="16 17 21 12 16 7"></polyline>
                                    <line x1="21" y1="12" x2="9" y2="12"></line>
                                </svg>
                                Sign Out
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <button class="mobile-menu-toggle">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </div>
</header>

<script>
    $(document).ready(function() {
        // Mobile menu toggle
        $('.mobile-menu-toggle').click(function() {
            $(this).toggleClass('active');
            $('.main-nav').toggleClass('active');
        });
        
        // User dropdown menu
        $('.user-menu-toggle').click(function(e) {
            e.stopPropagation();
            $('.dropdown-menu').toggleClass('active');
        });
        
        $(document).click(function() {
            $('.dropdown-menu').removeClass('active');
        });
    });
</script>