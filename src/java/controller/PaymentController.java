package com.mc_cab.controllers;

import com.mc_cab.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/PaymentController")
public class PaymentController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("calculateFare".equals(action)) {
            calculateFare(request, response);
        } else if ("confirmPayment".equals(action)) {
            confirmPayment(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
    }

    // Method to calculate the fare based on distance and number of stops
    private void calculateFare(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            double baseFare = 5.0;  // Base Fare in currency unit
            double perKmRate = 2.0;  // Cost per KM
            double perStopCharge = 1.5;  // Charge per additional stop

            double distance = Double.parseDouble(request.getParameter("distance"));
            int stops = Integer.parseInt(request.getParameter("stops"));

            // Calculate total fare
            double totalFare = baseFare + (distance * perKmRate) + (stops * perStopCharge);

            request.setAttribute("fareAmount", totalFare);
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input for distance or stops.");
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        }
    }

    // Method to confirm the payment and update the booking status
    private void confirmPayment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String paymentStatus = "Paid (Cash)";

            // Update the payment status in the bookings table
            try (Connection conn = DBConnection.getConnection()) {
                String query = "UPDATE bookings SET payment_status = ? WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, paymentStatus);
                    stmt.setInt(2, bookingId);

                    int rowsUpdated = stmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        request.setAttribute("message", "Payment confirmed successfully!");
                    } else {
                        request.setAttribute("error", "Booking not found or already paid.");
                    }
                }
            }

            request.getRequestDispatcher("payment.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing payment.");
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid booking ID.");
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        }
    }
}
