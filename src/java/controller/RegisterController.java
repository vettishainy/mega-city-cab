package com.mc_cab.controller;

import com.mc_cab.dao.UserDAO;
import com.mc_cab.model.User;
import com.mc_cab.util.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = SecurityUtil.hashPassword(request.getParameter("password")); // Hash password
        String phone = request.getParameter("phone");

        User newUser = new User(fullName, email, password, phone);
        UserDAO userDAO = new UserDAO();

        boolean isRegistered = userDAO.registerUser(newUser);

        if (isRegistered) {
            HttpSession session = request.getSession();
            session.setAttribute("user_email", email);
            session.setAttribute("user_name", fullName); // Store name
            response.sendRedirect("customer/dashboard.jsp"); // Redirect to dashboard
        } else {
            response.sendRedirect("register.jsp?error=Registration failed. Try again.");
        }
    }
}
