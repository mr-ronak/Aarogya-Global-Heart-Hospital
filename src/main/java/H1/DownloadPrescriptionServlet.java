package H1;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DownloadPrescriptionServlet")
public class DownloadPrescriptionServlet
extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id =
                    Integer.parseInt(
                    request.getParameter("id"));

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(

                    "SELECT p.*, " +
                    "pt.name patient_name, " +
                    "d.name doctor_name " +
                    "FROM prescriptions p " +
                    "JOIN patients pt ON p.patient_id=pt.id " +
                    "JOIN doctors d ON p.doctor_id=d.id " +
                    "WHERE p.id=?"

                    );

            ps.setInt(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){

                byte[] pdf =

                PrescriptionPdfUtility
                .generatePrescriptionPdf(

                        rs.getInt("id"),

                        rs.getString("patient_name"),

                        rs.getString("doctor_name"),

                        rs.getString("symptoms"),

                        rs.getString("diagnosis"),

                        rs.getString("medicines"),

                        rs.getString("advice"),

                        rs.getString("created_at")

                );

                response.setContentType(
                        "application/pdf");

                response.setHeader(

                        "Content-Disposition",

                        "attachment; filename=Prescription.pdf"

                );

                response.getOutputStream()
                .write(pdf);
            }

            rs.close();
            ps.close();
            con.close();

        } catch(Exception e){

            e.printStackTrace();
        }
    }
}