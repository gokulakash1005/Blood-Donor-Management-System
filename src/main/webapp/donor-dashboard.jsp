<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.bdms.Donor" %>
<%
    Donor d = (Donor) request.getAttribute("donor");
%>
<html>
<head>
    <title>My Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="card">
    <h2>Welcome <%= d.name %></h2>

    <table>
        <tr><td>Email</td><td><%= d.email %></td></tr>
        <tr><td>Phone</td><td><%= d.phone %></td></tr>
        <tr><td>Blood Group</td><td><%= d.bloodGroup %></td></tr>
        <tr><td>City</td><td><%= d.city %></td></tr>
        <tr>
            <td>Available</td>
            <td>
                <% if ("YES".equals(d.status)) { %>
                    <span class="tag green">YES</span>
                <% } else { %>
                    <span class="tag red">NO</span>
                <% } %>
            </td>
        </tr>
        <tr>
            <td>Verified</td>
            <td>
                <% if (d.verified == 1) { %>
                    <span class="tag green">YES</span>
                <% } else { %>
                    <span class="tag red">NO</span>
                <% } %>
            </td>
        </tr>
    </table>

    <% if ("YES".equals(d.status)) { %>
        <a class="btn" href="donor?status=NO">Set not available</a>
    <% } else { %>
        <a class="btn" href="donor?status=YES">Set available</a>
    <% } %>

    <a class="btn grey" href="logout">Logout</a>
</div>

</body>
</html>
