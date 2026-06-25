<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%

if(session.getAttribute("doctorId")==null){

response.sendRedirect("doctorLogin.jsp");
return;

}

int doctorId =
(Integer)session.getAttribute("doctorId");

String doctorName =
(String)session.getAttribute("doctorName");

%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>Doctor Appointments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

body{
background:#f4f6f9;
font-family:Segoe UI;
}

.sidebar{
position:fixed;
left:0;
top:0;
width:250px;
height:100%;
background:#1f2937;
padding-top:20px;
}

.sidebar h3{
color:white;
text-align:center;
margin-bottom:30px;
}

.sidebar a{
display:block;
color:white;
padding:15px 25px;
text-decoration:none;
}

.sidebar a:hover{
background:#374151;
}

.main{
margin-left:260px;
padding:30px;
}

.card{
border:none;
border-radius:15px;
box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

.badge-approved{
background:green;
color:white;
padding:8px;
border-radius:8px;
}

.badge-pending{
background:orange;
color:white;
padding:8px;
border-radius:8px;
}

.badge-cancelled{
background:red;
color:white;
padding:8px;
border-radius:8px;
}

</style>

</head>

<body>

<div class="sidebar">

<h3>Doctor Panel</h3>

<a href="doctorDashboard.jsp">
<i class="fa fa-home"></i> Dashboard
</a>

<a href="doctorAppointments.jsp">
<i class="fa fa-calendar"></i> My Appointments
</a>

<a href="doctorPatients.jsp">
<i class="fa fa-users"></i> Patients
</a>

<a href="doctorPrescription.jsp">
<i class="fa fa-file-medical"></i> Prescriptions
</a>

<a href="doctorProfile.jsp">
<i class="fa fa-user"></i> Profile
</a>

<a href="DoctorLogoutServlet">
<i class="fa fa-sign-out-alt"></i> Logout
</a>

</div>

<div class="main">

<div class="card p-4">

<h3 class="mb-4">

<i class="fa fa-calendar-check"></i>

My Appointments

</h3>

<table class="table table-bordered table-hover">

<thead class="table-dark">

<tr>

<th>ID</th>
<th>Patient Name</th>
<th>Age</th>
<th>Gender</th>
<th>Date</th>
<th>Time</th>
<th>Status</th>
<th>Action</th>

</tr>

</thead>

<tbody>

<%

try{

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(

"SELECT a.*, p.name, p.age, p.gender " +
"FROM appointments a " +
"JOIN patients p ON a.patient_id=p.id " +
"WHERE a.doctor_id=? " +
"ORDER BY a.appointment_date DESC"

);

ps.setInt(1, doctorId);

ResultSet rs =
ps.executeQuery();

while(rs.next()){

String status =
rs.getString("status");

%>

<tr>

<td>
<%=rs.getInt("id")%>
</td>

<td>
<%=rs.getString("name")%>
</td>

<td>
<%=rs.getInt("age")%>
</td>

<td>
<%=rs.getString("gender")%>
</td>

<td>
<%=rs.getDate("appointment_date")%>
</td>

<td>
<%=rs.getTime("appointment_time")%>
</td>

<td>

<%

if(status.equalsIgnoreCase("Approved")){
%>

<span class="badge-approved">
Approved
</span>

<%
}
else if(status.equalsIgnoreCase("Pending")){
%>

<span class="badge-pending">
Pending
</span>

<%
}
else{
%>

<span class="badge-cancelled">
Cancelled
</span>

<%
}
%>

</td>

<td>

<a href="doctorPatients.jsp?id=<%=rs.getInt("patient_id")%>"
class="btn btn-primary btn-sm">

<i class="fa fa-user"></i>

View Patient

</a>

<a href="doctorPrescription.jsp?appointmentId=<%=rs.getInt("id")%>&patientId=<%=rs.getInt("patient_id")%>"
class="btn btn-success btn-sm">

<i class="fa fa-file-medical"></i>

Prescription

</a>

</td>

</tr>

<%
}

rs.close();
ps.close();
con.close();

}catch(Exception e){

out.println(

"<tr><td colspan='8'>"+e.getMessage()+"</td></tr>"

);

}

%>

</tbody>

</table>

</div>

</div>

</body>
</html>
