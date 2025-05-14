package com.quizapp.servlet;

import com.quizapp.dao.QuizDAO;
import com.quizapp.model.Quiz;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/")
public class IndexServlet extends HttpServlet {
    private QuizDAO quizDAO;

    @Override
    public void init() {
        quizDAO = new QuizDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<Quiz> popularQuizzes = quizDAO.findRecentPublishedQuizzes(3);
            req.setAttribute("popularQuizzes", popularQuizzes);
        } catch (SQLException e) {
            throw new ServletException("Failed to load popular quizzes", e);
        }
        req.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(req, resp);
    }
}

