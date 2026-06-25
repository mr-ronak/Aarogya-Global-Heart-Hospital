package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String newPassword =
                request.getParameter("password");

        HttpSession session =
                request.getSession();

        String email =
                (String)session.getAttribute(
                        "forgotEmail");

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "UPDATE patients SET password=? WHERE email=?");

            ps.setString(1, newPassword);
            ps.setString(2, email);

            ps.executeUpdate();

            con.close();

            session.removeAttribute("forgotOtp");
            session.removeAttribute("forgotEmail");

            response.sendRedirect(
                    "patientLogin.jsp?reset=1");

        }
        catch(Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "resetPassword.jsp?error=1");
        }
    }
}