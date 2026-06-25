package H1;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/VerifyForgotOtpServlet")
public class VerifyForgotOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        String enteredOtp =
                request.getParameter("otp");

        String sessionOtp =
                (String)session.getAttribute(
                        "forgotOtp");

        if(sessionOtp == null) {

            response.sendRedirect(
                    "forgotPassword.jsp");

            return;
        }

        if(enteredOtp.equals(sessionOtp)) {

            response.sendRedirect(
                    "resetPassword.jsp");
        }
        else {

            response.sendRedirect(
                    "verifyForgotOtp.jsp?error=1");
        }
    }
}