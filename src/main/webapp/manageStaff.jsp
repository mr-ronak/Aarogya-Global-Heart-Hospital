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
<title>Manage Staff</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">

<h3>Manage Staff</h3>

<!-- Add Staff -->

<div class="card p-4 mb-4 shadow">
<form action="StaffServlet" method="post">
<input type="hidden" name="action" value="add">

<div class="row">
<div class="col-md-4">
<input type="text" name="name" class="form-control mb-3" placeholder="Name" required>
</div>

<div class="col-md-4">
<input type="text" name="role" class="form-control mb-3" placeholder="Role" required>
</div>

<div class="col-md-4">
<input type="text" name="department" class="form-control mb-3" placeholder="Department" required>
</div>

<div class="col-md-4">
<input type="text" name="contact" class="form-control mb-3" placeholder="Contact" required>
</div>

<div class="col-md-4">
<input type="email" name="email" class="form-control mb-3" placeholder="Email" required>
</div>

<div class="col-md-4">
<input type="number" name="salary" class="form-control mb-3" placeholder="Salary" required>
</div>

<div class="col-md-6">
<input type="text" name="shift_time" class="form-control mb-3" placeholder="Shift Time" required>
</div>

<div class="col-md-6">
<button class="btn btn-success w-100">Add Staff</button>
</div>

</div>
</form>
</div>

<!-- Staff List -->

<table class="table table-bordered table-hover">
<tr class="table-dark">
<th>ID</th>
<th>Name</th>
<th>Role</th>
<th>Department</th>
<th>Contact</th>
<th>Email</th>
<th>Salary</th>
<th>Shift</th>
<th>Action</th>
</tr>

<%
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM staff");

while(rs.next()){
%>

<tr>
<td><%=rs.getInt("id")%></td>
<td><%=rs.getString("name")%></td>
<td><%=rs.getString("role")%></td>
<td><%=rs.getString("department")%></td>
<td><%=rs.getString("contact")%></td>
<td><%=rs.getString("email")%></td>
<td>₹ <%=rs.getDouble("salary")%></td>
<td><%=rs.getString("shift_time")%></td>
<td>
<a href="StaffServlet?id=<%=rs.getInt("id")%>" 
class="btn btn-danger btn-sm">Delete</a>
</td>
</tr>

<%
}
con.close();
%>

</table>

</div>

</body>
</html>