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
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
	String takeOff = request.getParameter("takeoffTime");
	String str = "SELECT * FROM flight WHERE TIME(departure_time) = '" + takeOff + "'";
 	ResultSet res = stmt.executeQuery(str);
	while(res.next()) {
						out.print("Flight Number: " + res.getString("flight_number")); %>
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
						<%out.println("Price: " + res.getString("price")); %>
						<br />
						<br />
						<% 
					}
db.closeConnection(con);
	
}
catch (Exception e) {
	out.print(e);
}
%>


</body>
</html>