package com.quizapp.servlet.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.quizapp.dao.CategoryDAO;
import com.quizapp.dao.optionDAO;
import com.quizapp.dao.QuestionDAO;
import com.quizapp.dao.QuizDAO;
import com.quizapp.model.Category;
import com.quizapp.model.Option;
import com.quizapp.model.Question;
import com.quizapp.model.Quiz;
import com.quizapp.model.User;

@WebServlet("/admin/quiz/create")
public class CreateQuizServlet extends HttpServlet {

    private QuizDAO quizDAO;
    private QuestionDAO questionDAO;
    private optionDAO optionDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        quizDAO = new QuizDAO();
        questionDAO = new QuestionDAO();
        optionDAO = new optionDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load categories.");
        }

        request.getRequestDispatcher("/admin/create-quiz.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String timeLimit = request.getParameter("timeLimit");
        String isPublished = request.getParameter("isPublished");
        String categoryId = request.getParameter("categoryId");

        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Quiz title is required");
            request.getRequestDispatcher("/admin/create-quiz.jsp").forward(request, response);
            return;
        }

        try {
            Quiz quiz = new Quiz();
            quiz.setTitle(title);
            quiz.setDescription(description);

            // Parse time limit
            int timeLimitValue = 0;
            try {
                timeLimitValue = Integer.parseInt(timeLimit);
            } catch (NumberFormatException e) {
                // default value 0
            }
            quiz.setTimeLimit(timeLimitValue);
            quiz.setPublished("true".equals(isPublished)); // radio buttons return "true" or "false"
            quiz.setCategoryId(Integer.parseInt(categoryId));
            quiz.setCreatorId(currentUser.getId());

            int quizId = quizDAO.createQuiz(quiz);
            quiz.setId((long) quizId);

            // Process dynamic questions and options
            int questionIndex = 0;
            while (true) {
                String questionText = request.getParameter("questions[" + questionIndex + "].text");
                String correctOption = request.getParameter("questions[" + questionIndex + "].correctOption");

                if (questionText == null) {
                    break; // No more questions
                }

                if (!questionText.trim().isEmpty()) {
                    Question question = new Question();
                    question.setQuizId(quiz.getId());
                    question.setQuestionText(questionText);
                    question.setQuestionType("MCQ"); // Assuming default type

                    int questionId = questionDAO.createQuestion(question);
                    question.setId((long) questionId);

                    // Process options for the question
                    for (int optionIndex = 0; optionIndex < 4; optionIndex++) {
                        String optionText = request.getParameter("questions[" + questionIndex + "].options[" + optionIndex + "]");
                        if (optionText != null && !optionText.trim().isEmpty()) {
                            Option option = new Option();
                            option.setQuestionId(question.getId());
                            option.setOptionText(optionText);
                            option.setCorrect(String.valueOf(optionIndex).equals(correctOption));
                            optionDAO.createOption(option);
                        }
                    }
                }

                questionIndex++;
            }

            session.setAttribute("successMessage", "Quiz created successfully!");
            response.sendRedirect(request.getContextPath() + "/admin/quizzes");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error creating quiz: " + e.getMessage());
            request.getRequestDispatcher("/admin/create-quiz.jsp").forward(request, response);
        }
    }
}
