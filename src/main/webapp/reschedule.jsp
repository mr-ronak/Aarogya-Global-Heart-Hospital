<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reschedule Appointment</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

<h3>Reschedule Appointment</h3>

<form action="RescheduleServlet" method="post">

<input type="hidden" name="id" value="<%=request.getParameter("id")%>">

<input type="date" name="newDate" class="form-control mb-3" required>

<input type="time" name="newTime" class="form-control mb-3" required>

<button class="btn btn-primary w-100">Update Appointment</button>

</form>

</div>

</body>
</html>