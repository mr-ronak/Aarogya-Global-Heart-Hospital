<%@ page session="true" %>

<%

if(session.getAttribute("doctorId")==null){

response.sendRedirect("doctorLogin.jsp");
return;


}

int doctorId =
(Integer)session.getAttribute("doctorId");

String patientId =
request.getParameter("patientId");

String appointmentId =
request.getParameter("appointmentId");

if(patientId==null) patientId="0";
if(appointmentId==null) appointmentId="0";

%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<title>Write Prescription</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
background:#f4f6f9;
font-family:Segoe UI;
}

.card{
border:none;
border-radius:15px;
box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

</style>

</head>

<body>

<div class="container mt-5">

<div class="card p-4">

<h3 class="mb-4">

Write Prescription

</h3>

<form action="SavePrescriptionServlet"
method="post">

<input type="hidden"
name="doctorId"
value="<%=doctorId%>">

<input type="hidden"
name="patientId"
value="<%=patientId%>">

<input type="hidden"
name="appointmentId"
value="<%=appointmentId%>">

<div class="mb-3">

<label>Symptoms</label>

<textarea
name="symptoms"
class="form-control"
rows="4"
required></textarea>

</div>

<div class="mb-3">

<label>Diagnosis</label>

<textarea
name="diagnosis"
class="form-control"
rows="4"
required></textarea>

</div>

<div class="mb-3">

<label>Medicines</label>

<textarea
name="medicines"
class="form-control"
rows="5"
required></textarea>

</div>

<div class="mb-3">

<label>Advice</label>

<textarea
name="advice"
class="form-control"
rows="4"
required></textarea>

</div>

<button class="btn btn-success">

Save Prescription

</button>

<a href="doctorAppointments.jsp"
class="btn btn-secondary">

Back

</a>

</form>

</div>

</div>

</body>
</html>
