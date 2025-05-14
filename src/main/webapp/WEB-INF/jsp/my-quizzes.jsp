<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
>

<html>
<head>
<jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
    <title>My Completed Quizzes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* Reset and base styles */
       

        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            background-color: #f4f4f4;
            color: #333;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header styles */
        h2 {
            color: #2c3e50;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 24px;
        }

        /* Empty state message */
        .empty-state {
            background-color: #f8f9fa;
            border-left: 4px solid #6c757d;
            padding: 15px;
            margin: 20px 0;
            color: #6c757d;
            font-style: italic;
            text-align: center;
        }

        /* Quiz list styles */
        .quiz-list {
            list-style-type: none;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .quiz-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.3s ease;
        }

        .quiz-item:last-child {
            border-bottom: none;
        }

        .quiz-item:hover {
            background-color: #f1f1f1;
        }

        /* Quiz title and description */
        .quiz-details {
            flex-grow: 1;
            margin-right: 15px;
        }

        .quiz-title {
            color: #2980b9;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .quiz-description {
            color: #7f8c8d;
            font-size: 14px;
        }

        /* Score styles */
        .quiz-score {
            display: inline-block;
            padding: 8px 12px;
            border-radius: 20px;
            font-weight: bold;
            text-align: center;
            min-width: 60px;
        }

        .score-excellent {
            background-color: #2ecc71;
            color: white;
        }

        .score-good {
            background-color: #3498db;
            color: white;
        }

        .score-average {
            background-color: #f39c12;
            color: white;
        }

        .score-poor {
            background-color: #e74c3c;
            color: white;
        }

        /* Responsive design */
        @media (max-width: 600px) {
            .quiz-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .quiz-details {
                margin-right: 0;
                margin-bottom: 10px;
            }

            .quiz-score {
                align-self: flex-start;
            }
        }
    </style>
</head>

<body>

    <h2>My Completed Quizzes</h2>

    <c:if test="${empty completedQuizzes}">
        <p class="empty-state">You haven't completed any quizzes yet.</p>
    </c:if>

    <ul class="quiz-list">
        <c:forEach var="quiz" items="${completedQuizzes}">
            <li class="quiz-item">
                <div class="quiz-details">
                    <div class="quiz-title">${quiz.title}</div>
                    <div class="quiz-description">${quiz.description}</div>
                </div>
                <div class="quiz-score score-${quiz.scoreColor}">${quiz.score}%</div>
            </li>
        </c:forEach>
    </ul>
     <jsp:include page="/WEB-INF/jsp/include/footer.jsp" />
</body>
</html>