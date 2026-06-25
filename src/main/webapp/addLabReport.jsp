<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<!DOCTYPE html>

<html>
<head>

<title>Lab Report Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
background:linear-gradient(135deg,#eef2f7,#d9e4f5);
font-family:Segoe UI;
}

.card{
border-radius:12px;
}

.status-completed{
background:green;
color:white;
padding:5px 10px;
border-radius:10px;
}

.status-pending{
background:orange;
color:white;
padding:5px 10px;
border-radius:10px;
}

</style>

<script>

function loadPatientName(){

let pid=document.getElementById("patient_id").value;

if(pid=="") return;

fetch("getPatientName.jsp?id="+pid)
.then(res=>res.text())
.then(data=>{
document.getElementById("patient_name").value=data;
});

}

</script>

</head>

<body>

<div class="container mt-5">

<% if(request.getParameter("success")!=null){ %>

<div class="alert alert-success">
Lab Report Generated Successfully
</div>

<% } %>

<!-- CREATE REPORT -->

<div class="card shadow p-4 mb-4">

<h3>Create Lab Report</h3>

<form action="LabReportServlet" method="post">

<input type="number"
name="patient_id"
id="patient_id"
class="form-control mb-2"
placeholder="Patient ID"
onkeyup="loadPatientName()"
required>

<input type="text"
id="patient_name"
class="form-control mb-3"
placeholder="Patient Name"
readonly>

<input type="number"
step="0.1"
name="hemoglobin"
class="form-control mb-2"
placeholder="Hemoglobin"
required>

<input type="number"
step="0.1"
name="rbc"
class="form-control mb-2"
placeholder="RBC"
required>

<input type="number"
name="wbc"
class="form-control mb-2"
placeholder="WBC"
required>

<input type="number"
name="platelets"
class="form-control mb-2"
placeholder="Platelets"
required>

<input type="number"
name="blood_sugar"
class="form-control mb-2"
placeholder="Blood Sugar"
required>

<input type="number"
name="cholesterol"
class="form-control mb-2"
placeholder="Cholesterol"
required>

<input type="number"
name="heart_rate"
class="form-control mb-2"
placeholder="Heart Rate"
required>

<input type="text"
name="bp"
class="form-control mb-3"
placeholder="Blood Pressure"
required>

<button class="btn btn-success w-100">
Generate Report
</button>

</form>

</div>

<!-- PENDING REPORTS -->

<div class="card shadow p-4 mb-4">

<h4>Pending Reports</h4>

<table class="table table-bordered">

<tr class="table-warning">

<th>ID</th>
<th>Patient ID</th>
<th>Patient Name</th>
<th>Status</th>

</tr>

<%

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(

"SELECT l.*,p.name FROM lab_reports l JOIN patients p ON l.patient_id=p.id WHERE l.status='Pending'"

);

ResultSet rs=ps.executeQuery();

while(rs.next()){
%>

<tr>

<td><%=rs.getInt("id")%></td>
<td><%=rs.getInt("patient_id")%></td>
<td><%=rs.getString("name")%></td>

<td>
<span class="status-pending">
Pending
</span>
</td>

</tr>

<% } %>

</table>

</div>

<!-- COMPLETED REPORTS -->

<div class="card shadow p-4">

<h4>Completed Reports</h4>

<table class="table table-bordered table-hover">

<tr class="table-dark">

<th>ID</th>
<th>Patient ID</th>
<th>Patient Name</th>
<th>Status</th>
<th>Action</th>

</tr>

<%

PreparedStatement ps2=con.prepareStatement(

"SELECT l.*,p.name FROM lab_reports l JOIN patients p ON l.patient_id=p.id WHERE l.status='Completed' ORDER BY l.id DESC"

);

ResultSet rs2=ps2.executeQuery();

while(rs2.next()){
%>

<tr>

<td><%=rs2.getInt("id")%></td>

<td><%=rs2.getInt("patient_id")%></td>

<td><%=rs2.getString("name")%></td>

<td>
<span class="status-completed">
Completed
</span>
</td>

<td>

<a href="viewSingleReport.jsp?id=<%=rs2.getInt("id")%>"
class="btn btn-success btn-sm">
View </a>

<a href="EditLabReportServlet?id=<%=rs2.getInt("id")%>"
class="btn btn-primary btn-sm">
Edit </a>

<a href="DeleteLabReportServlet?id=<%=rs2.getInt("id")%>"
class="btn btn-danger btn-sm">
Delete </a>

</td>

</tr>

<%
}

con.close();
%>

</table>

</div>

</div>

</body>
</html>
