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

<title>Billing System</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{background:#f4f6f9;}
.container{margin-top:40px;}
.badge-paid{background:green;}
.badge-unpaid{background:red;}
</style>

<script>
function calculateTotal(){

let base = parseFloat(document.getElementById("base").value) || 0;
let gst = parseFloat(document.getElementById("gst").value) || 0;

let gstAmount = (base * gst) / 100;
let total = base + gstAmount;

document.getElementById("gst_amount").value = gstAmount.toFixed(2);
document.getElementById("total_amount").value = total.toFixed(2);

}
</script>

</head>

<body>

<div class="container">

<h3>Billing System</h3>

<% if(request.getParameter("success") != null){ %>
<div class="alert alert-success">Bill Generated Successfully</div>
<% } %>

<% if(request.getParameter("paid") != null){ %>
<div class="alert alert-info">Payment Updated</div>
<% } %>

<!-- BILL FORM -->

<div class="card p-4 mb-4">

<h5>Generate Bill</h5>

<form action="BillServlet" method="post">

<select name="appointment_id" class="form-control mb-3" required>

<option value="">Select Appointment</option>

<%

Connection con = DBConnection.getConnection();

Statement st = con.createStatement();

ResultSet rs = st.executeQuery("SELECT id FROM appointments");

while(rs.next()){

%>

<option value="<%=rs.getInt("id")%>">Appointment #<%=rs.getInt("id")%></option>

<% } con.close(); %>

</select>


<select name="payment_mode" class="form-control mb-3">
<option>Cash</option>
<option>Card</option>
<option>UPI</option>
<option>Online</option>
</select>

<input type="number" id="base" name="base_amount" onkeyup="calculateTotal()" class="form-control mb-3" placeholder="Base Amount" required>

<input type="number" id="gst" name="gst_percentage" value="18" onkeyup="calculateTotal()" class="form-control mb-3">

<input type="text" id="gst_amount" class="form-control mb-3" placeholder="GST Amount" readonly>

<input type="text" id="total_amount" class="form-control mb-3" placeholder="Total Amount" readonly>

<button class="btn btn-success w-100">Generate Bill</button>

</form>

</div>

<!-- UNPAID BILLS -->

<div class="card p-4 mb-4">

<h5 class="text-danger">Unpaid Bills</h5>

<table class="table table-bordered">

<tr class="table-dark">

<th>ID</th>
<th>Appointment</th>
<th>Total</th>
<th>Mode</th>
<th>Status</th>
<th>Action</th>

</tr>

<%

Connection con2 = DBConnection.getConnection();

Statement st2 = con2.createStatement();

ResultSet rs2 = st2.executeQuery("SELECT * FROM bills WHERE payment_status='Unpaid'");

while(rs2.next()){

%>

<tr>

<td><%=rs2.getInt("id")%></td>

<td>#<%=rs2.getInt("appointment_id")%></td>

<td>₹ <%=rs2.getDouble("total_amount")%></td>

<td><%=rs2.getString("payment_mode")%></td>

<td><span class="badge badge-unpaid">Unpaid</span></td>

<td>

<a href="BillServlet?id=<%=rs2.getInt("id")%>" class="btn btn-success btn-sm">
Mark Paid
</a>

</td>

</tr>

<% } con2.close(); %>

</table>

</div>

<!-- PAID BILLS -->

<div class="card p-4">

<h5 class="text-success">Paid Bills</h5>

<table class="table table-bordered">

<tr class="table-dark">

<th>ID</th>
<th>Appointment</th>
<th>Total</th>
<th>Mode</th>
<th>Status</th>

</tr>

<%

Connection con3 = DBConnection.getConnection();

Statement st3 = con3.createStatement();

ResultSet rs3 = st3.executeQuery("SELECT * FROM bills WHERE payment_status='Paid'");

while(rs3.next()){

%>

<tr>

<td><%=rs3.getInt("id")%></td>

<td>#<%=rs3.getInt("appointment_id")%></td>

<td>₹ <%=rs3.getDouble("total_amount")%></td>

<td><%=rs3.getString("payment_mode")%></td>

<td><span class="badge badge-paid">Paid</span></td>

</tr>

<% } con3.close(); %>

</table>

</div>

</div>

</body>
</html>