package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RescheduleServlet")
public class RescheduleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));
            String newDate = request.getParameter("newDate");
            String newTime = request.getParameter("newTime");

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "UPDATE appointments SET appointment_date=?, appointment_time=? WHERE id=?");

            ps.setString(1, newDate);
            ps.setString(2, newTime);
            ps.setInt(3, id);

            ps.executeUpdate();

            con.close();

            response.sendRedirect("ViewAppointmentServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}