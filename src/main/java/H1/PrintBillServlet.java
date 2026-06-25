package H1;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PrintBillServlet")
public class PrintBillServlet extends HttpServlet {

protected void doGet(HttpServletRequest request,HttpServletResponse response)
throws ServletException,IOException{

response.setContentType("text/html");
PrintWriter out=response.getWriter();

int id=Integer.parseInt(request.getParameter("id"));

try{

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(

"SELECT b.id,p.name patient,d.name doctor,b.base_amount,b.gst_amount,b.total_amount,b.created_at "+
"FROM bills b "+
"JOIN appointments a ON b.appointment_id=a.id "+
"JOIN doctors d ON a.doctor_id=d.id "+
"JOIN patients p ON a.patient_id=p.id "+
"WHERE b.id=?"

);

ps.setInt(1,id);
ResultSet rs=ps.executeQuery();

if(rs.next()){

out.println("<html><head>");

out.println("<style>");

out.println("body{font-family:Arial;padding:40px;background:#f4f6f9}");
out.println(".invoice{background:white;padding:30px;border-radius:8px}");
out.println(".header{display:flex;justify-content:space-between}");
out.println(".title{font-size:28px;font-weight:bold;color:#0d6efd}");
out.println("table{width:100%;border-collapse:collapse;margin-top:20px}");
out.println("th,td{border:1px solid #ddd;padding:10px;text-align:left}");
out.println("th{background:#0d6efd;color:white}");
out.println(".total{font-weight:bold;background:#f1f1f1}");
out.println("</style>");

out.println("</head>");

out.println("<body onload='window.print()'>");

out.println("<div class='invoice'>");

out.println("<div class='header'>");

out.println("<div class='title'>Aarogya Global Hospital</div>");

out.println("<div>");
out.println("Invoice #: "+rs.getInt("id")+"<br>");
out.println("Date: "+rs.getTimestamp("created_at"));
out.println("</div>");

out.println("</div>");

out.println("<hr>");

out.println("<h3>Patient: "+rs.getString("patient")+"</h3>");
out.println("<h4>Doctor: "+rs.getString("doctor")+"</h4>");

out.println("<table>");

out.println("<tr><th>Description</th><th>Amount</th></tr>");

out.println("<tr>");
out.println("<td>Consultation Fees</td>");
out.println("<td>₹ "+rs.getDouble("base_amount")+"</td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td>GST</td>");
out.println("<td>₹ "+rs.getDouble("gst_amount")+"</td>");
out.println("</tr>");

out.println("<tr class='total'>");
out.println("<td>Total</td>");
out.println("<td>₹ "+rs.getDouble("total_amount")+"</td>");
out.println("</tr>");

out.println("</table>");

out.println("<br><br>");
out.println("<p>Thank you for visiting Aarogya Global Hospital</p>");

out.println("</div>");
out.println("</body></html>");

}

con.close();

}catch(Exception e){
e.printStackTrace();
}

}
}