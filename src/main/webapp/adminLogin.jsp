<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
<div class="card shadow p-4">

<h3 class="text-center mb-4">Admin Login</h3>

<% if(request.getParameter("error") != null){ %>
<div class="alert alert-danger">Invalid Username or Password</div>
<% } %>

<form action="AdminLoginServlet" method="post">

<input type="text" name="username" class="form-control mb-3" placeholder="Username" required>
<input type="password" name="password" class="form-control mb-3" placeholder="Password" required>

<button type="submit" class="btn btn-primary w-100">Login</button>

</form>

</div>
</div>

</body>
</html>