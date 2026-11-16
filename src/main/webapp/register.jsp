<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String error = request.getParameter("error");
%>
<html>
<head>
    <title>Register as Donor</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="card">
    <h2>Register as Donor</h2>

    <% if (error != null) { %>
        <p class="msg error">Email already used or something went wrong</p>
    <% } %>

    <form action="register" method="post">
        <label>Name</label>
        <input type="text" name="name" required>

        <label>Email</label>
        <input type="text" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <label>Phone</label>
        <input type="text" name="phone" required>

        <label>Blood Group</label>
        <select name="bloodGroup">
            <option>O+</option>
            <option>O-</option>
            <option>A+</option>
            <option>A-</option>
            <option>B+</option>
            <option>B-</option>
            <option>AB+</option>
            <option>AB-</option>
        </select>

        <label>City</label>
        <input type="text" name="city" required>

        <button class="btn">Register</button>
    </form>

    <p class="small"><a href="login.jsp">Already have an account? Login</a></p>
</div>

</body>
</html>
