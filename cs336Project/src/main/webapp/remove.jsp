<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Removed From Waiting List</title>
</head>
<body>
Congralutations, you are now removed from the waiting list. Please feel free to reserve your flight using our service.
<br/>
<a href="home.jsp">Return Home</a>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
PreparedStatement ps = con.prepareStatement("delete from waiting_list where id=" + String.valueOf(session.getAttribute("id")) + " and flight_number = " + request.getParameter("fnum") + " and airline_id = '" + request.getParameter("id") + "'" );
ps.executeUpdate();
%>
</body>
</html>