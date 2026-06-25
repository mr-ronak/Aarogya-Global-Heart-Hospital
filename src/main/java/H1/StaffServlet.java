package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String action = request.getParameter("action");
            Connection con = DBConnection.getConnection();

            if("add".equals(action)){

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO staff(name, role, department, contact, email, salary, shift_time) VALUES(?,?,?,?,?,?,?)"
                );

                ps.setString(1, request.getParameter("name"));
                ps.setString(2, request.getParameter("role"));
                ps.setString(3, request.getParameter("department"));
                ps.setString(4, request.getParameter("contact"));
                ps.setString(5, request.getParameter("email"));
                ps.setDouble(6, Double.parseDouble(request.getParameter("salary")));
                ps.setString(7, request.getParameter("shift_time"));

                ps.executeUpdate();
            }

            con.close();
            response.sendRedirect("manageStaff.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(request.getParameter("id"));

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement("DELETE FROM staff WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();

            con.close();
            response.sendRedirect("manageStaff.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}