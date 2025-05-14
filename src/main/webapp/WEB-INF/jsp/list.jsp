<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Quizzes - Quiz App</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/list.css">
    <style>
    /* Quiz App - Professional Styling */
:root {
  --primary-color: #4a6cf7;
  --primary-dark: #3b5bd9;
  --primary-light: #eef2ff;
  --secondary-color: #6c757d;
  --success-color: #28a745;
  --danger-color: #dc3545;
  --warning-color: #ffc107;
  --info-color: #17a2b8;
  --dark-color: #343a40;
  --light-color: #f8f9fa;
  --gray-100: #f8f9fa;
  --gray-200: #e9ecef;
  --gray-300: #dee2e6;
  --gray-400: #ced4da;
  --gray-500: #adb5bd;
  --gray-600: #6c757d;
  --gray-700: #495057;
  --gray-800: #343a40;
  --gray-900: #212529;
  --font-primary: 'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  --font-heading: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  --transition: all 0.3s ease;
  --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  --border-radius: 8px;
}

/* Import Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700&family=Poppins:wght@400;500;600;700&display=swap');

/* Global Styles */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: var(--font-primary);
  font-size: 16px;
  line-height: 1.6;
  color: var(--gray-800);
  background-color: #f5f7fa;
}

.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

h1, h2, h3, h4, h5, h6 {
  font-family: var(--font-heading);
  margin-bottom: 0.5rem;
  font-weight: 600;
  line-height: 1.3;
  color: var(--gray-900);
}

a {
  color: var(--primary-color);
  text-decoration: none;
  transition: var(--transition);
}

a:hover {
  color: var(--primary-dark);
}

/* Button Styles */
.btn {
  display: inline-block;
  font-weight: 600;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  user-select: none;
  border: 1px solid transparent;
  padding: 0.5rem 1rem;
  font-size: 1rem;
  line-height: 1.5;
  border-radius: var(--border-radius);
  transition: var(--transition);
  cursor: pointer;
}

.btn:focus, .btn:hover {
  text-decoration: none;
}

.btn.primary {
  color: #fff;
  background-color: var(--primary-color);
  border-color: var(--primary-color);
}

.btn.primary:hover, .btn.primary:focus {
  background-color: var(--primary-dark);
  border-color: var(--primary-dark);
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}

.btn.secondary {
  color: #fff;
  background-color: var(--secondary-color);
  border-color: var(--secondary-color);
}

.btn.secondary:hover, .btn.secondary:focus {
  background-color: #5a6268;
  border-color: #545b62;
}

/* Navigation Styles */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 0;
  background-color: #fff;
  box-shadow: var(--shadow-sm);
  position: sticky;
  top: 0;
  z-index: 1000;
}

.navbar-brand {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--primary-color);
}

.nav-links {
  display: flex;
  list-style: none;
}

.nav-links li {
  margin-left: 1.5rem;
}

.nav-links a {
  color: var(--gray-700);
  font-weight: 600;
}

.nav-links a:hover {
  color: var(--primary-color);
}

.nav-links a.active {
  color: var(--primary-color);
  position: relative;
}

.nav-links a.active::after {
  content: '';
  position: absolute;
  bottom: -4px;
  left: 0;
  width: 100%;
  height: 2px;
  background-color: var(--primary-color);
}

/* Quiz Pages Styles */
.quizzes-page,
.quiz-container {
  padding: 2rem 0;
}

.page-header {
  text-align: center;
  margin-bottom: 2rem;
}

.page-header h1 {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
  color: var(--primary-color);
}

.page-header p {
  font-size: 1.1rem;
  color: var(--gray-600);
  max-width: 600px;
  margin: 0 auto;
}

/* Filters Styles */
.filters-container {
  background-color: #fff;
  padding: 1.5rem;
  border-radius: var(--border-radius);
  box-shadow: var(--shadow-md);
  margin-bottom: 1.5rem;
}

.filters {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  align-items: center;
}

.filter-group {
  flex: 1;
  min-width: 200px;
}

.filter-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: var(--gray-700);
}

.filter-group select,
.filter-group input[type="text"] {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid var(--gray-300);
  border-radius: var(--border-radius);
  font-family: var(--font-primary);
  font-size: 1rem;
  transition: var(--transition);
}

.filter-group select:focus,
.filter-group input[type="text"]:focus {
  border-color: var(--primary-color);
  outline: none;
  box-shadow: 0 0 0 3px rgba(74, 108, 247, 0.25);
}

.search-group {
  display: flex;
  gap: 0.5rem;
}

.search-group input {
  flex: 1;
}

.search-group button {
  white-space: nowrap;
}

/* Active Filters */
.active-filters {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  margin-bottom: 1.5rem;
  align-items: center;
}

