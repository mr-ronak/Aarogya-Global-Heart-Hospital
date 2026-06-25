package H1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class NotificationUtility {

public static void addNotification(
        int patientId,
        String title,
        String type,
        String message) {

    try {

        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(

        "INSERT INTO notifications(patient_id,title,notification_type,message,status) VALUES(?,?,?,?,?)"

        );

        ps.setInt(1, patientId);
        ps.setString(2, title);
        ps.setString(3, type);
        ps.setString(4, message);
        ps.setString(5, "Unread");

        ps.executeUpdate();

        PreparedStatement patientPs = con.prepareStatement(

        "SELECT email,name FROM patients WHERE id=?"

        );

        patientPs.setInt(1, patientId);

        ResultSet rs = patientPs.executeQuery();

        if(rs.next()){

            String email = rs.getString("email");
            String name = rs.getString("name");

            String body =
                    "Hello " + name +
                    ",<br><br>" +
                    message +
                    "<br><br>Regards,<br>" +
                    "Aarogya Global Hospital";

            EmailUtility.sendNotificationEmail(
                    email,
                    title,
                    body
            );
        }

        rs.close();
        patientPs.close();
        ps.close();
        con.close();

    }
    catch(Exception e){

        e.printStackTrace();
    }
}


}
