<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Quiz App</title>
    <style>/* Professional Dashboard Styling for Quiz App */

/* Base Dashboard Styles */
.dashboard {
  padding: 2rem 0;
  max-width: 1200px;
  margin: 0 auto;
}

/* Welcome Section */
.welcome-section {
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  border-radius: 10px;
  padding: 2rem;
  margin-bottom: 2rem;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
  text-align: center;
  position: relative;
  overflow: hidden;
}

.welcome-section::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 5px;
  background: linear-gradient(90deg, #4776E6 0%, #8E54E9 100%);
}

.welcome-section h1 {
  color: #333;
  margin-bottom: 0.75rem;
  font-size: 2rem;
  font-weight: 700;
}

.welcome-section p {
  color: #6c757d;
  margin-bottom: 1.5rem;
  font-size: 1.1rem;
  max-width: 700px;
  margin-left: auto;
  margin-right: auto;
}

.action-buttons {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-top: 1.5rem;
}

/* Button Styles - Consistent with Header */
.btn {
  padding: 0.6rem 1.5rem;
  border-radius: 4px;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.3s ease;
  font-size: 0.95rem;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border: none;
}

.btn.primary {
  background: linear-gradient(90deg, #4776E6 0%, #8E54E9 100%);
  color: white;
}

.btn.primary:hover {
  box-shadow: 0 4px 12px rgba(71, 118, 230, 0.3);
  transform: translateY(-2px);
}

.btn.secondary {
  color: #4776E6;
  background: rgba(71, 118, 230, 0.1);
}

.btn.secondary:hover {
  background: rgba(71, 118, 230, 0.2);
}

.btn.small {
  padding: 0.3rem 0.8rem;
  font-size: 0.85rem;
}

/* Dashboard Sections */
.dashboard-sections {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2rem;
}

@media (min-width: 992px) {
  .dashboard-sections {
    grid-template-columns: repeat(2, 1fr);
  }
}

.dashboard-section {
  background: #fff;
  border-radius: 10px;
  padding: 1.5rem;
  box-shadow: 0 2px 15px rgba(0, 0, 0, 0.06);
  height: 100%;
}

.dashboard-section h2 {
  font-size: 1.5rem;
  color: #333;
  margin-bottom: 1.5rem;
  padding-bottom: 0.75rem;
  border-bottom: 2px solid #f0f0f0;
  position: relative;
}

.dashboard-section h2::after {
  content: "";
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 60px;
  height: 2px;
  background: linear-gradient(90deg, #4776E6 0%, #8E54E9 100%);
}

/* Quiz Cards */
.quiz-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.quiz-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.2rem;
  border-radius: 8px;
  background-color: #f8f9fa;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.quiz-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
}

.quiz-info {
  flex: 1;
}

.quiz-info h3 {
  font-size: 1.1rem;
  margin-bottom: 0.5rem;
  color: #333;
}

.quiz-info p {
  color: #6c757d;
  font-size: 0.9rem;
  margin-bottom: 0.75rem;
  line-height: 1.4;
}

.quiz-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  font-size: 0.85rem;
}

.quiz-meta span {
  display: inline-flex;
  align-items: center;
  padding: 0.2rem 0.6rem;
  border-radius: 20px;
  font-weight: 500;
}

.quiz-meta .category {
  background-color: #e3f2fd;
  color: #1565c0;
}

.quiz-meta .difficulty {
  text-transform: capitalize;
}

.quiz-meta .difficulty.easy {
  background-color: #e8f5e9;
  color: #2e7d32;
}

.quiz-meta .difficulty.medium {
  background-color: #fff3e0;
  color: #ef6c00;
}

.quiz-meta .difficulty.hard {
  background-color: #ffebee;
  color: #c62828;
}

.quiz-meta .questions {
  background-color: #f3e5f5;
  color: #7b1fa2;
}

/* Attempts Table */
.attempts-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.95rem;
  color: #333;
  table-layout: fixed;
}

.attempts-table th,
.attempts-table td {
  padding: 0.75rem 1rem;
  text-align: left;
  border-bottom: 1px solid #e9ecef;
}

.attempts-table th {
  font-weight: 600;
  color: #495057;
  background-color: #f8f9fa;
  position: sticky;
  top: 0;
  z-index: 10;
  box-shadow: 0 1px 0 #e9ecef;
}

.attempts-table tr:last-child td {
  border-bottom: none;
}

.attempts-table tr:hover td {
  background-color: #f8f9fa;
}

.status {
  display: inline-flex;
  align-items: center;
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 500;
}

.status.completed {
  background-color: #e8f5e9;
  color: #2e7d32;
}

