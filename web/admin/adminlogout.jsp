<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page language="java" import="jakarta.servlet.http.*, jakarta.servlet.*" %>

<%
    // Destroy session
    if (session != null) {
        session.invalidate();
    }

    // Redirect to the correct admin login page
    response.sendRedirect(request.getContextPath() + "/admin/adminlogin.jsp?message=logout_success");
%>
