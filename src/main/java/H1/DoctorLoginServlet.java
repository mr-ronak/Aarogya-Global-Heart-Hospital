package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DoctorLoginServlet")
public class DoctorLoginServlet extends HttpServlet {


private static final long serialVersionUID = 1L;

protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    String email =
            request.getParameter("email");

    String password =
            request.getParameter("password");

    try {

        Connection con =
                DBConnection.getConnection();

        PreparedStatement ps =
                con.prepareStatement(

                "SELECT * FROM doctors WHERE email=? AND password=?"

                );

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs =
                ps.executeQuery();

        if(rs.next()){

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "doctorId",
                    rs.getInt("id"));

            session.setAttribute(
                    "doctorName",
                    rs.getString("name"));

            session.setAttribute(
                    "doctorEmail",
                    rs.getString("email"));

            response.sendRedirect(
                    "doctorDashboard.jsp");

        }
        else{

            response.sendRedirect(
                    "doctorLogin.jsp?error=1");

        }

        rs.close();
        ps.close();
        con.close();

    }
    catch(Exception e){

        e.printStackTrace();

        response.sendRedirect(
                "doctorLogin.jsp?error=1");
    }
}

}
