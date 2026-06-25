package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteLabReportServlet")
public class DeleteLabReportServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException {

		try {

			int id=Integer.parseInt(request.getParameter("id"));

			Connection con=DBConnection.getConnection();

			PreparedStatement ps=con.prepareStatement(
			"DELETE FROM lab_reports WHERE id=?"
			);

			ps.setInt(1,id);

			ps.executeUpdate();

			con.close();

			response.sendRedirect("addLabReport.jsp?deleted=1");

		}catch(Exception e){
			e.printStackTrace();
		}

	}
}