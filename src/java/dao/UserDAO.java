package com.mc_cab.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.mc_cab.model.User;
import com.mc_cab.util.SecurityUtil;

public class UserDAO {

    // Register a new user
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (fullname, email, password, phone) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, SecurityUtil.hashPassword(user.getPassword())); // Hash password
            stmt.setString(4, user.getPhone());
            
            return stmt.executeUpdate() > 0; // True if insertion is successful
        } catch (SQLException e) {
            logSQLException("Error during user registration", e);
        }
        return false;
    }

    // Authenticate user during login
    public User authenticateUser(String email, String password) {
        String sql = "SELECT id, fullname, password FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && SecurityUtil.verifyPassword(password, rs.getString("password"))) {
                    return new User(rs.getInt("id"), rs.getString("fullname"), email, null, null);
                }
            }
        } catch (SQLException e) {
            logSQLException("Error during user authentication", e);
        }
        return null;
    }

    // Check if the email already exists in the database
    public boolean emailExists(String email) {
        String sql = "SELECT 1 FROM users WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // True if email exists
            }
        } catch (SQLException e) {
            logSQLException("Error checking email existence", e);
        }
        return false;
    }

    // Get all users from the database
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT id, fullname, email, phone FROM users";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                userList.add(mapToUser(rs));
            }
        } catch (SQLException e) {
            logSQLException("Error fetching users", e);
        }
        return userList;
    }

    // Update user details
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET fullname = ?, email = ?, phone = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setInt(4, user.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logSQLException("Error updating user", e);
        }
        return false;
    }

    // Delete user by ID
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logSQLException("Error deleting user", e);
        }
        return false;
    }

    // Map ResultSet to User object
    private User mapToUser(ResultSet rs) throws SQLException {
        return new User(
            rs.getInt("id"),
            rs.getString("fullname"),
            rs.getString("email"),
            null, // Excluding password for security
            rs.getString("phone")
        );
    }

    // Log SQLException with error message
    private void logSQLException(String message, SQLException e) {
        System.err.println(message + ": " + e.getMessage());
        e.printStackTrace();
    }
}
