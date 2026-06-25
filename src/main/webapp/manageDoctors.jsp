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

<meta charset="UTF-8">
<title>Manage Doctors</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

body{
background:linear-gradient(135deg,#eef2f7,#d9e4f5);
font-family:'Segoe UI';
}

.container-box{
max-width:1400px;
margin:auto;
padding:30px;
}

.card{
border:none;
border-radius:15px;
box-shadow:0 5px 20px rgba(0,0,0,.1);
}

.search-box{
width:250px;
}

.table img{
border-radius:50%;
object-fit:cover;
}

</style>

<script>

function searchDoctor(){

let input=
document.getElementById("searchInput")
.value.toLowerCase();

let rows=
document.querySelectorAll("#doctorTable tr");

rows.forEach(row=>{

let text=
row.innerText.toLowerCase();

row.style.display=
text.includes(input) ? "" : "none";

});

}

</script>

</head>

<body>

<div class="container-box">

<h2 class="mb-4">
<i class="fa fa-user-md"></i>
Manage Doctors
</h2>

<div class="card p-4 mb-4">

<h4 class="mb-3">Add Doctor</h4>

<form action="AddDoctorServlet" method="post">

<div class="row">

<div class="col-md-3">
<input type="text"
name="name"
class="form-control mb-3"
placeholder="Doctor Name"
required>
</div>

<div class="col-md-3">
<input type="text"
name="specialization"
class="form-control mb-3"
placeholder="Specialization"
required>
</div>

<div class="col-md-3">

<select name="department_id"
class="form-control mb-3"
required>

<option value="">
Select Department
</option>

<%

try{

Connection deptCon =
DBConnection.getConnection();

Statement deptSt =
deptCon.createStatement();

ResultSet deptRs =
deptSt.executeQuery(
"SELECT * FROM departments");

while(deptRs.next()){

%>

<option value="<%=deptRs.getInt("id")%>">

<%=deptRs.getString("name")%>

</option>

<%
}

deptRs.close();
deptSt.close();
deptCon.close();

}catch(Exception e){
out.println(e.getMessage());
}

%>

</select>

</div>

<div class="col-md-3">
<input type="number"
name="experience"
class="form-control mb-3"
placeholder="Experience"
required>
</div>

<div class="col-md-3">
<input type="text"
name="contact"
class="form-control mb-3"
placeholder="Contact">
</div>

<div class="col-md-3">
<input type="email"
name="email"
class="form-control mb-3"
placeholder="Email">
</div>

<div class="col-md-3">
<input type="password"
name="password"
class="form-control mb-3"
placeholder="Password">
</div>

<div class="col-md-3">
<input type="text"
name="photo"
class="form-control mb-3"
placeholder="Photo URL">
</div>

<div class="col-md-3">
<input type="text"
name="schedule"
class="form-control mb-3"
placeholder="Mon-Fri 10AM-5PM">
</div>

<div class="col-md-3">

<select name="availability"
class="form-control mb-3">

<option value="Available">
Available
</option>

<option value="Busy">
Busy
</option>

<option value="On Leave">
On Leave
</option>

</select>

</div>

<div class="col-md-3">

<select name="account_status"
class="form-control mb-3">

<option value="Approved">
Approved
</option>

<option value="Pending">
Pending
</option>

<option value="Rejected">
Rejected
</option>

</select>

</div>

<div class="col-md-3">

<select name="status"
class="form-control mb-3">

<option value="Active">
Active
</option>

<option value="Inactive">
Inactive
</option>

</select>

</div>

<div class="col-md-12">

<button class="btn btn-success w-100">

<i class="fa fa-plus"></i>

Add Doctor

</button>

</div>

</div>

</form>

</div>

<div class="card p-4">

<div class="d-flex justify-content-between mb-3">

<h4>Doctor List</h4>

<input type="text"
id="searchInput"
onkeyup="searchDoctor()"
class="form-control search-box"
placeholder="Search Doctor">

</div>

<table class="table table-bordered table-hover">

<thead class="table-dark">

<tr>

<th>ID</th>
<th>Photo</th>
<th>Name</th>
<th>Department</th>
<th>Specialization</th>
<th>Experience</th>
<th>Email</th>
<th>Availability</th>
<th>Account</th>
<th>Status</th>
<th>Last Login</th>
<th>Action</th>

</tr>

</thead>

<tbody id="doctorTable">
<%

try{

Connection con =
DBConnection.getConnection();

Statement st =
con.createStatement();

ResultSet rs =
st.executeQuery(

"SELECT d.*, dep.name AS department_name " +
"FROM doctors d " +
"LEFT JOIN departments dep " +
"ON d.department_id = dep.id " +
"ORDER BY d.id DESC"

);

while(rs.next()){

%>

<tr>

<td>
<%=rs.getInt("id")%>
</td>

<td>

<%

String photo =
rs.getString("photo");

if(photo!=null &&
!photo.trim().equals("")){

%>

<img src="<%=photo%>"
width="50"
height="50">

<%

}else{

%>

<img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
width="50"
height="50">

<%
}
%>

</td>

<td>
<%=rs.getString("name")%>
</td>

<td>
<%=rs.getString("department_name")%>
</td>

<td>
<%=rs.getString("specialization")%>
</td>

<td>
<%=rs.getInt("experience")%> Years
</td>

<td>
<%=rs.getString("email")%>
</td>

<td>

<%

String availability =
rs.getString("availability");

if("Available".equalsIgnoreCase(availability)){
%>

<span class="badge bg-success">
Available
</span>

<%
}else if("Busy".equalsIgnoreCase(availability)){
%>

<span class="badge bg-warning text-dark">
Busy
</span>

<%
}else{
%>

<span class="badge bg-danger">
On Leave
</span>

<%
}
%>

</td>

<td>

<span class="badge bg-primary">

<%=rs.getString("account_status")==null ?
"Approved" :
rs.getString("account_status")%>

</span>

</td>

<td>

<span class="badge bg-dark">

<%=rs.getString("status")==null ?
"Active" :
rs.getString("status")%>

</span>

</td>

<td>

<%

Timestamp lastLogin =
rs.getTimestamp("last_login");

if(lastLogin!=null){

out.print(lastLogin);

}else{

out.print("Never");

}

%>

</td>

<td>

<a href="EditDoctorServlet?id=<%=rs.getInt("id")%>"
class="btn btn-primary btn-sm me-1">

<i class="fa fa-edit"></i>

</a>

<a href="DeleteDoctorServlet?id=<%=rs.getInt("id")%>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete Doctor?')">

<i class="fa fa-trash"></i>

</a>

</td>

</tr>

<%

}

rs.close();
st.close();
con.close();

}catch(Exception e){

%>

<tr>

<td colspan="12"
class="text-center text-danger">

<%=e.getMessage()%>

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