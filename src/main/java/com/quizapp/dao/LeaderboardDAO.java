package com.quizapp.dao;

import com.quizapp.model.LeaderboardEntry;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaderboardDAO extends BaseDAO {

    public List<LeaderboardEntry> getLeaderboard() throws SQLException {
        String sql = "SELECT username, score FROM leaderboard ORDER BY score DESC LIMIT 10";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<LeaderboardEntry> leaderboard = new ArrayList<>();

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                leaderboard.add(new LeaderboardEntry(rs.getString("username"), rs.getInt("score")));
            }
        } finally {
            closeResources(conn, stmt, rs);
        }

        return leaderboard;
    }

    public void saveUserScore(LeaderboardEntry entry) throws SQLException {
        String sql = "INSERT INTO leaderboard (username, score) VALUES (?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, entry.getUsername());
            stmt.setDouble(2, entry.getScore());
            stmt.executeUpdate();
        } finally {
            closeResources(conn, stmt, null);
        }
    }
}

