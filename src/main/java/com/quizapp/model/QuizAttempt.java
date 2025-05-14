package com.quizapp.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class QuizAttempt implements Serializable {
    private Long id;
    private Long userId;
    private Long quizId;
    private Timestamp startTime;
    private Timestamp endTime;
    private Double score;
    private boolean completed;
    private String quizTitle;
    private List<Answer> answers;
    private Timestamp attemptDate;
    private int totalQuestions;
    private int currentQuestion;  // ✅ Track current question index

    public QuizAttempt() {
        answers = new ArrayList<>();
        completed = false;
        currentQuestion = 0;
    }
    

    public QuizAttempt(Long userId, Long quizId, Timestamp startTime) {
        this.userId = userId;
        this.quizId = quizId;
        this.startTime = startTime;
        this.answers = new ArrayList<>();
        this.completed = false;
        this.currentQuestion = 0;
    }

    public QuizAttempt(Long id, Long userId, Long quizId, Timestamp startTime, Timestamp endTime, Double score, boolean completed) {
        this.id = id;
        this.userId = userId;
        this.quizId = quizId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.score = score;
        this.completed = completed;
        this.answers = new ArrayList<>();
        this.currentQuestion = 0;
    }

    public int getCurrentQuestion() {
        return currentQuestion;
    }

    public void setCurrentQuestion(int currentQuestion) {
        this.currentQuestion = currentQuestion;
    }

    public int getTotalQuestions() {
        return totalQuestions;
    }

    public void setTotalQuestions(int totalQuestions) {
        this.totalQuestions = totalQuestions;
    }

    public Timestamp getAttemptDate() {
        return attemptDate;
    }

    public void setAttemptDate(Timestamp attemptDate) {
        this.attemptDate = attemptDate;
    }

    public String getQuizTitle() {
        return quizTitle;
    }

    public void setQuizTitle(String quizTitle) {
        this.quizTitle = quizTitle;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getQuizId() {
        return quizId;
    }

    public void setQuizId(Long quizId) {
        this.quizId = quizId;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public Double getScore() {
        return score;
    }

    public void setScore(Double score) {
        this.score = score;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    public void addAnswer(Answer answer) {
        this.answers.add(answer);
    }

    @Override
    public String toString() {
        return "QuizAttempt{" +
                "id=" + id +
                ", userId=" + userId +
                ", quizId=" + quizId +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", score=" + score +
                ", completed=" + completed +
                ", currentQuestion=" + currentQuestion +
                ", answers=" + answers.size() +
                '}';
    }
}
