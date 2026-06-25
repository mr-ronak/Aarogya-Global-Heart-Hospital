<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%

if(session.getAttribute("doctorId")==null){

response.sendRedirect("doctorLogin.jsp");
return;


}

int doctorId =
(Integer)session.getAttribute("doctorId");

%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>Doctor Profile</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

body{
background:#f4f6f9;
font-family:Segoe UI;
}

.sidebar{
position:fixed;
left:0;
top:0;
width:250px;
height:100%;
background:#1f2937;
padding-top:20px;
}

.sidebar h3{
color:white;
text-align:center;
margin-bottom:30px;
}

.sidebar a{
display:block;
padding:15px 25px;
color:white;
text-decoration:none;
}

.sidebar a:hover{
background:#374151;
}

.main{
margin-left:260px;
padding:30px;
}

.card{
border:none;
border-radius:15px;
box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

.profile-img{
width:150px;
height:150px;
border-radius:50%;
object-fit:cover;
border:4px solid #0d6efd;
}

</style>

</head>

<body>

<div class="sidebar">

<h3>Doctor Panel</h3>

<a href="doctorDashboard.jsp">
<i class="fa fa-home"></i> Dashboard
</a>

<a href="doctorAppointments.jsp">
<i class="fa fa-calendar"></i> My Appointments
</a>

<a href="doctorPatients.jsp">
<i class="fa fa-users"></i> Patients
</a>

<a href="doctorPrescription.jsp">
<i class="fa fa-file-medical"></i> Prescriptions
</a>

<a href="doctorProfile.jsp">
<i class="fa fa-user"></i> Profile
</a>

<a href="DoctorLogoutServlet">
<i class="fa fa-sign-out-alt"></i> Logout
</a>

</div>

<div class="main">

<div class="card p-4">

<h3 class="mb-4">

<i class="fa fa-user-md"></i>

My Profile

</h3>

<%

try{

Connection con =
DBConnection.getConnection();

PreparedStatement ps =
con.prepareStatement(
"SELECT * FROM doctors WHERE id=?"
);

ps.setInt(1, doctorId);

ResultSet rs =
ps.executeQuery();

if(rs.next()){

String photo =
rs.getString("photo");

%>

<% if(request.getParameter("success")!=null){ %>

<div class="alert alert-success">
Profile Updated Successfully
</div>

<% } %>

<% if(request.getParameter("error")!=null){ %>

<div class="alert alert-danger">
Profile Update Failed
</div>

<% } %>

<div class="text-center mb-4">

<%

if(photo!=null && !photo.trim().equals("")){

%>

<img src="<%=photo%>"
class="profile-img">

<%

}else{

%>

<img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
class="profile-img">

<%

}

%>

</div>

<form action="UpdateDoctorProfileServlet"
method="post">

<input type="hidden"
name="doctorId"
value="<%=rs.getInt("id")%>">

<div class="row">

<div class="col-md-6 mb-3">

<label>Name</label>

<input type="text"
name="name"
class="form-control"
value="<%=rs.getString("name")%>"
required>

</div>

<div class="col-md-6 mb-3">

<label>Specialization</label>

<input type="text"
name="specialization"
class="form-control"
value="<%=rs.getString("specialization")%>"
required>

</div>

<div class="col-md-6 mb-3">

<label>Experience</label>

<input type="number"
name="experience"
class="form-control"
value="<%=rs.getInt("experience")%>"
required>

</div>

<div class="col-md-6 mb-3">

<label>Contact</label>

<input type="text"
name="contact"
class="form-control"
value="<%=rs.getString("contact")%>">

</div>

<div class="col-md-6 mb-3">

<label>Email</label>

<input type="email"
name="email"
class="form-control"
value="<%=rs.getString("email")%>"
required>

</div>

<div class="col-md-6 mb-3">

<label>Photo URL</label>

<input type="text"
name="photo"
class="form-control"
value="<%=rs.getString("photo")%>">

</div>

<div class="col-md-6 mb-3">

<label>Schedule</label>

<input type="text"
name="schedule"
class="form-control"
value="<%=rs.getString("schedule")%>">

</div>

<div class="col-md-6 mb-3">

<label>Availability</label>

<select name="availability"
class="form-control">

<option value="Available"
<%= "Available".equals(rs.getString("availability")) ? "selected" : "" %>>
Available
</option>

<option value="Busy"
<%= "Busy".equals(rs.getString("availability")) ? "selected" : "" %>>
Busy
</option>

<option value="On Leave"
<%= "On Leave".equals(rs.getString("availability")) ? "selected" : "" %>>
On Leave
</option>

</select>

</div>

<div class="col-md-6 mb-3">

<label>Account Status</label>

<input type="text"
class="form-control"
value="<%=rs.getString("account_status")%>"
readonly>

</div>

<div class="col-md-6 mb-3">

<label>Status</label>

<input type="text"
class="form-control"
value="<%=rs.getString("status")%>"
readonly>

</div>

<div class="col-md-12 mb-3">

<label>Last Login</label>

<input type="text"
class="form-control"
value="<%=rs.getTimestamp("last_login")%>"
readonly>

</div>

<div class="col-md-12">

<button class="btn btn-success">

<i class="fa fa-save"></i>

Update Profile

</button>

</div>

</div>

</form>

<%

}

rs.close();
ps.close();
con.close();

}catch(Exception e){

%>

<div class="alert alert-danger">

<%=e.getMessage()%>

</div>

<%

}

%>

</div>

</div>

</body>
</html>
