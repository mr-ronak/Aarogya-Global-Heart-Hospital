package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditDoctorServlet")
public class EditDoctorServlet extends HttpServlet {

private static final long serialVersionUID = 1L;

protected void doGet(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {

        int id =
                Integer.parseInt(
                        request.getParameter("id"));

        Connection con =
                DBConnection.getConnection();

        PreparedStatement ps =
                con.prepareStatement(

                "SELECT * FROM doctors WHERE id=?"

                );

        ps.setInt(1, id);

        ResultSet rs =
                ps.executeQuery();

        if(rs.next()){

            request.setAttribute(
                    "id",
                    rs.getInt("id"));

            request.setAttribute(
                    "name",
                    rs.getString("name"));

            request.setAttribute(
                    "specialization",
                    rs.getString("specialization"));

            request.setAttribute(
                    "experience",
                    rs.getInt("experience"));

            request.setAttribute(
                    "contact",
                    rs.getString("contact"));

            request.setAttribute(
                    "email",
                    rs.getString("email"));

            request.setAttribute(
                    "password",
                    rs.getString("password"));

            request.setAttribute(
                    "photo",
                    rs.getString("photo"));

            request.setAttribute(
                    "schedule",
                    rs.getString("schedule"));

            request.setAttribute(
                    "availability",
                    rs.getString("availability"));

            request.setAttribute(
                    "account_status",
                    rs.getString("account_status"));

            request.setAttribute(
                    "status",
                    rs.getString("status"));

            request.setAttribute(
                    "last_login",
                    rs.getTimestamp("last_login"));
        }
        request.setAttribute(
                "department_id",
                rs.getInt("department_id"));

        rs.close();
        ps.close();
        con.close();

        request.getRequestDispatcher(
                "editDoctor.jsp")
                .forward(
                        request,
                        response);

    }
    catch(Exception e){

        e.printStackTrace();

        response.sendRedirect(
                "manageDoctors.jsp?error=1");
    }
}


}
