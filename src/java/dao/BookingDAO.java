package com.mc_cab.dao;

import com.mc_cab.model.Booking;

import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookingDAO {

    private static final Logger logger = Logger.getLogger(BookingDAO.class.getName());

    // SQL Queries
    private static final String INSERT_SQL = "INSERT INTO bookings (user_email, pickup, destination, ride_time, fare, vehicle_model, status, stops, customer_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_ALL_SQL = "SELECT * FROM bookings ORDER BY updated_at DESC";
    private static final String SELECT_BY_ID_SQL = "SELECT * FROM bookings WHERE id = ?";
    private static final String UPDATE_SQL = "UPDATE bookings SET user_email = ?, pickup = ?, destination = ?, ride_time = ?, fare = ?, vehicle_model = ?, status = ?, stops = ?, customer_id = ?, updated_at = NOW() WHERE id = ?";
    private static final String DELETE_SQL = "DELETE FROM bookings WHERE id = ?";

    /**
     * Add a new booking to the database.
     *
     * @param booking The booking to add.
     * @return True if the booking was added successfully, false otherwise.
     */
    public boolean addBooking(Booking booking) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_SQL, Statement.RETURN_GENERATED_KEYS)) {

            setBookingParameters(stmt, booking);
            if (stmt.executeUpdate() > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        booking.setId(generatedKeys.getInt(1)); // Set the generated ID
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error inserting booking", e);
        }
        return false;
    }

    /**
     * Get all bookings from the database.
     *
     * @return A list of all bookings.
     */
    public List<Booking> getAllBookings() {
        return executeQueryList(SELECT_ALL_SQL, stmt -> {});
    }

    /**
     * Get a booking by its ID.
     *
     * @param id The ID of the booking.
     * @return An Optional containing the booking if found, otherwise empty.
     */
    public Optional<Booking> getBookingById(int id) {
        return executeQuerySingle(SELECT_BY_ID_SQL, stmt -> stmt.setInt(1, id));
    }

    /**
     * Update an existing booking in the database.
     *
     * @param booking The booking to update.
     * @return True if the booking was updated successfully, false otherwise.
     */
    public boolean updateBooking(Booking booking) {
        return executeUpdate(UPDATE_SQL, stmt -> {
            setBookingParameters(stmt, booking);
            stmt.setInt(10, booking.getId()); // Set the ID for the WHERE clause
        });
    }

    /**
     * Delete a booking by its ID.
     *
     * @param id The ID of the booking to delete.
     * @return True if the booking was deleted successfully, false otherwise.
     */
    public boolean deleteBooking(int id) {
        return executeUpdate(DELETE_SQL, stmt -> stmt.setInt(1, id));
    }

    /**
     * Set parameters for a PreparedStatement using a Booking object.
     *
     * @param stmt    The PreparedStatement to set parameters on.
     * @param booking The Booking object containing the data.
     * @throws SQLException If a database error occurs.
     */
    private void setBookingParameters(PreparedStatement stmt, Booking booking) throws SQLException {
        stmt.setString(1, booking.getUserEmail());
        stmt.setString(2, booking.getPickup());
        stmt.setString(3, booking.getDestination());
        stmt.setString(4, booking.getRideTime());
        stmt.setDouble(5, booking.getFare());
        stmt.setString(6, booking.getVehicleModel());
        stmt.setString(7, booking.getStatus());
        stmt.setString(8, Objects.toString(booking.getStops(), ""));
        stmt.setInt(9, booking.getCustomerId());
    }

    /**
     * Map a ResultSet row to a Booking object.
     *
     * @param rs The ResultSet to map.
     * @return A Booking object.
     * @throws SQLException If a database error occurs.
     */
    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        return new Booking(
            rs.getInt("id"),
            rs.getString("user_email"),
            rs.getString("pickup"),
            rs.getString("destination"),
            rs.getString("ride_time"),
            rs.getDouble("fare"),
            rs.getString("vehicle_model"),
            rs.getString("status"),
            rs.getString("stops"),
            rs.getTimestamp("updated_at").toLocalDateTime(),
            rs.getInt("customer_id")
        );
    }

    /**
     * Execute an update operation (INSERT, UPDATE, DELETE).
     *
     * @param sql          The SQL query to execute.
     * @param paramSetter  A consumer to set parameters on the PreparedStatement.
     * @return True if the operation was successful, false otherwise.
     */
    private boolean executeUpdate(String sql, SQLConsumer<PreparedStatement> paramSetter) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            paramSetter.accept(stmt);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database update failed: " + sql, e);
        }
        return false;
    }

    /**
     * Execute a query that returns a list of bookings.
     *
     * @param sql          The SQL query to execute.
     * @param paramSetter  A consumer to set parameters on the PreparedStatement.
     * @return A list of bookings.
     */
    private List<Booking> executeQueryList(String sql, SQLConsumer<PreparedStatement> paramSetter) {
        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            paramSetter.accept(stmt);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database query failed: " + sql, e);
        }
        return bookings;
    }

    /**
     * Execute a query that returns a single booking record.
     *
     * @param sql          The SQL query to execute.
     * @param paramSetter  A consumer to set parameters on the PreparedStatement.
     * @return An Optional containing the booking if found, otherwise empty.
     */
    private Optional<Booking> executeQuerySingle(String sql, SQLConsumer<PreparedStatement> paramSetter) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            paramSetter.accept(stmt);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database query failed: " + sql, e);
        }
        return Optional.empty();
    }

    /**
     * Functional interface to handle PreparedStatement parameter setting.
     */
    @FunctionalInterface
    private interface SQLConsumer<T> {
        void accept(T t) throws SQLException;
    }
}