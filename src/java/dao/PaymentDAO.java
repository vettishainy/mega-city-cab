package com.mc_cab.dao;

import com.mc_cab.model.Payment;
import com.mc_cab.dao.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {
    private Connection connection;

    // Constructor to initialize DB connection
    public PaymentDAO() throws SQLException {
        this.connection = DBConnection.getConnection();
    }

    // Add a new payment
    public boolean addPayment(Payment payment) {
        String sql = "INSERT INTO payments (booking_id, amount, payment_date, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, payment.getBookingId());
            stmt.setDouble(2, payment.getAmount());
            stmt.setTimestamp(3, new Timestamp(payment.getPaymentDate().getTime()));
            stmt.setString(4, payment.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding payment: " + e.getMessage());
        }
        return false;
    }

    // Retrieve payment by ID
    public Payment getPaymentById(int id) {
        String sql = "SELECT * FROM payments WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPayment(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving payment by ID: " + e.getMessage());
        }
        return null;
    }

    // Retrieve all payments
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT * FROM payments ORDER BY payment_date DESC";

        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                payments.add(mapResultSetToPayment(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving all payments: " + e.getMessage());
        }
        return payments;
    }

    // Update payment status
    public boolean updatePaymentStatus(int id, String status) {
        String sql = "UPDATE payments SET status = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating payment status: " + e.getMessage());
        }
        return false;
    }

    // Delete a payment record
    public boolean deletePayment(int id) {
        String sql = "DELETE FROM payments WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting payment: " + e.getMessage());
        }
        return false;
    }

    // Utility method to map ResultSet to Payment object
    private Payment mapResultSetToPayment(ResultSet rs) throws SQLException {
        return new Payment(
            rs.getInt("id"),
            rs.getInt("booking_id"),
            rs.getDouble("amount"),
            rs.getString("payment_method"),
            rs.getString("status"),
            rs.getTimestamp("payment_date")
        );
    }
}
