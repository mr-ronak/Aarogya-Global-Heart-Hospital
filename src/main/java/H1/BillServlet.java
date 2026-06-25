package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {


private static final long serialVersionUID = 1L;

// GENERATE BILL

protected void doPost(HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {

        int appointmentId =
                Integer.parseInt(
                        request.getParameter("appointment_id"));

        double baseAmount =
                Double.parseDouble(
                        request.getParameter("base_amount"));

        double gstPercentage =
                Double.parseDouble(
                        request.getParameter("gst_percentage"));

        String paymentMode =
                request.getParameter("payment_mode");

        double gstAmount =
                (baseAmount * gstPercentage) / 100;

        double totalAmount =
                baseAmount + gstAmount;

        Connection con =
                DBConnection.getConnection();

        PreparedStatement ps =
                con.prepareStatement(

                "INSERT INTO bills(appointment_id,base_amount,gst_percentage,gst_amount,total_amount,payment_mode,payment_status) VALUES(?,?,?,?,?,?,?)",

                Statement.RETURN_GENERATED_KEYS

                );

        ps.setInt(1, appointmentId);
        ps.setDouble(2, baseAmount);
        ps.setDouble(3, gstPercentage);
        ps.setDouble(4, gstAmount);
        ps.setDouble(5, totalAmount);
        ps.setString(6, paymentMode);
        ps.setString(7, "Unpaid");

        ps.executeUpdate();

        int billId = 0;

        ResultSet generatedKeys =
                ps.getGeneratedKeys();

        if (generatedKeys.next()) {

            billId =
                    generatedKeys.getInt(1);
        }

        // GET PATIENT DETAILS

        PreparedStatement patientPs =
                con.prepareStatement(

                "SELECT p.id,p.name,p.email,d.name doctor_name " +
                "FROM appointments a " +
                "JOIN patients p ON a.patient_id=p.id " +
                "JOIN doctors d ON a.doctor_id=d.id " +
                "WHERE a.id=?"

                );

        patientPs.setInt(1, appointmentId);

        ResultSet rs =
                patientPs.executeQuery();

        int patientId = 0;
        String patientName = "";
        String patientEmail = "";
        String doctorName = "";

        if(rs.next()){

            patientId =
                    rs.getInt("id");

            patientName =
                    rs.getString("name");

            patientEmail =
                    rs.getString("email");

            doctorName =
                    rs.getString("doctor_name");
        }

        // GENERATE PDF

        String projectPath =
                getServletContext()
                .getRealPath("/");

        String pdfPath =
                PdfEmailUtility.generateBillPdf(

                        projectPath,

                        billId,

                        patientName,

                        doctorName,

                        baseAmount,

                        gstAmount,

                        totalAmount
                );

        // SEND PDF EMAIL

        if(pdfPath != null){

            EmailUtility.sendPdfEmail(

                    patientEmail,

                    patientName,

                    "Hospital Bill Generated",

                    "Your hospital bill has been generated successfully. Please find the attached PDF invoice.",

                    pdfPath
            );
        }

        // NOTIFICATION

        NotificationUtility.addNotification(

                patientId,

                "Bill Generated",

                "billing",

                "A new hospital bill has been generated. Please check your billing section."
        );

        rs.close();
        patientPs.close();
        ps.close();
        con.close();

        response.sendRedirect(
                "manageBills.jsp?success=1");

    }
    catch(Exception e){

        e.printStackTrace();

        response.sendRedirect(
                "manageBills.jsp?error=1");
    }
}

// MARK BILL AS PAID

protected void doGet(HttpServletRequest request,
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

                "UPDATE bills SET payment_status='Paid' WHERE id=?"

                );

        ps.setInt(1, id);

        ps.executeUpdate();

        PreparedStatement patientPs =
                con.prepareStatement(

                "SELECT p.id,p.name,p.email " +
                "FROM bills b " +
                "JOIN appointments a ON b.appointment_id=a.id " +
                "JOIN patients p ON a.patient_id=p.id " +
                "WHERE b.id=?"

                );

        patientPs.setInt(1, id);

        ResultSet rs =
                patientPs.executeQuery();

        int patientId = 0;
        String patientName = "";
        String patientEmail = "";

        if(rs.next()){

            patientId =
                    rs.getInt("id");

            patientName =
                    rs.getString("name");

            patientEmail =
                    rs.getString("email");
        }

        EmailUtility.sendNotificationEmail(

                patientEmail,

                "Payment Received",

                "Dear " + patientName +
                ",<br><br>Your bill payment has been received successfully."
        );

        NotificationUtility.addNotification(

                patientId,

                "Payment Received",

                "billing",

                "Your bill payment has been received successfully."
        );

        rs.close();
        patientPs.close();
        ps.close();
        con.close();

        response.sendRedirect(
                "manageBills.jsp?paid=1");

    }
    catch(Exception e){

        e.printStackTrace();

        response.sendRedirect(
                "manageBills.jsp?error=1");
    }
}


}
