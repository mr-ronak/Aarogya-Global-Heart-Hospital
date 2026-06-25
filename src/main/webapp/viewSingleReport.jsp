<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>

<%
int id=Integer.parseInt(request.getParameter("id"));

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(
"SELECT l.*,p.name FROM lab_reports l JOIN patients p ON l.patient_id=p.id WHERE l.id=?"
);

ps.setInt(1,id);

ResultSet rs=ps.executeQuery();

rs.next();

/* Get values */

double hb=rs.getDouble("hemoglobin");
double rbc=rs.getDouble("rbc");
double wbc=rs.getDouble("wbc");
double platelets=rs.getDouble("platelets");
double sugar=rs.getDouble("blood_sugar");
double chol=rs.getDouble("cholesterol");
double heart=rs.getDouble("heart_rate");

/* Highlight logic */

String hbClass=(hb<13 || hb>17)?"table-danger":"";
String rbcClass=(rbc<4.5 || rbc>5.9)?"table-danger":"";
String wbcClass=(wbc<4000 || wbc>11000)?"table-danger":"";
String plateClass=(platelets<150000 || platelets>450000)?"table-danger":"";
String sugarClass=(sugar<70 || sugar>100)?"table-danger":"";
String cholClass=(chol>200)?"table-danger":"";
String heartClass=(heart<60 || heart>100)?"table-danger":"";
%>

<!DOCTYPE html>
<html>
<head>

<title>Lab Report</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
background:#f4f6f9;
font-family:Segoe UI;
}

.report-box{
background:white;
padding:40px;
border-radius:10px;
box-shadow:0 10px 25px rgba(0,0,0,0.1);
}

h3{
font-weight:600;
}

.abnormal{
background:#ffd6d6;
font-weight:bold;
}

</style>

</head>

<body>

<div class="container mt-5">

<div class="report-box">

<h3>Aarogya Global Hospital</h3>
<hr>

<h5>Patient : <%=rs.getString("name")%></h5>

<br>

<table class="table table-bordered">

<tr class="table-dark">
<th>Test</th>
<th>Result</th>
<th>Normal Range</th>
</tr>

<tr class="<%=hbClass%>">
<td>Hemoglobin</td>
<td><%=hb%></td>
<td>13 – 17 g/dL</td>
</tr>

<tr class="<%=rbcClass%>">
<td>RBC</td>
<td><%=rbc%></td>
<td>4.5 – 5.9</td>
</tr>

<tr class="<%=wbcClass%>">
<td>WBC</td>
<td><%=wbc%></td>
<td>4000 – 11000</td>
</tr>

<tr class="<%=plateClass%>">
<td>Platelets</td>
<td><%=platelets%></td>
<td>150000 – 450000</td>
</tr>

<tr class="<%=sugarClass%>">
<td>Blood Sugar</td>
<td><%=sugar%></td>
<td>70 – 100</td>
</tr>

<tr class="<%=cholClass%>">
<td>Cholesterol</td>
<td><%=chol%></td>
<td>Less than 200</td>
</tr>

<tr class="<%=heartClass%>">
<td>Heart Rate</td>
<td><%=heart%></td>
<td>60 – 100 bpm</td>
</tr>

<tr>
<td>Blood Pressure</td>
<td><%=rs.getString("bp")%></td>
<td>120 / 80</td>
</tr>

</table>

<br>

<button onclick="window.print()" class="btn btn-primary">
Print Report
</button>

</div>

</div>

</body>
</html>