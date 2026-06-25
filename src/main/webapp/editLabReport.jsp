<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>

<%

int id=Integer.parseInt(request.getParameter("id"));

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM lab_reports WHERE id=?"
);

ps.setInt(1,id);

ResultSet rs=ps.executeQuery();

rs.next();

%>

<!DOCTYPE html>
<html>
<head>

<title>Edit Lab Report</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

<div class="card shadow p-4">

<h3>Edit Lab Report</h3>

<form action="EditLabReportServlet" method="post">

<input type="hidden" name="id" value="<%=rs.getInt("id")%>">

<input type="number" step="0.1" name="hemoglobin"
value="<%=rs.getDouble("hemoglobin")%>"
class="form-control mb-2">

<input type="number" step="0.1" name="rbc"
value="<%=rs.getDouble("rbc")%>"
class="form-control mb-2">

<input type="number" name="wbc"
value="<%=rs.getDouble("wbc")%>"
class="form-control mb-2">

<input type="number" name="platelets"
value="<%=rs.getDouble("platelets")%>"
class="form-control mb-2">

<input type="number" name="blood_sugar"
value="<%=rs.getDouble("blood_sugar")%>"
class="form-control mb-2">

<input type="number" name="cholesterol"
value="<%=rs.getDouble("cholesterol")%>"
class="form-control mb-2">

<input type="number" name="heart_rate"
value="<%=rs.getDouble("heart_rate")%>"
class="form-control mb-2">

<input type="text" name="bp"
value="<%=rs.getString("bp")%>"
class="form-control mb-3">

<button class="btn btn-primary w-100">
Update Report
</button>

</form>

</div>

</div>

</body>
</html>