<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String error = request.getParameter("error");
    String done = request.getParameter("done");
%>
<html>
<head>
    <title>Donor Login</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="card">
    <h2>Donor Login</h2>

    <% if (error != null) { %>
        <p class="msg error">Wrong email or password</p>
    <% } %>

    <% if (done != null) { %>
        <p class="msg ok">Registration done, please login</p>
    <% } %>

    <form action="login" method="post">
        <label>Email</label>
        <input type="text" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button class="btn">Login</button>
    </form>

    <p class="small">New here? <a href="register.jsp">Create an account</a></p>
    <p class="small">Demo account: rahul@gmail.com / 123456</p>
</div>

</body>
</html>
