<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String error = request.getParameter("error");
%>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="card">
    <h2>Admin Login</h2>

    <% if (error != null) { %>
        <p class="msg error">Wrong username or password</p>
    <% } %>

    <form action="adminLogin" method="post">
        <label>Username</label>
        <input type="text" name="username" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button class="btn">Login</button>
    </form>

    <p class="small">Demo admin: admin / admin123</p>
</div>

</body>
</html>
