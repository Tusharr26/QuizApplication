<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Quiz App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
    /* Register Page Specific Styles */
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
    padding: 40px 30px;
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
    position: relative;
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

/* Password Strength Meter */
.password-strength-meter {
    height: 4px;
    background-color: #e0e0e0;
    margin-top: 5px;
    border-radius: 2px;
    overflow: hidden;
}

.meter-bar {
    height: 100%;
    width: 0;
    transition: width 0.3s ease;
}

.meter-bar.weak {
    background-color: #e74c3c;
}

.meter-bar.medium {
    background-color: #f39c12;
}

.meter-bar.strong {
    background-color: #2ecc71;
}

.meter-bar.very-strong {
    background-color: #27ae60;
}

/* Password Requirements */
.password-requirements {
    font-size: 12px;
    color: #7f8c8d;
    margin-top: 8px;
    font-style: italic;
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

/* Form Check (Terms Agreement) */
.form-check {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.form-check input[type="checkbox"] {
    margin-right: 10px;
    width: auto;
}

.form-check label {
    font-size: 14px;
    color: #7f8c8d;
    cursor: pointer;
}

.form-check a {
    color: #3498db;
    text-decoration: none;
    transition: color 0.3s ease;
}

.form-check a:hover {
    color: #2980b9;
    text-decoration: underline;
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

    .password-requirements {
        font-size: 11px;
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
                <h1>Create Account</h1>
                <p>Join our community and start exploring quizzes!</p>
                
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/auth/register" method="post" id="registerForm">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" value="${username}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" value="${email}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                        <div class="password-strength-meter">
                            <div class="meter-bar"></div>
                        </div>
                        <div class="password-requirements">
                            Password should be at least 8 characters and include a mix of letters, numbers, and symbols.
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    
                    <div class="form-check">
                        <input type="checkbox" id="termsAgreement" name="termsAgreement" required>
                        <label for="termsAgreement">I agree to the <a href="${pageContext.request.contextPath}/terms" target="_blank">Terms of Service</a> and <a href="${pageContext.request.contextPath}/privacy" target="_blank">Privacy Policy</a></label>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn primary">Create Account</button>
                    </div>
                </form>
                
                <div class="auth-links">
                    <p>Already have an account? <a href="${pageContext.request.contextPath}/auth/login">Sign In</a></p>
                </div>
            </div>
            
            <div class="auth-image">
                <img src="${pageContext.request.contextPath}/images/register-illustration.svg" alt="Register">
                <div class="auth-overlay">
                    <h2>Join Our Community</h2>
                    <p>Create, take, and share quizzes on any topic!</p>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp" />
    
    <script>
        $(document).ready(function() {
            // Focus on username field
            $('#username').focus();
            
            // Password strength meter
            $('#password').on('input', function() {
                let password = $(this).val();
                let strength = 0;
                
                if (password.length >= 8) strength += 1;
                if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength += 1;
                if (password.match(/\d+/)) strength += 1;
                if (password.match(/[^a-zA-Z0-9]/)) strength += 1;
                
                let meterBar = $('.meter-bar');
                meterBar.removeClass('weak medium strong very-strong');
                
                if (password.length === 0) {
                    meterBar.css('width', '0%');
                } else if (strength === 1) {
                    meterBar.addClass('weak').css('width', '25%');
                } else if (strength === 2) {
                    meterBar.addClass('medium').css('width', '50%');
                } else if (strength === 3) {
                    meterBar.addClass('strong').css('width', '75%');
                } else if (strength === 4) {
                    meterBar.addClass('very-strong').css('width', '100%');
                }
            });
            
            // Form validation
            $('#registerForm').submit(function(e) {
                let username = $('#username').val().trim();
                let email = $('#email').val().trim();
                let password = $('#password').val();
                let confirmPassword = $('#confirmPassword').val();
                let termsAgreement = $('#termsAgreement').is(':checked');
                let error = '';
                
                if (username === '') {
                    error = 'Username is required';
                } else if (email === '') {
                    error = 'Email is required';
                } else if (!isValidEmail(email)) {
                    error = 'Please enter a valid email address';
                } else if (password === '') {
                    error = 'Password is required';
                } else if (password.length < 8) {
                    error = 'Password must be at least 8 characters long';
                } else if (password !== confirmPassword) {
                    error = 'Passwords do not match';
                } else if (!termsAgreement) {
                    error = 'You must agree to the Terms of Service and Privacy Policy';
                }
                
                if (error !== '') {
                    e.preventDefault();
                    $('.error-message').text(error).show();
                    return false;
                }
            });
            
            function isValidEmail(email) {
                let regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                return regex.test(email);
            }
        });
    </script>
</body>
</html>