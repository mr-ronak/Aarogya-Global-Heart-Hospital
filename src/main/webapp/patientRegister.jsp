<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Patient Registration</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-5">
<div class="card shadow p-4">
<h3 class="text-center mb-4">Patient Registration</h3>

<% if(request.getParameter("error") != null){ %>
<div class="alert alert-danger">Registration Failed!</div>
<% } %>

<form action="<%=request.getContextPath()%>/PatientRegisterServlet" method="post">

<input type="text" name="name" class="form-control mb-3" placeholder="Full Name" required>

<input type="number" name="age" class="form-control mb-3" placeholder="Age" required>

<select name="gender" class="form-control mb-3">
<option value="Male">Male</option>
<option value="Female">Female</option>
<option value="Other">Other</option>
</select>

<input type="text" name="contact" class="form-control mb-3" placeholder="Contact Number" required>

<input type="email" name="email" class="form-control mb-3" placeholder="Email" required>

<input type="password" name="password" class="form-control mb-3" placeholder="Password" required>

<button type="submit" class="btn btn-primary w-100">Register</button>

</form>

<div class="text-center mt-3">
<a href="patientLogin.jsp">Already have account? Login</a>
</div>

</div>
</div>

</body>
</html>