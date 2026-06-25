package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SavePrescriptionServlet")
public class SavePrescriptionServlet
extends HttpServlet {


private static final long serialVersionUID = 1L;

protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try{

        int doctorId =
        Integer.parseInt(
        request.getParameter("doctorId"));

        int patientId =
        Integer.parseInt(
        request.getParameter("patientId"));

        int appointmentId =
        Integer.parseInt(
        request.getParameter("appointmentId"));

        String symptoms =
        request.getParameter("symptoms");

        String diagnosis =
        request.getParameter("diagnosis");

        String medicines =
        request.getParameter("medicines");

        String advice =
        request.getParameter("advice");

        Connection con =
        DBConnection.getConnection();

        PreparedStatement ps =
        con.prepareStatement(

        "INSERT INTO prescriptions(patient_id,doctor_id,appointment_id,symptoms,diagnosis,medicines,advice) VALUES(?,?,?,?,?,?,?)"

        );

        ps.setInt(1, patientId);
        ps.setInt(2, doctorId);
        ps.setInt(3, appointmentId);
        ps.setString(4, symptoms);
        ps.setString(5, diagnosis);
        ps.setString(6, medicines);
        ps.setString(7, advice);

        ps.executeUpdate();

        NotificationUtility.addNotification(

                patientId,

                "Prescription Ready",

                "prescription",

                "Doctor has uploaded a prescription for your appointment."

        );

        ps.close();
        con.close();

        response.sendRedirect(
        "doctorAppointments.jsp?saved=1");

    }
    catch(Exception e){

        e.printStackTrace();
    }
}

}
