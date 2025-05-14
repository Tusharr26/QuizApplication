package com.quizapp.servlet.quiz;

import com.quizapp.dao.QuizAttemptDAO;
import com.quizapp.dao.QuestionDAO;
import com.quizapp.dao.QuizDAO;
import com.quizapp.model.Quiz;
import com.quizapp.model.QuizAttempt;
import com.quizapp.model.User;
import com.quizapp.model.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/quiz/resume/*")
public class ResumeQuizServlet extends HttpServlet {

    private QuizDAO quizDAO;
    private QuizAttemptDAO quizAttemptDAO;
    private QuestionDAO questionDAO;

    @Override
    public void init() throws ServletException {
        quizDAO = new QuizDAO();
        quizAttemptDAO = new QuizAttemptDAO();
        questionDAO = new QuestionDAO();  // Initialize QuestionDAO to fetch questions
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Extract quizId from the URL
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.split("/").length < 2) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quiz ID");
            return;
        }

        Long quizId = Long.parseLong(pathInfo.split("/")[1]);

        // Check session and user login status
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Fetch the quiz by ID
            Quiz quiz = quizDAO.getQuizById(quizId);
            if (quiz == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Quiz not found");
                return;
            }

            // Fetch unfinished quiz attempt for the current user
            QuizAttempt unfinishedAttempt = quizAttemptDAO.findUnfinishedAttempt(currentUser.getId(), quizId);
            if (unfinishedAttempt != null) {
                // Resume the unfinished attempt
                session.setAttribute("currentAttempt", unfinishedAttempt);
                session.setAttribute("currentQuiz", quiz);
                
                // Fetch all questions for the quiz and set them in the session
                List<Question> questions = questionDAO.getQuestionsByQuizId(quizId);
                
                // Add questions and options to the session
                for (Question question : questions) {
                    question.setOptions(questionDAO.getOptionsByQuestionId(question.getId())); // Load options for each question
                }
                
                session.setAttribute("questions", questions);
                
                // Set the current question index in the session
                session.setAttribute("currentQuestionIndex", unfinishedAttempt.getCurrentQuestion());

                // Forward to the quiz page where questions are displayed
                request.getRequestDispatcher("/WEB-INF/jsp/take-quiz.jsp").forward(request, response);
            } else {
                // If no unfinished attempt, redirect to the start
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "No unfinished quiz attempt found");
            }
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }
}
