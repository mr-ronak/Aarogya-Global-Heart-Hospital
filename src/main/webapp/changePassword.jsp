<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Password</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<%
    if(session.getAttribute("patientId") == null){
        response.sendRedirect("patientLogin.jsp");
        return;
    }
%>

<div class="container mt-5">
<div class="card shadow p-4">

<h3 class="mb-4">Change Password</h3>

<% if(request.getParameter("success") != null){ %>
<div class="alert alert-success">Password Changed Successfully!</div>
<% } %>

<% if(request.getParameter("error") != null){ %>
<div class="alert alert-danger">Old Password Incorrect!</div>
<% } %>

<form action="ChangePasswordServlet" method="post">

<div class="mb-3">
<label>Old Password</label>
<input type="password" name="oldPassword" class="form-control" required>
</div>

<div class="mb-3">
<label>New Password</label>
<input type="password" name="newPassword" class="form-control" required>
</div>

<button type="submit" class="btn btn-primary w-100">Update Password</button>

</form>

<a href="ProfileServlet" class="btn btn-secondary mt-3">Back</a>

</div>
</div>

</body>
</html>