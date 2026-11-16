package com.bdms;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

// saves a new donor in the database
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String bloodGroup = req.getParameter("bloodGroup");
        String city = req.getParameter("city");

        try (Connection con = DB.getConnection()) {

            String sql = "insert into donors (name, email, password, phone, blood_group, city, available, verified) values (?,?,?,?,?,?,'YES',0)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.setString(5, bloodGroup);
            ps.setString(6, city);
            ps.executeUpdate();

            res.sendRedirect("login.jsp?done=1");

        } catch (Exception e) {
            // this is mostly for a duplicate email
            e.printStackTrace();
            res.sendRedirect("register.jsp?error=1");
        }
    }
}
