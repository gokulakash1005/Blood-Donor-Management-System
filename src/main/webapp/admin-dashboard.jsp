<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bdms.Donor" %>
<%@ page import="com.bdms.Request" %>
<%
    ArrayList<Donor> donors = (ArrayList<Donor>) request.getAttribute("donors");
    ArrayList<Request> requests = (ArrayList<Request>) request.getAttribute("requests");
%>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="card wide">
    <h2>Admin Dashboard</h2>

    <p>
        Total donors: <b><%= request.getAttribute("totalDonors") %></b> |
        Available: <b><%= request.getAttribute("totalAvailable") %></b> |
        Pending requests: <b><%= request.getAttribute("totalRequests") %></b>
    </p>

    <h3>Donors</h3>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Email</th><th>Phone</th>
            <th>Blood</th><th>City</th><th>Available</th><th>Verified</th><th>Action</th>
        </tr>
        <%
            for (Donor d : donors) {
        %>
        <tr>
            <td><%= d.id %></td>
            <td><%= d.name %></td>
            <td><%= d.email %></td>
            <td><%= d.phone %></td>
            <td><%= d.bloodGroup %></td>
            <td><%= d.city %></td>
            <td><%= d.status %></td>
            <td><%= d.verified == 1 ? "YES" : "NO" %></td>
            <td>
                <a href="admin?action=verify&id=<%= d.id %>">Verify</a> |
                <a href="admin?action=delete&id=<%= d.id %>" onclick="return confirm('Delete this donor?')">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <h3>Blood Requests</h3>
    <table>
        <tr>
            <th>ID</th><th>Patient</th><th>Blood</th><th>Hospital</th><th>City</th><th>Status</th>
        </tr>
        <%
            for (Request r : requests) {
        %>
        <tr>
            <td><%= r.id %></td>
            <td><%= r.patient %></td>
            <td><%= r.bloodGroup %></td>
            <td><%= r.hospital %></td>
            <td><%= r.city %></td>
            <td><%= r.status %></td>
        </tr>
        <%
            }
        %>
    </table>

    <a class="btn grey" href="logout">Logout</a>
</div>

</body>
</html>
