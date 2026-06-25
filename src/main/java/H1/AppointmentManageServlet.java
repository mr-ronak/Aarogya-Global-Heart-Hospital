package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AppointmentManageServlet")
public class AppointmentManageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        try {

            if (action != null && idParam != null) {

                int id = Integer.parseInt(idParam);

                Connection con = DBConnection.getConnection();

                String status = "Pending";

                if ("approve".equals(action)) {
                    status = "Approved";
                }

                if ("cancel".equals(action)) {
                    status = "Cancelled";
                }

                // UPDATE APPOINTMENT STATUS

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE appointments SET status=? WHERE id=?");

                ps.setString(1, status);
                ps.setInt(2, id);

                ps.executeUpdate();

                // GET PATIENT ID

                PreparedStatement getPatient = con.prepareStatement(
                        "SELECT patient_id FROM appointments WHERE id=?");

                getPatient.setInt(1, id);

                ResultSet rs = getPatient.executeQuery();

                int patientId = 0;

                if (rs.next()) {
                    patientId = rs.getInt("patient_id");
                }

                // ADVANCED NOTIFICATION

                if ("Approved".equals(status)) {

                    NotificationUtility.addNotification(

                            patientId,

                            "Appointment Approved",

                            "appointment",

                            "Congratulations! Your appointment has been approved by the hospital administration."

                    );

                } else if ("Cancelled".equals(status)) {

                    NotificationUtility.addNotification(

                            patientId,

                            "Appointment Cancelled",

                            "appointment",

                            "Your appointment has been cancelled. Please book another appointment if required."

                    );
                }

                con.close();
            }

            response.sendRedirect("manageAppointments.jsp");

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}