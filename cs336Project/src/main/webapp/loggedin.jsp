<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Airport Account</title>
</head>
<body>
<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
<%
if(session.getAttribute("type").equals("A")) {
	response.sendRedirect("admin_home.jsp");
}
else if(session.getAttribute("type").equals("R")) {
	response.sendRedirect("rep_home.jsp");
}
else {
response.sendRedirect("home.jsp");
}
    }
%>
</body>
</html>