<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Patient Login | Aarogya Global Heart Hospital</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>
*{font-family:'Poppins',sans-serif}
body{
min-height:100vh;
background:linear-gradient(rgba(7,18,39,.70),rgba(7,18,39,.75)),
url('https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=1600&q=80') center/cover no-repeat;
overflow:hidden;
}
.glass{
background:rgba(255,255,255,.12);
backdrop-filter:blur(18px);
border:1px solid rgba(255,255,255,.2);
border-radius:25px;
box-shadow:0 20px 45px rgba(0,0,0,.35);
animation:fade .8s ease;
}
@keyframes fade{from{opacity:0;transform:translateY(30px)}to{opacity:1;transform:none}}
.float{
position:absolute;border-radius:50%;
background:rgba(255,255,255,.12);
animation:move 8s infinite alternate;
}
.f1{width:160px;height:160px;left:8%;top:8%}
.f2{width:90px;height:90px;right:10%;bottom:15%}
@keyframes move{to{transform:translateY(-40px) rotate(30deg)}}
.input-group-text{background:#fff}
</style>
</head>
<body class="flex items-center justify-center p-4">

<div class="float f1"></div><div class="float f2"></div>

<div class="container">
<div class="row justify-content-center align-items-center">

<div class="col-lg-6 d-none d-lg-block text-white">
<h1 class="display-4 fw-bold">Aarogya Global Heart Hospital</h1>
<p class="lead">Secure Patient Portal with modern healthcare experience.</p>
<ul class="list-unstyled fs-5">
<li><i class="fa-solid fa-circle-check text-info"></i> Book Appointments</li>
<li><i class="fa-solid fa-circle-check text-info"></i> Lab Reports</li>
<li><i class="fa-solid fa-circle-check text-info"></i> Billing</li>
<li><i class="fa-solid fa-circle-check text-info"></i> 24×7 Care</li>
</ul>
</div>

<div class="col-lg-5">
<div class="glass p-5 text-white">

<h2 class="text-center fw-bold mb-2">Welcome Back</h2>
<p class="text-center text-light mb-4">Patient Login</p>

<% if(request.getParameter("error")!=null){ %>
<div class="alert alert-danger">Invalid Email or Password.</div>
<% } %>

<% if(request.getParameter("reset")!=null){ %>
<div class="alert alert-success">Password updated successfully.</div>
<% } %>

<form action="<%=request.getContextPath()%>/PatientLoginServlet" method="post">

<div class="input-group mb-3">
<span class="input-group-text"><i class="fa fa-envelope"></i></span>
<input type="email" class="form-control" name="email" placeholder="Email Address" required>
</div>

<div class="input-group mb-4">
<span class="input-group-text"><i class="fa fa-lock"></i></span>
<input type="password" id="pwd" class="form-control" name="password" placeholder="Password" required>
<button class="btn btn-light" type="button" onclick="togglePwd()"><i id="eye" class="fa fa-eye"></i></button>
</div>

<button id="btn" class="btn btn-info w-100 fw-bold py-2" type="submit">
<i class="fa fa-right-to-bracket"></i> Login
</button>

</form>

<div class="text-center mt-4">
<a class="text-info text-decoration-none" href="forgotPassword.jsp">Forgot Password?</a><br><br>
<a class="btn btn-outline-light w-100" href="patientRegister.jsp">Create New Account</a>
</div>

</div>
</div>

</div>
</div>

<script>
function togglePwd(){
const p=document.getElementById("pwd");
const e=document.getElementById("eye");
if(p.type==="password"){p.type="text";e.className="fa fa-eye-slash";}
else{p.type="password";e.className="fa fa-eye";}
}
document.querySelector("form").addEventListener("submit",function(){
document.getElementById("btn").innerHTML='<span class="spinner-border spinner-border-sm"></span> Signing In...';
});
</script>

</body>
</html>
