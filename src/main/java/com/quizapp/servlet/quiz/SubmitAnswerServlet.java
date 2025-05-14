package com.quizapp.servlet.quiz;

import com.quizapp.dao.QuestionDAO;
import com.quizapp.dao.QuizAttemptDAO;
import com.quizapp.dao.LeaderboardDAO;  // Add DAO for Leaderboard
import com.quizapp.model.Option;
import com.quizapp.model.Question;
import com.quizapp.model.Quiz;
import com.quizapp.model.QuizAttempt;
import com.quizapp.model.User;
import com.quizapp.model.LeaderboardEntry;  // Add LeaderboardEntry Model

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/quiz/submit")
public class SubmitAnswerServlet extends HttpServlet {
    private QuestionDAO questionDAO;
    private QuizAttemptDAO quizAttemptDAO;
    private LeaderboardDAO leaderboardDAO;  // Add LeaderboardDAO instance

    @Override
    public void init() throws ServletException {
        questionDAO = new QuestionDAO();
        quizAttemptDAO = new QuizAttemptDAO();
        leaderboardDAO = new LeaderboardDAO();  // Initialize LeaderboardDAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        QuizAttempt currentAttempt = (QuizAttempt) session.getAttribute("currentAttempt");
        Quiz currentQuiz = (Quiz) session.getAttribute("currentQuiz");
        Integer currentQuestionIndex = (Integer) session.getAttribute("currentQuestionIndex");

        if (currentAttempt == null || currentQuiz == null || currentQuestionIndex == null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        try {
            List<Question> questions = questionDAO.getQuestionsByQuizId(currentQuiz.getId());

            // Defensive check to prevent IndexOutOfBoundsException
            if (questions == null || questions.isEmpty() || currentQuestionIndex < 0 || currentQuestionIndex >= questions.size()) {
                request.setAttribute("error", "Invalid question index or empty quiz.");
                request.getRequestDispatcher("/quiz/take").forward(request, response);
                return;
            }

            Question currentQuestion = questions.get(currentQuestionIndex);

            // Get selected option ID from request
            String selectedOptionIdStr = request.getParameter("selectedOption");
            if (selectedOptionIdStr == null || selectedOptionIdStr.isEmpty()) {
                request.setAttribute("error", "Please select an option before submitting.");
                request.getRequestDispatcher("/quiz/take").forward(request, response);
                return;
            }

            long selectedOptionId = Long.parseLong(selectedOptionIdStr);

            // Check if selected option is correct
            boolean isCorrect = false;
            for (Option option : currentQuestion.getOptions()) {
                if (option.isCorrect() && option.getId() == selectedOptionId) {
                    isCorrect = true;
                    break;
                }
            }

            if (isCorrect) {
                currentAttempt.setScore(currentAttempt.getScore() + 1);
            }

            // Save answer
            quizAttemptDAO.saveAnswer(currentAttempt.getId(), currentQuestion.getId(), selectedOptionId, isCorrect);

            // Update session
            currentQuestionIndex++;
            session.setAttribute("currentQuestionIndex", currentQuestionIndex);

            if (currentQuestionIndex >= questions.size()) {
                // Quiz completed, mark the attempt as finished
                currentAttempt.setCompleted(true);
                quizAttemptDAO.updateQuizAttempt(currentAttempt);

                // Save the score to the leaderboard
                saveToLeaderboard(session, currentAttempt);

                // Clear session data
                session.removeAttribute("currentAttempt");
                session.removeAttribute("currentQuiz");
                session.removeAttribute("currentQuestionIndex");

                // Redirect to the leaderboard page
                response.sendRedirect(request.getContextPath() + "/WEB-INF/jsp/results.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/quiz/take");
            }

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your answer.");
        }
    }

    // Method to save the score to the leaderboard
    private void saveToLeaderboard(HttpSession session, QuizAttempt currentAttempt) throws SQLException {
        User user = (User) session.getAttribute("user");   // ✅ Correct cast
        String username = user.getUsername();              // ✅ Extract username
        int score = currentAttempt.getScore().intValue();  // ✅ Safely convert Double to int

        LeaderboardEntry leaderboardEntry = new LeaderboardEntry(username, score);
        leaderboardDAO.saveUserScore(leaderboardEntry);
    }

}
