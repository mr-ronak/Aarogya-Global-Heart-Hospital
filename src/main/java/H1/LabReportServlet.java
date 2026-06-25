package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LabReportServlet")
public class LabReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int patientId =
                    Integer.parseInt(
                            request.getParameter("patient_id"));

            double hemoglobin =
                    Double.parseDouble(
                            request.getParameter("hemoglobin"));

            double rbc =
                    Double.parseDouble(
                            request.getParameter("rbc"));

            double wbc =
                    Double.parseDouble(
                            request.getParameter("wbc"));

            double platelets =
                    Double.parseDouble(
                            request.getParameter("platelets"));

            double sugar =
                    Double.parseDouble(
                            request.getParameter("blood_sugar"));

            double chol =
                    Double.parseDouble(
                            request.getParameter("cholesterol"));

            double heart =
                    Double.parseDouble(
                            request.getParameter("heart_rate"));

            String bp =
                    request.getParameter("bp");

            Connection con =
                    DBConnection.getConnection();

            // SAVE REPORT

            PreparedStatement ps =
                    con.prepareStatement(

                    "INSERT INTO lab_reports(patient_id,hemoglobin,rbc,wbc,platelets,blood_sugar,cholesterol,heart_rate,bp,status) VALUES(?,?,?,?,?,?,?,?,?,?)"

                    );

            ps.setInt(1, patientId);
            ps.setDouble(2, hemoglobin);
            ps.setDouble(3, rbc);
            ps.setDouble(4, wbc);
            ps.setDouble(5, platelets);
            ps.setDouble(6, sugar);
            ps.setDouble(7, chol);
            ps.setDouble(8, heart);
            ps.setString(9, bp);
            ps.setString(10, "Completed");

            ps.executeUpdate();

            // GET PATIENT DETAILS

            PreparedStatement patientPs =
                    con.prepareStatement(

                    "SELECT name,email FROM patients WHERE id=?"

                    );

            patientPs.setInt(1, patientId);

            ResultSet rs =
                    patientPs.executeQuery();

            String patientName = "";
            String patientEmail = "";

            if (rs.next()) {

                patientName =
                        rs.getString("name");

                patientEmail =
                        rs.getString("email");
            }

            // GENERATE PDF

            String projectPath =
                    getServletContext()
                    .getRealPath("/");

            String pdfPath =
                    PdfEmailUtility.generateLabReportPdf(

                            projectPath,

                            patientId,
                            patientName,

                            hemoglobin,
                            rbc,
                            wbc,
                            platelets,

                            sugar,
                            chol,
                            heart,

                            bp
                    );

            // SEND PDF EMAIL

            if (pdfPath != null) {

                EmailUtility.sendPdfEmail(

                        patientEmail,

                        patientName,

                        "Lab Report Ready",

                        "Your laboratory report has been generated successfully. PDF report is attached with this email.",

                        pdfPath
                );
            }

            // NOTIFICATION

            NotificationUtility.addNotification(

                    patientId,

                    "Lab Report Ready",

                    "report",

                    "Your laboratory report has been generated successfully and is now available for viewing."

            );

            rs.close();
            patientPs.close();
            ps.close();
            con.close();

            response.sendRedirect(
                    "addLabReport.jsp?success=1");

        }
        catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "addLabReport.jsp?error=1");
        }
    }
}