<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Ride</title>
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            background: url('https://media.istockphoto.com/id/503243012/photo/green-five-borough-taxi-in-brooklyn-new-york.jpg?s=170667a&w=0&k=20&c=bdiHBJVGR164ec0VSrMTHLb3kMdE2gHGLMaDrrhDAQI=') no-repeat center center/cover;
            font-family: 'Arial', sans-serif;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            background: rgba(0, 0, 0, 0.6);
            border-radius: 15px;
            padding: 40px;
            max-width: 450px;
            color: white;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }
        .btn {
            width: 100%;
            padding: 12px;
            font-size: 1.1rem;
            border-radius: 25px;
            border: none;
            transition: 0.3s;
        }
        .btn-primary {
            background-color: #C6E073;
            color: black;
            box-shadow: 0 0 10px rgba(198, 224, 115, 0.7);
        }
        .btn-primary:hover {
            background-color: #A8D86B;
            box-shadow: 0 0 20px rgba(198, 224, 115, 1);
        }
        .btn-confirm {
            background-color: #007BFF;
            color: white;
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.7);
        }
        .btn-confirm:hover {
            background-color: #0056b3;
            box-shadow: 0 0 20px rgba(0, 123, 255, 1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        input, select {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid #fff;
            padding: 12px;
            border-radius: 10px;
            width: 100%;
        }
        input::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        label {
            font-weight: bold;
        }
        h3 {
            margin-bottom: 20px;
            font-size: 24px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h3 class="text-center">Book a Ride</h3>
        <form action="../admin/BookingController" method="post" id="bookingForm">
            <input type="hidden" name="action" value="bookRide">

            <!-- Pickup Location -->
            <div class="form-group">
                <label for="pickup">Pickup Location:</label>
                <input type="text" id="pickup" name="pickup" placeholder="Enter pickup location" required>
            </div>

            <!-- Destination -->
            <div class="form-group">
                <label for="destination">Destination:</label>
                <input type="text" id="destination" name="destination" placeholder="Enter destination" required>
            </div>

            <!-- Pickup Time -->
            <div class="form-group">
                <label for="rideTime">Pickup Time:</label>
                <input type="datetime-local" id="rideTime" name="rideTime" required>
            </div>

            <!-- Vehicle Model (Populated from request attribute) -->
            <div class="form-group">
                <label for="vehicleModel">Selected Vehicle:</label>
                <input type="text" id="vehicleModel" name="vehicleModel" readonly value="<%= request.getAttribute("vehicleModel") != null ? request.getAttribute("vehicleModel") : "" %>">
            </div>

            <!-- Select Vehicle Button -->
            <button type="button" class="btn btn-primary" id="selectVehicle">Select Vehicle</button>
            <input type="hidden" id="selectedVehicleId" name="vehicleId" value="<%= request.getAttribute("vehicleId") != null ? request.getAttribute("vehicleId") : "" %>">

            <!-- Estimated Fare -->
            <div class="form-group">
                <label for="fare">Estimated Fare (LKR):</label>
                <input type="text" id="fare" name="fare" readonly value="<%= request.getAttribute("fare") != null ? request.getAttribute("fare") : "" %>">
            </div>

            <!-- Confirm Booking Button -->
            <button type="submit" class="btn btn-confirm mt-3" id="confirmBooking" disabled>Confirm Booking</button>
            <button type="button" class="btn btn-danger mt-3" id="cancelBooking">Cancel Booking</button>
        </form>
    </div>

    <script>
        // Function to be called after vehicle selection
        function updateBookingDetails(vehicleModel, fare, vehicleId) {
            document.getElementById("vehicleModel").value = vehicleModel;
            document.getElementById("fare").value = fare;
            document.getElementById("selectedVehicleId").value = vehicleId;
            document.getElementById("confirmBooking").disabled = false;  // Enable confirm button
        }

        // Redirect to vehicle selection page
        document.getElementById("selectVehicle").addEventListener("click", function () {
            window.location.href = "http://localhost:8080/MC_CAB/customer/vehicles.jsp";
        });
    </script>
</body>
</html>
