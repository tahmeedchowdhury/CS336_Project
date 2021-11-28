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
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

		
	Statement st = con.createStatement();
	String departure_date = request.getParameter("depart_date");
	String departure_airport = request.getParameter("depart_airport");
	String arrival_airport = request.getParameter("dest_airport");
	ResultSet res = st.executeQuery("select * from flight where DATE(DATE_ADD(departure_time, INTERVAL 3 DAY)) >= '" + departure_date + "' and DATE(DATE_ADD(departure_time, INTERVAL -3 DAY)) <= '" + departure_date + "' and departure_airport = '" + departure_airport + "' and destination_airport = '" + arrival_airport + "'");
	
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