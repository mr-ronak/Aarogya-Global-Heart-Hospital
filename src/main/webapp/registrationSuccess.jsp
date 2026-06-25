<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Registration Success</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
background:#f4f6f9;
height:100vh;
display:flex;
justify-content:center;
align-items:center;
font-family:Segoe UI;
}

.card{
width:500px;
padding:30px;
border-radius:15px;
text-align:center;
box-shadow:0 10px 20px rgba(0,0,0,0.15);
}

.success{
font-size:70px;
}

</style>

</head>

<body>

<div class="card">

<div class="success">
✅
</div>

<h2 class="text-success">
Registration Successful
</h2>

<p class="mt-3">
Your account has been verified successfully.
</p>

<a href="patientLogin.jsp"
class="btn btn-success mt-3">
Login Now
</a>

</div>

</body>
</html>