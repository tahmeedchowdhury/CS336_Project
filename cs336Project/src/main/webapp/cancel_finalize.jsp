<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reservation Cancelled</title>
</head>
<body>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet res = st.executeQuery("select * from ticket_for where number =" + request.getParameter("number"));
res.next();
String cl = res.getString("class");
if(cl.equals("first") || cl.equals("business")) {
PreparedStatement ps = con.prepareStatement("delete from ticket where number = " + request.getParameter("number"));
ps.executeUpdate();
}
else {
	PreparedStatement ps = con.prepareStatement("update ticket set total_fare = 10.00 where number=" + request.getParameter("number"));
	PreparedStatement ps2 = con.prepareStatement("update ticket_for set class = 'cancelled' where number = " + request.getParameter("number"));
	ps.executeUpdate();
	ps2.executeUpdate();
}
out.print("You Reservation has been canceled."); %>
<br/>
<a href="home.jsp">Return Home</a>
<% 
%>
</body>
</html>