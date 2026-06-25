package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateDoctorProfileServlet")
public class UpdateDoctorProfileServlet extends HttpServlet {

private static final long serialVersionUID = 1L;

protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException, IOException {

    try {

        int doctorId =
                Integer.parseInt(
                request.getParameter("doctorId"));

        String name =
                request.getParameter("name");

        String specialization =
                request.getParameter("specialization");

        int experience =
                Integer.parseInt(
                request.getParameter("experience"));

        String contact =
                request.getParameter("contact");

        String email =
                request.getParameter("email");

        String photo =
                request.getParameter("photo");

        String schedule =
                request.getParameter("schedule");

        String availability =
                request.getParameter("availability");

        Connection con =
                DBConnection.getConnection();

        PreparedStatement ps =
                con.prepareStatement(

                "UPDATE doctors SET " +
                "name=?, " +
                "specialization=?, " +
                "experience=?, " +
                "contact=?, " +
                "email=?, " +
                "photo=?, " +
                "schedule=?, " +
                "availability=? " +
                "WHERE id=?"

                );

        ps.setString(1, name);
        ps.setString(2, specialization);
        ps.setInt(3, experience);
        ps.setString(4, contact);
        ps.setString(5, email);
        ps.setString(6, photo);
        ps.setString(7, schedule);
        ps.setString(8, availability);
        ps.setInt(9, doctorId);

        ps.executeUpdate();

        ps.close();
        con.close();

        response.sendRedirect(
                "doctorProfile.jsp?success=1");

    }
    catch(Exception e){

        e.printStackTrace();

        response.sendRedirect(
                "doctorProfile.jsp?error=1");
    }
}


}
