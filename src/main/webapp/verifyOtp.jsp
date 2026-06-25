<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Verify OTP</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
height:100vh;
display:flex;
justify-content:center;
align-items:center;
font-family:Segoe UI;
}

.card{
width:450px;
border-radius:15px;
padding:25px;
box-shadow:0 10px 25px rgba(0,0,0,0.3);
}

.otp-icon{
font-size:60px;
text-align:center;
}

</style>

</head>

<body>

<div class="card">

<div class="otp-icon">
📧
</div>

<h3 class="text-center mb-3">
Email Verification
</h3>

<p class="text-center text-muted">
Enter the OTP sent to your Email
</p>

<% if(request.getParameter("error") != null){ %>

<div class="alert alert-danger">
Invalid OTP. Please try again.
</div>

<% } %>

<form action="VerifyOtpServlet" method="post">

<input type="text"
name="otp"
class="form-control mb-3"
placeholder="Enter OTP"
required>

<button type="submit"
class="btn btn-primary w-100">
Verify OTP
</button>

</form>

</div>

</body>
</html>