package com.quizapp.dao;

import com.quizapp.model.Quiz;
import com.quizapp.model.QuizAttempt;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuizAttemptDAO extends BaseDAO {

    public int createQuizAttempt(QuizAttempt attempt) throws SQLException {
        String sql = "INSERT INTO quiz_attempts (user_id, quiz_id, start_time, end_time, score, completed, current_question) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        return executeUpdateAndGetGeneratedKey(sql,
                attempt.getUserId(),
                attempt.getQuizId(),
                attempt.getStartTime(),
                attempt.getEndTime(),
                attempt.getScore(),
                attempt.isCompleted(),
                attempt.getCurrentQuestion());
    }

    public QuizAttempt getQuizAttemptById(Long id) throws SQLException {
        String sql = "SELECT * FROM quiz_attempts WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractQuizAttemptFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public QuizAttempt findUnfinishedAttempt(Long userId, Long quizId) throws SQLException {
        String sql = "SELECT * FROM quiz_attempts WHERE user_id = ? AND quiz_id = ? AND completed = FALSE ORDER BY start_time DESC LIMIT 1";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            stmt.setLong(2, quizId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractQuizAttemptFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public List<QuizAttempt> getAttemptsByUser(Long userId) throws SQLException {
        String sql = "SELECT * FROM quiz_attempts WHERE user_id = ?";
        List<QuizAttempt> attempts = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    attempts.add(extractQuizAttemptFromResultSet(rs));
                }
            }
        }

        return attempts;
    }

    public List<QuizAttempt> getQuizAttemptsByQuizId(Long quizId) throws SQLException {
        String sql = "SELECT * FROM quiz_attempts WHERE quiz_id = ?";
        List<QuizAttempt> attempts = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, quizId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    attempts.add(extractQuizAttemptFromResultSet(rs));
                }
            }
        }

        return attempts;
    }

    public void saveAnswer(Long attemptId, Long questionId, Long optionId, boolean isCorrect) throws SQLException {
        String sql = "INSERT INTO answers (attempt_id, question_id, option_id, is_correct) VALUES (?, ?, ?, ?)";
        executeUpdate(sql, attemptId, questionId, optionId, isCorrect);
    }

    public QuizAttempt getLatestAttemptByUserAndQuiz(Long userId, Long quizId) throws SQLException {
        String sql = "SELECT * FROM quiz_attempts WHERE user_id = ? AND quiz_id = ? ORDER BY start_time DESC LIMIT 1";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            stmt.setLong(2, quizId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractQuizAttemptFromResultSet(rs);
                }
            }
        }
        return null;
    }

    public void updateQuizAttempt(QuizAttempt attempt) throws SQLException {
        String sql = "UPDATE quiz_attempts SET user_id = ?, quiz_id = ?, start_time = ?, end_time = ?, score = ?, completed = ?, current_question = ? WHERE id = ?";
        executeUpdate(sql,
                attempt.getUserId(),
                attempt.getQuizId(),
                attempt.getStartTime(),
                attempt.getEndTime(),
                attempt.getScore(),
                attempt.isCompleted(),
                attempt.getCurrentQuestion(),
                attempt.getId());
    }

    public void deleteQuizAttempt(Long id) throws SQLException {
        String sql = "DELETE FROM quiz_attempts WHERE id = ?";
        executeUpdate(sql, id);
    }

    public QuizAttempt getAttemptById(Long attemptId) throws SQLException {
        return getQuizAttemptById(attemptId); // Reuse
    }

    public int getAnswerCountByAttempt(Long attemptId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM answers WHERE attempt_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, attemptId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }
    
    public List<Quiz> getCompletedQuizzesByUser(Long userId) throws SQLException {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT q.id, q.title, q.description, q.creator_id, q.time_limit, q.is_published, q.created_at, q.category, q.difficulty " +
                     "FROM quiz_attempts qa " +
                     "JOIN quizzes q ON qa.quiz_id = q.id " +
                     "WHERE qa.user_id = ? AND qa.completed = TRUE";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setId(rs.getLong("id"));
                    quiz.setTitle(rs.getString("title"));
                    quiz.setDescription(rs.getString("description"));
                    quiz.setCreatorId(rs.getLong("creator_id"));
                    quiz.setTimeLimit(rs.getInt("time_limit"));
                    quiz.setPublished(rs.getBoolean("is_published"));
                   // quiz.setCreatedAt(rs.getTimestamp("created_at"));
                    quiz.setCategory(rs.getString("category"));
                    quiz.setDifficulty(rs.getString("difficulty"));

                    quizzes.add(quiz);
                }
            }
        }

        return quizzes;
    }



    private QuizAttempt extractQuizAttemptFromResultSet(ResultSet rs) throws SQLException {
        QuizAttempt attempt = new QuizAttempt();
        attempt.setId(rs.getLong("id"));
        attempt.setUserId(rs.getLong("user_id"));
        attempt.setQuizId(rs.getLong("quiz_id"));
        attempt.setStartTime(rs.getTimestamp("start_time"));
        attempt.setEndTime(rs.getTimestamp("end_time"));
        attempt.setScore(rs.getDouble("score"));
        attempt.setCompleted(rs.getBoolean("completed"));
        attempt.setCurrentQuestion(rs.getInt("current_question"));
        attempt.setAttemptDate(rs.getTimestamp("start_time"));
        return attempt;
    }
}
