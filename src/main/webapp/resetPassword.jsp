<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Reset Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="card shadow p-4">

<h2 class="text-center mb-4">

Reset Password

</h2>

<% if(request.getParameter("error") != null){ %>

<div class="alert alert-danger">

Password Update Failed

</div>

<% } %>

<form action="ResetPasswordServlet"
method="post">

<input
type="password"
name="password"
class="form-control mb-3"
placeholder="New Password"
required>

<input
type="password"
name="confirmPassword"
class="form-control mb-3"
placeholder="Confirm Password"
required>

<button
class="btn btn-primary w-100">

Update Password

</button>

</form>

</div>

</div>

</body>
</html>