.active-filters > span:first-child {
  font-weight: 600;
  color: var(--gray-700);
}

.filter-tag {
  display: inline-flex;
  align-items: center;
  background-color: var(--primary-light);
  color: var(--primary-color);
  padding: 0.35rem 0.75rem;
  border-radius: 50px;
  font-size: 0.875rem;
  font-weight: 600;
}

.remove-filter {
  margin-left: 0.5rem;
  font-size: 1.25rem;
  line-height: 1;
  color: var(--primary-color);
}

.remove-filter:hover {
  color: var(--danger-color);
}

.clear-all {
  margin-left: auto;
  font-size: 0.875rem;
  font-weight: 600;
  color: var(--danger-color);
}

.total-count {
  margin-bottom: 1rem;
  font-weight: 500;
  color: var(--gray-600);
}

/* Quiz Cards */
.quizzes-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.quiz-card {
  background-color: #fff;
  border-radius: var(--border-radius);
  box-shadow: var(--shadow-md);
  overflow: hidden;
  transition: var(--transition);
  display: flex;
  flex-direction: column;
  opacity: 0;  /* Start invisible for fade-in effect */
  animation: fadeIn 0.5s ease forwards;
}

.quiz-card:hover {
  transform: translateY(-5px);
  box-shadow: var(--shadow-lg);
}

.quiz-info {
  padding: 1.5rem;
  flex: 1;
}

.quiz-info h3 {
  font-size: 1.25rem;
  margin-bottom: 0.75rem;
  color: var(--gray-900);
}

.quiz-info p {
  color: var(--gray-700);
  margin-bottom: 1rem;
  font-size: 0.95rem;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.quiz-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  margin-top: 1rem;
}

.quiz-meta span {
  font-size: 0.8rem;
  font-weight: 600;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  white-space: nowrap;
}

.category {
  background-color: #e6f2ff;
  color: #0066cc;
}

.difficulty {
  background-color: var(--gray-200);
  color: var(--gray-700);
}

.difficulty.easy {
  background-color: #e6ffec;
  color: #28a745;
}

.difficulty.medium {
  background-color: #fff8e6;
  color: #ffc107;
}

.difficulty.hard {
  background-color: #ffe6e6;
  color: #dc3545;
}

.questions {
  background-color: #f0f0f0;
  color: var(--gray-700);
}

.author {
  background-color: #f0f0ff;
  color: #6610f2;
}

.date {
  background-color: #f5f5f5;
  color: var(--gray-600);
}

.quiz-actions {
  padding: 1rem 1.5rem;
  background-color: #f9fafc;
  border-top: 1px solid var(--gray-200);
  display: flex;
  justify-content: flex-end;
}

/* Empty State */
.empty-state {
  grid-column: 1 / -1;
  text-align: center;
  padding: 4rem 2rem;
  background-color: #fff;
  border-radius: var(--border-radius);
  box-shadow: var(--shadow-md);
}

.empty-icon {
  margin-bottom: 1.5rem;
}

.empty-icon img {
  width: 120px;
  height: auto;
}

.empty-state h3 {
  font-size: 1.5rem;
  margin-bottom: 0.75rem;
  color: var(--gray-700);
}

.empty-state p {
  color: var(--gray-600);
  margin-bottom: 1.5rem;
  max-width: 400px;
  margin-left: auto;
  margin-right: auto;
}

/* Pagination */
.pagination {
  display: flex;
  justify-content: center;
  gap: 0.5rem;
  margin-top: 2rem;
}

.page-btn {
  min-width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  color: var(--gray-700);
  background-color: #fff;
  border: 1px solid var(--gray-300);
}

.page-btn:hover {
  background-color: var(--gray-100);
  color: var(--primary-color);
}

.page-btn.active {
  background-color: var(--primary-color);
  color: #fff;
  border-color: var(--primary-color);
}

.page-btn.prev, .page-btn.next {
  padding: 0 1rem;
}

/* Responsive Design */
@media (max-width: 992px) {
  .quizzes-list {
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  }
}

