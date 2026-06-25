package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddDoctorServlet")
public class AddDoctorServlet extends HttpServlet {

private static final long serialVersionUID = 1L;

protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {

        String name =
                request.getParameter("name");

        String specialization =
                request.getParameter("specialization");

        int experience =
                Integer.parseInt(
                request.getParameter("experience"));

        int departmentId =
                Integer.parseInt(
                request.getParameter("department_id"));

        String contact =
                request.getParameter("contact");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        String photo =
                request.getParameter("photo");

        String schedule =
                request.getParameter("schedule");

        String availability =
                request.getParameter("availability");

        String accountStatus =
                request.getParameter("account_status");

        String status =
                request.getParameter("status");

        Connection con =
                DBConnection.getConnection();

        PreparedStatement ps =
                con.prepareStatement(

                "INSERT INTO doctors(" +
                "name," +
                "specialization," +
                "experience," +
                "department_id," +
                "contact," +
                "email," +
                "photo," +
                "schedule," +
                "availability," +
                "password," +
                "account_status," +
                "status" +
                ") VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"

                );

        ps.setString(1, name);
        ps.setString(2, specialization);
        ps.setInt(3, experience);
        ps.setInt(4, departmentId);
        ps.setString(5, contact);
        ps.setString(6, email);
        ps.setString(7, photo);
        ps.setString(8, schedule);
        ps.setString(9, availability);
        ps.setString(10, password);
        ps.setString(11, accountStatus);
        ps.setString(12, status);

        ps.executeUpdate();

        ps.close();
        con.close();

        response.sendRedirect(
                "manageDoctors.jsp?success=1");

    }
    catch(Exception e){

        e.printStackTrace();

        response.sendRedirect(
                "manageDoctors.jsp?error=1");
    }
}


}
