package com.quizapp.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class User implements Serializable {
    private static final long serialVersionUID = 1L; // Add serialVersionUID to ensure serialization compatibility

    private Long id;
    private String username;
    private String password;
    private String email;
    private String fullName;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private boolean isAdmin;
    private String avatarUrl;  // New field for avatar URL

    public User() {
    }

    public User(String username, String password, String email, String fullName, String avatarUrl) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.isAdmin = false;
        this.avatarUrl = avatarUrl;  // Initialize avatar URL
    }

    public User(Long id, String username, String password, String email, String fullName, 
                LocalDateTime createdAt, LocalDateTime updatedAt, boolean isAdmin, String avatarUrl) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isAdmin = isAdmin;
        this.avatarUrl = avatarUrl;  // Initialize avatar URL
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public String getAvatarUrl() {
        return avatarUrl;  // Getter for avatar URL
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;  // Setter for avatar URL
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", isAdmin=" + isAdmin +
                ", avatarUrl='" + avatarUrl + '\'' +  // Include avatar URL in toString
                '}';
    }
}
