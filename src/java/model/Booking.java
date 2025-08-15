package com.mc_cab.model;

import java.time.LocalDateTime;
import java.util.Objects;

/**
 * Represents a booking made by a user for a ride.
 */
public class Booking {

    private int id;
    private String userEmail;
    private String pickup;
    private String destination;
    private String rideTime;
    private double fare;
    private String vehicleModel;
    private String status;
    private String stops;
    private LocalDateTime updatedAt;
    private int customerId;

    /**
     * Default constructor initializing default values.
     */
    public Booking() {
        this.status = "Pending";
        this.updatedAt = LocalDateTime.now();
    }

    /**
     * Constructor for creating a new booking (without ID).
     */
    public Booking(int customerId, String userEmail, String pickup, String destination, double fare, String rideTime, String vehicleModel, LocalDateTime updatedAt) {
        this.userEmail = validateEmail(userEmail.trim());
        this.pickup = pickup;
        this.destination = destination;
        this.rideTime = rideTime;
        this.fare = Math.max(fare, 0.0); // Ensure fare is non-negative
        this.vehicleModel = vehicleModel;
        this.status = (status != null) ? status : "Pending";
        this.stops = stops;
        this.updatedAt = (updatedAt != null) ? updatedAt : LocalDateTime.now();
        this.customerId = customerId;
    }

    /**
     * Constructor for existing bookings (with ID).
     */
    public Booking(int id, String userEmail, String pickup, String destination, String rideTime, double fare,
                   String vehicleModel, String status, String stops, LocalDateTime updatedAt, int customerId) {
        this(customerId, userEmail, pickup, destination, fare, rideTime, vehicleModel, updatedAt);
        this.id = id;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = validateEmail(userEmail.trim());
    }

    public String getPickup() {
        return pickup;
    }

    public void setPickup(String pickup) {
        this.pickup = pickup;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getRideTime() {
        return rideTime;
    }

    public void setRideTime(String rideTime) {
        this.rideTime = rideTime;
    }

    public double getFare() {
        return fare;
    }

    public void setFare(double fare) {
        this.fare = Math.max(fare, 0.0); // Ensure fare is non-negative
    }

    public String getVehicleModel() {
        return vehicleModel;
    }

    public void setVehicleModel(String vehicleModel) {
        this.vehicleModel = vehicleModel;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = (status != null) ? status : "Pending";
        this.updatedAt = LocalDateTime.now(); // Auto-update timestamp when status changes
    }

    public String getStops() {
        return stops;
    }

    public void setStops(String stops) {
        this.stops = stops;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = (updatedAt != null) ? updatedAt : LocalDateTime.now();
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    /**
     * Validates email format.
     */
    private String validateEmail(String email) {
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            throw new IllegalArgumentException("Invalid email format");
        }
        return email;
    }

    @Override
    public String toString() {
        return String.format(
            "Booking{id=%d, userEmail='%s', pickup='%s', destination='%s', rideTime='%s', fare=%.2f, vehicleModel='%s', status='%s', stops='%s', updatedAt=%s, customerId=%d}",
            id, userEmail, pickup, destination, rideTime, fare, vehicleModel, status, stops, updatedAt, customerId
        );
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Booking)) return false;
        Booking booking = (Booking) o;
        return id == booking.id &&
                Double.compare(booking.fare, fare) == 0 &&
                customerId == booking.customerId &&
                Objects.equals(userEmail, booking.userEmail) &&
                Objects.equals(pickup, booking.pickup) &&
                Objects.equals(destination, booking.destination) &&
                Objects.equals(rideTime, booking.rideTime) &&
                Objects.equals(status, booking.status) &&
                Objects.equals(stops, booking.stops) &&
                Objects.equals(updatedAt, booking.updatedAt) &&
                Objects.equals(vehicleModel, booking.vehicleModel);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, userEmail, pickup, destination, rideTime, fare, vehicleModel, status, stops, updatedAt, customerId);
    }
}