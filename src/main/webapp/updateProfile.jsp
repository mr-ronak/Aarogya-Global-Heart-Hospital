<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%
    if(session.getAttribute("patientId") == null){
        response.sendRedirect("patientLogin.jsp");
        return;
    }

    int patientId = (int) session.getAttribute("patientId");

    String name="";
    int age=0;
    String gender="";
    String contact="";
    String email="";

    try{
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM patients WHERE id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, patientId);

        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            name = rs.getString("name");
            age = rs.getInt("age");
            gender = rs.getString("gender");
            contact = rs.getString("contact");
            email = rs.getString("email");
        }

        con.close();
    }catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Profile</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
<div class="card shadow p-4">

<h3 class="mb-4">Update Profile</h3>

<form action="UpdateProfileServlet" method="post">

<input type="text" name="name" class="form-control mb-3" value="<%=name%>" required>

<input type="number" name="age" class="form-control mb-3" value="<%=age%>" required>

<select name="gender" class="form-control mb-3">
<option <%= gender.equals("Male")?"selected":"" %>>Male</option>
<option <%= gender.equals("Female")?"selected":"" %>>Female</option>
<option <%= gender.equals("Other")?"selected":"" %>>Other</option>
</select>

<input type="text" name="contact" class="form-control mb-3" value="<%=contact%>" required>

<input type="email" name="email" class="form-control mb-3" value="<%=email%>" required>

<button type="submit" class="btn btn-success w-100">Update</button>

</form>

<a href="ProfileServlet" class="btn btn-secondary mt-3">Back</a>

</div>
</div>

</body>
</html>