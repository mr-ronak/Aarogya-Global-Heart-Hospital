<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
<div class="card shadow p-4">

<h3 class="mb-4">My Profile</h3>

<table class="table table-bordered">
<tr><th>Name</th><td>${name}</td></tr>
<tr><th>Age</th><td>${age}</td></tr>
<tr><th>Gender</th><td>${gender}</td></tr>
<tr><th>Contact</th><td>${contact}</td></tr>
<tr><th>Email</th><td>${email}</td></tr>
</table>

<a href="updateProfile.jsp" class="btn btn-primary">Edit Profile</a>
<a href="changePassword.jsp" class="btn btn-warning">Change Password</a>
<a href="index.jsp" class="btn btn-secondary">Back</a>

</div>
</div>

</body>
</html>