<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%
if(session.getAttribute("adminUser") == null){
    response.sendRedirect("adminLogin.jsp");
    return;
}

int id = Integer.parseInt(request.getParameter("id"));

Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement("SELECT * FROM patients WHERE id=?");
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();

rs.next();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Patient</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{ background:#f4f6f9; font-family:'Segoe UI'; }
.container-box{ margin-left:270px; padding:40px; }
.card{ border-radius:15px; }
</style>

</head>
<body>

<div class="container-box">

<div class="card shadow p-4">
<h4>Edit Patient</h4>

<form action="PatientManageServlet" method="post">

<input type="hidden" name="action" value="update">
<input type="hidden" name="id" value="<%=rs.getInt("id")%>">

<input type="text" name="name"
class="form-control mb-3"
value="<%=rs.getString("name")%>" required>

<input type="number" name="age"
class="form-control mb-3"
value="<%=rs.getInt("age")%>" required>

<select name="gender" class="form-control mb-3">
<option <%=rs.getString("gender").equals("Male")?"selected":""%>>Male</option>
<option <%=rs.getString("gender").equals("Female")?"selected":""%>>Female</option>
<option <%=rs.getString("gender").equals("Other")?"selected":""%>>Other</option>
</select>

<input type="text" name="contact"
class="form-control mb-3"
value="<%=rs.getString("contact")%>" required>

<input type="email" name="email"
class="form-control mb-3"
value="<%=rs.getString("email")%>" required>

<button type="submit" class="btn btn-success w-100">
Update Patient
</button>

</form>

</div>

</div>

</body>
</html>

<%
con.close();
%>