<%@ page session="true" %>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>Edit Doctor</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
background:#f4f6f9;
font-family:'Segoe UI';
}

.card{
border-radius:15px;
border:none;
box-shadow:0 5px 15px rgba(0,0,0,0.15);
}

</style>

</head>

<body>

<div class="container mt-5">

<div class="card p-4">

<h3 class="mb-4">

Edit Doctor

</h3>

<form action="UpdateDoctorServlet" method="post">

<input type="hidden"
name="id"
value="<%=request.getAttribute("id")%>">

<div class="row">

<div class="col-md-6">

<label>Doctor Name</label>

<input type="text"
name="name"
class="form-control mb-3"
value="<%=request.getAttribute("name")%>"
required>

</div>

<div class="col-md-6">

<label>Specialization</label>

<input type="text"
name="specialization"
class="form-control mb-3"
value="<%=request.getAttribute("specialization")%>"
required>

</div>

<div class="col-md-4">

<label>Experience</label>

<input type="number"
name="experience"
class="form-control mb-3"
value="<%=request.getAttribute("experience")%>"
required>

</div>

<div class="col-md-4">

<label>Contact</label>

<input type="text"
name="contact"
class="form-control mb-3"
value="<%=request.getAttribute("contact")%>">

</div>

<div class="col-md-4">

<label>Email</label>

<input type="email"
name="email"
class="form-control mb-3"
value="<%=request.getAttribute("email")%>">

</div>

<div class="col-md-6">

<label>Password</label>

<input type="text"
name="password"
class="form-control mb-3"
value="<%=request.getAttribute("password")%>">

</div>

<div class="col-md-6">

<label>Photo URL</label>

<input type="text"
name="photo"
class="form-control mb-3"
value="<%=request.getAttribute("photo")%>">

</div>

<div class="col-md-6">

<label>Schedule</label>

<input type="text"
name="schedule"
class="form-control mb-3"
value="<%=request.getAttribute("schedule")%>"
placeholder="Mon-Fri 10AM-5PM">

</div>

<div class="col-md-6">

<label>Availability</label>

<select
name="availability"
class="form-control mb-3">

<option value="Available"
<% if("Available".equals(String.valueOf(request.getAttribute("availability")))){ %>
selected
<% } %>>
Available
</option>

<option value="Busy"
<% if("Busy".equals(String.valueOf(request.getAttribute("availability")))){ %>
selected
<% } %>>
Busy
</option>

<option value="On Leave"
<% if("On Leave".equals(String.valueOf(request.getAttribute("availability")))){ %>
selected
<% } %>>
On Leave
</option>

</select>

</div>

<div class="col-md-6">

<label>Account Status</label>

<select
name="account_status"
class="form-control mb-3">

<option value="Approved">Approved</option>
<option value="Pending">Pending</option>
<option value="Rejected">Rejected</option>

</select>

</div>

<div class="col-md-6">

<label>Status</label>

<select
name="status"
class="form-control mb-3">

<option value="Active">Active</option>
<option value="Inactive">Inactive</option>

</select>

</div>

<div class="col-md-12">

<label>Last Login</label>

<input type="text"
class="form-control mb-3"
value="<%=request.getAttribute("last_login")%>"
readonly>

</div>

<div class="col-md-12">

<button
type="submit"
class="btn btn-success w-100">

Update Doctor

</button>

</div>

</div>

</form>

</div>

</div>

</body>
</html>
