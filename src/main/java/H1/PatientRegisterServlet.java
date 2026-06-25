package H1;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PatientRegisterServlet")
public class PatientRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            // Generate 6-digit OTP
            Random random = new Random();
            String otp = String.valueOf(
                    100000 + random.nextInt(900000));

            // Send Email OTP
            boolean sent = EmailUtility.sendOTP(email, otp);

            if(sent){

                HttpSession session = request.getSession();

                session.setAttribute("otp", otp);

                session.setAttribute("reg_name", name);
                session.setAttribute("reg_age", Integer.parseInt(age));
                session.setAttribute("reg_gender", gender);
                session.setAttribute("reg_contact", contact);
                session.setAttribute("reg_email", email);
                session.setAttribute("reg_password", password);

                response.sendRedirect("verifyOtp.jsp");

            }else{

                response.sendRedirect(
                        "patientRegister.jsp?error=1");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "patientRegister.jsp?error=1");
        }
    }
}