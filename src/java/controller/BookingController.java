package com.mc_cab.controller;

import com.mc_cab.dao.BookingDAO;
import com.mc_cab.model.Booking;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/BookingController")
public class BookingController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(BookingController.class.getName());
    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    /**
     * Handles all incoming requests and routes them to the appropriate method based on the "action" parameter.
     */
    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = Optional.ofNullable(request.getParameter("action")).orElse("manageBookings");

        try {
            switch (action) {
                case "view":
                    viewBooking(request, response);
                    break;
                case "manageBookings":
                    listBookings(request, response);
                    break;
                case "create":
                    createBooking(request, response);
                    break;
                case "update":
                    updateBooking(request, response);
                    break;
                case "delete":
                    deleteBooking(request, response);
                    break;
                case "confirm":
                    changeBookingStatus(request, response, "Confirmed");
                    break;
                case "cancel":
                    changeBookingStatus(request, response, "Cancelled");
                    break;
                default:
                    listBookings(request, response);
                    break;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error handling action: " + action, e);
            response.sendRedirect("error.jsp?message=Unexpected error occurred.");
        }
    }

    /**
     * Displays the details of a specific booking.
     */
    private void viewBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = parseInt(request.getParameter("id"));
        Optional<Booking> bookingOpt = bookingDAO.getBookingById(bookingId);

        if (bookingOpt.isPresent()) {
            request.setAttribute("booking", bookingOpt.get());
            request.getRequestDispatcher("/bookingHistory.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp?message=Booking not found.");
        }
    }

    /**
     * Lists all bookings.
     */
    private void listBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Booking> bookings = bookingDAO.getAllBookings();
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/manageBookings.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error fetching bookings", e);
            response.sendRedirect("error.jsp?message=Unable to fetch bookings.");
        }
    }

    /**
     * Creates a new booking.
     */
    private void createBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("userEmail");
        if (userEmail == null) {
            response.sendRedirect("error.jsp?message=Please log in to book a ride.");
            return;
        }

        Booking booking = extractBookingFromRequest(request);
        booking.setUserEmail(userEmail);

        boolean success = bookingDAO.addBooking(booking);
        redirectWithMessage(response, success, "customer/bookingHistory.jsp", "error.jsp?message=Failed to create booking.");
    }

    /**
     * Updates an existing booking.
     */
    private void updateBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = parseInt(request.getParameter("id"));
        Booking booking = extractBookingFromRequest(request);
        booking.setId(bookingId);

        boolean success = bookingDAO.updateBooking(booking);
        redirectWithMessage(response, success, "customer/bookingHistory.jsp", "error.jsp?message=Failed to update booking.");
    }

    /**
     * Deletes a booking.
     */
    private void deleteBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = parseInt(request.getParameter("id"));
        boolean success = bookingDAO.deleteBooking(bookingId);
        redirectWithMessage(response, success, "customer/bookingHistory.jsp", "error.jsp?message=Failed to delete booking.");
    }

    /**
     * Changes the status of a booking (e.g., confirm or cancel).
     */
    private void changeBookingStatus(HttpServletRequest request, HttpServletResponse response, String status) throws ServletException, IOException {
        int bookingId = parseInt(request.getParameter("id"));
        Optional<Booking> bookingOpt = bookingDAO.getBookingById(bookingId);

        if (bookingOpt.isPresent()) {
            Booking booking = bookingOpt.get();
            booking.setStatus(status);
            boolean success = bookingDAO.updateBooking(booking);
            redirectWithMessage(response, success, "admin/manageBookings.jsp", "error.jsp?message=Failed to update status.");
        } else {
            response.sendRedirect("error.jsp?message=Booking not found.");
        }
    }

    /**
     * Redirects to a success or error page based on the operation result.
     */
    private void redirectWithMessage(HttpServletResponse response, boolean success, String successPage, String errorPage) throws IOException {
        response.sendRedirect(success ? successPage : errorPage);
    }

    /**
     * Extracts booking details from the request and creates a Booking object.
     */
    private Booking extractBookingFromRequest(HttpServletRequest request) {
        String pickup = request.getParameter("pickup");
        String destination = request.getParameter("destination");
        String rideTime = request.getParameter("ride_time");
        double fare = parseDouble(request.getParameter("fare"));
        String vehicleModel = request.getParameter("vehicle_model");
        String status = Optional.ofNullable(request.getParameter("status")).orElse("Pending");
        String stops = request.getParameter("stops");

        if (pickup == null || destination == null || rideTime == null || vehicleModel == null) {
            throw new IllegalArgumentException("Missing required booking information.");
        }

        return new Booking(0, pickup, destination, rideTime, fare, vehicleModel, status, LocalDateTime.now());
    }

    /**
     * Parses a string into a double. Returns 0.0 if the string is null or invalid.
     */
    private double parseDouble(String value) {
        try {
            return value != null ? Double.parseDouble(value) : 0.0;
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Invalid fare format: " + value, e);
            return 0.0;
        }
    }

    /**
     * Parses a string into an integer. Returns 0 if the string is null or invalid.
     */
    private int parseInt(String value) {
        try {
            return value != null ? Integer.parseInt(value) : 0;
        } catch (NumberFormatException e) {
            logger.log(Level.WARNING, "Invalid ID format: " + value, e);
            return 0;
        }
    }
}
