package com.quizapp.dao;

import com.quizapp.model.Option;
import com.quizapp.model.Question;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO extends BaseDAO {

    public int createQuestion(Question question) throws SQLException {
        String sql = "INSERT INTO questions (quiz_id, question_text, question_type) VALUES (?, ?, ?)";
        return executeUpdateAndGetGeneratedKey(sql, question.getQuizId(), question.getQuestionText(), 
                question.getQuestionType());
    }

    public Question getQuestionById(Long id) throws SQLException {
        String sql = "SELECT * FROM questions WHERE id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Question question = null;

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setLong(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                question = extractQuestionFromResultSet(rs);
            }
        } finally {
            closeResources(conn, stmt, rs);
        }

        return question;
    }

    public List<Question> getQuestionsByQuizId(Long quizId) throws SQLException {
        String sql = "SELECT * FROM questions WHERE quiz_id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Question> questions = new ArrayList<>();

        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setLong(1, quizId);
            rs = stmt.executeQuery();

            System.out.println("Executing query: " + sql + " with quizId = " + quizId);

            while (rs.next()) {
                Question q = extractQuestionFromResultSet(rs);
                q.setOptions(getOptionsByQuestionId(q.getId()));  // Load options for each question
                questions.add(q);
            }
        } finally {
            closeResources(conn, stmt, rs);
        }

        System.out.println("Fetched " + questions.size() + " questions for quizId: " + quizId);

        return questions;
    }

    public List<Option> getOptionsByQuestionId(Long questionId) throws SQLException {
        String sql = "SELECT * FROM options WHERE question_id = ?";
        List<Option> options = new ArrayList<>();

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, questionId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Option option = new Option();
                option.setId(rs.getLong("id"));
                option.setQuestionId(rs.getLong("question_id"));
                option.setOptionText(rs.getString("option_text"));
                option.setCorrect(rs.getBoolean("is_correct"));
                options.add(option);
            }
        }

        return options;
    }

    public void updateQuestion(Question question) throws SQLException {
        String sql = "UPDATE questions SET quiz_id = ?, question_text = ?, question_type = ? WHERE id = ?";
        executeUpdate(sql, question.getQuizId(), question.getQuestionText(), 
                question.getQuestionType(), question.getId());
    }

    public void deleteQuestion(Long id) throws SQLException {
        String sql = "DELETE FROM questions WHERE id = ?";
        executeUpdate(sql, id);
    }

    public void deleteQuestionsByQuizId(Long quizId) throws SQLException {
        String sql = "DELETE FROM questions WHERE quiz_id = ?";
        executeUpdate(sql, quizId);
    }

    private Question extractQuestionFromResultSet(ResultSet rs) throws SQLException {
        Question question = new Question();
        question.setId(rs.getLong("id"));
        question.setQuizId(rs.getLong("quiz_id"));
        question.setQuestionText(rs.getString("question_text"));
        question.setQuestionType(rs.getString("question_type"));
        return question;
    }
}
