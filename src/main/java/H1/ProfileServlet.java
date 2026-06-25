package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
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

            String sql = "SELECT * FROM patients WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, patientId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("age", rs.getInt("age"));
                request.setAttribute("gender", rs.getString("gender"));
                request.setAttribute("contact", rs.getString("contact"));
                request.setAttribute("email", rs.getString("email"));
            }

            con.close();

            request.getRequestDispatcher("profile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}