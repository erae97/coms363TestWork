<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tweet Database</title>
</head>
<body>
	<!-- any error is redirected to ShowError.jsp -->
	<%@ page errorPage="Error.jsp"%>
	<!-- include all the database connection configurations -->
	<%@ include file="./DB.jsp"%>
	
	<%
		Connection conn=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
		
		//add query
		String sqlQuery = "";
		
		stmt = conn.prepareStatement(sqlQuery);		
		//Q1
		stmt.setInt(1,Integer.parseInt(request.getParameter("info_selector")));
		rs = stmt.executeQuery();
		while (rs.next()) {
			//add user input for month and year
			out.println("<h3>Here's the most retweeted tweet in MONTH YEAR:</h3>");
		}
		out.println("<br/>");
		
		//most tweeted tweet query Q1
		sqlQuery = "";
		
		stmt = conn.prepareStatement(sqlQuery);
		stmt.clearParameters();
		
	
		//Q3
		stmt.setInt(1,Integer.parseInt(request.getParameter("info_selector")));
		rs = stmt.executeQuery();
		while (rs.next()) {
			//add user input for state
			out.println("<h3>Here's the hashtags that appeared the most in STATE:</h3>");
		}
		out.println("<br/>");
		
		//hashtag by state query Q3
		sqlQuery = "";
		
		stmt = conn.prepareStatement(sqlQuery);
		stmt.clearParameters();
		
		
		//Q6
		stmt.setInt(1,Integer.parseInt(request.getParameter("info_selector")));
		rs = stmt.executeQuery();
		while (rs.next()) {
			//add list
			out.println("<h3>Here's who used at least one of these hashtags LIST:</h3>");
		}
		out.println("<br/>");
		
		//used at least one hashtag query Q6
		sqlQuery = "";
		
		stmt = conn.prepareStatement(sqlQuery);
		stmt.clearParameters();
		
		
		
		//Q9
		stmt.setInt(1,Integer.parseInt(request.getParameter("info_selector")));
		rs = stmt.executeQuery();
		while (rs.next()) {
			//add user input for party affiliation
			out.println("<h3>Here's the most followed user in the PARTY party:</h3>");
		}
		out.println("<br/>");
		
		//most followed query Q9
		sqlQuery = "";
		
		stmt = conn.prepareStatement(sqlQuery);
		stmt.clearParameters();
		
		
		//Q10
		stmt.setInt(1,Integer.parseInt(request.getParameter("info_selector")));
		rs = stmt.executeQuery();
		while (rs.next()) {
			//add user input list of states
			out.println("<h3>Here's a list of hashtags that appeared is one of these states LIST:</h3>");
		}
		out.println("<br/>");
		
		//most distinct hashtags query Q10
		sqlQuery = "";
		
		stmt = conn.prepareStatement(sqlQuery);
		stmt.clearParameters();
	%>
	<br />
	<form action="Index1.jsp">
		<input type="submit" value="BACK" />
	</form>
</body>
</html>