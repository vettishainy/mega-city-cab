<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.mc_cab.model.Booking" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Retrieve the session (avoid duplicate declarations)
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("bookingDetails") == null) {
        response.sendRedirect("bookCab.jsp?error=No booking found");
        return;
    }
    
    // Assuming bookingDetails is a List<Booking>
    List<Booking> bookingList = (List<Booking>) session.getAttribute("bookingDetails");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking History</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <h2>Your Booking History</h2>
    
    <c:if test="${empty bookingList}">
        <div class="alert alert-warning">No bookings found.</div>
    </c:if>
    
    <c:if test="${not empty bookingList}">
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>User Email</th>
                    <th>Pickup</th>
                    <th>Destination</th>
                    <th>Ride Time</th>
                    <th>Fare</th>
                    <th>Status</th>
                    <th>Updated At</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="booking" items="${bookingList}">
                    <tr>
                        <td>${booking.id}</td>
                        <td>${booking.userEmail}</td>
                        <td>${booking.pickup}</td>
                        <td>${booking.destination}</td>
                        <td>${booking.rideTime}</td>
                        <td>$${booking.fare}</td>
                        <td>${booking.status}</td>
                        <td>${booking.updatedAt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    
    <a href="bookCab.jsp" class="btn btn-primary">Book Another Ride</a>
</body>
</html>
