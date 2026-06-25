<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%
if(session.getAttribute("adminUser")==null){
response.sendRedirect("adminLogin.jsp");
return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>Manage Departments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

body{
background:linear-gradient(135deg,#eef2f7,#d9e4f5);
font-family:'Segoe UI';
}

.container-box{
max-width:1100px;
margin:auto;
padding:40px;
}

.card{
border-radius:15px;
border:none;
transition:0.4s;
}

.card:hover{
transform:translateY(-5px);
box-shadow:0 15px 30px rgba(0,0,0,0.15);
}

.search-box{
width:250px;
border-radius:20px;
}

.table tbody tr:hover{
background:#f1f6ff;
transform:scale(1.01);
}

.btn{
border-radius:8px;
}

</style>

<script>

function searchDepartment(){

let input=document.getElementById("searchInput").value.toLowerCase();
let rows=document.querySelectorAll("#deptTable tr");

rows.forEach(row=>{
let text=row.innerText.toLowerCase();
row.style.display=text.includes(input)?"":"none";
});

}

</script>

</head>

<body>

<div class="container-box">

<h3 class="mb-4">
<i class="fa fa-building"></i> Manage Departments
</h3>

<!-- ADD DEPARTMENT -->

<div class="card p-4 mb-4 shadow">

<h5>Add Department</h5>

<form action="DepartmentServlet" method="post">

<input type="hidden" name="action" value="add">

<div class="row">

<div class="col-md-5">

<input list="departmentList"
name="name"
class="form-control"
placeholder="Select or type department"
required>

<datalist id="departmentList">

<%
try{

Connection con=DBConnection.getConnection();
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("SELECT name FROM departments");

while(rs.next()){
%>

<option value="<%=rs.getString("name")%>">

<%
}

con.close();

}catch(Exception e){
out.println(e);
}
%>

</datalist>

</div>

<div class="col-md-5">

<input type="text"
name="description"
class="form-control"
placeholder="Department Description"
required>

</div>

<div class="col-md-2">

<button class="btn btn-success w-100">
<i class="fa fa-plus"></i> Add
</button>

</div>

</div>

</form>

</div>

<!-- LIST -->

<div class="card p-4 shadow">

<div class="d-flex justify-content-between mb-3">

<h5>Department List</h5>

<input type="text"
id="searchInput"
onkeyup="searchDepartment()"
class="form-control search-box"
placeholder="Search Department">

</div>

<table class="table table-bordered table-hover">

<thead class="table-dark">
<tr>
<th>ID</th>
<th>Name</th>
<th>Description</th>
<th>Action</th>
</tr>
</thead>

<tbody id="deptTable">

<%

try{

Connection con=DBConnection.getConnection();
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("SELECT * FROM departments");

while(rs.next()){
%>

<tr>

<td><%=rs.getInt("id")%></td>
<td><%=rs.getString("name")%></td>
<td><%=rs.getString("description")%></td>

<td>

<a href="EditDepartmentServlet?id=<%=rs.getInt("id")%>"
class="btn btn-primary btn-sm">
<i class="fa fa-edit"></i>
</a>

<a href="DepartmentServlet?action=delete&id=<%=rs.getInt("id")%>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete department?');">
<i class="fa fa-trash"></i>
</a>

</td>

</tr>

<%
}

con.close();

}catch(Exception e){

out.println("<tr><td colspan='4'>"+e.getMessage()+"</td></tr>");

}
%>

</tbody>

</table>

</div>

</div>

</body>
</html>