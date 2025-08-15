<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout - MC_CAB</title>

    <!-- Bootstrap CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Custom Styles -->
    <style>
        /* Background Styling */
        body {
            background: url('https://media.bizj.us/view/img/2894371/1317192769431bdb5c0d9o*900xx5472-3084-0-104.jpg') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Poppins', sans-serif;
            margin: 0;
        }

        /* Dark Overlay for Background Image */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6); /* Dark overlay for better contrast */
            z-index: -1;
        }

        /* Logout Message Container */
        .logout-container {
            text-align: center;
            color: white;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            padding: 30px;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0px 8px 32px rgba(0, 0, 0, 0.5);
        }

        /* Logout Message */
        .logout-message {
            font-size: 1.5rem;
            font-weight: 600;
            color: #C6E073; /* Lighter Lime Green */
            margin-bottom: 20px;
        }

        /* Redirect Message */
        .redirect-message {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.8);
        }
    </style>
</head>
<body>
    <%
        HttpSession userSession = request.getSession(false);
        if (userSession != null) {
            userSession.invalidate(); // Destroy session
        }
    %>

    <div class="logout-container">
        <div class="logout-message">You have been logged out successfully.</div>
        <div class="redirect-message">Redirecting to the login page...</div>
    </div>

    <script>
        // Redirect to login page after 3 seconds
        setTimeout(function () {
            window.location.href = "login.jsp";
        }, 3000); // 3 seconds delay
    </script>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>