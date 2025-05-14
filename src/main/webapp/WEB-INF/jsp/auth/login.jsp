<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Quiz App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
    /* Login Page Specific Styles */
.auth-container {
    display: flex;
    width: 100%;
    max-width: 1200px;
    min-height: calc(100vh - 120px); /* Adjust based on header and footer height */
    margin: 0 auto;
    background-color: #ffffff;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
    border-radius: 8px;
    overflow: hidden;
}

/* Authentication Form Section */
.auth-form {
    width: 50%;
    padding: 50px 40px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    background-color: #ffffff;
}

.auth-form h1 {
    color: #2c3e50;
    font-size: 28px;
    margin-bottom: 15px;
    text-align: center;
}

.auth-form > p {
    color: #7f8c8d;
    text-align: center;
    margin-bottom: 30px;
    font-size: 16px;
}

/* Form Group Styles */
.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #2c3e50;
    font-weight: 600;
}

.form-group input {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    font-size: 16px;
    transition: all 0.3s ease;
}

.form-group input:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
}

/* Error Message */
.error-message {
    background-color: #f8d7da;
    color: #721c24;
    padding: 10px 15px;
    border-radius: 4px;
    margin-bottom: 20px;
    text-align: center;
}

/* Form Actions */
.form-actions {
    margin-bottom: 20px;
}

.btn.primary {
    width: 100%;
    padding: 12px 15px;
    background-color: #3498db;
    color: #ffffff;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.btn.primary:hover {
    background-color: #2980b9;
}

/* Authentication Links */
.auth-links {
    text-align: center;
    margin-top: 20px;
}

.auth-links p {
    margin: 10px 0;
    color: #7f8c8d;
}

.auth-links a {
    color: #3498db;
    text-decoration: none;
    transition: color 0.3s ease;
}

.auth-links a:hover {
    color: #2980b9;
    text-decoration: underline;
}

/* Authentication Image Section */
.auth-image {
    width: 50%;
    position: relative;
    background: linear-gradient(135deg, #3498db, #2ecc71);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.auth-image img {
    max-width: 80%;
    max-height: 500px;
    z-index: 1;
    position: relative;
}

.auth-overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(0, 0, 0, 0.5);
    color: #ffffff;
    padding: 20px;
    text-align: center;
}

.auth-overlay h2 {
    margin-bottom: 10px;
    font-size: 22px;
}

.auth-overlay p {
    font-size: 14px;
    opacity: 0.8;
}

/* Responsive Design */
@media (max-width: 1024px) {
    .auth-container {
        flex-direction: column;
        max-width: 500px;
    }

    .auth-form, 
    .auth-image {
        width: 100%;
    }

    .auth-image {
        height: 250px;
    }

    .auth-image img {
        max-width: 60%;
    }
}

@media (max-width: 480px) {
    .auth-form {
        padding: 30px 20px;
    }

    .auth-form h1 {
        font-size: 24px;
    }

    .form-group input {
        padding: 10px;
    }

    .btn.primary {
        padding: 10px;
    }
}
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp" />

    <div class="container">
        <div class="auth-container">
            <div class="auth-form">
                <h1>Sign In</h1>
                <p>Welcome back! Please login to your account.</p>
                
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/auth/login" method="post">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn primary">Sign In</button>
                    </div>
                </form>
                
                <div class="auth-links">
                    <p>Don't have an account? <a href="${pageContext.request.contextPath}/auth/register">Create one</a></p>
                    <p><a href="${pageContext.request.contextPath}/auth/forgot-password">Forgot your password?</a></p>
                </div>
            </div>
            
            <div class="auth-image">
                <img src="${pageContext.request.contextPath}/images/login-illustration.svg" alt="Login">
                <div class="auth-overlay">
                    <h2>Test Your Knowledge</h2>
                    <p>Access hundreds of quizzes and challenge yourself!</p>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp" />
    
    <script>
        $(document).ready(function() {
            // Focus on username field
            $('#username').focus();
            
            // Simple form validation
            $('form').submit(function(e) {
                let username = $('#username').val().trim();
                let password = $('#password').val().trim();
                
                if (username === '' || password === '') {
                    e.preventDefault();
                    $('.error-message').text('Please enter both username and password').show();
                    return false;
                }
            });
        });
    </script>
</body>
</html>