<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Forgot Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="card shadow p-4">

<h2 class="text-center mb-4">
Forgot Password
</h2>

<% if(request.getParameter("notfound") != null){ %>

<div class="alert alert-danger">
Email Not Registered
</div>

<% } %>

<% if(request.getParameter("error") != null){ %>

<div class="alert alert-danger">
Something Went Wrong
</div>

<% } %>

<form action="ForgotPasswordServlet" method="post">

<input
type="email"
name="email"
class="form-control mb-3"
placeholder="Enter Registered Email"
required>

<button
class="btn btn-primary w-100">

Send OTP

</button>

</form>

<div class="text-center mt-3">

<a href="patientLogin.jsp">

Back To Login

</a>

</div>

</div>

</div>

</body>
</html>