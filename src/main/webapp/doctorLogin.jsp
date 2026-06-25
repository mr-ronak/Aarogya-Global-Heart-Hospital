<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>Doctor Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
margin:0;
padding:0;
height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
font-family:'Segoe UI';
}

.login-card{

width:420px;

background:white;

padding:40px;

border-radius:15px;

box-shadow:0 15px 35px rgba(0,0,0,0.3);

}

.title{

text-align:center;
font-size:30px;
font-weight:bold;
margin-bottom:30px;

}

</style>

</head>

<body>

<div class="login-card">

<div class="title">
Doctor Login
</div>

<%
if(request.getParameter("error")!=null){
%>

<div class="alert alert-danger">

Invalid Email or Password

</div>

<%
}
%>

<form action="DoctorLoginServlet" method="post">

<div class="mb-3">

<label>Email</label>

<input type="email"
name="email"
class="form-control"
required>

</div>

<div class="mb-3">

<label>Password</label>

<input type="password"
name="password"
class="form-control"
required>

</div>

<button type="submit"
class="btn btn-primary w-100">

Login

</button>

</form>

</div>

</body>
</html>
