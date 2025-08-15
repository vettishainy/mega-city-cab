<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    // Check if user is logged in
    String userEmail = (String) session.getAttribute("userEmail");

    if (userEmail == null) {
        // Redirect to login page if user is not logged in
        response.sendRedirect("../auth/login.jsp");
        return;
    }

    // Retrieve booking details from request parameters
    String bookingId = request.getParameter("bookingId");
    String amount = request.getParameter("amount");

    // Check if the booking ID or amount is missing
    if (bookingId == null || amount == null) {
        out.println("<p style='color: red;'>Error: Missing payment details. Please try again.</p>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment for Booking</title>
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<body>
    <div class="payment-container">
        <h2>Payment for Booking ID: <%= bookingId %></h2>
        <p>Amount Due: <strong>$<%= amount %></strong></p>

        <h3>Payment Method: Cash</h3>
        <p>Please pay the amount in cash after completing the ride.</p>

        <div class="buttons">
            <a href="dashboard.jsp" class="btn-back">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
