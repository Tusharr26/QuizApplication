package com.quizapp.servlet.quiz;

import com.quizapp.dao.QuestionDAO;
import com.quizapp.dao.optionDAO;
import com.quizapp.model.Option;
import com.quizapp.model.Question;
import com.quizapp.model.Quiz;
import com.quizapp.model.QuizAttempt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/quiz/take")
public class TakeQuizServlet extends HttpServlet {

    private QuestionDAO questionDAO;
    private optionDAO optionDAO;

    @Override
    public void init() throws ServletException {
        questionDAO = new QuestionDAO();
        optionDAO = new optionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        Quiz currentQuiz = (Quiz) session.getAttribute("currentQuiz");
        QuizAttempt currentAttempt = (QuizAttempt) session.getAttribute("currentAttempt");
        Integer currentQuestionIndex = (Integer) session.getAttribute("currentQuestionIndex");

        // Debugging log for session attributes
        System.out.println("Session attributes: currentQuiz=" + currentQuiz + ", currentAttempt=" + currentAttempt + ", currentQuestionIndex=" + currentQuestionIndex);

        if (currentQuiz == null || currentAttempt == null || currentQuestionIndex == null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        // Initialize currentQuestionIndex if it's not already set
        if (currentQuestionIndex == null) {
            currentQuestionIndex = 0;
            session.setAttribute("currentQuestionIndex", currentQuestionIndex);
        }

        try {
            // Fetch questions for the current quiz
            List<Question> questions = questionDAO.getQuestionsByQuizId(currentQuiz.getId());

            // Debugging log for questions
            System.out.println("Fetched questions: " + questions);

            if (questions == null || questions.isEmpty()) {
                System.out.println("No questions found for this quiz.");
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "No questions available for this quiz.");
                return;
            }

            // Check if the currentQuestionIndex is within the bounds of the questions list
            if (currentQuestionIndex >= questions.size()) {
                currentQuestionIndex = 0;  // Reset to first question if index is out of bounds
                session.setAttribute("currentQuestionIndex", currentQuestionIndex);
            }

            // Set current question based on the currentQuestionIndex
            Question currentQuestion = questions.get(currentQuestionIndex);

            // Populate options for each question
            for (Question question : questions) {
                List<Option> options = optionDAO.getOptionsByQuestionId(question.getId());
                question.setOptions(options);
            }

            // Set attributes for JSP
            request.setAttribute("currentQuiz", currentQuiz);
            request.setAttribute("currentAttempt", currentAttempt);
            request.setAttribute("currentQuestionIndex", currentQuestionIndex);
            request.setAttribute("currentQuestion", currentQuestion);
            request.setAttribute("questions", questions);

            // Forward to the JSP page to render the quiz
            request.getRequestDispatcher("/WEB-INF/jsp/take-quiz.jsp").forward(request, response);

        } catch (SQLException e) {
            // Log the error
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load quiz questions.");
        }
    }
}
