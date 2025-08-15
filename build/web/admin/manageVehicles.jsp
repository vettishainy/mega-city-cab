<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mc_cab.dao.VehicleDAO" %>
<%@ page import="com.mc_cab.model.Vehicle" %>

<%
    VehicleDAO vehicleDAO = new VehicleDAO();
    List<Vehicle> vehicleList = vehicleDAO.getAllVehicles();
    String successMessage = request.getParameter("successMessage") != null ? request.getParameter("successMessage") : "";
    String errorMessage = request.getParameter("errorMessage") != null ? request.getParameter("errorMessage") : "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Vehicles - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Custom Styles */
        body {
            background: linear-gradient(135deg, #C6E073, #FFFFFF);
            font-family: 'Arial', sans-serif;
        }

        .container {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .card {
            background: rgba(255, 255, 255, 0.9);
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background: #000000;
            color: #C6E073;
            font-weight: bold;
            border-radius: 10px 10px 0 0;
        }

        .btn-primary, .btn-success, .btn-warning, .btn-danger {
            border: none;
            border-radius: 25px;
            padding: 10px 20px;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #C6E073, #A8D46D);
            box-shadow: 0 4px 15px rgba(198, 224, 115, 0.4);
        }

        .btn-primary:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(198, 224, 115, 0.6);
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #218838);
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
        }

        .btn-success:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.6);
        }

        .btn-warning {
            background: linear-gradient(135deg, #ffc107, #e0a800);
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.4);
        }

        .btn-warning:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(255, 193, 7, 0.6);
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
        }

        .btn-danger:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.6);
        }

        .table {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            overflow: hidden;
        }

        .table thead th {
            background: #000000;
            color: #C6E073;
            border: none;
        }

        .table tbody tr {
            transition: background 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(198, 224, 115, 0.1);
        }

        .alert {
            border-radius: 10px;
        }

        .modal-content {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .modal-header {
            background: #000000;
            color: #C6E073;
            border-radius: 15px 15px 0 0;
        }

        .modal-title {
            font-weight: bold;
        }
    </style>
</head>

<body class="bg-light">
    <div class="container mt-5 p-4">
        <h2 class="text-center mb-4" style="color: #000000;">Manage Vehicles</h2>

        <% if (!successMessage.isEmpty()) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% } %>

        <% if (!errorMessage.isEmpty()) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>

        <!-- Add Vehicle Form -->
        <div class="card mt-3">
            <div class="card-header">Add Vehicle</div>
            <div class="card-body">
                <form action="/MC_CAB/admin/VehicleController" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label class="form-label">Model:</label>
                        <input type="text" name="model" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Plate Number:</label>
                        <input type="text" name="plateNumber" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Fare Per KM:</label>
                        <input type="number" name="farePerKm" class="form-control" step="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Status:</label>
                        <select name="status" class="form-select" required>
                            <option value="Available">Available</option>
                            <option value="Unavailable">Unavailable</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Driver ID:</label>
                        <input type="number" name="driverId" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Add Vehicle</button>
                </form>
            </div>
        </div>

        <!-- Vehicle List -->
        <div class="mt-4">
            <h3 style="color: #000000;">Vehicle List</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Model</th>
                        <th>Plate Number</th>
                        <th>Fare Per KM</th>
                        <th>Status</th>
                        <th>Driver ID</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Vehicle vehicle : vehicleList) { %>
                        <tr>
                            <td><%= vehicle.getId() %></td>
                            <td><%= vehicle.getModel() %></td>
                            <td><%= vehicle.getPlateNumber() %></td>
                            <td><%= vehicle.getFarePerKm() %></td>
                            <td><%= vehicle.getStatus() %></td>
                            <td><%= vehicle.getDriverId() %></td>
                            <td>
                                <!-- Edit Button (Triggers Modal) -->
                                <button class="btn btn-warning btn-sm" onclick="editVehicle('<%= vehicle.getId() %>', '<%= vehicle.getModel() %>', '<%= vehicle.getPlateNumber() %>', '<%= vehicle.getFarePerKm() %>', '<%= vehicle.getStatus() %>', '<%= vehicle.getDriverId() %>')" data-bs-toggle="modal" data-bs-target="#editVehicleModal">
                                    Edit
                                </button>

                                <!-- Delete Button -->
                                <form action="/MC_CAB/admin/VehicleController" method="post" style="display:inline-block;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="<%= vehicle.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this vehicle?');">Delete</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Edit Vehicle Modal -->
    <div class="modal fade" id="editVehicleModal" tabindex="-1" aria-labelledby="editVehicleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editVehicleModalLabel">Edit Vehicle</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="/MC_CAB/admin/VehicleController" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" id="editVehicleId" name="id">
                        
                        <div class="mb-3">
                            <label class="form-label">Model:</label>
                            <input type="text" id="editModel" name="model" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Plate Number:</label>
                            <input type="text" id="editPlateNumber" name="plateNumber" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Fare Per KM:</label>
                            <input type="number" id="editFarePerKm" name="farePerKm" class="form-control" step="0.01" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status:</label>
                            <select id="editStatus" name="status" class="form-select" required>
                                <option value="Available">Available</option>
                                <option value="Unavailable">Unavailable</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Driver ID:</label>
                            <input type="number" id="editDriverId" name="driverId" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100">Update Vehicle</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript for Editing -->
    <script>
        function editVehicle(id, model, plateNumber, farePerKm, status, driverId) {
            document.getElementById('editVehicleId').value = id;
            document.getElementById('editModel').value = model;
            document.getElementById('editPlateNumber').value = plateNumber;
            document.getElementById('editFarePerKm').value = farePerKm;
            document.getElementById('editStatus').value = status;
            document.getElementById('editDriverId').value = driverId;
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>