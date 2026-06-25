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

int totalAppointments=0;
int approvedAppointments=0;
int pendingAppointments=0;
int totalPatients=0;

try{

    Connection con =
    DBConnection.getConnection();

    PreparedStatement ps1=
    con.prepareStatement(

    "SELECT COUNT(*) FROM appointments WHERE doctor_id=?"

    );

    ps1.setInt(1,doctorId);

    ResultSet rs1=
    ps1.executeQuery();

    if(rs1.next()){

        totalAppointments=
        rs1.getInt(1);
    }

    PreparedStatement ps2=
    con.prepareStatement(

    "SELECT COUNT(*) FROM appointments WHERE doctor_id=? AND status='Approved'"

    );

    ps2.setInt(1,doctorId);

    ResultSet rs2=
    ps2.executeQuery();

    if(rs2.next()){

        approvedAppointments=
        rs2.getInt(1);
    }

    PreparedStatement ps3=
    con.prepareStatement(

    "SELECT COUNT(*) FROM appointments WHERE doctor_id=? AND status='Pending'"

    );

    ps3.setInt(1,doctorId);

    ResultSet rs3=
    ps3.executeQuery();

    if(rs3.next()){

        pendingAppointments=
        rs3.getInt(1);
    }

    PreparedStatement ps4=
    con.prepareStatement(

    "SELECT COUNT(DISTINCT patient_id) FROM appointments WHERE doctor_id=?"

    );

    ps4.setInt(1,doctorId);

    ResultSet rs4=
    ps4.executeQuery();

    if(rs4.next()){

        totalPatients=
        rs4.getInt(1);
    }

%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Doctor Dashboard</title>

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
height:100vh;

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

</style>

</head>

<body>

<div class="sidebar">

<h3>Doctor Panel</h3>

<a href="doctorDashboard.jsp">

<i class="fa fa-home"></i>
 Dashboard

</a>

<a href="doctorAppointments.jsp">

<i class="fa fa-calendar"></i>
 My Appointments

</a>

<a href="doctorPatients.jsp">

<i class="fa fa-users"></i>
 Patients

</a>

<a href="doctorPrescription.jsp">

<i class="fa fa-file-medical"></i>
 Prescriptions

</a>

<a href="#">

<i class="fa fa-user"></i>
 Profile

</a>

<a href="DoctorLogoutServlet">

<i class="fa fa-sign-out-alt"></i>
 Logout

</a>

</div>

<div class="main">

<h2>

Welcome Dr.
<%=doctorName%>

</h2>

<hr>

<div class="row">

<div class="col-md-3">

<div class="card bg-primary text-white p-4">

<h4>
<%=totalAppointments%>
</h4>

<p>Total Appointments</p>

</div>

</div>

<div class="col-md-3">

<div class="card bg-success text-white p-4">

<h4>
<%=approvedAppointments%>
</h4>

<p>Approved</p>

</div>

</div>

<div class="col-md-3">

<div class="card bg-warning text-dark p-4">

<h4>
<%=pendingAppointments%>
</h4>

<p>Pending</p>

</div>

</div>

<div class="col-md-3">

<div class="card bg-info text-white p-4">

<h4>
<%=totalPatients%>
</h4>

<p>Total Patients</p>

</div>

</div>

</div>

<br>

<div class="card p-4">

<h4>

Recent Appointments

</h4>

<table class="table table-bordered">

<tr class="table-dark">

<th>ID</th>
<th>Patient</th>
<th>Date</th>
<th>Time</th>
<th>Status</th>

</tr>

<%

PreparedStatement ps5=
con.prepareStatement(

"SELECT a.*,p.name " +
"FROM appointments a " +
"JOIN patients p ON a.patient_id=p.id " +
"WHERE a.doctor_id=? " +
"ORDER BY a.id DESC LIMIT 10"

);

ps5.setInt(1,doctorId);

ResultSet rs5=
ps5.executeQuery();

while(rs5.next()){

%>

<tr>

<td>
<%=rs5.getInt("id")%>
</td>

<td>
<%=rs5.getString("name")%>
</td>

<td>
<%=rs5.getDate("appointment_date")%>
</td>

<td>
<%=rs5.getTime("appointment_time")%>
</td>

<td>
<%=rs5.getString("status")%>
</td>

</tr>

<%
}
%>

</table>

</div>

</div>

</body>
</html>

<%

con.close();

}catch(Exception e){

out.println(e);
}

%>