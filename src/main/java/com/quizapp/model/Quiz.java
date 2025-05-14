package com.quizapp.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Quiz implements Serializable {
    private Long id;
    private String title;
    private String description;
    private String topic;
    private Long creatorId;
    private int timeLimit; // in minutes
    private boolean published;
    private int categoryId;
    private String category;
    private String difficulty;
    private List<Question> questions;
    private int questionCount;  // Add the questionCount field
    private String createdBy;  // Add this field
    private Date createdDate; // Add this field for the creation date
    private int score;


    // Default constructor
    public Quiz() {
        questions = new ArrayList<>();
    }

    // Constructor with essential fields
    public Quiz(String title, String description, String topic, Long creatorId) {
        this.title = title;
        this.description = description;
        this.topic = topic;
        this.creatorId = creatorId;
        this.questions = new ArrayList<>();
    }

    // Constructor with all fields
    public Quiz(Long id, String title, String description, String topic, Long creatorId) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.topic = topic;
        this.creatorId = creatorId;
        this.questions = new ArrayList<>();
    }

    // Getters and Setters for all fields
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public Long getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Long creatorId) {
        this.creatorId = creatorId;
    }

    public int getTimeLimit() {
        return timeLimit;
    }

    public void setTimeLimit(int timeLimit) {
        this.timeLimit = timeLimit;
    }

    public boolean isPublished() {
        return published;
    }

    public void setPublished(boolean published) {
        this.published = published;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(String difficulty) {
        this.difficulty = difficulty;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
        this.questionCount = questions.size();  // Update question count
    }

    public void addQuestion(Question question) {
        this.questions.add(question);
        this.questionCount = this.questions.size(); // Update question count
    }

    public int getQuestionCount() {
        return questionCount;
    }

    public void setQuestionCount(int questionCount) {
        this.questionCount = questionCount;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    // Additional method for total questions
    public int getTotalQuestions() {
        return questionCount;  // Return the number of questions
    }
    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getScoreColor() {
        if (score >= 80) return "green";
        else if (score >= 50) return "orange";
        else return "red";
    }


    @Override
    public String toString() {
        return "Quiz{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", topic='" + topic + '\'' +
                ", creatorId=" + creatorId +
                ", timeLimit=" + timeLimit +
                ", published=" + published +
                ", questions=" + questions.size() +
                ", createdBy='" + createdBy + '\'' +
                ", createdDate=" + createdDate +
                '}';
    }
}
