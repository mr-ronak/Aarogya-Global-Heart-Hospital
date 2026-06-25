<%@ page import="java.sql.*" %>
<%@ page import="H1.DBConnection" %>

<%

String id=request.getParameter("id");

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(
"SELECT name FROM patients WHERE id=?"
);

ps.setInt(1,Integer.parseInt(id));

ResultSet rs=ps.executeQuery();

if(rs.next()){
out.print(rs.getString("name"));
}

con.close();

%>