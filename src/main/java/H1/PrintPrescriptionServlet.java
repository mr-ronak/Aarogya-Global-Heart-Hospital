package H1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PrintPrescriptionServlet")
public class PrintPrescriptionServlet
extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out =
                response.getWriter();

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

                out.println("<html>");

                out.println("<head>");

                out.println("<title>Prescription</title>");

                out.println("<style>");

                out.println("body{font-family:Arial;padding:40px;}");

                out.println("table{width:100%;border-collapse:collapse;}");

                out.println("th,td{border:1px solid #ccc;padding:10px;}");

                out.println("</style>");

                out.println("</head>");

                out.println(

                "<body onload='window.print()'>"

                );

                out.println(
                "<h1>Aarogya Global Hospital</h1>");

                out.println(
                "<h3>Prescription</h3>");

                out.println(
                "<p><b>Patient :</b> "
                + rs.getString("patient_name")
                + "</p>");

                out.println(
                "<p><b>Doctor :</b> "
                + rs.getString("doctor_name")
                + "</p>");

                out.println(
                "<p><b>Date :</b> "
                + rs.getString("created_at")
                + "</p>");

                out.println("<table>");

                out.println(
                "<tr><th>Symptoms</th><td>"
                + rs.getString("symptoms")
                + "</td></tr>");

                out.println(
                "<tr><th>Diagnosis</th><td>"
                + rs.getString("diagnosis")
                + "</td></tr>");

                out.println(
                "<tr><th>Medicines</th><td>"
                + rs.getString("medicines")
                + "</td></tr>");

                out.println(
                "<tr><th>Advice</th><td>"
                + rs.getString("advice")
                + "</td></tr>");

                out.println("</table>");

                out.println("<br><br>");
                out.println(
                "Doctor Signature __________________");

                out.println("</body>");
                out.println("</html>");
            }

            rs.close();
            ps.close();
            con.close();

        } catch(Exception e){

            e.printStackTrace();
        }
    }
}