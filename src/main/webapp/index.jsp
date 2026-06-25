<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%

String patientName = (String) session.getAttribute("patientName");
boolean isLoggedIn = (patientName != null);

int unreadCount = 0;

Connection notifyCon = null;
PreparedStatement countPs = null;
PreparedStatement notifyPs = null;
ResultSet countRs = null;
ResultSet notifyRs = null;

try{

if(session.getAttribute("patientId") != null){

int patientId = (Integer)session.getAttribute("patientId");

notifyCon = DBConnection.getConnection();

countPs = notifyCon.prepareStatement(

"SELECT COUNT(*) total FROM notifications WHERE patient_id=? AND status='Unread'"

);

countPs.setInt(1, patientId);

countRs = countPs.executeQuery();

if(countRs.next()){

unreadCount = countRs.getInt("total");

}

notifyPs = notifyCon.prepareStatement(

"SELECT * FROM notifications WHERE patient_id=? ORDER BY id DESC LIMIT 5"

);

notifyPs.setInt(1, patientId);

notifyRs = notifyPs.executeQuery();

}

}catch(Exception e){

e.printStackTrace();

}

%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Aarogya Global Heart Multispeciality Center</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

body{
margin:0;
font-family:'Segoe UI', sans-serif;
overflow-x:hidden;
}

/* NAVBAR */