.status.in-progress {
  background-color: #e3f2fd;
  color: #1565c0;
}

/* Empty States */
.empty-state {
  text-align: center;
  padding: 2rem 1rem;
  color: #6c757d;
}

.empty-state p {
  margin-bottom: 1.5rem;
  font-size: 1.1rem;
}

/* Error Messages */
.error-message {
  background-color: #ffebee;
  color: #c62828;
  padding: 1rem;
  border-radius: 8px;
  margin-bottom: 1.5rem;
  font-weight: 500;
  border-left: 4px solid #c62828;
}

/* Responsive Adjustments */
@media (max-width: 768px) {
  .dashboard {
    padding: 1.5rem 1rem;
  }
  
  .welcome-section {
    padding: 1.5rem;
  }
  
  .welcome-section h1 {
    font-size: 1.75rem;
  }
  
  .action-buttons {
    flex-direction: column;
    gap: 0.75rem;
  }
  
  .action-buttons .btn {
    width: 100%;
  }
  
  .dashboard-section {
    padding: 1.2rem;
  }
  
  .quiz-card {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .quiz-card .btn {
    margin-top: 1rem;
    width: 100%;
  }
  
  .attempts-table {
    display: block;
    overflow-x: auto;
  }
  
  .attempts-table th, 
  .attempts-table td {
    padding: 0.5rem 0.75rem;
  }
}

/* Animations */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

.dashboard-section {
  animation: fadeIn 0.5s ease-out forwards;
}

.dashboard-section:nth-child(2) {
  animation-delay: 0.2s;
}

/* Scrollbar styling */
.quiz-list::-webkit-scrollbar,
.attempt-list::-webkit-scrollbar {
  width: 6px;
}

.quiz-list::-webkit-scrollbar-track,
.attempt-list::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}

.quiz-list::-webkit-scrollbar-thumb,
.attempt-list::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 10px;
}

.quiz-list::-webkit-scrollbar-thumb:hover,
.attempt-list::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}

/* Custom Height for scrollable sections */
@media (min-width: 992px) {
  .quiz-list,
  .attempt-list {
    max-height: 500px;
    overflow-y: auto;
    padding-right: 5px;
  }
}</style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp" />

    <div class="container">
        <div class="dashboard">
            <div class="welcome-section">
                <h1>Welcome, ${user.username}!</h1>
                <p>Ready to test your knowledge? Browse available quizzes or check your progress below.</p>
                
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/quizzes" class="btn primary">Browse Quizzes</a>
                    <a href="${pageContext.request.contextPath}/profile" class="btn secondary">My Profile</a>
                </div>
            </div>
            
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
            
            <div class="dashboard-sections">
                <div class="dashboard-section">
                    <h2>Recent Quizzes</h2>
                    <div class="quiz-list">
                        <c:choose>
                            <c:when test="${not empty recentQuizzes}">
                                <c:forEach items="${recentQuizzes}" var="quiz">
                                    <div class="quiz-card">
                                        <div class="quiz-info">
                                            <h3>${quiz.title}</h3>
                                            <p>${quiz.description}</p>
                                            <div class="quiz-meta">
                                                <span class="category">${quiz.category}</span>
                                                <span class="difficulty ${quiz.difficulty.toLowerCase()}">${quiz.difficulty}</span>
                                                <span class="questions">${quiz.questionCount} Questions</span>
                                            </div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/quiz/start/${quiz.id}" class="btn primary">Start Quiz</a>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <p>No quizzes available right now.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div class="dashboard-section">
                    <h2>My Quiz History</h2>
                    <div class="attempt-list">
                        <c:choose>
                            <c:when test="${not empty userAttempts}">
                                <table class="attempts-table">
                                    <thead>
                                        <tr>
                                            <th>Quiz</th>
                                            <th>Date</th>
                                            <th>Score</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${userAttempts}" var="attempt">
                                            <tr>
                                                <td>${attempt.quizTitle}</td>
                                                <td><fmt:formatDate value="${attempt.attemptDate}" pattern="MMM dd, yyyy HH:mm" /></td>
                                                <td>${attempt.score}/${attempt.totalQuestions}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${attempt.completed}">
                                                            <span class="status completed">Completed</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status in-progress">In Progress</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${attempt.completed}">
                                                            <a href="${pageContext.request.contextPath}/quiz/finish/${attempt.id}" class="btn small">View Results</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/quiz/resume/${attempt.id}" class="btn small primary">Resume</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <p>You haven't taken any quizzes yet.</p>
                                    <a href="${pageContext.request.contextPath}/quizzes" class="btn primary">Find Quizzes</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp" />
</body>
</html>