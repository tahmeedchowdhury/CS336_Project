<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

try {
	
	if (request.getParameter("trip_type").equals("one_way_set")) {
		%>
		<form method="get" action="onewayset.jsp">
		<table>
		<tr>
		<td>Departing Airport</td><td><input type="text" name="depart_airport"></td>
		<td>Destination Airport</td><td><input type="text" name="dest_airport"></td>
		</tr>
	
		<tr>
		<td>Departure Date</td><td><input type="date" name="depart_date"></td>
		</tr>
		</table>
		
		<input type="submit" value="submit">
		</form>
	
	<%
	}
	
	else if (request.getParameter("trip_type").equals("round_trip_set")) {
		%>
		<form method="get" action="roundtripset.jsp">
		<table>
		<tr>
		<td>Departing Airport</td><td><input type="text" name="depart_airport"></td>
		<td>Destination Airport</td><td><input type="text" name="dest_airport"></td>
		</tr>
	
		<tr>
		<td>Departure Date</td><td><input type="date" name="depart_date"></td>
		<td>Return Date</td><td><input type="date" name="return_date"></td>
		</tr>
		</table>
		
		<input type="submit" value="submit">
		</form>
		
		<%
		
	}
	
	else if (request.getParameter("trip_type").equals("one_way_flex")) {
		%>
		<form method="get" action="onewayflex.jsp">
		<table>
		<tr>
		<td>Departing Airport</td><td><input type="text" name="depart_airport"></td>
		<td>Destination Airport</td><td><input type="text" name="dest_airport"></td>
		</tr>
	
		<tr>
		<td>Departure Date</td><td><input type="date" name="depart_date"></td>
		</tr>
		</table>
		
		<input type="submit" value="submit">
		</form>
		
		<%
	}
	
	else {
		%>
		<form method="get" action="roundtripflex.jsp">
		<table>
		<tr>
		<td>Departing Airport</td><td><input type="text" name="depart_airport"></td>
		<td>Destination Airport</td><td><input type="text" name="dest_airport"></td>
		</tr>
	
		<tr>
		<td>Departure Date</td><td><input type="date" name="depart_date"></td>
		<td>Return Date</td><td><input type="date" name="return_date"></td>
		</tr>
		</table>
		
		<input type="submit" value="submit">
		</form>
		
		<%
	}

}

catch(Exception e) {
	out.print(e);
}

%>

</body>
</html>