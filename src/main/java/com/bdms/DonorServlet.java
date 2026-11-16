package com.bdms;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// shows the donor home page and changes the availability
@WebServlet("/donor")
public class DonorServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Integer donorId = (Integer) session.getAttribute("donorId");

        // if not logged in go back to the login page
        if (donorId == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        try (Connection con = DB.getConnection()) {

            // this runs when the donor clicks the availability button
            String status = req.getParameter("status");
            if (status != null) {
                PreparedStatement up = con.prepareStatement("update donors set available=? where id=?");
                up.setString(1, status);
                up.setInt(2, donorId);
                up.executeUpdate();
            }

            PreparedStatement ps = con.prepareStatement("select * from donors where id=?");
            ps.setInt(1, donorId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Donor d = new Donor();
                d.id = rs.getInt("id");
                d.name = rs.getString("name");
                d.email = rs.getString("email");
                d.phone = rs.getString("phone");
                d.bloodGroup = rs.getString("blood_group");
                d.city = rs.getString("city");
                d.status = rs.getString("available");
                d.verified = rs.getInt("verified");
                req.setAttribute("donor", d);
            }

            req.getRequestDispatcher("donor-dashboard.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("login.jsp");
        }
    }
}
