package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("patientId") == null){
            response.sendRedirect("patientLogin.jsp");
            return;
        }

        int patientId = (int) session.getAttribute("patientId");

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        try{
            Connection con = DBConnection.getConnection();

            // Check old password
            String checkSql = "SELECT * FROM patients WHERE id=? AND password=?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, patientId);
            checkPs.setString(2, oldPassword);

            ResultSet rs = checkPs.executeQuery();

            if(rs.next()){
                // Update password
                String updateSql = "UPDATE patients SET password=? WHERE id=?";
                PreparedStatement updatePs = con.prepareStatement(updateSql);
                updatePs.setString(1, newPassword);
                updatePs.setInt(2, patientId);
                updatePs.executeUpdate();

                response.sendRedirect("changePassword.jsp?success=1");
            } else {
                response.sendRedirect("changePassword.jsp?error=1");
            }

            con.close();

        }catch(Exception e){
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}