.custom-navbar{
background: linear-gradient(90deg,#1f1f1f,#2c5364);
padding:15px 40px;
}

.navbar-brand{
color:white !important;
font-weight:700;
font-size:22px;
}

.nav-link{
color:#ddd !important;
margin:0 10px;
}

.nav-link:hover{
color:#00f2fe !important;
}

/* HERO */

.hero{
height:100vh;
background-image:url('https://images.unsplash.com/photo-1586773860418-d37222d8fce3?q=80&w=1920&auto=format&fit=crop');
background-size:cover;
background-position:center;
background-attachment:fixed;
position:relative;
display:flex;
align-items:center;
justify-content:center;
text-align:center;
color:white;
}

.hero::before{
content:"";
position:absolute;
top:0;
left:0;
width:100%;
height:100%;
background:rgba(0,0,0,0.6);
}

.hero-content{
position:relative;
z-index:2;
animation:fadeUp 1s ease-in-out;
}

/* Moving Text */

.moving-text{
font-size:45px;
font-weight:700;
margin-bottom:20px;
animation:slideText 10s linear infinite;
}

@keyframes slideText{
0%{transform:translateX(-100%);}
50%{transform:translateX(0);}
100%{transform:translateX(100%);}
}

.subtext{
font-size:20px;
margin-bottom:40px;
}

/* Buttons */

.action-btn{
padding:15px 35px;
border-radius:50px;
font-weight:600;
margin:10px;
transition:0.4s;
}

.action-btn:hover{
transform:scale(1.1);
box-shadow:0 0 20px rgba(255,255,255,0.8);
}

.btn-book{background:#1e7e34;color:white;}
.btn-appointment{background:#17a2b8;color:black;}
.btn-bill{background:#ffc107;color:black;}
.btn-profile{background:#f8f9fa;color:black;}

/* Footer */

.footer{
background: linear-gradient(90deg,#1f1f1f,#2c5364);
color:white;
padding:40px 0;
}

.footer a{
color:#ddd;
text-decoration:none;
}

.footer a:hover{
color:#00f2fe;
}

.footer-bottom{
background:#111;
color:#aaa;
text-align:center;
padding:10px;
font-size:14px;
}

/* Animations */

@keyframes fadeUp{
from{opacity:0;transform:translateY(50px);}
to{opacity:1;transform:translateY(0);}
}

/* ========================= */
/* NOTIFICATION CSS */
/* ========================= */

.notification-box{
position:relative;
margin-right:20px;
display:inline-block;
}

.bell-icon{
font-size:22px;
color:white;
cursor:pointer;
transition:0.3s;
}

.bell-icon:hover{
transform:scale(1.1);
color:#00e5ff;
}

.notify-count{

position:absolute;
top:-8px;
right:-10px;

background:red;
color:white;

width:20px;
height:20px;

border-radius:50%;

font-size:11px;
font-weight:bold;

display:flex;
align-items:center;
justify-content:center;

animation:pulse 1s infinite;

}

@keyframes pulse{

0%{transform:scale(1);}
50%{transform:scale(1.2);}
100%{transform:scale(1);}

}

.notification-dropdown{

display:none;

position:absolute;
right:0;
top:40px;

width:380px;
max-height:450px;

background:white;

border-radius:10px;

box-shadow:0 5px 15px rgba(0,0,0,0.3);

overflow-y:auto;

z-index:9999;

}

.notification-header{

background:#0d6efd;
color:white;

padding:12px;
font-weight:bold;

}

.notification-item{

padding:12px;
border-bottom:1px solid #eee;

transition:0.3s;

color:black;

}

.notification-item:hover{
background:#f5f5f5;
}

.notification-time{
font-size:12px;
color:gray;
margin-top:5px;
}

.showNotify{
display:block;
}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg custom-navbar">

<div class="container-fluid">

<a class="navbar-brand" href="#">
<span style="color:#ff2e63;">●</span> Aarogya Global
</a>

<div class="collapse navbar-collapse justify-content-center">

<ul class="navbar-nav">

<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
<li class="nav-item"><a class="nav-link" href="bookAppointment.jsp">Book Appointment</a></li>
<li class="nav-item"><a class="nav-link" href="ViewAppointmentServlet">Appointments</a></li>
<li class="nav-item"><a class="nav-link" href="viewBill.jsp">Bills</a></li>
<li class="nav-item"><a class="nav-link" href="viewLabReport.jsp">View Report</a></li>
<li class="nav-item"><a class="nav-link" href="patientPrescription.jsp">My Prescriptions</a></li>
<li class="nav-item"><a class="nav-link" href="ProfileServlet">Profile</a></li>
<li class="nav-item"><a class="nav-link" href="#">About</a></li>

</ul>

</div>

<!-- RIGHT SIDE BUTTONS -->

<div class="ms-auto d-flex align-items-center">

<% if(isLoggedIn){ %>

<!-- NOTIFICATION -->

<div class="notification-box">

<i class="fa-solid fa-bell bell-icon"
onclick="toggleNotification()"></i>

<% if(unreadCount > 0){ %>

<div class="notify-count">
<%=unreadCount%>
</div>

<% } %>

<div class="notification-dropdown"
id="notificationDropdown">

<div class="notification-header">

<i class="fa-solid fa-bell"></i>
Latest Notifications

</div>

<%

if(notifyRs != null){

boolean hasNotification = false;

while(notifyRs.next()){

hasNotification = true;

%>

<div class="notification-item">

<%
String type = notifyRs.getString("notification_type");

String icon = "fa-bell";

if("appointment".equals(type)){
    icon = "fa-calendar-check";
}
else if("billing".equals(type)){
    icon = "fa-file-invoice-dollar";
}
else if("report".equals(type)){
    icon = "fa-flask";
}
%>

<div style="font-weight:bold;color:#0d6efd;">

<i class="fa-solid <%=icon%>"></i>

<%=notifyRs.getString("title")%>

</div>

<div style="margin-top:5px;">

<%=notifyRs.getString("message")%>

</div>

<div class="notification-time">

<%=notifyRs.getTimestamp("created_at")%>

</div>

</div>
<%

}

}

%>

</div>

</div>

<span style="color:white;margin-right:15px;">
Welcome, <%=patientName%>
</span>

<a href="PatientLogoutServlet" class="btn btn-light btn-sm">
Logout
</a>

<% } else { %>

<a href="patientLogin.jsp" class="btn btn-success btn-sm me-2">
Login
</a>

<a href="patientRegister.jsp" class="btn btn-warning btn-sm">
Register
</a>

<% } %>

</div>

</div>

</nav>

<!-- HERO SECTION -->

<div class="hero">

<div class="hero-content">

<div class="moving-text">
World Class Cardiology • Neurology • Oncology • Orthopedics
</div>

<div class="subtext">

<% if(isLoggedIn){ %>
Welcome, <%=patientName%>
<% } else { %>
Welcome to Aarogya Global
<% } %>

Experience Advanced Multispeciality Care with Modern Technology

</div>

<div>

<a href="bookAppointment.jsp" class="btn action-btn btn-book">
<i class="fa fa-calendar"></i> Book Appointment
</a>

<a href="ViewAppointmentServlet" class="btn action-btn btn-appointment">
<i class="fa fa-list"></i> View Appointments
</a>

<a href="viewBill.jsp" class="btn action-btn btn-bill">
<i class="fa fa-file-invoice"></i> View Bills
</a>

<a href="ProfileServlet" class="btn action-btn btn-profile">
<i class="fa fa-user"></i> My Profile
</a>

</div>

</div>

</div>

<!-- FOOTER -->

<footer class="footer">

<div class="container">

<div class="row">

<div class="col-md-4">

<h5>Aarogya Global</h5>
<p>Advanced multispeciality hospital providing world class healthcare services with modern technology.</p>

</div>

<div class="col-md-4">

<h5>Quick Links</h5>

<ul class="list-unstyled">

<li><a href="index.jsp">Home</a></li>
<li><a href="bookAppointment.jsp">Book Appointment</a></li>
<li><a href="viewBill.jsp">View Bills</a></li>
<li><a href="viewLabReport.jsp">Lab Reports</a></li>

</ul>

</div>

<div class="col-md-4">

<h5>Contact Us</h5>

<p><i class="fa fa-map-marker-alt"></i> Ahmedabad, Gujarat</p>
<p><i class="fa fa-phone"></i> +91 98765 43210</p>
<p><i class="fa fa-envelope"></i> info@aarogyaglobal.com</p>

<div>

<i class="fab fa-facebook fa-lg me-3"></i>
<i class="fab fa-twitter fa-lg me-3"></i>
<i class="fab fa-instagram fa-lg"></i>

</div>

</div>

</div>

</div>

</footer>

<div class="footer-bottom">

© 2026 Aarogya Global Multispeciality Hospital. All Rights Reserved.

</div>

<script>

function toggleNotification(){

document.getElementById("notificationDropdown")
.classList.toggle("showNotify");

}

window.onclick=function(event){

if(!event.target.matches('.bell-icon')){

var dropdown=
document.getElementById("notificationDropdown");

if(dropdown.classList.contains('showNotify')){

dropdown.classList.remove('showNotify');

}

}

}

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>