package com.mc_cab.controller;

import com.mc_cab.dao.UserDAO;
import com.mc_cab.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(LoginController.class.getName());

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            LOGGER.log(Level.WARNING, "Empty email or password submitted.");
            response.sendRedirect("login.jsp?error=Email and password are required");
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.authenticateUser(email, password);

            if (user != null) {
                // Create session and store user data
                HttpSession session = request.getSession();
                session.setAttribute("user_email", user.getEmail());
                session.setAttribute("user_name", user.getFullName());
                
                LOGGER.log(Level.INFO, "User authenticated successfully. Redirecting to dashboard.");
                response.sendRedirect("customer/dashboard.jsp"); // Redirect to customer dashboard
            } else {
                LOGGER.log(Level.WARNING, "Invalid login attempt for email: {0}", email);
                response.sendRedirect("login.jsp?error=Invalid email or password");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error during authentication process", e);
            response.sendRedirect("login.jsp?error=An error occurred, please try again later");
        }
    }
}
