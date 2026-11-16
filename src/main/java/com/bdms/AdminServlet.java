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
import java.util.ArrayList;

// admin page with all the donors and requests
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        String admin = (String) session.getAttribute("admin");

        if (admin == null) {
            res.sendRedirect("admin-login.jsp");
            return;
        }

        String action = req.getParameter("action");
        String id = req.getParameter("id");

        try (Connection con = DB.getConnection()) {

            // delete a donor
            if ("delete".equals(action) && id != null) {
                PreparedStatement ps = con.prepareStatement("delete from donors where id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
            }

            // verify or unverify a donor
            if ("verify".equals(action) && id != null) {
                PreparedStatement ps = con.prepareStatement("update donors set verified = 1 - verified where id=?");
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
            }

            // small counts for the top of the page
            PreparedStatement total = con.prepareStatement("select count(*) from donors");
            ResultSet rs1 = total.executeQuery();
            rs1.next();
            req.setAttribute("totalDonors", rs1.getInt(1));

            PreparedStatement avail = con.prepareStatement("select count(*) from donors where available='YES'");
            ResultSet rs2 = avail.executeQuery();
            rs2.next();
            req.setAttribute("totalAvailable", rs2.getInt(1));

            PreparedStatement reqs = con.prepareStatement("select count(*) from requests where status='PENDING'");
            ResultSet rs3 = reqs.executeQuery();
            rs3.next();
            req.setAttribute("totalRequests", rs3.getInt(1));

            // all donors
            ArrayList<Donor> donors = new ArrayList<Donor>();
            PreparedStatement ps = con.prepareStatement("select * from donors order by id");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Donor d = new Donor();
                d.id = rs.getInt("id");
                d.name = rs.getString("name");
                d.email = rs.getString("email");
                d.phone = rs.getString("phone");
                d.bloodGroup = rs.getString("blood_group");
                d.city = rs.getString("city");
                d.status = rs.getString("available");
                d.verified = rs.getInt("verified");
                donors.add(d);
            }
            req.setAttribute("donors", donors);

            // all requests
            ArrayList<Request> requests = new ArrayList<Request>();
            PreparedStatement ps2 = con.prepareStatement("select * from requests order by id");
            ResultSet rs4 = ps2.executeQuery();
            while (rs4.next()) {
                Request r = new Request();
                r.id = rs4.getInt("id");
                r.patient = rs4.getString("patient");
                r.bloodGroup = rs4.getString("blood_group");
                r.hospital = rs4.getString("hospital");
                r.city = rs4.getString("city");
                r.status = rs4.getString("status");
                requests.add(r);
            }
            req.setAttribute("requests", requests);

            req.getRequestDispatcher("admin-dashboard.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("admin-login.jsp");
        }
    }
}