@media (max-width: 768px) {
  .filters {
    flex-direction: column;
    gap: 1rem;
  }
  
  .filter-group {
    width: 100%;
  }
  
  .search-group {
    width: 100%;
  }
  
  .quizzes-list {
    grid-template-columns: 1fr;
  }
  
  .active-filters {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .clear-all {
    margin-left: 0;
    margin-top: 0.5rem;
  }
}

/* Animation Keyframes */
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

/* Quiz Taking Page Styles */
.quiz-container {
  max-width: 800px;
  margin: 0 auto;
}

.quiz-container h1 {
  color: var(--primary-color);
  font-size: 2rem;
  text-align: center;
  margin-bottom: 0.75rem;
}

.quiz-container > p {
  text-align: center;
  color: var(--gray-600);
  margin-bottom: 2rem;
  font-size: 1.1rem;
}

.quiz-progress {
  margin: 2rem 0;
}

.quiz-progress p {
  text-align: center;
  margin-top: 0.5rem;
  font-weight: 600;
  color: var(--gray-700);
  font-size: 0.9rem;
}

.progress-bar {
  height: 8px;
  background-color: var(--gray-200);
  border-radius: 4px;
  overflow: hidden;
}

.progress {
  height: 100%;
  background-color: var(--primary-color);
  border-radius: 4px;
  transition: width 0.5s ease;
}

.question-card {
  background-color: #fff;
  border-radius: var(--border-radius);
  box-shadow: var(--shadow-md);
  padding: 2rem;
  margin-bottom: 2rem;
  animation: fadeIn 0.5s ease forwards;
}

.question-card h2 {
  margin-bottom: 1.5rem;
  font-size: 1.4rem;
  color: var(--gray-800);
  line-height: 1.5;
}

.options-container {
  margin-bottom: 1.5rem;
}

.option {
  margin-bottom: 1rem;
  position: relative;
  border: 2px solid var(--gray-300);
  border-radius: var(--border-radius);
  padding: 1rem;
  transition: all 0.2s ease;
  cursor: pointer;
}

.option:last-child {
  margin-bottom: 0;
}

.option:hover {
  border-color: var(--primary-color);
  background-color: var(--primary-light);
}

.option input[type="radio"] {
  position: absolute;
  opacity: 0;
  width: 0;
  height: 0;
}

.option label {
  padding-left: 2rem;
  cursor: pointer;
  display: block;
  font-size: 1.1rem;
  position: relative;
}

.option label:before {
  content: '';
  position: absolute;
  left: 0;
  top: 0.2rem;
  width: 1.2rem;
  height: 1.2rem;
  border: 2px solid var(--gray-500);
  border-radius: 50%;
  background-color: #fff;
}

.option input[type="radio"]:checked + label:before {
  border-color: var(--primary-color);
}

.option input[type="radio"]:checked + label:after {
  content: '';
  position: absolute;
  left: 0.35rem;
  top: 0.55rem;
  width: 0.6rem;
  height: 0.6rem;
  background-color: var(--primary-color);
  border-radius: 50%;
}

.option input[type="radio"]:checked + label {
  color: var(--primary-color);
  font-weight: 600;
}

.option input[type="radio"]:checked ~ label {
  border-color: var(--primary-color);
}

.option input[type="radio"]:focus + label:before {
  box-shadow: 0 0 0 3px rgba(74, 108, 247, 0.25);
}

.button-container {
  display: flex;
  justify-content: center;
  margin-top: 2rem;
}

.button-container .btn {
  min-width: 180px;
  padding: 0.75rem 1.5rem;
  font-size: 1.1rem;
}

/* Results Page Styles */
.quiz-results {
  text-align: center;
}

.score-display {
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--primary-color);
  margin: 1rem 0;
}

.result-message {
  font-size: 1.25rem;
  margin-bottom: 2rem;
  color: var(--gray-700);
}

.results-breakdown {
  max-width: 600px;
  margin: 0 auto 2rem;
  text-align: left;
}

.result-item {
  margin-bottom: 1rem;
  padding: 1rem;
  border-radius: var(--border-radius);
  background-color: #fff;
  box-shadow: var(--shadow-sm);
}

.result-item.correct {
  border-left: 4px solid var(--success-color);
}

.result-item.incorrect {
  border-left: 4px solid var(--danger-color);
}

.result-answer {
  font-weight: 600;
}

.correct-answer {
  color: var(--success-color);
}

.incorrect-answer {
  color: var(--danger-color);
}

.result-actions {
  margin-top: 2rem;
  display: flex;
  justify-content: center;
  gap: 1rem;
}

/* Helper Classes */
.text-center {
  text-align: center;
}

.mb-1 {
  margin-bottom: 0.5rem;
}

.mb-2 {
  margin-bottom: 1rem;
}

.mb-3 {
  margin-bottom: 1.5rem;
}

