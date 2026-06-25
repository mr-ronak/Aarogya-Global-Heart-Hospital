<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
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
<title>Book Appointment</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<nav class="navbar navbar-dark bg-primary">
<div class="container">
<span class="navbar-brand">Aarogya Hospital</span>
<a href="index.jsp" class="btn btn-light">Back</a>
</div>
</nav>

<div class="container mt-5">
<div class="card shadow p-4">

<h3 class="text-center mb-4">Book Appointment</h3>

<form action="<%=request.getContextPath()%>/BookAppointmentServlet" method="post">

<!-- Doctor -->
<div class="mb-3">
<label>Select Doctor</label>
<select name="doctorId" class="form-control" required>
<option value="">-- Select Doctor --</option>

<%
try{
Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement("SELECT * FROM doctors");
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>
<option value="<%=rs.getInt("id")%>">
<%=rs.getString("name")%> - <%=rs.getString("specialization")%>
</option>
<%
}
con.close();
}catch(Exception e){
out.println(e.getMessage());
}
%>
</select>
</div>

<!-- Date -->
<div class="mb-3">
<label>Appointment Date</label>
<input type="date" name="appointmentDate" class="form-control" required>
</div>

<!-- Time -->
<div class="mb-3">
<label>Appointment Time</label>
<input type="time" name="appointmentTime" class="form-control" required>
</div>

<button type="submit" class="btn btn-success w-100">
Book Appointment
</button>

</form>

</div>
</div>

</body>
</html>