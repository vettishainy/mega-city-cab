package com.mc_cab.dao;

import com.mc_cab.model.Vehicle;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VehicleDAO {
    private static final Logger LOGGER = Logger.getLogger(VehicleDAO.class.getName());

    // SQL Queries
    private static final String INSERT_SQL = 
        "INSERT INTO vehicles (model, plate_number, fare_per_km, status, driver_id) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE_SQL = 
        "UPDATE vehicles SET model = ?, plate_number = ?, fare_per_km = ?, status = ?, driver_id = ? WHERE id = ?";
    private static final String DELETE_SQL = 
        "DELETE FROM vehicles WHERE id = ?";
    private static final String SELECT_ALL_SQL = 
        "SELECT id, model, plate_number, fare_per_km, status, driver_id FROM vehicles WHERE status != 'Deleted'";
    private static final String SELECT_BY_ID_SQL = 
        "SELECT id, model, plate_number, fare_per_km, status, driver_id FROM vehicles WHERE id = ?";
    private static final String SELECT_AVAILABLE_VEHICLES_SQL = 
        "SELECT id, model, plate_number, fare_per_km, status, driver_id FROM vehicles WHERE status = 'Available'";

    // Add a new vehicle
    public boolean addVehicle(Vehicle vehicle) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_SQL)) {

            stmt.setString(1, vehicle.getModel());
            stmt.setString(2, vehicle.getPlateNumber());
            stmt.setDouble(3, vehicle.getFarePerKm());
            stmt.setString(4, vehicle.getStatus());
            stmt.setInt(5, vehicle.getDriverId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error adding vehicle: ", e);
            return false;
        }
    }

    // Update an existing vehicle
    public boolean updateVehicle(Vehicle vehicle) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_SQL)) {

            stmt.setString(1, vehicle.getModel());
            stmt.setString(2, vehicle.getPlateNumber());
            stmt.setDouble(3, vehicle.getFarePerKm());
            stmt.setString(4, vehicle.getStatus());
            stmt.setInt(5, vehicle.getDriverId());
            stmt.setInt(6, vehicle.getId()); // Use vehicle ID for updating

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating vehicle: ", e);
            return false;
        }
    }

    // Delete a vehicle
    public boolean deleteVehicle(int vehicleId) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_SQL)) {

            stmt.setInt(1, vehicleId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting vehicle: ", e);
            return false;
        }
    }

    // Get all vehicles (excluding those marked as deleted)
    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_SQL);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                vehicles.add(new Vehicle(
                        rs.getInt("id"),
                        rs.getString("model"),
                        rs.getString("plate_number"),
                        rs.getDouble("fare_per_km"),
                        rs.getString("status"),
                        rs.getInt("driver_id")
                ));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving vehicles: ", e);
        }
        return vehicles;
    }

    // Get a vehicle by its ID
    public Optional<Vehicle> getVehicleById(int vehicleId) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_BY_ID_SQL)) {

            stmt.setInt(1, vehicleId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(new Vehicle(
                            rs.getInt("id"),
                            rs.getString("model"),
                            rs.getString("plate_number"),
                            rs.getDouble("fare_per_km"),
                            rs.getString("status"),
                            rs.getInt("driver_id")
                    ));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving vehicle by ID: ", e);
        }
        return Optional.empty();
    }

    // Get all available vehicles
    public List<Vehicle> getAvailableVehicles() {
        List<Vehicle> availableVehicles = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_AVAILABLE_VEHICLES_SQL);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                availableVehicles.add(new Vehicle(
                        rs.getInt("id"),
                        rs.getString("model"),
                        rs.getString("plate_number"),
                        rs.getDouble("fare_per_km"),
                        rs.getString("status"),
                        rs.getInt("driver_id")
                ));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving available vehicles: ", e);
        }
        return availableVehicles;
    }
}
