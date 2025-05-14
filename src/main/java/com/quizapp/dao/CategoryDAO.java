package com.quizapp.dao;

import com.quizapp.model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    private Connection conn;

    public CategoryDAO() {
        try {
            // Replace with your connection logic
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/quiz", "root", "tushar");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Category> getAllCategories() throws SQLException {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT id, name FROM categories";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Category category = new Category();
            category.setId(rs.getLong("id"));
            category.setName(rs.getString("name"));
            System.out.println("Fetched category: " + category.getName());

            categories.add(category);
            //System.out.print(categories);
        }

        rs.close();
        stmt.close();
        return categories;
    }
}
