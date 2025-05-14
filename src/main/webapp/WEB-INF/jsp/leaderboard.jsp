<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leaderboard - Quiz App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/leaderboard.css">
    <style>
    /* --------------------------------------------
   Leaderboard Professional Styling
   -------------------------------------------- */

/* Base Elements & Reset */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  background-color: #f8f9fa;
}

/* Container Layout */
.container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 2rem 1.5rem;
}

/* Typography */
h1 {
  font-size: 2.4rem;
  font-weight: 700;
  color: #2c3e50;
  margin-bottom: 2rem;
  text-align: center;
  position: relative;
}

h1::after {
  content: "";
  display: block;
  width: 80px;
  height: 4px;
  background: linear-gradient(90deg, #4a6cf7, #6c8fff);
  margin: 0.75rem auto 0;
  border-radius: 2px;
}

/* Leaderboard Table */
.leaderboard-table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  background-color: #fff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
  margin-bottom: 3rem;
}

/* Table Header */
.leaderboard-table thead {
  background: linear-gradient(90deg, #4a6cf7, #6c8fff);
  color: #fff;
}

.leaderboard-table th {
  padding: 1.25rem 1.5rem;
  font-weight: 600;
  text-align: left;
  letter-spacing: 0.03em;
  font-size: 1.05rem;
}

.leaderboard-table th:first-child {
  width: 15%;
  text-align: center;
}

.leaderboard-table th:last-child {
  text-align: right;
}

/* Table Body */
.leaderboard-table tbody tr {
  transition: all 0.2s ease;
  border-bottom: 1px solid #e9ecef;
}

.leaderboard-table tbody tr:last-child {
  border-bottom: none;
}

.leaderboard-table tbody tr:hover {
  background-color: #f8f9fa;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
}

.leaderboard-table td {
  padding: 1.25rem 1.5rem;
  font-size: 1rem;
}

.leaderboard-table td:first-child {
  font-weight: 700;
  color: #495057;
  text-align: center;
}

.leaderboard-table td:last-child {
  font-weight: 700;
  color: #4a6cf7;
  text-align: right;
}

/* Top 3 Ranks Highlighting */
.leaderboard-table tbody tr:nth-child(1) td:first-child {
  color: #ffa600;
}

.leaderboard-table tbody tr:nth-child(2) td:first-child {
  color: #7b8794;
}

.leaderboard-table tbody tr:nth-child(3) td:first-child {
  color: #cd7f32;
}

/* Top 3 Rank Medal Icons */
.leaderboard-table tbody tr:nth-child(1) td:first-child::before,
.leaderboard-table tbody tr:nth-child(2) td:first-child::before,
.leaderboard-table tbody tr:nth-child(3) td:first-child::before {
  display: inline-block;
  margin-right: 8px;
  font-size: 1.1rem;
}

.leaderboard-table tbody tr:nth-child(1) td:first-child::before {
  content: "🏆";
}

.leaderboard-table tbody tr:nth-child(2) td:first-child::before {
  content: "🥈";
}

.leaderboard-table tbody tr:nth-child(3) td:first-child::before {
  content: "🥉";
}

/* Empty State */
.leaderboard-table tbody:empty::after {
  content: "No entries yet";
  display: block;
  text-align: center;
  padding: 2rem;
  color: #6c757d;
  font-style: italic;
}

/* Responsive Design */
@media (max-width: 768px) {
  h1 {
    font-size: 1.8rem;
  }
  
  .leaderboard-table th,
  .leaderboard-table td {
    padding: 1rem;
  }
  
  .leaderboard-table th:first-child,
  .leaderboard-table td:first-child {
    padding-left: 0.75rem;
    padding-right: 0.5rem;
  }
  
  .leaderboard-table th:last-child,
  .leaderboard-table td:last-child {
    padding-right: 0.75rem;
  }
}

@media (max-width: 480px) {
  .leaderboard-table {
    font-size: 0.9rem;
  }
  
  .leaderboard-table th,
  .leaderboard-table td {
    padding: 0.75rem 0.5rem;
  }
  
  .leaderboard-table tbody tr:nth-child(1) td:first-child::before,
  .leaderboard-table tbody tr:nth-child(2) td:first-child::before,
  .leaderboard-table tbody tr:nth-child(3) td:first-child::before {
    margin-right: 4px;
    font-size: 1rem;
  }
}

/* Animations */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

.container {
  animation: fadeIn 0.4s ease-out;
}

/* Fix for JSTL loop issue */
/* Make sure to change ${loop.index + 1} to ${status.index + 1} in your JSP */
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/jsp/include/header.jsp"/>

<div class="container">
    <h1>Leaderboard</h1>
    <table class="leaderboard-table">
        <thead>
            <tr>
                <th>Rank</th>
                <th>Username</th>
                <th>Score</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="entry" items="${leaderboard}" varStatus="status">
    <tr>
        <td>${status.index + 1}</td>
        <td>${entry.username}</td>
        <td>${entry.score}</td>
    </tr>
</c:forEach>

        </tbody>
    </table>
</div>

<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>

</body>
</html>
