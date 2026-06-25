package H1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PrintLabReportServlet")
public class PrintLabReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if(session.getAttribute("patientId")==null){
            response.sendRedirect("patientLogin.jsp");
            return;
        }

        int patientId =
                (Integer)session.getAttribute("patientId");

        response.setContentType("text/html");

        PrintWriter out =
                response.getWriter();

        try{

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(

                    "SELECT * FROM lab_reports WHERE patient_id=? AND status='Completed' ORDER BY id DESC LIMIT 1"

                    );

            ps.setInt(1, patientId);

            ResultSet rs =
                    ps.executeQuery();

            out.println("<html>");
            out.println("<body onload='window.print()'>");

            if(rs.next()){

                out.println("<h1>Aarogya Global Hospital</h1>");
                out.println("<h3>Laboratory Report</h3>");

                out.println("<hr>");

                out.println("<p>Patient ID : "
                        + rs.getInt("patient_id")
                        + "</p>");

                out.println("<p>Date : "
                        + rs.getTimestamp("report_date")
                        + "</p>");

                out.println("<table border='1' width='100%'>");

                out.println("<tr>");
                out.println("<th>Test</th>");
                out.println("<th>Result</th>");
                out.println("<th>Normal</th>");
                out.println("</tr>");

                out.println("<tr><td>Hemoglobin</td><td>"
                        + rs.getDouble("hemoglobin")
                        + "</td><td>13 - 17</td></tr>");

                out.println("<tr><td>RBC</td><td>"
                        + rs.getDouble("rbc")
                        + "</td><td>4.5 - 5.9</td></tr>");

                out.println("<tr><td>WBC</td><td>"
                        + rs.getDouble("wbc")
                        + "</td><td>4000 - 11000</td></tr>");

                out.println("<tr><td>Platelets</td><td>"
                        + rs.getDouble("platelets")
                        + "</td><td>150000 - 450000</td></tr>");

                out.println("<tr><td>Blood Sugar</td><td>"
                        + rs.getDouble("blood_sugar")
                        + "</td><td>70 - 100</td></tr>");

                out.println("<tr><td>Cholesterol</td><td>"
                        + rs.getDouble("cholesterol")
                        + "</td><td>< 200</td></tr>");

                out.println("<tr><td>Heart Rate</td><td>"
                        + rs.getDouble("heart_rate")
                        + "</td><td>60 - 100</td></tr>");

                out.println("<tr><td>Blood Pressure</td><td>"
                        + rs.getString("bp")
                        + "</td><td>120/80</td></tr>");

                out.println("</table>");

            }
            else{

                out.println("<h3>No Report Available</h3>");
            }

            out.println("</body>");
            out.println("</html>");

            con.close();

        }catch(Exception e){

            e.printStackTrace();
        }
    }
}