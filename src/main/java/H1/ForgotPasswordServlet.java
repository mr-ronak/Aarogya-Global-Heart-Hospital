package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM patients WHERE email=?");

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                Random random = new Random();

                String otp =
                        String.valueOf(
                        100000 + random.nextInt(900000));

                HttpSession session =
                        request.getSession();

                session.setAttribute(
                        "forgotOtp",
                        otp);

                session.setAttribute(
                        "forgotEmail",
                        email);

                EmailUtility.sendOTP(email, otp);

                response.sendRedirect(
                        "verifyForgotOtp.jsp");

            }
            else {

                response.sendRedirect(
                        "forgotPassword.jsp?notfound=1");
            }

            con.close();

        }
        catch(Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "forgotPassword.jsp?error=1");
        }
    }
}