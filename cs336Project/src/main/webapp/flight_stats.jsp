<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Flight Statistics</title>
</head>
<body>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
try{
if(request.getParameter("command").equals("View Past Flight Reservations")) {
	out.print("Below are all past flight reservations that you have made and all information associated with them."); %>
	<br/>
	<br/>
	<%
	Statement st = con.createStatement();
	Statement st2 = con.createStatement();
	ResultSet res = st.executeQuery("select * from ticket t join ticket_for using(number) where id =" + String.valueOf(session.getAttribute("id")));
	ResultSetMetaData resmeta = res.getMetaData();
	int cols = resmeta.getColumnCount();
	while(res.next()) { %>
	<br/>
	<br/>
	<%
	for(int i = 1; i <= cols; i++) {
		if(!resmeta.getColumnName(i).equals("first_name") && !resmeta.getColumnName(i).equals("last_name") && !resmeta.getColumnName(i).equals("id")) {
			out.print(resmeta.getColumnName(i) + ": " + res.getString(i) + "  ||  ");
		}
	}
	}
}
else if(request.getParameter("command").equals("View Upcoming Flights")) {
	out.print("Below are a list of all upcoming flights whose departure dates are later than today and all their corresponding information."); %>
	<br/>
	<br/>
	<%
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select * from flight where date(departure_time) > now()");
	ResultSetMetaData resmeta = res.getMetaData();
	int cols = resmeta.getColumnCount();
	while(res.next()) { %>
	<br/>
	<br/>
	<%
	for(int i = 1; i <= cols; i++) {
			out.print(resmeta.getColumnName(i) + ": " + res.getString(i) + "  ||  ");
	}
	}
}
}
catch(Exception e) {
	e.printStackTrace();
	out.print("Sorry, Something went wrong. Please try Again."); %>
	<a href="home.jsp">Return Home</a>
	<%
}
%>
</body>
</html>