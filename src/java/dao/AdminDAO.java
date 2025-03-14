package dao;

import model.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {
    private Connection conn;

    public AdminDAO(Connection conn) {
        this.conn = conn;
    }

    public Admin getAdminByEmail(String email) {
    Admin admin = null;
    String sql = "SELECT * FROM admin WHERE email = ?";

    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            System.out.println("Admin Found: " + rs.getString("email")); // Debug
            admin = new Admin();
            admin.setFullname(rs.getString("fullname"));
            admin.setEmail(rs.getString("email"));
            admin.setPassword(rs.getString("password"));  
        } else {
            System.out.println("Admin Not Found in DB"); // Debug
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return admin;
}
}