package com.quizapp.servlet;

import com.quizapp.dao.LeaderboardDAO;
import com.quizapp.model.LeaderboardEntry;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/leaderboard")
public class Leaderboard extends HttpServlet {
    private LeaderboardDAO leaderboardDAO;

    @Override
    public void init() throws ServletException {
        leaderboardDAO = new LeaderboardDAO(); // Initialize the DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<LeaderboardEntry> leaderboard = leaderboardDAO.getLeaderboard();
            request.setAttribute("leaderboard", leaderboard);
            request.getRequestDispatcher("/WEB-INF/jsp/leaderboard.jsp").forward(request, response);
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred");
        }
    }
}
