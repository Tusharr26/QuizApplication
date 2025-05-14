package com.quizapp.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation for About page
 */
@WebServlet("/about")
public class abooutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Constructor
     */
    public abooutServlet() {
        super();
    }

    /**
     * Handles GET requests for the About page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // You can add any attributes needed for the JSP page here
        request.setAttribute("pageTitle", "About Quiz App - Tushar Patil");
        request.setAttribute("developer", "Tushar Patil");
        
        // Forward the request to the about.jsp page
        request.getRequestDispatcher("/WEB-INF/jsp/about.jsp").forward(request, response);
    }
}