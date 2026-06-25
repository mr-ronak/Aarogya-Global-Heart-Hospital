<%@ page import="java.util.*" %>
<%@ page session="true" %>

<%
if(session.getAttribute("patientId") == null){
    response.sendRedirect("patientLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Appointments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
    font-family:'Segoe UI';
}
.card{
    border-radius:15px;
}
</style>

</head>

<body class="bg-light">

<nav class="navbar navbar-dark bg-primary">
<div class="container">
<span class="navbar-brand">
<i class="fa fa-hospital"></i> Aarogya Hospital
</span>
<a href="index.jsp" class="btn btn-light">Back</a>
</div>
</nav>

<div class="container mt-5">

<div class="card shadow p-4">

<h3 class="mb-4">
<i class="fa fa-calendar-check"></i> My Appointments
</h3>

<table class="table table-bordered table-hover text-center">

<thead class="table-dark">
<tr>
<th>ID</th>
<th>Doctor</th>
<th>Specialization</th>
<th>Date</th>
<th>Time</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>

<tbody>

<%
ArrayList<String[]> list = (ArrayList<String[]>) request.getAttribute("appointments");

if(list != null && !list.isEmpty()){

    for(String[] row : list){

        boolean isFuture = Boolean.parseBoolean(row[6]);
%>

<tr>

<td><%=row[0]%></td>
<td><%=row[1]%></td>
<td><%=row[2]%></td>
<td><%=row[3]%></td>
<td><%=row[4]%></td>

<td>
<span class="badge 
<%= row[5].equals("Approved") ? "bg-success" :
    row[5].equals("Cancelled") ? "bg-danger" :
    "bg-warning text-dark" %>">
<%=row[5]%>
</span>
</td>

<td>

<%
if(isFuture && row[5].equals("Pending")){
%>

<a href="CancelAppointmentServlet?id=<%=row[0]%>"
class="btn btn-danger btn-sm"
onclick="return confirm('Cancel this appointment?');">
<i class="fa fa-times"></i>
</a>

<a href="reschedule.jsp?id=<%=row[0]%>"
class="btn btn-warning btn-sm">
<i class="fa fa-edit"></i>
</a>

<%
}else{
%>

<span class="text-muted">No Action</span>

<%
}
%>

</td>

</tr>

<%
    }

}else{
%>

<tr>
<td colspan="7" class="text-center text-muted">
No Appointments Found
</td>
</tr>

<%
}
%>

</tbody>

</table>

</div>

</div>

</body>
</html>