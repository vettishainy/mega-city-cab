package com.mc_cab.admin;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/AdminController")
public class AdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Hardcoded admin credentials
    private static final String ADMIN_EMAIL = "admin123@gmail.com";
    private static final String ADMIN_PASSWORD = "admin123";

    // Mocked data for demonstration (Replace with DB queries in future)
    private static final int MOCK_TOTAL_BOOKINGS = 120;
    private static final int MOCK_TOTAL_CUSTOMERS = 85;
    private static final int MOCK_TOTAL_VEHICLES = 50;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null) {
            response.sendRedirect("adminlogin.jsp?error=Missing credentials");
            return;
        }

        if (email.equals(ADMIN_EMAIL) && password.equals(ADMIN_PASSWORD)) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", "true");

            // Mock data — replace with DB data
            session.setAttribute("totalBookings", MOCK_TOTAL_BOOKINGS);
            session.setAttribute("totalCustomers", MOCK_TOTAL_CUSTOMERS);
            session.setAttribute("totalVehicles", MOCK_TOTAL_VEHICLES);

            response.sendRedirect("dashboard.jsp"); // Redirect to dashboard
        } else {
            response.sendRedirect("adminlogin.jsp?error=Invalid credentials");
        }
    }
}
