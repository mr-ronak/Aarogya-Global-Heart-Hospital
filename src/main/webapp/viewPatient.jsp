<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%

if(session.getAttribute("doctorId")==null){


response.sendRedirect("doctorLogin.jsp");
return;

}

String patientId =
request.getParameter("id");

if(patientId==null){


response.sendRedirect("doctorPatients.jsp");
return;


}

%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>Patient Details</title>

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
padding:15px 25px;
color:white;
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
margin-bottom:20px;
}

.info-row{
padding:12px;
border-bottom:1px solid #eee;
}

.label{
font-weight:bold;
color:#555;
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

<h2 class="mb-4">

<i class="fa fa-user"></i>

Patient Profile

</h2>

<%

try{

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(

"SELECT * FROM patients WHERE id=?"

);

ps.setInt(
1,
Integer.parseInt(patientId)
);

ResultSet rs =
ps.executeQuery();

if(rs.next()){

%>

<div class="card p-4">

<div class="info-row">

<span class="label">
Patient ID :
</span>

<%=rs.getInt("id")%>

</div>

<div class="info-row">

<span class="label">
Name :
</span>

<%=rs.getString("name")%>

</div>

<div class="info-row">

<span class="label">
Age :
</span>

<%=rs.getInt("age")%>

</div>

<div class="info-row">

<span class="label">
Gender :
</span>

<%=rs.getString("gender")%>

</div>

<div class="info-row">

<span class="label">
Contact :
</span>

<%=rs.getString("contact")%>

</div>

<div class="info-row">

<span class="label">
Email :
</span>

<%=rs.getString("email")%>

</div>

<div class="info-row">

<span class="label">
Registered On :
</span>

<%=rs.getTimestamp("created_at")%>

</div>

<br>

<a href="doctorPrescription.jsp?patientId=<%=rs.getInt("id")%>"
class="btn btn-success">

<i class="fa fa-file-medical"></i>

Write Prescription

</a>

<a href="doctorPatients.jsp"
class="btn btn-secondary">

Back

</a>

</div>

<%

}

rs.close();
ps.close();

%>

<div class="card p-4">

<h4>

Recent Appointments

</h4>

<table class="table table-bordered">

<tr class="table-dark">

<th>ID</th>
<th>Date</th>
<th>Time</th>
<th>Status</th>

</tr>

<%

PreparedStatement aps =
con.prepareStatement(

"SELECT * FROM appointments WHERE patient_id=? ORDER BY id DESC LIMIT 10"

);

aps.setInt(
1,
Integer.parseInt(patientId)
);

ResultSet ars =
aps.executeQuery();

while(ars.next()){

%>

<tr>

<td>
<%=ars.getInt("id")%>
</td>

<td>
<%=ars.getDate("appointment_date")%>
</td>

<td>
<%=ars.getTime("appointment_time")%>
</td>

<td>
<%=ars.getString("status")%>
</td>

</tr>

<%
}
%>

</table>

</div>

<%

con.close();

}catch(Exception e){

%>

<div class="alert alert-danger">

<%= e.getMessage() %>

</div>

<%

}

%>

</div>

</body>
</html>

</div>

</body>
</html>
