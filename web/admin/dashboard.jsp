<%@ page session="true" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionAdmin = request.getSession(false);
    if (sessionAdmin == null || sessionAdmin.getAttribute("admin") == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }

    Integer totalBookings = (Integer) sessionAdmin.getAttribute("totalBookings");
    Integer totalCustomers = (Integer) sessionAdmin.getAttribute("totalCustomers");
    Integer totalVehicles = (Integer) sessionAdmin.getAttribute("totalVehicles");
    Integer totalPayments = (Integer) sessionAdmin.getAttribute("totalPayments");
    Integer totalReports = (Integer) sessionAdmin.getAttribute("totalReports");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Mega City Cab</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background-image: url('https://deltataxi.com/wp-content/uploads/2021/03/LADNER-BUS-LOOP-WEBSITE-PHOTO.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: #C6E073;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            min-height: 100vh;
        }

        /* Header */
        .header {
            width: 100%;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(10px);
            font-size: 28px;
            font-weight: bold;
            box-shadow: 0 4px 10px rgba(198, 224, 115, 0.3);
            text-align: center;
            color: #C6E073;
            animation: fadeIn 1.5s ease-in-out;
        }

        .header h1 {
            margin: 0;
            font-size: 32px;
            color: #C6E073;
        }

        /* Dashboard Container */
        .dashboard-container {
            display: flex;
            gap: 30px;
            padding: 40px;
            flex-wrap: wrap;
            justify-content: center;
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Cards */
        .card {
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(12px);
            border-radius: 15px;
            border: 1px solid rgba(198, 224, 115, 0.3);
            box-shadow: 0 4px 15px rgba(198, 224, 115, 0.3);
            text-align: center;
            padding: 30px;
            width: 250px;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s;
            margin-bottom: 20px;
            animation: slideIn 0.5s ease-in-out;
        }

        .card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 25px rgba(198, 224, 115, 0.6);
        }

        .card h2 {
            color: #C6E073;
            font-size: 22px;
            margin-bottom: 15px;
        }

        .card p {
            font-size: 40px;
            font-weight: bold;
            margin: 0;
            color: #FFFFFF;
        }

        .card a {
            display: block;
            margin-top: 12px;
            color: #C6E073;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .card a:hover {
            color: #FFFFFF;
            text-decoration: underline;
        }

        /* Logout Button */
        .logout-btn {
            background-color: rgba(198, 224, 115, 0.2);
            color: #C6E073;
            border: 1px solid #C6E073;
            border-radius: 20px;
            padding: 12px 25px;
            cursor: pointer;
            font-size: 16px;
            box-shadow: 0 4px 10px rgba(198, 224, 115, 0.3);
            transition: background 0.3s ease, transform 0.2s, box-shadow 0.3s;
            text-align: center;
            animation: glow 2s infinite alternate;
        }

        .logout-btn:hover {
            background-color: rgba(198, 224, 115, 0.4);
            transform: scale(1.1);
            box-shadow: 0 6px 15px rgba(198, 224, 115, 0.6);
        }

        /* Footer */
        .footer {
            width: 100%;
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(10px);
            text-align: center;
            color: #C6E073;
            font-size: 14px;
            margin-top: auto;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes glow {
            0% { box-shadow: 0 0 10px rgba(198, 224, 115, 0.3); }
            100% { box-shadow: 0 0 20px rgba(198, 224, 115, 0.6); }
        }
    </style>
</head>
<body>
    <header class="header">
        <h1>Mega City Cab - Admin Dashboard</h1>
    </header>

    <main class="dashboard-container">
        <!-- Total Bookings Card -->
        <div class="card">
            <h2>Total Bookings</h2>
            <p><%= totalBookings != null ? totalBookings : 0 %></p>
            <a href="manageBookings.jsp">Manage Bookings</a>
        </div>

        <!-- Total Customers Card -->
        <div class="card">
            <h2>Total Customers</h2>
            <p><%= totalCustomers != null ? totalCustomers : 0 %></p>
            <a href="manageUsers.jsp">Manage Customers</a>
        </div>

        <!-- Total Vehicles Card -->
        <div class="card">
            <h2>Total Vehicles</h2>
            <p><%= totalVehicles != null ? totalVehicles : 0 %></p>
            <a href="manageVehicles.jsp">Manage Vehicles</a>
        </div>

        <!-- Total Payments Card -->
        <div class="card">
            <h2>Total Payments</h2>
            <p><%= totalPayments != null ? totalPayments : 37000 %></p>
            <a href="managePayments.jsp">Manage Payments</a>
        </div>

        
    </main>

    <footer class="footer">
        <a href="adminlogout.jsp">
            <button type="button" class="logout-btn">Logout</button>
        </a>
        <p>&copy; 2023 Mega City Cab. All rights reserved.</p>
    </footer>

    <script>
        // JavaScript for additional interactivity
        const cards = document.querySelectorAll('.card');
        cards.forEach(card => {
            card.addEventListener('mouseenter', () => {
                card.style.transform = 'scale(1.05)';
                card.style.boxShadow = '0 6px 25px rgba(198, 224, 115, 0.6)';
            });
            card.addEventListener('mouseleave', () => {
                card.style.transform = 'scale(1)';
                card.style.boxShadow = '0 4px 15px rgba(198, 224, 115, 0.3)';
            });
        });

        const logoutBtn = document.querySelector('.logout-btn');
        logoutBtn.addEventListener('mouseenter', () => {
            logoutBtn.style.boxShadow = '0 0 20px rgba(198, 224, 115, 0.6)';
        });
        logoutBtn.addEventListener('mouseleave', () => {
            logoutBtn.style.boxShadow = '0 0 10px rgba(198, 224, 115, 0.3)';
        });
    </script>
</body>
</html>