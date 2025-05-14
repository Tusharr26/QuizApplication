package com.quizapp.servlet.quiz;

import com.quizapp.dao.QuizAttemptDAO;
import com.quizapp.dao.QuizDAO;
import com.quizapp.model.Quiz;
import com.quizapp.model.QuizAttempt;
import com.quizapp.model.Answer;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/quiz/results")
public class QuizResultsServlet extends HttpServlet {
    
    private QuizAttemptDAO quizAttemptDAO;
    private QuizDAO quizDAO;
    
    @Override
    public void init() throws ServletException {
        quizAttemptDAO = new QuizAttemptDAO();
        quizDAO = new QuizDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        Long attemptId = Long.parseLong(request.getParameter("attemptId"));

        try {
            // Fetch the quiz attempt data
            QuizAttempt attempt = quizAttemptDAO.getQuizAttemptById(attemptId);
            Quiz quiz = quizDAO.getQuizById(attempt.getQuizId());
            List<Answer> answers = attempt.getAnswers();

            // Calculate total score and percentage
            int totalQuestions = quiz.getTotalQuestions();
            int correctAnswers = (int) answers.stream().filter(Answer::isCorrect).count();
            int totalScore = correctAnswers; // You can modify this to include other scoring logic
            int percentage = (int) ((double) correctAnswers / totalQuestions * 100);

            // Set attributes to pass data to the JSP
            request.setAttribute("attempt", attempt);
            request.setAttribute("quiz", quiz);
            request.setAttribute("answers", answers);
            request.setAttribute("percentage", percentage);
            request.setAttribute("totalQuestions", totalQuestions);

            // Forward to results page
            request.getRequestDispatcher("/WEB-INF/jsp/results.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch quiz results.");
        }
    }
}
