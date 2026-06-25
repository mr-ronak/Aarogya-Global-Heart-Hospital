package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DoctorServlet")
public class DoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Connection con = DBConnection.getConnection();

            if ("add".equals(action)) {

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO doctors(name,specialization,experience,contact,email) VALUES(?,?,?,?,?)");

                ps.setString(1, request.getParameter("name"));
                ps.setString(2, request.getParameter("specialization"));
                ps.setInt(3, Integer.parseInt(request.getParameter("experience")));
                ps.setString(4, request.getParameter("contact"));
                ps.setString(5, request.getParameter("email"));

                ps.executeUpdate();
            }

            if ("delete".equals(action)) {

                PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM doctors WHERE id=?");

                ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                ps.executeUpdate();
            }

            con.close();
            response.sendRedirect("manageDoctors.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}