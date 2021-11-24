<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>HomePage</title>
</head>
<body>
<h1 style="align-self:center; font-size: 36px">Welcome <%=session.getAttribute("user")%></h1>
<p> Please select an option below </p>
<br/>
<a href="flights.jsp">Flights</a>
<br/>
<a href='logout.jsp'>Log out</a>
<br />
<a href = "questions.jsp">Questions for the Customer Representative</a>
</body>
</html>