package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // If not logged in
        if (session == null || session.getAttribute("patientId") == null) {
            response.sendRedirect("patientLogin.jsp");
            return;
        }

        int patientId = (int) session.getAttribute("patientId");

        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE patients SET name=?, age=?, gender=?, contact=?, email=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setInt(2, Integer.parseInt(age));
            ps.setString(3, gender);
            ps.setString(4, contact);
            ps.setString(5, email);
            ps.setInt(6, patientId);

            ps.executeUpdate();

            con.close();

            response.sendRedirect("ProfileServlet?success=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}