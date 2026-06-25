<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%
if(session.getAttribute("adminUser")==null){
    response.sendRedirect("adminLogin.jsp");
    return;
}

Connection con = DBConnection.getConnection();
Statement st = con.createStatement();

/* COUNTS */

ResultSet r1 = st.executeQuery("SELECT COUNT(*) FROM doctors");
r1.next();
int doctors = r1.getInt(1);

ResultSet r2 = st.executeQuery("SELECT COUNT(*) FROM patients");
r2.next();
int patients = r2.getInt(1);

ResultSet r3 = st.executeQuery("SELECT COUNT(*) FROM appointments");
r3.next();
int appointments = r3.getInt(1);

/* MONTHLY REVENUE */

ResultSet r4 = st.executeQuery(
"SELECT IFNULL(SUM(total_amount),0) FROM bills WHERE payment_status='Paid' AND MONTH(created_at)=MONTH(CURDATE()) AND YEAR(created_at)=YEAR(CURDATE())");
r4.next();
double monthlyRevenue = r4.getDouble(1);

/* RECENT APPOINTMENTS */

PreparedStatement ps = con.prepareStatement(
"SELECT a.id,p.name patient,d.name doctor,a.created_at FROM appointments a JOIN patients p ON a.patient_id=p.id JOIN doctors d ON a.doctor_id=d.id ORDER BY a.id DESC LIMIT 5");

ResultSet recent = ps.executeQuery();

/* LATEST PATIENTS */

PreparedStatement ps2 = con.prepareStatement(
"SELECT name,email,created_at FROM patients ORDER BY id DESC LIMIT 5");

ResultSet latest = ps2.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>

<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>

body{
margin:0;
font-family:'Segoe UI';
background:#eef2f7;
}

/* Sidebar */

.sidebar{
width:260px;
height:100vh;
position:fixed;
background:linear-gradient(180deg,#1f1f1f,#2c5364);
color:white;
padding-top:20px;
}

.sidebar a{
display:block;
padding:15px 25px;
color:#ddd;
text-decoration:none;
}

.sidebar a:hover{
background:rgba(255,255,255,0.1);
color:#00f2fe;
padding-left:35px;
}

/* Topbar */

.topbar{
margin-left:260px;
height:70px;
background:white;
display:flex;
align-items:center;
justify-content:space-between;
padding:0 30px;
box-shadow:0 3px 10px rgba(0,0,0,0.1);
}

/* Content */

.content{
margin-left:260px;
padding:40px;
}

/* Animated Cards */

.stat-card{
border-radius:20px;
color:white;
padding:30px;
transition:0.4s;
cursor:pointer;
animation:fadeUp 0.8s ease;
}

.stat-card:hover{
transform:translateY(-10px) scale(1.03);
box-shadow:0 20px 40px rgba(0,0,0,0.2);
}

.card-doctor{background:linear-gradient(45deg,#28a745,#1e7e34);}
.card-patient{background:linear-gradient(45deg,#20c997,#17a2b8);}
.card-appointment{background:linear-gradient(45deg,#ffc107,#fd7e14);}
.card-revenue{background:linear-gradient(45deg,#dc3545,#e83e8c);}

.stat-card i{
font-size:40px;
margin-bottom:10px;
}

/* Table animation */

.recent-row{
animation:slideIn 0.6s ease;
}

/* Animations */

@keyframes fadeUp{
from{opacity:0; transform:translateY(40px);}
to{opacity:1; transform:translateY(0);}
}

@keyframes slideIn{
from{opacity:0; transform:translateX(-40px);}
to{opacity:1; transform:translateX(0);}
}

</style>

</head>

<body>

<!-- Sidebar -->

<div class="sidebar">

<h4 class="text-center">🏥 Aarogya Admin</h4>

<a href="adminDashboard.jsp"><i class="fa fa-home"></i> Dashboard</a>
<a href="manageDoctors.jsp"><i class="fa fa-user-md"></i> Manage Doctors</a>
<a href="manageDepartments.jsp"><i class="fa fa-building"></i> Departments</a>
<a href="manageStaff.jsp"><i class="fa fa-users"></i> Staff</a>
<a href="managePatients.jsp"><i class="fa fa-users"></i> Patients</a>
<a href="manageAppointments.jsp"><i class="fa fa-calendar-check"></i> Appointments</a>
<a href="addLabReport.jsp"><i class="fa fa-file-medical"></i> Add Lab Report</a>
<a href="report.jsp"><i class="fa fa-chart-bar"></i> Reports</a>

<a href="manageBills.jsp"><i class="fa fa-file-invoice-dollar"></i> Billing</a>
<a href="AdminLogoutServlet"><i class="fa fa-sign-out-alt"></i> Logout</a>

</div>

<!-- Topbar -->

<div class="topbar">
<h5>Welcome Admin</h5>
<span>Hospital Control Panel</span>
<a href="doctorLogin.jsp"
class="btn btn-primary">

Doctor Panel

</a>
</div>

<!-- Dashboard Content -->

<div class="content">

<div class="row">

<div class="col-md-3">
<div class="stat-card card-doctor text-center">
<i class="fa fa-user-md"></i>
<h4><%=doctors%></h4>
<p>Doctors</p>
</div>
</div>

<div class="col-md-3">
<div class="stat-card card-patient text-center">
<i class="fa fa-users"></i>
<h4><%=patients%></h4>
<p>Patients</p>
</div>
</div>

<div class="col-md-3">
<div class="stat-card card-appointment text-center">
<i class="fa fa-calendar-check"></i>
<h4><%=appointments%></h4>
<p>Total Appointments</p>
</div>
</div>

<div class="col-md-3">
<div class="stat-card card-revenue text-center">
<i class="fa fa-rupee-sign"></i>
<h4>₹ <%=monthlyRevenue%></h4>
<p>This Month Revenue</p>
</div>
</div>

</div>

<!-- Recent Appointments -->

<div class="card mt-4 shadow">

<div class="card-header bg-dark text-white">
Recent Appointments
</div>

<table class="table">

<tr>
<th>ID</th>
<th>Patient</th>
<th>Doctor</th>
<th>Date</th>
</tr>

<%
while(recent.next()){
%>

<tr class="recent-row">
<td><%=recent.getInt("id")%></td>
<td><%=recent.getString("patient")%></td>
<td><%=recent.getString("doctor")%></td>
<td><%=recent.getTimestamp("created_at")%></td>
</tr>

<% } %>

</table>

</div>

<!-- Latest Patients -->

<div class="card mt-4 shadow">

<div class="card-header bg-primary text-white">
Latest Registered Patients
</div>

<table class="table">

<tr>
<th>Name</th>
<th>Email</th>
<th>Registered</th>
</tr>

<%
while(latest.next()){
%>

<tr>
<td><%=latest.getString("name")%></td>
<td><%=latest.getString("email")%></td>
<td><%=latest.getTimestamp("created_at")%></td>
</tr>

<% } %>

</table>

</div>

<!-- Revenue Chart -->

<div class="card mt-4 shadow">

<div class="card-header bg-success text-white">
Monthly Revenue Chart
</div>

<div class="card-body">
<canvas id="revenueChart"></canvas>
</div>

</div>

</div>

<script>

var ctx=document.getElementById('revenueChart');

new Chart(ctx,{
type:'doughnut',
data:{
labels:['Revenue'],
datasets:[{
data:[<%=monthlyRevenue%>],
backgroundColor:['#28a745']
}]
}
});

</script>

</body>
</html>