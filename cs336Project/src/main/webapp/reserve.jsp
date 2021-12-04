<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reserve A Flight</title>
</head>
<body>
<form method="post" action=make_reservation.jsp>
Please enter the number of flights you are reserving right now: <input type="number" min=1 max=6 step=1 name="num"/> Trip type(0 for One Way, 1 for Round Trip): <input type="number" min=0 max=1 step=1 name="type"/>
<br/>
Please select your class:
<select name='class'>
<option value='first'>First</option>
<option value='business'>Business</option>
<option value='economy'>Economy</option>
</select>
<input type="submit" name="command" value="Make Reservations"/>
<br/>
<br/>
Note that you can have a maximum of 6 flights per ticket. Please indicate 2 flights for a round trip, and more if you would like a round trip with
stops or a one way trip with stops. Also note that not inputting a trip type assumes the trip is a One Way.
<%
if(session.getAttribute("type").equals("R")) {%>
	<input type="hidden" name="fname" value=<%=request.getParameter("fname")%> />
	<input type="hidden" name="lname" value=<%=request.getParameter("lname")%> />
	<input type="hidden" name="id" value=<%=request.getParameter("id")%> />
	<%
}
%>
</form>
</body>
</html>