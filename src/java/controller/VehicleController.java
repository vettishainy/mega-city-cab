package com.mc_cab.controller;

import com.mc_cab.dao.VehicleDAO;
import com.mc_cab.model.Vehicle;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Optional;

@WebServlet("/admin/VehicleController")
public class VehicleController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final VehicleDAO vehicleDAO = new VehicleDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("availableVehicles".equals(action)) {
                loadAvailableVehicles(request, response);
            } else if ("edit".equals(action)) {
                int vehicleId = parseInt(request.getParameter("id"));
                Optional<Vehicle> vehicleOpt = vehicleDAO.getVehicleById(vehicleId);
                vehicleOpt.ifPresentOrElse(
                    vehicle -> request.setAttribute("vehicle", vehicle),
                    () -> request.setAttribute("errorMessage", "Vehicle not found!")
                );
                loadVehicleList(request, response);
            } else if ("delete".equals(action)) {
                deleteVehicle(request, response);
            } else {
                loadVehicleList(request, response);
            }
        } catch (Exception e) {
            response.sendRedirect("manageVehicles.jsp?errorMessage=" + URLEncoder.encode("An unexpected error occurred!", "UTF-8"));
            e.printStackTrace();
        }
    }
    
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action) {
                case "add":
                    addVehicle(request, response);
                    break;
                case "update":
                    updateVehicle(request, response);
                    break;
                case "delete":
                    deleteVehicle(request, response);
                    break;
                default:
                    response.sendRedirect("manageVehicles.jsp?errorMessage=" + URLEncoder.encode("Invalid action!", "UTF-8"));
            }
        } catch (Exception e) {
            response.sendRedirect("manageVehicles.jsp?errorMessage=" + URLEncoder.encode("An unexpected error occurred!", "UTF-8"));
            e.printStackTrace();
        }
    }

    private void addVehicle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String model = request.getParameter("model");
        String plateNumber = request.getParameter("plateNumber");
        double farePerKm = parseDouble(request.getParameter("farePerKm"));
        String status = request.getParameter("status");
        int driverId = parseInt(request.getParameter("driverId"));

        if (model.isEmpty() || plateNumber.isEmpty()) {
            response.sendRedirect("manageVehicles.jsp?errorMessage=" + URLEncoder.encode("Model and Plate Number are required!", "UTF-8"));
            return;
        }

        Vehicle newVehicle = new Vehicle(model, plateNumber, farePerKm, status, driverId);
        boolean success = vehicleDAO.addVehicle(newVehicle);
        response.sendRedirect("manageVehicles.jsp?successMessage=" + URLEncoder.encode(success ? "Vehicle added successfully!" : "Failed to add vehicle!", "UTF-8"));
    }

    private void updateVehicle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int vehicleId = parseInt(request.getParameter("id"));
        String model = request.getParameter("model");
        String plateNumber = request.getParameter("plateNumber");
        double farePerKm = parseDouble(request.getParameter("farePerKm"));
        String status = request.getParameter("status");
        int driverId = parseInt(request.getParameter("driverId"));

        if (vehicleId <= 0 || model.isEmpty() || plateNumber.isEmpty()) {
            response.sendRedirect("manageVehicles.jsp?errorMessage=" + URLEncoder.encode("Invalid input!", "UTF-8"));
            return;
        }

        Vehicle updatedVehicle = new Vehicle(vehicleId, model, plateNumber, farePerKm, status, driverId);
        boolean success = vehicleDAO.updateVehicle(updatedVehicle);
        response.sendRedirect("manageVehicles.jsp?successMessage=" + URLEncoder.encode(success ? "Vehicle updated successfully!" : "Failed to update vehicle!", "UTF-8"));
    }

    private void deleteVehicle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int vehicleId = parseInt(request.getParameter("id"));
        if (vehicleId <= 0) {
            response.sendRedirect("manageVehicles.jsp?errorMessage=" + URLEncoder.encode("Invalid vehicle ID!", "UTF-8"));
            return;
        }

        boolean success = vehicleDAO.deleteVehicle(vehicleId);
        response.sendRedirect("manageVehicles.jsp?successMessage=" + URLEncoder.encode(success ? "Vehicle deleted successfully!" : "Failed to delete vehicle!", "UTF-8"));
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private double parseDouble(String value) {
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }

    private void loadVehicleList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Vehicle> vehicleList = vehicleDAO.getAllVehicles();
        request.setAttribute("vehicleList", vehicleList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/manageVehicles.jsp");
        dispatcher.forward(request, response);
    }
    private void loadAvailableVehicles(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Vehicle> availableVehicles = vehicleDAO.getAvailableVehicles(); // Fetch only available vehicles
        request.setAttribute("vehicleList", availableVehicles);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/vehicles.jsp");
        dispatcher.forward(request, response);
    }
}
