package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

@WebServlet("/DownloadLabReportServlet")
public class DownloadLabReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if(session.getAttribute("patientId")==null){
            response.sendRedirect("patientLogin.jsp");
            return;
        }

        int patientId = (Integer)session.getAttribute("patientId");

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "attachment; filename=LabReport.pdf");

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM lab_reports WHERE patient_id=? AND status='Completed' ORDER BY id DESC LIMIT 1");

            ps.setInt(1, patientId);

            ResultSet rs = ps.executeQuery();

            Document document = new Document(PageSize.A4);

            PdfWriter.getInstance(
                    document,
                    response.getOutputStream());

            document.open();

            Font titleFont =
                    new Font(Font.FontFamily.HELVETICA,20,Font.BOLD);

            document.add(new Paragraph(
                    "Aarogya Global Hospital",
                    titleFont));

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Laboratory Report"));
            document.add(new Paragraph(" "));

            if(rs.next()){

                document.add(new Paragraph(
                        "Patient ID : " +
                        rs.getInt("patient_id")));

                document.add(new Paragraph(
                        "Report Date : " +
                        rs.getTimestamp("report_date")));

                document.add(new Paragraph(" "));

                PdfPTable table =
                        new PdfPTable(3);

                table.setWidthPercentage(100);

                table.addCell("Test");
                table.addCell("Result");
                table.addCell("Normal Range");

                table.addCell("Hemoglobin");
                table.addCell(rs.getString("hemoglobin"));
                table.addCell("13 - 17");

                table.addCell("RBC");
                table.addCell(rs.getString("rbc"));
                table.addCell("4.5 - 5.9");

                table.addCell("WBC");
                table.addCell(rs.getString("wbc"));
                table.addCell("4000 - 11000");

                table.addCell("Platelets");
                table.addCell(rs.getString("platelets"));
                table.addCell("150000 - 450000");

                table.addCell("Blood Sugar");
                table.addCell(rs.getString("blood_sugar"));
                table.addCell("70 - 100");

                table.addCell("Cholesterol");
                table.addCell(rs.getString("cholesterol"));
                table.addCell("Less than 200");

                table.addCell("Heart Rate");
                table.addCell(rs.getString("heart_rate"));
                table.addCell("60 - 100");

                table.addCell("Blood Pressure");
                table.addCell(rs.getString("bp"));
                table.addCell("120/80");

                document.add(table);
            }
            else{

                document.add(new Paragraph(
                "No Lab Report Available"));
            }

            document.close();

            rs.close();
            ps.close();
            con.close();

        } catch(Exception e){

            e.printStackTrace();
        }
    }
}