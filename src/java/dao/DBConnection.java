package com.mc_cab.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Database connection utility using the Singleton pattern.
 */
public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/mc_cab?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "Vetti0603@";

    private static Connection connection;
    private static final Logger LOGGER = Logger.getLogger(DBConnection.class.getName());

    private DBConnection() {}  // Private constructor to prevent instantiation

    /**
     * Provides a database connection using the Singleton pattern.
     * 
     * @return Connection instance
     * @throws SQLException if connection fails
     */
    public static synchronized Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL Driver
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                LOGGER.info("✅ Database Connected Successfully!");
            } catch (ClassNotFoundException e) {
                LOGGER.log(Level.SEVERE, "❌ MySQL Driver not found!", e);
                throw new SQLException("MySQL Driver not found!", e);
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "❌ Database connection failed!", e);
                throw e;
            }
        }
        return connection;
    }

    /**
     * Closes the database connection safely.
     */
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                LOGGER.info("✅ Database Connection Closed!");
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "❌ Error closing database connection", e);
            }
        }
    }
}
