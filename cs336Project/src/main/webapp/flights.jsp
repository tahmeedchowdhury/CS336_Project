<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Flights</title>
</head>
<body>
<a href="home.jsp">Return Home</a>
<br/>
<p>The following is a list of all available flights.</p>
<br/>
<a href="reserve.jsp">Make A Flight Reservation</a>
<br/>
<br/>
<% 
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet res = st.executeQuery("select * from flight");
while(res.next()) {
	out.print("Flight Number: " + res.getString("flight_number")); %>
	<br/>
	<%out.println("Price: $" + res.getString("price")); %>
	<br/>
	<%out.println("Departure Time: " + res.getString("departure_time")); %> 
	<br/>
	<%out.println("Arrival Time: " + res.getString("arrival_time")); %>
	<br/>
	<%out.println("Departure Airport: " + res.getString("departure_airport")); %>
	<br/>
	<%out.println("Destination Airport: " + res.getString("destination_airport")); %>
	<br/>
	<%if(res.getString("isDomestic").equals("1")) {
		out.println("Domestic Flight"); 
		}
		else {
			out.println("International Flight");
		}%>
		<br/>
	<%out.println("Airline: " + res.getString("airline_id")); %>
	<br/>
	<%out.println("Airport: " + res.getString("airport_id")); %>
	<br/>
	<%out.println("Aircraft: " + res.getString("aircraft_id")); %>
	<br />
	<br />
	<% 
}
%>
</body>
</html>