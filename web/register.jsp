<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Mega City Cab</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* Background Styling with Image */
        body {
            background: url('https://s.wsj.net/public/resources/images/NY-DB383_TAXI_GR_20140618163715.jpg') no-repeat center center/cover;
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

        /* Glassmorphism Form Container */
        .register-container {
            width: 100%;
            max-width: 450px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            padding: 30px;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0px 8px 32px rgba(0, 0, 0, 0.5);
            text-align: center;
            color: white;
        }

        /* Title */
        .register-container h2 {
            font-weight: 600;
            letter-spacing: 1px;
            color: #C6E073; /* Lighter Lime Green */
            margin-bottom: 20px;
        }

        /* Input Fields */
        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            box-shadow: 0 0 10px rgba(198, 224, 115, 0.5); /* Glowing effect */
            border: 1px solid #C6E073;
        }

        /* Register Button */
        .btn-register {
            background: #C6E073; /* Lighter Lime Green */
            color: #000000; /* Black text */
            padding: 12px;
            border-radius: 30px;
            font-weight: bold;
            border: none;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 10px;
        }

        .btn-register:hover {
            background: #A8C95B; /* Slightly darker green on hover */
            box-shadow: 0 0 15px rgba(198, 224, 115, 0.8); /* Glowing effect */
        }

        /* Login Link */
        .login-link {
            color: #C6E073; /* Lighter Lime Green */
            font-size: 14px;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .login-link:hover {
            color: #A8C95B; /* Slightly darker green on hover */
            text-decoration: underline;
        }

        /* Success & Error Messages */
        .message {
            margin-top: 15px;
            font-size: 14px;
            font-weight: bold;
        }

        /* Glowing Effect for Inputs and Button */
        .form-control:focus, .btn-register:hover {
            animation: glow 1.5s infinite alternate;
        }

        @keyframes glow {
            0% {
                box-shadow: 0 0 5px rgba(198, 224, 115, 0.5);
            }
            100% {
                box-shadow: 0 0 20px rgba(198, 224, 115, 0.8);
            }
        }
    </style>
</head>
<body>

    <div class="register-container">
        <h2>Create an Account</h2>

        <%-- Display dynamic success or error message --%>
        <% String message = request.getParameter("message"); %>
        <% if (message != null && !message.isEmpty()) { %>
            <p class="message" style="color: <%= message.equals("Registration successful!") ? "lightgreen" : "red" %>;">
                <%= message %>
            </p>
        <% } %>

        <form action="RegisterController" method="post">
            <div class="mb-3">
                <input type="text" id="fullname" name="fullname" class="form-control" placeholder="Full Name" required>
            </div>
            <div class="mb-3">
                <input type="email" id="email" name="email" class="form-control" placeholder="Email" required>
            </div>
            <div class="mb-3">
                <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
            </div>
            <div class="mb-3">
                <input type="tel" id="phone" name="phone" class="form-control" pattern="[0-9]{10,15}" required placeholder="Phone Number">
            </div>
            <button type="submit" class="btn btn-register">Register</button>
        </form>

        <p class="mt-3">
            Already have an account? <a href="login.jsp" class="login-link">Login here</a>
        </p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>