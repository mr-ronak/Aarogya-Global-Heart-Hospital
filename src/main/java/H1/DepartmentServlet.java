package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DepartmentServlet")
public class DepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            Connection con = DBConnection.getConnection();

            if ("add".equals(action)) {

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO departments(name, description) VALUES(?,?)");

                ps.setString(1, request.getParameter("name"));
                ps.setString(2, request.getParameter("description"));

                ps.executeUpdate();
                response.sendRedirect("manageDepartments.jsp?success=1");
            }

            if ("update".equals(action)) {

                PreparedStatement ps = con.prepareStatement(
                        "UPDATE departments SET name=?, description=? WHERE id=?");

                ps.setString(1, request.getParameter("name"));
                ps.setString(2, request.getParameter("description"));
                ps.setInt(3, Integer.parseInt(request.getParameter("id")));

                ps.executeUpdate();
                response.sendRedirect("manageDepartments.jsp?updated=1");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM departments WHERE id=?");

            ps.setInt(1, Integer.parseInt(request.getParameter("id")));
            ps.executeUpdate();

            con.close();
            response.sendRedirect("manageDepartments.jsp?deleted=1");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}