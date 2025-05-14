package com.quizapp.model;

public class LeaderboardEntry {
    private String username;
    private double score;

    public LeaderboardEntry(String username, double score) {
        this.username = username;
        this.score = score;
    }

    public String getUsername() {
        return username;
    }

    public double getScore() {
        return score;
    }
}






