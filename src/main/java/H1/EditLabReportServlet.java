package H1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EditLabReportServlet")
public class EditLabReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {

			int id = Integer.parseInt(request.getParameter("id"));

			double hemoglobin = Double.parseDouble(request.getParameter("hemoglobin"));
			double rbc = Double.parseDouble(request.getParameter("rbc"));
			double wbc = Double.parseDouble(request.getParameter("wbc"));
			double platelets = Double.parseDouble(request.getParameter("platelets"));
			double sugar = Double.parseDouble(request.getParameter("blood_sugar"));
			double chol = Double.parseDouble(request.getParameter("cholesterol"));
			double heart = Double.parseDouble(request.getParameter("heart_rate"));
			String bp = request.getParameter("bp");

			Connection con = DBConnection.getConnection();

			PreparedStatement ps = con.prepareStatement(

			"UPDATE lab_reports SET hemoglobin=?, rbc=?, wbc=?, platelets=?, blood_sugar=?, cholesterol=?, heart_rate=?, bp=? WHERE id=?"

			);

			ps.setDouble(1, hemoglobin);
			ps.setDouble(2, rbc);
			ps.setDouble(3, wbc);
			ps.setDouble(4, platelets);
			ps.setDouble(5, sugar);
			ps.setDouble(6, chol);
			ps.setDouble(7, heart);
			ps.setString(8, bp);
			ps.setInt(9, id);

			ps.executeUpdate();

			con.close();

			response.sendRedirect("addLabReport.jsp?updated=1");

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}