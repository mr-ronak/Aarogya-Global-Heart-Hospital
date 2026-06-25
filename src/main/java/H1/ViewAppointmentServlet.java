package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewAppointmentServlet")
public class ViewAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("patientId") == null) {
            response.sendRedirect("patientLogin.jsp");
            return;
        }

        int patientId = (int) session.getAttribute("patientId");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT a.id, d.name, d.specialization, " +
                         "a.appointment_date, a.appointment_time, a.status " +
                         "FROM appointments a " +
                         "JOIN doctors d ON a.doctor_id = d.id " +
                         "WHERE a.patient_id = ? " +
                         "ORDER BY a.appointment_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, patientId);

            ResultSet rs = ps.executeQuery();

            ArrayList<String[]> list = new ArrayList<>();
            LocalDate today = LocalDate.now();

            while (rs.next()) {

                LocalDate appDate = rs.getDate("appointment_date").toLocalDate();
                boolean isFuture = appDate.isAfter(today) || appDate.isEqual(today);

                String[] row = new String[7];
                row[0] = rs.getString("id");
                row[1] = rs.getString("name");
                row[2] = rs.getString("specialization");
                row[3] = rs.getString("appointment_date");
                row[4] = rs.getString("appointment_time");
                row[5] = rs.getString("status");
                row[6] = String.valueOf(isFuture);

                list.add(row);
            }

            request.setAttribute("appointments", list);
            request.getRequestDispatcher("viewAppointments.jsp").forward(request, response);

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}