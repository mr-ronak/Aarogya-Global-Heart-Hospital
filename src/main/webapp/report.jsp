<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hospital Report</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

<h3>Hospital Report Summary</h3>

<div class="row">

<%
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();

ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM patients");
rs1.next();
int totalPatients = rs1.getInt(1);

ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM doctors");
rs2.next();
int totalDoctors = rs2.getInt(1);

ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM appointments");
rs3.next();
int totalAppointments = rs3.getInt(1);

ResultSet rs4 = st.executeQuery("SELECT SUM(total_amount) FROM bills");
rs4.next();
double totalRevenue = rs4.getDouble(1);

con.close();
%>

<div class="col-md-3">
<div class="card p-4 text-center shadow">
<h4>Total Patients</h4>
<h2><%=totalPatients%></h2>
</div>
</div>

<div class="col-md-3">
<div class="card p-4 text-center shadow">
<h4>Total Doctors</h4>
<h2><%=totalDoctors%></h2>
</div>
</div>

<div class="col-md-3">
<div class="card p-4 text-center shadow">
<h4>Total Appointments</h4>
<h2><%=totalAppointments%></h2>
</div>
</div>

<div class="col-md-3">
<div class="card p-4 text-center shadow">
<h4>Total Revenue</h4>
<h2>₹ <%=totalRevenue%></h2>
</div>
</div>

</div>

</div>

</body>
</html>