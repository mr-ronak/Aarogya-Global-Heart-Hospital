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
<title>Manage Patients</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body{ background:#f4f6f9; font-family:'Segoe UI'; }
.container-box{ margin-left:000px; padding:40px; }
.search-box{ max-width:300px; }
</style>

<script>
function searchPatient(){
    let input = document.getElementById("searchInput").value.toLowerCase();
    let rows = document.querySelectorAll("#patientTable tr");

    rows.forEach(row => {
        let text = row.innerText.toLowerCase();
        row.style.display = text.includes(input) ? "" : "none";
    });
}
</script>

</head>
<body>

<div class="container-box">

<h3 class="mb-4"><i class="fa fa-users"></i> Manage Patients</h3>

<% if(request.getParameter("updated") != null){ %>
<div class="alert alert-info">Patient Updated Successfully</div>
<% } %>

<% if(request.getParameter("deleted") != null){ %>
<div class="alert alert-danger">Patient Deleted Successfully</div>
<% } %>

<div class="d-flex justify-content-between mb-3">
<h5>Patient List</h5>
<input type="text" id="searchInput" onkeyup="searchPatient()"
class="form-control search-box"
placeholder="Search Patient...">
</div>

<table class="table table-bordered table-hover">
<thead class="table-dark">
<tr>
<th>ID</th>
<th>Name</th>
<th>Age</th>
<th>Gender</th>
<th>Contact</th>
<th>Email</th>
<th>Action</th>
</tr>
</thead>

<tbody id="patientTable">

<%
try{
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM patients");

while(rs.next()){
%>

<tr>
<td><%=rs.getInt("id")%></td>
<td><%=rs.getString("name")%></td>
<td><%=rs.getInt("age")%></td>
<td><%=rs.getString("gender")%></td>
<td><%=rs.getString("contact")%></td>
<td><%=rs.getString("email")%></td>
<td>

<a href="editPatient.jsp?id=<%=rs.getInt("id")%>"
class="btn btn-primary btn-sm">
<i class="fa fa-edit"></i>
</a>

<a href="PatientManageServlet?id=<%=rs.getInt("id")%>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete this patient?');">
<i class="fa fa-trash"></i>
</a>

</td>
</tr>

<%
}
con.close();
}catch(Exception e){
out.println("<tr><td colspan='7' class='text-danger'>"+e.getMessage()+"</td></tr>");
}
%>

</tbody>
</table>

</div>

</body>
</html>