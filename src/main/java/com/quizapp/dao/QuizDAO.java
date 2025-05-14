package com.quizapp.dao;

import com.quizapp.model.Quiz;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuizDAO extends BaseDAO {

    public int createQuiz(Quiz quiz) throws SQLException {
        String sql = "INSERT INTO quizzes (title, description, creator_id, time_limit, is_published) VALUES (?, ?, ?, ?, ?)";
        return executeUpdateAndGetGeneratedKey(sql, quiz.getTitle(), quiz.getDescription(),
                quiz.getCreatorId(), quiz.getTimeLimit(), quiz.isPublished());
    }

    public Quiz getQuizById(Long id) throws SQLException {
        String sql = "SELECT * FROM quizzes WHERE id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Quiz quiz = null;
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setLong(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                quiz = extractQuizFromResultSet(rs);
                
                // Fetch question count and set it for the quiz
                int questionCount = getQuestionCountByQuizId(id);
                quiz.setQuestionCount(questionCount);
            }
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return quiz;
    }

    // Fetch the question count for a quiz
    private int getQuestionCountByQuizId(Long quizId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM questions WHERE quiz_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int questionCount = 0;
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setLong(1, quizId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                questionCount = rs.getInt(1);
            }
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return questionCount;
    }

    public List<Quiz> getRecentQuizzes(int limit) throws SQLException {
        String sql = "SELECT * FROM quizzes ORDER BY created_at DESC LIMIT ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Quiz> quizzes = new ArrayList<>();

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit); 
            rs = stmt.executeQuery();

            while (rs.next()) {
                Quiz quiz = extractQuizFromResultSet(rs);
                
                // Fetch and set the question count
                int questionCount = getQuestionCountByQuizId(quiz.getId());
                quiz.setQuestionCount(questionCount);
                
                quizzes.add(quiz);
            }
        } finally {
            closeResources(conn, stmt, rs);
        }

        return quizzes;
    }

    public List<Quiz> getAllQuizzes() throws SQLException {
        String sql = "SELECT * FROM quizzes";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Quiz> quizzes = new ArrayList<>();
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Quiz quiz = extractQuizFromResultSet(rs);
                
                // Fetch and set the question count
                int questionCount = getQuestionCountByQuizId(quiz.getId());
                quiz.setQuestionCount(questionCount);
                
                quizzes.add(quiz);
            }
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return quizzes;
    }

    public List<Quiz> getQuizzesByCreatorId(Long creatorId) throws SQLException {
        String sql = "SELECT * FROM quizzes WHERE creator_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Quiz> quizzes = new ArrayList<>();
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setLong(1, creatorId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Quiz quiz = extractQuizFromResultSet(rs);
                
                // Fetch and set the question count
                int questionCount = getQuestionCountByQuizId(quiz.getId());
                quiz.setQuestionCount(questionCount);
                
                quizzes.add(quiz);
            }
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return quizzes;
    }

    public List<Quiz> getPublishedQuizzes() throws SQLException {
        String sql = "SELECT * FROM quizzes WHERE is_published = true";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Quiz> quizzes = new ArrayList<>();
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Quiz quiz = extractQuizFromResultSet(rs);
                
                // Fetch and set the question count
                int questionCount = getQuestionCountByQuizId(quiz.getId());
                quiz.setQuestionCount(questionCount);
                
                quizzes.add(quiz);
            }
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return quizzes;
    }

    public void updateQuiz(Quiz quiz) throws SQLException {
        String sql = "UPDATE quizzes SET title = ?, description = ?, time_limit = ?, is_published = ? WHERE id = ?";
        executeUpdate(sql, quiz.getTitle(), quiz.getDescription(), quiz.getTimeLimit(), 
                quiz.isPublished(), quiz.getId());
    }
    
    public void deleteQuiz(Long id) throws SQLException {
        String sql = "DELETE FROM quizzes WHERE id = ?";
        executeUpdate(sql, id);
    }

    private Quiz extractQuizFromResultSet(ResultSet rs) throws SQLException {
        Quiz quiz = new Quiz();
        quiz.setId(rs.getLong("id"));
        quiz.setTitle(rs.getString("title"));
        quiz.setDescription(rs.getString("description"));
        quiz.setCreatorId(rs.getLong("creator_id"));
        quiz.setTimeLimit(rs.getInt("time_limit"));
        quiz.setPublished(rs.getBoolean("is_published"));
        quiz.setCategory(rs.getString("category")); // Fetch the category
        quiz.setDifficulty(rs.getString("difficulty")); // Fetch the difficulty
        return quiz;
    }

    // Add the missing methods
    public List<Quiz> getQuizzesByCategory(String category) throws SQLException {
        String sql = "SELECT * FROM quizzes WHERE category = ?";
        return getQuizzesByQuery(sql, category);
    }
    
    public List<Quiz> getQuizzesByDifficulty(String difficulty) throws SQLException {
        String sql = "SELECT * FROM quizzes WHERE difficulty = ?";
        return getQuizzesByQuery(sql, difficulty);
    }
    
    public List<Quiz> searchQuizzes(String searchTerm) throws SQLException {
        String sql = "SELECT * FROM quizzes WHERE title LIKE ? OR description LIKE ?";
        return getQuizzesByQuery(sql, "%" + searchTerm + "%");
    }
    
    public List<String> getAllCategories() throws SQLException {
        String sql = "SELECT DISTINCT category FROM quizzes";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String> categories = new ArrayList<>();
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return categories;
    }
    
    private List<Quiz> getQuizzesByQuery(String sql, String param) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Quiz> quizzes = new ArrayList<>();
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, param);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                quizzes.add(extractQuizFromResultSet(rs));
            }
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return quizzes;
    }
    public List<Quiz> getPopularQuizzes() throws SQLException {
        String sql = "SELECT q.id, q.title, q.description, q.time_limit, q.category, q.difficulty, q.created_at " +
                     "FROM quizzes q " +
                     "ORDER BY q.created_at DESC LIMIT 3"; // You can order by a different metric if needed

        List<Quiz> quizzes = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setId(rs.getLong("id"));
                quiz.setTitle(rs.getString("title"));
                quiz.setDescription(rs.getString("description"));
                quiz.setTimeLimit(rs.getInt("time_limit"));
                quiz.setCategory(rs.getString("category"));
                quiz.setDifficulty(rs.getString("difficulty"));
                quiz.setCreatedDate(rs.getTimestamp("created_at"));
                quizzes.add(quiz);
            }
        }
        return quizzes;
    }
    public List<Quiz> findRecentPublishedQuizzes(int limit) throws SQLException {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM quizzes WHERE is_published = 1 ORDER BY created_at DESC LIMIT ?";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = extractQuizFromResultSet(rs);
                    // Fetch and set the question count
                    int questionCount = getQuestionCountByQuizId(quiz.getId());
                    quiz.setQuestionCount(questionCount);
                    quizzes.add(quiz);
                }
            }
        }

        return quizzes;
    }



}
