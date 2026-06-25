<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Department</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
<div class="card shadow p-4">

<h4>Edit Department</h4>

<form action="DepartmentServlet" method="post">

<input type="hidden" name="action" value="update">
<input type="hidden" name="id" value="<%=request.getAttribute("id")%>">

<input type="text" name="name"
class="form-control mb-3"
value="<%=request.getAttribute("name")%>" required>

<input type="text" name="description"
class="form-control mb-3"
value="<%=request.getAttribute("description")%>" required>

<button type="submit" class="btn btn-success w-100">
Update Department
</button>

</form>

</div>
</div>

</body>
</html>