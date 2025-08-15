<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mc_cab.dao.VehicleDAO" %>
<%@ page import="com.mc_cab.model.Vehicle" %>

<%
    VehicleDAO vehicleDAO = new VehicleDAO();
    List<Vehicle> vehicleList = vehicleDAO.getAvailableVehicles();  // Fetch available vehicles
    String successMessage = request.getParameter("successMessage") != null ? request.getParameter("successMessage") : "";
    String errorMessage = request.getParameter("errorMessage") != null ? request.getParameter("errorMessage") : "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Vehicle - Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Custom Styles */
        body {
            background: linear-gradient(135deg, #C6E073, #A8D46D);
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 2rem;
            width: 90%;
            max-width: 1200px;
        }

        h2 {
            color: #000000;
            font-weight: bold;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .table {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .table thead th {
            background: linear-gradient(135deg, #000000, #333333);
            color: #C6E073;
            border: none;
            padding: 1rem;
        }

        .table tbody tr {
            transition: background 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(198, 224, 115, 0.1);
        }

        .btn {
            border: none;
            border-radius: 25px;
            padding: 10px 20px;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #C6E073, #A8D46D);
            box-shadow: 0 4px 15px rgba(198, 224, 115, 0.4);
            color: #000000;
        }

        .btn-primary:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(198, 224, 115, 0.6);
        }

        .alert {
            border-radius: 10px;
            margin-bottom: 1rem;
        }
    </style>

    <script>
        function selectVehicle(model, fare, vehicleId) {
            // Save vehicle details in sessionStorage
            sessionStorage.setItem("selectedVehicle", model);
            sessionStorage.setItem("selectedVehicleFare", fare);
            sessionStorage.setItem("selectedVehicleId", vehicleId);

            // Redirect back to booking.jsp
            window.location.href = "booking.jsp";
        }
    </script>
</head>

<body>
    <div class="container">
        <h2>Select Vehicle</h2>

        <% if (!successMessage.isEmpty()) { %>
            <div class="alert alert-success"><%= successMessage %></div>
        <% } %>

        <% if (!errorMessage.isEmpty()) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>

        <!-- Vehicle List -->
        <div class="mt-4">
            <h3>Available Vehicles</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Model</th>
                        <th>Plate Number</th>
                        <th>Fare Per KM</th>
                        <th>Status</th>
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
                            <td>
                                <!-- Select Vehicle Button -->
                                <button class="btn btn-primary btn-sm"
                                    onclick="selectVehicle('<%= vehicle.getModel() %>', '<%= vehicle.getFarePerKm() %>', '<%= vehicle.getId() %>')">
                                    Select
                                </button>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>