<%@ page import="java.util.List" %>
<%@ page import="com.mc_cab.model.Booking" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Bookings</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: url('https://s3-prod.crainsnewyork.com/s3fs-public/SMALLBIZ_170319985_V3_-1_TVVOYQBTXXMK.gif') no-repeat center center/cover;
            font-family: 'Poppins', sans-serif;
            color: #FFFFFF;
            padding: 20px;
        }

        .table-container {
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(15px);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.3);
            animation: fadeIn 1s ease-in-out;
        }

        .table {
            color: #FFFFFF;
            border-color: rgba(255, 255, 255, 0.2);
        }

        .table thead th {
            background: rgba(198, 224, 115, 0.2);
            color: #FFFFFF;
            border-color: rgba(255, 255, 255, 0.2);
        }

        .table tbody td {
            background: rgba(0, 0, 0, 0.4);
            border-color: rgba(255, 255, 255, 0.2);
        }

        .badge {
            padding: 8px 12px;
            font-size: 14px;
            border-radius: 20px;
        }

        .badge.bg-success { background: rgba(198, 224, 115, 0.8); }
        .badge.bg-danger { background: rgba(255, 0, 0, 0.8); }

        .btn {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: bold;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-primary:hover,
        .btn-warning:hover,
        .btn-danger:hover,
        .btn-success:hover,
        .btn-secondary:hover {
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
    <script>
        function confirmDelete(bookingId) {
            if (confirm("Are you sure you want to delete this booking?")) {
                window.location.href = "BookingController?action=delete&id=" + bookingId;
            }
        }

        function updateBookingStatus(bookingId, status) {
            if (confirm("Are you sure you want to " + status + " this booking?")) {
                window.location.href = "BookingController?action=" + status + "&id=" + bookingId;
            }
        }
    </script>
</head>
<body class="container mt-4">

    <h2 class="mb-3 text-center">Manage Bookings</h2>

    <% List<Booking> bookings = (List<Booking>) request.getAttribute("bookings"); %>

    <% if (bookings != null && !bookings.isEmpty()) { %>
        <div class="table-container">
            <div class="table-responsive">
                <table class="table table-striped table-bordered text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>User Email</th>
                            <th>Pickup</th>
                            <th>Destination</th>
                            <th>Ride Time</th>
                            <th>Fare</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Booking booking : bookings) { %>
                            <tr>
                                <td><%= booking.getId() %></td>
                                <td><%= booking.getUserEmail() %></td>
                                <td><%= booking.getPickup() %></td>
                                <td><%= booking.getDestination() %></td>
                                <td><%= booking.getRideTime() %></td>
                                <td>LKR <%= booking.getFare() %></td>
                                <td>
                                    <span class="badge <%= booking.getStatus().equals("Confirmed") ? "bg-success" : "bg-danger" %>">
                                        <%= booking.getStatus() %>
                                    </span>
                                </td>
                                <td>
                                    <a href="BookingController?action=view&id=<%= booking.getId() %>" class="btn btn-sm btn-primary">View</a>
                                    <a href="BookingController?action=update&id=<%= booking.getId() %>" class="btn btn-sm btn-warning">Edit</a>
                                    <button onclick="confirmDelete(<%= booking.getId() %>)" class="btn btn-sm btn-danger">Delete</button>
                                    <button onclick="updateBookingStatus(<%= booking.getId() %>, 'confirm')" 
                                            class="btn btn-sm btn-success <%= booking.getStatus().equals("Confirmed") ? "disabled" : "" %>">
                                            Confirm
                                    </button>
                                    <button onclick="updateBookingStatus(<%= booking.getId() %>, 'cancel')" 
                                            class="btn btn-sm btn-danger <%= booking.getStatus().equals("Cancelled") ? "disabled" : "" %>">
                                            Cancel
                                    </button>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    <% } else { %>
        <div class="alert alert-warning text-center">No bookings found.</div>
    <% } %>

    <div class="text-center mt-3">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

</body>
</html>
