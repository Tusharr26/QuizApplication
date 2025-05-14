package com.quizapp.servlet.quiz;

import com.quizapp.dao.QuestionDAO;
import com.quizapp.dao.QuizAttemptDAO;
import com.quizapp.dao.QuizDAO;
import com.quizapp.model.Question;
import com.quizapp.model.Quiz;
import com.quizapp.model.QuizAttempt;
import com.quizapp.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/quiz/start/*")
public class StartQuizServlet extends HttpServlet {

    private QuizDAO quizDAO;
    private QuizAttemptDAO quizAttemptDAO;
    private QuestionDAO questionDAO;

    @Override
    public void init() throws ServletException {
        quizDAO = new QuizDAO();
        quizAttemptDAO = new QuizAttemptDAO();
        questionDAO = new QuestionDAO(); // Initialize QuestionDAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        System.out.println("Path Info: " + pathInfo);

        if (pathInfo == null || pathInfo.split("/").length < 2) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quiz ID");
            return;
        }

        String[] pathParts = pathInfo.split("/");
        Long quizId = Long.parseLong(pathParts[1]);
        System.out.println("Quiz ID: " + quizId);

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        try {
            Quiz quiz = quizDAO.getQuizById(quizId);
            if (quiz == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Quiz not found");
                return;
            }

            // Fetch questions and options
            List<Question> questions = questionDAO.getQuestionsByQuizId(quizId);
            for (Question q : questions) {
                q.setOptions(questionDAO.getOptionsByQuestionId(q.getId()));
            }

            session.setAttribute("questions", questions);

            QuizAttempt unfinishedAttempt = quizAttemptDAO.findUnfinishedAttempt(currentUser.getId(), quizId);
            if (unfinishedAttempt != null) {
                session.setAttribute("currentAttempt", unfinishedAttempt);
                session.setAttribute("currentQuiz", quiz);
                session.setAttribute("currentQuestionIndex", unfinishedAttempt.getCurrentQuestion());
                request.setAttribute("resume", true);

                // Set current question
                request.setAttribute("currentQuestion", questions.get(unfinishedAttempt.getCurrentQuestion()));

                request.getRequestDispatcher("/WEB-INF/jsp/take-quiz.jsp").forward(request, response);
            } else {
                // Start new attempt
                QuizAttempt attempt = new QuizAttempt();
                attempt.setQuizId(quizId);
                attempt.setUserId(currentUser.getId());
                attempt.setStartTime(new Timestamp(System.currentTimeMillis()));
                attempt.setScore(0.0);
                attempt.setCompleted(false);
                attempt.setCurrentQuestion(0);

                int attemptId = quizAttemptDAO.createQuizAttempt(attempt);
                attempt.setId((long) attemptId);

                session.setAttribute("currentAttempt", attempt);
                session.setAttribute("currentQuiz", quiz);
                session.setAttribute("currentQuestionIndex", 0);

                // Set current question
                request.setAttribute("currentQuestion", questions.get(0));

                request.getRequestDispatcher("/WEB-INF/jsp/take-quiz.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }
}
