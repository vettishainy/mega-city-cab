<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* General Styles */
        body {
            background: url('https://www.nydailynews.com/wp-content/uploads/migration/2019/05/26/MTOCNZ2SR5FJXLEOSUKMEAVEKY.jpg') no-repeat center center/cover;
            display: flex;
            height: 100vh;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Login Container */
        .login-container {
            width: 100%;
            max-width: 400px;
            background: rgba(0, 0, 0, 0.6); /* Semi-transparent black */
            backdrop-filter: blur(15px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.3);
            text-align: center;
            color: #FFFFFF; /* White text */
            border: 1px solid rgba(198, 224, 115, 0.3); /* Lighter Lime Green border */
            animation: fadeIn 1s ease-in-out;
        }

        .login-container h3 {
            font-weight: 600;
            letter-spacing: 1px;
            margin-bottom: 20px;
            color: #C6E073; /* Lighter Lime Green */
        }

        /* Form Inputs */
        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: none;
            color: #FFFFFF; /* White text */
            padding: 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            color: #FFFFFF; /* White text */
            box-shadow: 0 0 10px rgba(198, 224, 115, 0.5); /* Lighter Lime Green glow */
            border: 1px solid rgba(198, 224, 115, 0.5); /* Lighter Lime Green border */
        }

        /* Login Button */
        .btn-login {
            background: rgba(198, 224, 115, 0.2); /* Lighter Lime Green with transparency */
            color: #FFFFFF; /* White text */
            padding: 12px;
            border-radius: 30px;
            font-weight: bold;
            transition: all 0.3s ease;
            border: 1px solid rgba(198, 224, 115, 0.5); /* Lighter Lime Green border */
            width: 100%;
            margin-top: 20px;
            box-shadow: 0 4px 15px rgba(198, 224, 115, 0.4); /* Lighter Lime Green glow */
        }

        .btn-login:hover {
            background: rgba(198, 224, 115, 0.4); /* Lighter Lime Green with more opacity */
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(198, 224, 115, 0.6); /* Lighter Lime Green glow */
        }

        /* Error Message */
        .alert-danger {
            font-size: 14px;
            padding: 10px;
            background: rgba(255, 0, 0, 0.2);
            border: 1px solid rgba(255, 0, 0, 0.5);
            border-radius: 8px;
            margin-bottom: 20px;
            color: #FFFFFF; /* White text */
        }

        /* Forgot Password Link */
        .forgot-password {
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
            text-decoration: none;
            display: block;
            margin-top: 10px;
            transition: color 0.3s ease;
        }

        .forgot-password:hover {
            color: #C6E073; /* Lighter Lime Green */
            text-decoration: underline;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h3>Admin Login</h3>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger">Invalid email or password</div>
        <% } %>

        <form action="AdminController" method="post">
            <div class="mb-3">
                <input type="text" name="email" class="form-control" placeholder="Email" required>
            </div>
            <div class="mb-3">
                <input type="password" name="password" class="form-control" placeholder="Password" required>
            </div>
            <button type="submit" class="btn btn-login">Login</button>
            <a href="#" class="forgot-password">Forgot password?</a>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>