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
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>My Patients</title>

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
<i class="fa fa-users"></i>
My Patients
</h3>

<table class="table table-bordered table-hover">

<thead class="table-dark">

<tr>

<th>ID</th>
<th>Name</th>
<th>Age</th>
<th>Gender</th>
<th>Contact</th>
<th>Email</th>
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

"SELECT DISTINCT p.* " +
"FROM patients p " +
"JOIN appointments a ON p.id=a.patient_id " +
"WHERE a.doctor_id=? " +
"ORDER BY p.id DESC"

);

ps.setInt(1, doctorId);

ResultSet rs =
ps.executeQuery();

while(rs.next()){

%>

<tr>

<td><%=rs.getInt("id")%></td>

<td><%=rs.getString("name")%></td>

<td><%=rs.getInt("age")%></td>

<td><%=rs.getString("gender")%></td>

<td><%=rs.getString("contact")%></td>

<td><%=rs.getString("email")%></td>

<td>

<a href="viewPatient.jsp?id=<%=rs.getInt("id")%>"
class="btn btn-primary btn-sm">

<i class="fa fa-eye"></i>
View

</a>

<a href="doctorPrescription.jsp?patientId=<%=rs.getInt("id")%>"
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

out.println("<tr><td colspan='7'>"+e.getMessage()+"</td></tr>");

}
%>

</tbody>

</table>

</div>

</div>

</body>
</html>
