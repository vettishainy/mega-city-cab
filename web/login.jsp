<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        /* Background Styling with Image */
        body {
            background: url('https://newyorkdearest.com/wp-content/uploads/2021/09/green-cabs-NYC-03539.jpg') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Poppins', sans-serif;
            margin: 0;
        }

        /* Overlay to darken the background image */
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

        /* Glassmorphism Card */
        .login-container {
            width: 100%;
            max-width: 400px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            padding: 30px;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0px 8px 32px rgba(0, 0, 0, 0.5);
            text-align: center;
            color: #ffffff;
        }

        /* Title */
        .login-container h2 {
            font-weight: 600;
            letter-spacing: 1px;
            color: #C6E073;
            margin-bottom: 20px;
        }

        /* Input Fields */
        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #ffffff;
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
            color: #ffffff;
            box-shadow: 0 0 10px rgba(198, 224, 115, 0.5);
            border: 1px solid #C6E073;
        }

        /* Login Button */
        .btn-login {
            background: #C6E073;
            color: #000000;
            padding: 12px;
            border-radius: 30px;
            font-weight: bold;
            border: none;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 10px;
        }

        .btn-login:hover {
            background: #A8C95B;
            box-shadow: 0 0 15px rgba(198, 224, 115, 0.8);
        }

        /* Register Link */
        .register-link {
            color: #C6E073;
            font-size: 14px;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .register-link:hover {
            color: #A8C95B;
            text-decoration: underline;
        }

        /* Error Message */
        .error-message {
            color: #ff4d4d;
            font-size: 14px;
            margin-top: 10px;
        }

        /* Glowing Effect for Inputs and Button */
        .form-control:focus, .btn-login:hover {
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

    <div class="login-container">
        <h2>Login</h2>

        <%-- Display error message if login fails --%>
        <% String loginError = request.getParameter("error"); 
           if (loginError != null && loginError.equals("invalid")) { %>
            <div class="error-message">Invalid email or password. Try again.</div>
        <% } %>

        <form action="LoginController" method="post">
            <div class="mb-3">
                <input type="email" id="email" name="email" class="form-control" placeholder="Email" required>
            </div>
            <div class="mb-3">
                <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
            </div>
            <button type="submit" class="btn btn-login">Login</button>
        </form>

        <p class="mt-3">
            Don't have an account? <a href="register.jsp" class="register-link">Register</a>
        </p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>