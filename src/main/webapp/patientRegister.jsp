<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Patient Registration | Aarogya Global Heart Hospital</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>
*{font-family:'Poppins',sans-serif}
body{
min-height:100vh;
background:linear-gradient(rgba(4,25,55,.75),rgba(4,25,55,.78)),
url('https://images.unsplash.com/photo-1586773860418-d37222d8fce3?auto=format&fit=crop&w=1600&q=80') center/cover no-repeat;
}
.glass{
background:rgba(255,255,255,.13);
backdrop-filter:blur(18px);
border-radius:25px;
border:1px solid rgba(255,255,255,.2);
box-shadow:0 20px 40px rgba(0,0,0,.35);
animation:fade .8s ease;
}
@keyframes fade{from{opacity:0;transform:translateY(25px)}to{opacity:1;transform:none}}
.input-group-text{background:#fff}
.float{position:absolute;border-radius:50%;background:rgba(255,255,255,.12);animation:f 7s infinite alternate}
.a{width:140px;height:140px;left:8%;top:10%}
.b{width:90px;height:90px;right:8%;bottom:10%}
@keyframes f{to{transform:translateY(-35px) rotate(25deg)}}
</style>
</head>
<body class="d-flex align-items-center justify-content-center p-3">

<div class="float a"></div><div class="float b"></div>

<div class="container">
<div class="row justify-content-center align-items-center">

<div class="col-lg-6 d-none d-lg-block text-white pe-5">
<h1 class="display-4 fw-bold">Join Aarogya Global Heart Hospital</h1>
<p class="lead">Create your patient account to manage appointments, reports, bills and healthcare records securely.</p>
<div class="mt-4">
<p><i class="fa-solid fa-heart-pulse text-info"></i> Cardiology Specialists</p>
<p><i class="fa-solid fa-user-doctor text-info"></i> Experienced Doctors</p>
<p><i class="fa-solid fa-shield-heart text-info"></i> Secure Patient Portal</p>
</div>
</div>

<div class="col-lg-6">
<div class="glass p-5 text-white">

<h2 class="fw-bold text-center">Patient Registration</h2>
<p class="text-center mb-4">Create your healthcare account</p>

<% if(request.getParameter("error") != null){ %>
<div class="alert alert-danger">Registration failed. Please try again.</div>
<% } %>

<form action="<%=request.getContextPath()%>/PatientRegisterServlet" method="post">

<div class="row">
<div class="col-md-6 mb-3">
<div class="input-group">
<span class="input-group-text"><i class="fa fa-user"></i></span>
<input type="text" name="name" class="form-control" placeholder="Full Name" required>
</div>
</div>

<div class="col-md-6 mb-3">
<div class="input-group">
<span class="input-group-text"><i class="fa fa-calendar"></i></span>
<input type="number" min="1" max="120" name="age" class="form-control" placeholder="Age" required>
</div>
</div>
</div>

<div class="mb-3">
<select name="gender" class="form-select" required>
<option value="">Select Gender</option>
<option>Male</option>
<option>Female</option>
<option>Other</option>
</select>
</div>

<div class="mb-3">
<div class="input-group">
<span class="input-group-text"><i class="fa fa-phone"></i></span>
<input type="text" name="contact" class="form-control" placeholder="Mobile Number" required>
</div>
</div>

<div class="mb-3">
<div class="input-group">
<span class="input-group-text"><i class="fa fa-envelope"></i></span>
<input type="email" name="email" class="form-control" placeholder="Email Address" required>
</div>
</div>

<div class="mb-4">
<div class="input-group">
<span class="input-group-text"><i class="fa fa-lock"></i></span>
<input type="password" id="pwd" name="password" class="form-control" placeholder="Create Password" required>
<button class="btn btn-light" type="button" onclick="togglePwd()"><i id="eye" class="fa fa-eye"></i></button>
</div>
</div>

<button id="btn" class="btn btn-info w-100 fw-bold py-2">
<i class="fa fa-user-plus"></i> Register Now
</button>

</form>

<div class="text-center mt-4">
Already have an account?<br>
<a href="patientLogin.jsp" class="btn btn-outline-light mt-2 w-100">Login Here</a>
</div>

</div>
</div>

</div>
</div>

<script>
function togglePwd(){
const p=document.getElementById('pwd');
const e=document.getElementById('eye');
if(p.type==='password'){p.type='text';e.className='fa fa-eye-slash';}
else{p.type='password';e.className='fa fa-eye';}
}
document.querySelector("form").addEventListener("submit",function(){
document.getElementById("btn").innerHTML='<span class="spinner-border spinner-border-sm"></span> Creating Account...';
});
</script>

</body>
</html>
