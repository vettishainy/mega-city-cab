package com.mc_cab.controller;

import com.mc_cab.dao.DBConnection;
import com.mc_cab.util.SecurityUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        switch (action) {
            case "login":
                loginUser(request, response);
                break;
            case "add":
                addUser(request, response);
                break;
            case "edit":
                editUser(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("editForm".equals(action)) {
            getEditForm(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (isEmpty(email) || isEmpty(password)) {
            forwardWithError(request, response, "Email and password cannot be empty!", "login.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT id, name, password FROM users WHERE email=?")) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && SecurityUtil.verifyPassword(password, rs.getString("password"))) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", rs.getString("name"));
                    session.setAttribute("userId", rs.getInt("id"));
                    response.sendRedirect("customer/dashboard.jsp");
                } else {
                    forwardWithError(request, response, "Invalid email or password!", "login.jsp");
                }
            }
        } catch (SQLException e) {
            logErrorAndForward(request, response, e, "Database connection error!", "login.jsp");
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (isEmpty(name) || isEmpty(email) || isEmpty(phone)) {
            out.print("{\"success\":false, \"message\":\"All fields are required.\"}");
            return;
        }

        if (isEmailExists(email)) {
            out.print("{\"success\":false, \"message\":\"Email is already in use.\"}");
            return;
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("INSERT INTO users (name, email, phone) VALUES (?, ?, ?)")) {
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                out.print("{\"success\":true, \"message\":\"User added successfully!\", \"user\": {\"id\": " + getGeneratedId(conn) + "}}");
            } else {
                out.print("{\"success\":false, \"message\":\"Failed to add user.\"}");
            }
        } catch (SQLException e) {
            logErrorAndForward(request, response, e, "Database connection error!", "manageuser.jsp");
        }
    }

    private void editUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        int userId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (isEmpty(name) || isEmpty(email) || isEmpty(phone)) {
            out.print("{\"success\":false, \"message\":\"All fields are required.\"}");
            return;
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("UPDATE users SET name=?, email=?, phone=? WHERE id=?")) {
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setInt(4, userId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                out.print("{\"success\":true, \"message\":\"User updated successfully!\"}");
            } else {
                out.print("{\"success\":false, \"message\":\"Failed to update user.\"}");
            }
        } catch (SQLException e) {
            logErrorAndForward(request, response, e, "Database connection error!", "manageuser.jsp");
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        int userId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM users WHERE id=?")) {
            stmt.setInt(1, userId);
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                out.print("{\"success\":true, \"message\":\"User deleted successfully!\"}");
            } else {
                out.print("{\"success\":false, \"message\":\"Failed to delete user.\"}");
            }
        } catch (SQLException e) {
            logErrorAndForward(request, response, e, "Database connection error!", "manageuser.jsp");
        }
    }

    private void getEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE id=?")) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");

                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    out.print("{\"user\": {\"id\": " + userId + ", \"fullName\": \"" + name + "\", \"email\": \"" + email + "\", \"phone\": \"" + phone + "\"}}");
                } else {
                    response.sendRedirect("manageuser.jsp");
                }
            }
        } catch (SQLException e) {
            logErrorAndForward(request, response, e, "Database connection error!", "manageuser.jsp");
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isEmailExists(String email) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT id FROM users WHERE email=?")) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            return false;
        }
    }

    private int getGeneratedId(Connection conn) throws SQLException {
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID()")) {
            return rs.next() ? rs.getInt(1) : -1;
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String message, String target) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher(target).forward(request, response);
    }

    private void logErrorAndForward(HttpServletRequest request, HttpServletResponse response, SQLException e, String message, String target) throws ServletException, IOException {
        e.printStackTrace();
        forwardWithError(request, response, message, target);
    }
}
