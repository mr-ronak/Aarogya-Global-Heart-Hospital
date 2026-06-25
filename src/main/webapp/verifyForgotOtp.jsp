<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Verify OTP</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body style="background:#f4f6f9;">

<div class="container mt-5">

<div class="card shadow p-4">

<h2 class="text-center mb-4">

Verify OTP

</h2>

<% if(request.getParameter("error") != null){ %>

<div class="alert alert-danger">

Invalid OTP

</div>

<% } %>

<form action="VerifyForgotOtpServlet"
method="post">

<input
type="text"
name="otp"
class="form-control mb-3"
placeholder="Enter OTP"
required>

<button
class="btn btn-success w-100">

Verify OTP

</button>

</form>

</div>

</div>

</body>
</html>