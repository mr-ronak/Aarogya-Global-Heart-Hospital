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
import javax.servlet.http.HttpSession;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("patientId") == null) {

            response.sendRedirect("patientLogin.jsp");
            return;
        }

        int patientId =
                (int) session.getAttribute("patientId");

        int doctorId =
                Integer.parseInt(
                        request.getParameter("doctorId"));

        String date =
                request.getParameter("appointmentDate");

        String time =
                request.getParameter("appointmentTime");

        try {

            Connection con =
                    DBConnection.getConnection();

            // CHECK SAME SLOT

            String checkSql =
            "SELECT * FROM appointments WHERE doctor_id=? AND appointment_date=? AND appointment_time=?";

            PreparedStatement checkPs =
                    con.prepareStatement(checkSql);

            checkPs.setInt(1, doctorId);
            checkPs.setString(2, date);
            checkPs.setString(3, time);

            ResultSet rs =
                    checkPs.executeQuery();

            if(rs.next()) {

                response.getWriter().println(
                "<h3 style='color:red;text-align:center;margin-top:50px;'>Time Slot Already Booked!</h3>"
                );

                return;
            }

            // INSERT APPOINTMENT

            String sql =
            "INSERT INTO appointments(patient_id,doctor_id,appointment_date,appointment_time,status) VALUES(?,?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, patientId);
            ps.setInt(2, doctorId);
            ps.setString(3, date);
            ps.setString(4, time);
            ps.setString(5, "Pending");

            ps.executeUpdate();

            // ADVANCED NOTIFICATION

            NotificationUtility.addNotification(

                    patientId,

                    "Appointment Request Submitted",

                    "appointment",

                    "Your appointment request has been submitted successfully and is waiting for approval."

            );

            con.close();

            response.sendRedirect("index.jsp");

        }
        catch(Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error : " + e.getMessage());
        }
    }
}