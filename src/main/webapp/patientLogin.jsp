<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Patient Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="card shadow p-4">

<h3 class="text-center mb-4">Patient Login</h3>

<% if(request.getParameter("error") != null){ %>
<div class="alert alert-danger">
Invalid Email or Password!
</div>
<% } %>

<% if(request.getParameter("reset") != null){ %>
<div class="alert alert-success">
Password Updated Successfully. Login Now.
</div>
<% } %>

<form action="<%=request.getContextPath()%>/PatientLoginServlet" method="post">

<input type="email"
name="email"
class="form-control mb-3"
placeholder="Email"
required>

<input type="password"
name="password"
class="form-control mb-3"
placeholder="Password"
required>

<button type="submit"
class="btn btn-primary w-100">
Login
</button>

</form>

<div class="text-center mt-3">

<a href="forgotPassword.jsp">
Forgot Password?
</a>

<br><br>

<a href="patientRegister.jsp">
New Patient? Register
</a>

</div>

</div>

</div>

</body>
</html>