.mb-4 {
  margin-bottom: 2rem;
}
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
    

    <div class="container">
        <div class="quizzes-page">
            <div class="page-header">
                <h1>Browse Quizzes</h1>
                <p>Find and take quizzes on various topics</p>
            </div>
            
            <div class="filters-container">
                <form id="filter-form" action="${pageContext.request.contextPath}/quizzes" method="get">
                    <div class="filters">
                        <div class="filter-group">
                            <label for="category">Category:</label>
                            <select name="category" id="category" onchange="this.form.submit()">
                                <option value="">All Categories</option>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category}" ${category eq selectedCategory ? 'selected' : ''}>${category}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label for="difficulty">Difficulty:</label>
                            <select name="difficulty" id="difficulty" onchange="this.form.submit()">
                                <option value="">All Difficulties</option>
                                <option value="Easy" ${selectedDifficulty eq 'Easy' ? 'selected' : ''}>Easy</option>
                                <option value="Medium" ${selectedDifficulty eq 'Medium' ? 'selected' : ''}>Medium</option>
                                <option value="Hard" ${selectedDifficulty eq 'Hard' ? 'selected' : ''}>Hard</option>
                            </select>
                        </div>
                        
                        <div class="filter-group search-group">
                            <input type="text" name="search" id="search" placeholder="Search quizzes..." value="${searchQuery}">
                            <button type="submit" class="btn primary">Search</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="total-count">
                <c:if test="${not empty quizzes}">
                    <p>Found ${quizzes.size()} quizzes</p>
                </c:if>
                <c:if test="${empty quizzes}">
                    <p>No quizzes found</p>
                </c:if>
            </div>
            
            <c:if test="${not empty selectedCategory || not empty selectedDifficulty || not empty searchQuery}">
                <div class="active-filters">
                    <span>Active filters:</span>
                    <c:if test="${not empty selectedCategory}">
                        <span class="filter-tag">
                            Category: ${selectedCategory}
                            <a href="${pageContext.request.contextPath}/quizzes?difficulty=${selectedDifficulty}&search=${searchQuery}" class="remove-filter">×</a>
                        </span>
                    </c:if>
                    <c:if test="${not empty selectedDifficulty}">
                        <span class="filter-tag">
                            Difficulty: ${selectedDifficulty}
                            <a href="${pageContext.request.contextPath}/quizzes?category=${selectedCategory}&search=${searchQuery}" class="remove-filter">×</a>
                        </span>
                    </c:if>
                    <c:if test="${not empty searchQuery}">
                        <span class="filter-tag">
                            Search: "${searchQuery}"
                            <a href="${pageContext.request.contextPath}/quizzes?category=${selectedCategory}&difficulty=${selectedDifficulty}" class="remove-filter">×</a>
                        </span>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/quizzes" class="clear-all">Clear All</a>
                </div>
            </c:if>
            
            <div class="quizzes-list">
                <c:choose>
                    <c:when test="${not empty quizzes}">
                        <c:forEach items="${quizzes}" var="quiz">
                            <div class="quiz-card">
                                <div class="quiz-info">
                                    <h3>${quiz.title}</h3>
                                    <p>${quiz.description}</p>
                                    <div class="quiz-meta">
                                        <span class="category">${quiz.category}</span>
                                        <span class="difficulty ${quiz.difficulty.toLowerCase()}">${quiz.difficulty}</span>
                                        <span class="questions">${quiz.questionCount} Questions</span>
                                        <c:if test="${not empty quiz.creatorId}">
    									<span class="author">By: ${quiz.creatorId}</span>
										</c:if>

                                        <span class="date">
                                            <fmt:formatDate value="${quiz.createdDate}" pattern="MMM dd, yyyy" />
                                        </span>
                                    </div>
                                </div>
                                <div class="quiz-actions">
                                    <a href="${pageContext.request.contextPath}/quiz/start/${quiz.id}" class="btn primary">Start Quiz</a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-icon">
                                <img src="${pageContext.request.contextPath}/images/empty-state.svg" alt="No quizzes found">
                            </div>
                            <h3>No quizzes found</h3>
                            <p>Try adjusting your filters or check back later for new quizzes.</p>
                            <a href="${pageContext.request.contextPath}/quizzes" class="btn primary">Clear Filters</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/quizzes?page=${currentPage - 1}&category=${selectedCategory}&difficulty=${selectedDifficulty}&search=${searchQuery}" class="btn page-btn prev">Previous</a>
                    </c:if>
                    
                    <c:forEach begin="1" end="${totalPages}" var="pageNum">
                        <a href="${pageContext.request.contextPath}/quizzes?page=${pageNum}&category=${selectedCategory}&difficulty=${selectedDifficulty}&search=${searchQuery}" class="btn page-btn ${pageNum == currentPage ? 'active' : ''}">${pageNum}</a>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/quizzes?page=${currentPage + 1}&category=${selectedCategory}&difficulty=${selectedDifficulty}&search=${searchQuery}" class="btn page-btn next">Next</a>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Fade in quiz cards
            $('.quiz-card').each(function(index) {
                $(this).delay(100 * index).animate({opacity: 1}, 500);
            });
        });
    </script>
    <jsp:include page="/WEB-INF/jsp/include/footer.jsp" />
</body>
</html>
