<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<html>
<head>
    <title>Quiz Results</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
    <style>
    /* Quiz Results Page Styles */
:root {
    --primary-color: #3498db;
    --secondary-color: #2ecc71;
    --danger-color: #e74c3c;
    --text-color: #333;
    --background-color: #f4f6f7;
    --card-background: #ffffff;
    --border-radius: 12px;
    --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

body {
    font-family: 'Inter', 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    background-color: var(--background-color);
    color: var(--text-color);
    line-height: 1.6;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.results-container {
    background-color: var(--card-background);
    border-radius: var(--border-radius);
    box-shadow: var(--box-shadow);
    padding: 30px;
}

.results-header {
    text-align: center;
    margin-bottom: 30px;
    border-bottom: 2px solid var(--background-color);
    padding-bottom: 20px;
}

.results-header h1 {
    color: var(--primary-color);
    margin-bottom: 10px;
    font-weight: 600;
}

.results-header h2 {
    color: var(--text-color);
    font-weight: 500;
}

.results-summary {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    gap: 30px;
}

.score-card {
    display: flex;
    align-items: center;
    flex: 1;
}

.score-circle {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 20px;
    transition: transform 0.3s ease;
}

.score-circle:hover {
    transform: scale(1.05);
}

.score-circle.good {
    background-color: rgba(46, 204, 113, 0.1);
    border: 10px solid var(--secondary-color);
}

.score-circle.average {
    background-color: rgba(241, 196, 15, 0.1);
    border: 10px solid #f1c40f;
}

.score-circle.poor {
    background-color: rgba(231, 76, 60, 0.1);
    border: 10px solid var(--danger-color);
}

.percentage {
    font-size: 3rem;
    font-weight: 700;
    color: var(--text-color);
}

.score-details {
    flex-grow: 1;
}

.score-details p {
    margin: 5px 0;
}

.score-comment {
    font-weight: 600;
    color: var(--primary-color);
}

.results-chart {
    flex: 1;
    height: 250px;
}

.results-breakdown {
    background-color: var(--background-color);
    border-radius: var(--border-radius);
    padding: 20px;
    margin-bottom: 30px;
}

.results-breakdown h3 {
    color: var(--primary-color);
    border-bottom: 2px solid var(--primary-color);
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.answer-item {
    display: flex;
    align-items: center;
    background-color: var(--card-background);
    border-radius: var(--border-radius);
    margin-bottom: 15px;
    padding: 15px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    opacity: 0;
    transition: all 0.3s ease;
}

.answer-item.correct {
    border-left: 5px solid var(--secondary-color);
}

.answer-item.incorrect {
    border-left: 5px solid var(--danger-color);
}

.question-number {
    width: 40px;
    height: 40px;
    background-color: var(--primary-color);
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 15px;
    font-weight: 600;
}

.answer-details {
    flex-grow: 1;
}

.answer-details .question-text {
    font-weight: 500;
    margin-bottom: 5px;
}

.answer-text {
    color: var(--text-color);
}

.answer-icon {
    display: flex;
    align-items: center;
}

.correct-icon {
    fill: var(--secondary-color);
}

.incorrect-icon {
    fill: var(--danger-color);
}

.results-actions {
    display: flex;
    justify-content: center;
    gap: 20px;
}

.btn {
    display: inline-block;
    padding: 12px 25px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn.primary {
    background-color: var(--primary-color);
    color: white;
}

.btn.secondary {
    background-color: var(--background-color);
    color: var(--text-color);
    border: 2px solid var(--primary-color);
}

.btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* Responsive Design */
@media (max-width: 768px) {
    .results-summary {
        flex-direction: column;
        text-align: center;
    }

    .score-card {
        flex-direction: column;
    }

    .score-circle {
        margin-right: 0;
        margin-bottom: 20px;
    }

    .results-actions {
        flex-direction: column;
    }

    .btn {
        width: 100%;
        text-align: center;
    }
}
    </style>
    </head>
<body>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp" />

    <div class="container">
        <div class="results-container">
            <div class="results-header">
                <h1>Quiz Results</h1>
                <h2>${quiz.title}</h2>
                <p>Completed on <fmt:formatDate value="${attempt.attemptDate}" pattern="MMM dd, yyyy HH:mm" /></p>
            </div>
            
            <div class="results-summary">
                <div class="score-card">
                    <div class="score-circle ${percentage >= 70 ? 'good' : percentage >= 50 ? 'average' : 'poor'}">
                        <div class="percentage">${percentage}%</div>
                    </div>
                    <div class="score-details">
                        <p>Your Score: <strong>${attempt.score}/${totalQuestions}</strong></p>
                        <c:choose>
                            <c:when test="${percentage >= 80}">
                                <p class="score-comment">Excellent work!</p>
                            </c:when>
                            <c:when test="${percentage >= 70}">
                                <p class="score-comment">Great job!</p>
                            </c:when>
                            <c:when test="${percentage >= 50}">
                                <p class="score-comment">Good effort!</p>
                            </c:when>
                            <c:otherwise>
                                <p class="score-comment">Keep practicing!</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div class="results-chart">
                    <canvas id="resultChart"></canvas>
                </div>
            </div>
            
            <div class="results-breakdown">
                <h3>Question Breakdown</h3>
                <div class="answers-list">
                    <c:forEach items="${answers}" var="answer" varStatus="status">
                        <div class="answer-item ${answer.correct ? 'correct' : 'incorrect'}">
                            <div class="question-number">${status.index + 1}</div>
                            <div class="answer-details">
                                <p class="question-text">${answer.questionText}</p>
                                <p class="answer-text">
                                    <strong>Your answer:</strong> ${answer.userAnswer}
                                    <c:if test="${!answer.correct}">
                                        <br><strong>Correct answer:</strong> ${answer.correctAnswer}
                                    </c:if>
                                </p>
                            </div>
                            <div class="answer-icon">
                                <c:choose>
                                    <c:when test="${answer.correct}">
                                        <svg class="correct-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                                            <path fill="none" d="M0 0h24v24H0z"/>
                                            <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>
                                        </svg>
                                    </c:when>
                                    <c:otherwise>
                                        <svg class="incorrect-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                                            <path fill="none" d="M0 0h24v24H0z"/>
                                            <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/>
                                        </svg>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            
            <div class="results-actions">
                <a href="${pageContext.request.contextPath}/quizzes" class="btn secondary">Browse More Quizzes</a>
                <a href="${pageContext.request.contextPath}/quiz/start/${quiz.id}" class="btn primary">Try Again</a>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/jsp/include/footer.jsp" />
    
    <script>
        $(document).ready(function() {
            // Animate score circle
            let percentage = ${percentage};
            $('.percentage').each(function () {
                $(this).prop('Counter', 0).animate({
                    Counter: percentage
                }, {
                    duration: 1500,
                    easing: 'swing',
                    step: function (now) {
                        $(this).text(Math.ceil(now) + '%');
                    }
                });
            });
            
            // Initialize results chart
            const ctx = document.getElementById('resultChart').getContext('2d');
            const correct = ${attempt.score};
            const incorrect = ${totalQuestions - attempt.score};
            
            const resultChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Correct', 'Incorrect'],
                    datasets: [{
                        data: [correct, incorrect],
                        backgroundColor: [
                            '#4CAF50',
                            '#F44336'
                        ],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: '70%',
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });
            
            // Fade in answer items
            $('.answer-item').each(function(index) {
                $(this).delay(100 * index).animate({opacity: 1}, 500);
            });
        });
    </script>
</body>
</html>