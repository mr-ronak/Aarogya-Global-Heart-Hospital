package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/VerifyOtpServlet")
public class VerifyOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String enteredOtp = request.getParameter("otp");
        String sessionOtp = (String) session.getAttribute("otp");

        if (sessionOtp == null) {

            response.sendRedirect("patientRegister.jsp?expired=1");
            return;
        }

        if (enteredOtp.equals(sessionOtp)) {

            try {

                String name =
                        (String) session.getAttribute("reg_name");

                Integer age =
                        (Integer) session.getAttribute("reg_age");

                String gender =
                        (String) session.getAttribute("reg_gender");

                String contact =
                        (String) session.getAttribute("reg_contact");

                String email =
                        (String) session.getAttribute("reg_email");

                String password =
                        (String) session.getAttribute("reg_password");

                Connection con = DBConnection.getConnection();

                // CHECK DUPLICATE EMAIL
                PreparedStatement check =
                        con.prepareStatement(
                        "SELECT * FROM patients WHERE email=?");

                check.setString(1, email);

                ResultSet rs = check.executeQuery();

                if(rs.next()){

                    response.getWriter().println(
                    "<h2 style='color:red'>Email Already Registered!</h2>");

                    con.close();
                    return;
                }

                // INSERT PATIENT

                String sql =
                "INSERT INTO patients(name,age,gender,contact,email,password) VALUES(?,?,?,?,?,?)";

                PreparedStatement ps =
                        con.prepareStatement(sql);

                ps.setString(1, name);
                ps.setInt(2, age);
                ps.setString(3, gender);
                ps.setString(4, contact);
                ps.setString(5, email);
                ps.setString(6, password);

                int result = ps.executeUpdate();

                con.close();

                if(result > 0){

                    session.removeAttribute("otp");
                    session.removeAttribute("reg_name");
                    session.removeAttribute("reg_age");
                    session.removeAttribute("reg_gender");
                    session.removeAttribute("reg_contact");
                    session.removeAttribute("reg_email");
                    session.removeAttribute("reg_password");

                    response.sendRedirect("registrationSuccess.jsp");

                }else{

                    response.getWriter().println(
                    "<h2 style='color:red'>Patient Insert Failed</h2>");
                }

            }
            catch(Exception e) {

                e.printStackTrace();

                response.setContentType("text/html");

                response.getWriter().println(
                "<h2 style='color:red'>Registration Error</h2>");

                response.getWriter().println("<pre>");
                e.printStackTrace(response.getWriter());
                response.getWriter().println("</pre>");
            }

        }
        else {

            response.sendRedirect(
            "verifyOtp.jsp?error=1");
        }
    }
}