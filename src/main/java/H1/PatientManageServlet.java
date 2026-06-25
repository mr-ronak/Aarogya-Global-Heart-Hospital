package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PatientManageServlet")
public class PatientManageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Connection con = DBConnection.getConnection();

            if ("update".equals(action)) {

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE patients SET name=?, age=?, gender=?, contact=?, email=? WHERE id=?");

                ps.setString(1, request.getParameter("name"));
                ps.setInt(2, Integer.parseInt(request.getParameter("age")));
                ps.setString(3, request.getParameter("gender"));
                ps.setString(4, request.getParameter("contact"));
                ps.setString(5, request.getParameter("email"));
                ps.setInt(6, Integer.parseInt(request.getParameter("id")));

                ps.executeUpdate();
            }

            con.close();
            response.sendRedirect("managePatients.jsp?updated=1");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM patients WHERE id=?");

            ps.setInt(1, id);
            ps.executeUpdate();

            con.close();
            response.sendRedirect("managePatients.jsp?deleted=1");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}