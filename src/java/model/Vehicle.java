package com.mc_cab.model;

public class Vehicle {
    private int id;
    private String model;
    private String plateNumber;
    private double farePerKm;
    private String status;
    private int driverId;

    // Constructor for adding a new vehicle (without id)
    public Vehicle(String model, String plateNumber, double farePerKm, String status, int driverId) {
        this.model = model;
        this.plateNumber = plateNumber;
        this.farePerKm = farePerKm;
        this.status = status;
        this.driverId = driverId;
    }

    // Constructor for existing vehicle (with id)
    public Vehicle(int id, String model, String plateNumber, double farePerKm, String status, int driverId) {
        this.id = id;
        this.model = model;
        this.plateNumber = plateNumber;
        this.farePerKm = farePerKm;
        this.status = status;
        this.driverId = driverId;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public String getModel() {
        return model;
    }

    public String getPlateNumber() {
        return plateNumber;
    }

    public double getFarePerKm() {
        return farePerKm;
    }

    public String getStatus() {
        return status;
    }

    public int getDriverId() {
        return driverId;
    }
    // Add this method to Vehicle.java
public boolean isAvailable() {
    return "Available".equalsIgnoreCase(this.status);
}

}
