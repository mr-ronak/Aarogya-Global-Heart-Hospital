<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%
if(session.getAttribute("adminUser") == null){
    response.sendRedirect("adminLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Appointments</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

<h3>Manage Appointments</h3>

<table class="table table-bordered table-hover">
<thead class="table-dark">
<tr>
<th>ID</th>
<th>Patient</th>
<th>Doctor</th>
<th>Date</th>
<th>Time</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>

<tbody>

<%
try{
Connection con = DBConnection.getConnection();

String sql = "SELECT a.id, p.name AS patient, d.name AS doctor, " +
             "a.appointment_date, a.appointment_time, a.status " +
             "FROM appointments a " +
             "JOIN patients p ON a.patient_id = p.id " +
             "JOIN doctors d ON a.doctor_id = d.id";

Statement st = con.createStatement();
ResultSet rs = st.executeQuery(sql);

while(rs.next()){
String status = rs.getString("status");
%>

<tr>
<td><%=rs.getInt("id")%></td>
<td><%=rs.getString("patient")%></td>
<td><%=rs.getString("doctor")%></td>
<td><%=rs.getDate("appointment_date")%></td>
<td><%=rs.getTime("appointment_time")%></td>
<td><%=status%></td>

<td>
<% if(status.equals("Pending")){ %>

<a href="AppointmentManageServlet?action=approve&id=<%=rs.getInt("id")%>"
class="btn btn-success btn-sm">Approve</a>

<a href="AppointmentManageServlet?action=cancel&id=<%=rs.getInt("id")%>"
class="btn btn-danger btn-sm">Cancel</a>

<% } else { %>
No Action
<% } %>
</td>

</tr>

<%
}
con.close();
}catch(Exception e){
out.println(e.getMessage());
}
%>

</tbody>
</table>

</div>

</body>
</html>