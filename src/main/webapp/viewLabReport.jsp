<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%

if(session.getAttribute("patientId")==null){
    response.sendRedirect("patientLogin.jsp");
    return;
}

int patientId=(Integer)session.getAttribute("patientId");

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

.card{
border-radius:12px;
}

.low{
background:#fff3cd;
color:#856404;
font-weight:bold;
}

.high{
background:#f8d7da;
color:#721c24;
font-weight:bold;
}

</style>

</head>

<body>

<div class="container mt-5">

<div class="card shadow p-4">

<h3 class="text-center mb-4">
Aarogya Global Hospital - Lab Report
</h3>

<table class="table table-bordered">

<tr class="table-dark">

<th>Test</th>
<th>Result</th>
<th>Normal Range</th>

</tr>

<%

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(

"SELECT * FROM lab_reports WHERE patient_id=? AND status='Completed' ORDER BY id DESC LIMIT 1"

);

ps.setInt(1,patientId);

ResultSet rs=ps.executeQuery();

if(rs.next()){

double hemoglobin=rs.getDouble("hemoglobin");
double rbc=rs.getDouble("rbc");
double wbc=rs.getDouble("wbc");
double platelets=rs.getDouble("platelets");
double sugar=rs.getDouble("blood_sugar");
double chol=rs.getDouble("cholesterol");
double heart=rs.getDouble("heart_rate");

%>

<tr>

<td>Hemoglobin</td>

<%
String hbClass="";
if(hemoglobin<13) hbClass="low";
else if(hemoglobin>17) hbClass="high";
%>

<td class="<%=hbClass%>"><%=hemoglobin%></td>

<td>13 - 17 g/dL</td>

</tr>

<tr>

<td>RBC</td>

<%
String rbcClass="";
if(rbc<4.5) rbcClass="low";
else if(rbc>5.9) rbcClass="high";
%>

<td class="<%=rbcClass%>"><%=rbc%></td>

<td>4.5 - 5.9</td>

</tr>

<tr>

<td>WBC</td>

<%
String wbcClass="";
if(wbc<4000) wbcClass="low";
else if(wbc>11000) wbcClass="high";
%>

<td class="<%=wbcClass%>"><%=wbc%></td>

<td>4000 - 11000</td>

</tr>

<tr>

<td>Platelets</td>

<%
String plClass="";
if(platelets<150000) plClass="low";
else if(platelets>450000) plClass="high";
%>

<td class="<%=plClass%>"><%=platelets%></td>

<td>150000 - 450000</td>

</tr>

<tr>

<td>Blood Sugar</td>

<%
String sugarClass="";
if(sugar<70) sugarClass="low";
else if(sugar>100) sugarClass="high";
%>

<td class="<%=sugarClass%>"><%=sugar%></td>

<td>70 - 100</td>

</tr>

<tr>

<td>Cholesterol</td>

<%
String cholClass="";
if(chol>200) cholClass="high";
%>

<td class="<%=cholClass%>"><%=chol%></td>

<td>Less than 200</td>

</tr>

<tr>

<td>Heart Rate</td>

<%
String hrClass="";
if(heart<60) hrClass="low";
else if(heart>100) hrClass="high";
%>

<td class="<%=hrClass%>"><%=heart%></td>

<td>60 - 100 bpm</td>

</tr>

<tr>

<td>Blood Pressure</td>

<td><%=rs.getString("bp")%></td>

<td>120/80 Normal</td>

</tr>

<tr>

<td>Report Date</td>

<td colspan="2">

<%=rs.getTimestamp("report_date")%>

</td>

</tr>

<%

}else{

%>

<tr>

<td colspan="3" class="text-center text-danger">

No Lab Report Available

</td>

</tr>

<%

}

con.close();

%>

</table>

<div class="text-center mt-4">

<a href="PrintLabReportServlet"
class="btn btn-primary me-2">

Print Report

</a>

<a href="DownloadLabReportServlet"
class="btn btn-success">

Download PDF

</a>

</div>

</div>

</div>

</body>
</html>