<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>
<%@ page session="true" %>

<%

/* Check Login */

if(session.getAttribute("patientId")==null){
    response.sendRedirect("patientLogin.jsp");
    return;
}

int patientId = (Integer)session.getAttribute("patientId");

%>

<!DOCTYPE html>
<html>

<head>

<title>My Bills</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:#f4f6f9;
}

.card{
    border-radius:10px;
}

.badge-paid{
    background:green;
}

.badge-unpaid{
    background:red;
}

</style>

</head>

<body>

<div class="container mt-5">

<div class="card shadow p-4">

<h4 class="mb-4">My Billing Reports</h4>

<table class="table table-bordered table-hover">

<tr class="table-dark">

<th>Bill ID</th>
<th>Doctor</th>
<th>Base Amount</th>
<th>GST</th>
<th>Total</th>
<th>Status</th>
<th>Date</th>
<th>Action</th>

</tr>

<%

try{

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(

"SELECT b.id, d.name doctor, b.base_amount, b.gst_amount, b.total_amount, b.payment_status, b.created_at " +
"FROM bills b " +
"JOIN appointments a ON b.appointment_id = a.id " +
"JOIN doctors d ON a.doctor_id = d.id " +
"WHERE a.patient_id=?"

);

ps.setInt(1, patientId);

ResultSet rs = ps.executeQuery();

boolean found=false;

while(rs.next()){

found=true;

%>

<tr>

<td><%=rs.getInt("id")%></td>

<td><%=rs.getString("doctor")%></td>

<td>₹ <%=rs.getDouble("base_amount")%></td>

<td>₹ <%=rs.getDouble("gst_amount")%></td>

<td><b>₹ <%=rs.getDouble("total_amount")%></b></td>

<td>

<span class="badge <%=rs.getString("payment_status").equals("Paid") ? "badge-paid":"badge-unpaid"%>">

<%=rs.getString("payment_status")%>

</span>

</td>

<td><%=rs.getTimestamp("created_at")%></td>

<td>

<!-- PRINT BILL -->

<a href="PrintBillServlet?id=<%=rs.getInt("id")%>"
class="btn btn-primary btn-sm"
target="_blank">

Print

</a>

<!-- DOWNLOAD PDF -->

<a href="DownloadBillServlet?id=<%=rs.getInt("id")%>"
class="btn btn-success btn-sm">

PDF

</a>

</td>

</tr>

<%

}

if(!found){

%>

<tr>

<td colspan="8" class="text-center text-danger">

No Bills Found

</td>

</tr>

<%

}

con.close();

}catch(Exception e){

out.println("<div class='alert alert-danger'>"+e.getMessage()+"</div>");

}

%>

</table>

</div>

</div>

</body>

</html>