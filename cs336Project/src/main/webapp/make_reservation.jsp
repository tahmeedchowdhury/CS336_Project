<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Make Reservation</title>
</head>
<body>
<form method="post" action = finalize.jsp>
<%
int num = Integer.parseInt(request.getParameter("num"));
for(int i = 1; i <= num; i++) {
	%>
	<br/>
	Enter Flight Number: <input type="text" name="fnum"/>
	Enter Airline ID: <input type="text" name="id"/>
	<br/>
	<%
}
%>
<br/>
<input type="submit" name="command" value="Finalize Reservation"/>
<%if(request.getParameter("type").equals("1")) {
%>
<input type="hidden" name="trip_type" value="round"/>
<%	
}
else {
	%>
	<input type="hidden" name="trip_type" value="one"/>
<%}
%>
<input type="hidden" name="class" value=<%=request.getParameter("class") %> />
<%
if(session.getAttribute("type").equals("R")) { %>
<input type="hidden" name="fname" value=<%=request.getParameter("fname") %> />
<input type="hidden" name="lname" value=<%=request.getParameter("lname") %> />
<input type="hidden" name="rid" value=<%=request.getParameter("id") %> />
<% 
	
}
%>
<br/>
<br/>
<a href="flightsearch.jsp">Search For Flights Here!</a>
</form>
</body>
</html>