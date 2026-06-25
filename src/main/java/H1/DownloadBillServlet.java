package H1;

import java.io.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

@WebServlet("/DownloadBillServlet")
public class DownloadBillServlet extends HttpServlet {

protected void doGet(HttpServletRequest request,HttpServletResponse response)
throws ServletException,IOException{

int id=Integer.parseInt(request.getParameter("id"));

response.setContentType("application/pdf");
response.setHeader("Content-Disposition","attachment; filename=invoice.pdf");

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

Document document=new Document();
PdfWriter.getInstance(document,response.getOutputStream());

document.open();

Font titleFont=new Font(Font.FontFamily.HELVETICA,20,Font.BOLD);
Font headerFont=new Font(Font.FontFamily.HELVETICA,12,Font.BOLD);
Font textFont=new Font(Font.FontFamily.HELVETICA,12);

if(rs.next()){

document.add(new Paragraph("Aarogya Global Hospital",titleFont));
document.add(new Paragraph("Invoice #: "+rs.getInt("id"),textFont));
document.add(new Paragraph("Date: "+rs.getTimestamp("created_at"),textFont));
document.add(new Paragraph(" "));
document.add(new Paragraph("Patient: "+rs.getString("patient"),headerFont));
document.add(new Paragraph("Doctor: "+rs.getString("doctor"),headerFont));
document.add(new Paragraph(" "));

PdfPTable table=new PdfPTable(2);

table.addCell("Description");
table.addCell("Amount");

table.addCell("Consultation Fees");
table.addCell("₹ "+rs.getDouble("base_amount"));

table.addCell("GST");
table.addCell("₹ "+rs.getDouble("gst_amount"));

table.addCell("Total");
table.addCell("₹ "+rs.getDouble("total_amount"));

document.add(table);

document.add(new Paragraph(" "));
document.add(new Paragraph("Thank you for visiting Aarogya Global Hospital",textFont));

}

document.close();

con.close();

}catch(Exception e){
e.printStackTrace();
}

}
}