<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%

if(session.getAttribute("patientId")==null){


response.sendRedirect("patientLogin.jsp");
return;


}

int patientId =
(Integer)session.getAttribute("patientId");

%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>My Prescriptions</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

body{
background:#f4f6f9;
font-family:'Segoe UI';
}

.card{
border:none;
border-radius:15px;
box-shadow:0 5px 15px rgba(0,0,0,0.1);
margin-bottom:20px;
}

.section-title{
font-weight:bold;
color:#0d6efd;
margin-bottom:5px;
}

.header-box{
background:white;
padding:20px;
border-radius:15px;
margin-bottom:20px;
box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

</style>

</head>

<body>

<div class="container mt-4">

<div class="header-box">

<h2>

<i class="fa fa-file-medical"></i>

My Prescriptions

</h2>

<p class="text-muted">

View all prescriptions provided by your doctors.

</p>

</div>

<%

try{

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(

"SELECT p.*, d.name doctor_name, d.specialization " +
"FROM prescriptions p " +
"JOIN doctors d ON p.doctor_id=d.id " +
"WHERE p.patient_id=? " +
"ORDER BY p.id DESC"

);

ps.setInt(1, patientId);

ResultSet rs =
ps.executeQuery();

boolean found = false;

while(rs.next()){

found = true;

%>

<div class="card p-4">

<div class="row">

<div class="col-md-8">

<h4>

Dr. <%=rs.getString("doctor_name")%>

</h4>

<p class="text-primary">

<%=rs.getString("specialization")%>

</p>

</div>

<div class="col-md-4 text-end">

<b>Date :</b>

<br>

<%=rs.getTimestamp("created_at")%>

</div>

</div>

<hr>

<div class="mb-3">

<div class="section-title">
Symptoms
</div>

<%=rs.getString("symptoms")%>

</div>

<div class="mb-3">

<div class="section-title">
Diagnosis
</div>

<%=rs.getString("diagnosis")%>

</div>

<div class="mb-3">

<div class="section-title">
Medicines
</div>

<%=rs.getString("medicines")%>

</div>

<div class="mb-3">

<div class="section-title">
Advice
</div>

<%=rs.getString("advice")%>

</div>

<hr>

<div class="mt-3">

<a href="PrintPrescriptionServlet?id=<%=rs.getInt("id")%>"
class="btn btn-primary btn-sm"
target="_blank">

<i class="fa fa-print"></i>
Print

</a>

<a href="DownloadPrescriptionServlet?id=<%=rs.getInt("id")%>"
class="btn btn-success btn-sm">

<i class="fa fa-download"></i>
Download PDF

</a>

</div>

</div>

<%

}

if(!found){

%>

<div class="alert alert-warning">

No Prescriptions Available

</div>

<%

}

rs.close();
ps.close();
con.close();

}
catch(Exception e){

%>

<div class="alert alert-danger">

<%=e.getMessage()%>

</div>

<%

}

%>

</div>

</body>
</html>
