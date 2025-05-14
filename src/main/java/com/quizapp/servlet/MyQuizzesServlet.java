package com.quizapp.servlet;

import com.quizapp.dao.QuizAttemptDAO;
import com.quizapp.model.Quiz;
import com.quizapp.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/my-quizzes")
public class MyQuizzesServlet extends HttpServlet {
    private QuizAttemptDAO quizAttemptDAO;

    @Override
    public void init() {
        quizAttemptDAO = new QuizAttemptDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        try {
            List<Quiz> completedQuizzes = quizAttemptDAO.getCompletedQuizzesByUser(user.getId());
            req.setAttribute("completedQuizzes", completedQuizzes);
            req.getRequestDispatcher("/WEB-INF/jsp/my-quizzes.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Unable to load completed quizzes", e);
        }
    }
}
