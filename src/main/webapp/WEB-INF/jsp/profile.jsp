<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
    <style>
    /* Professional User Profile Page Stylesheet */
:root {
    /* Color Palette */
    --primary-color: #007BFF;
    --secondary-color: #6c757d;
    --background-color: #f2f4f8;
    --card-background: #ffffff;
    --text-primary: #333333;
    --text-secondary: #555555;
    
    /* Typography */
    --font-primary: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    
    /* Shadows and Transitions */
    --box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
    --transition-speed: 0.3s;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: var(--font-primary);
    background-color: var(--background-color);
    color: var(--text-primary);
    line-height: 1.6;
    text-rendering: optimizeLegibility;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}

.profile-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    flex-direction: column;
    padding: 20px;
    background-color: var(--background-color);
}

.profile-card {
    background-color: var(--card-background);
    padding: 40px;
    border-radius: 20px;
    box-shadow: var(--box-shadow);
    text-align: center;
    width: 100%;
    max-width: 400px;
    transition: transform var(--transition-speed), box-shadow var(--transition-speed);
    position: relative;
    overflow: hidden;
}

.profile-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.icon {
    margin-bottom: 25px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.icon svg {
    width: 80px;
    height: 80px;
    color: var(--primary-color);
    stroke-width: 1.5;
    transition: transform var(--transition-speed);
}

.icon svg:hover {
    transform: scale(1.1) rotate(5deg);
}

h2 {
    margin: 15px 0 10px;
    font-size: 1.8rem;
    font-weight: 600;
    color: var(--text-primary);
    letter-spacing: -0.5px;
}

p {
    margin: 8px 0;
    color: var(--text-secondary);
    font-size: 1rem;
}

.back-btn {
    display: inline-block;
    margin-bottom: 20px;
    text-decoration: none;
    color: var(--primary-color);
    font-weight: 600;
    padding: 8px 16px;
    border-radius: 8px;
    transition: background-color var(--transition-speed), color var(--transition-speed);
}

.back-btn:hover {
    background-color: rgba(0, 123, 255, 0.1);
}

/* Responsive Adjustments */
@media screen and (max-width: 480px) {
    .profile-card {
        width: 95%;
        padding: 25px;
        border-radius: 15px;
    }

    .icon svg {
        width: 64px;
        height: 64px;
    }

    h2 {
        font-size: 1.5rem;
    }

    p {
        font-size: 0.9rem;
    }
}

/* Subtle Decorative Elements */
.profile-card::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(
        45deg, 
        transparent, 
        rgba(0, 123, 255, 0.05), 
        transparent
    );
    transform: rotate(-45deg);
    z-index: 1;
    pointer-events: none;
}

/* Accessibility Enhancements */
@media (prefers-reduced-motion: reduce) {
    * {
        transition: none !important;
    }
}

/* Print Styles */
@media print {
    body {
        background: white;
    }
    
    .profile-card {
        box-shadow: none;
        border: 1px solid #ddd;
    }
}
    
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
    <div class="profile-container">
       

        <div class="profile-card">
            <div class="icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                    <circle cx="12" cy="7" r="4"></circle>
                </svg>
            </div>
           		<h2>${user.username}</h2>
				<p>Email: ${user.email}</p>
        </div>
    </div>
    <jsp:include page="/WEB-INF/jsp/include/footer.jsp" />
</body>
</html>
