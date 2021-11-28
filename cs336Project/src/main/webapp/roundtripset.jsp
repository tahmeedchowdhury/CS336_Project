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
	Statement st2 = con.createStatement();
	Statement st3 = con.createStatement();
	String departure_date = request.getParameter("depart_date");
	String return_date = request.getParameter("return_date");
	String departure_airport = request.getParameter("depart_airport");
	String arrival_airport = request.getParameter("dest_airport");
	st.executeUpdate("create temporary table t1 select * from flight where departure_time like '" + departure_date + "%' and departure_airport = '" + departure_airport + "' and destination_airport = '" + arrival_airport + "'");
	st2.executeUpdate("create temporary table t2 select * from flight where departure_time like '" + return_date + "%' and departure_airport = '" + arrival_airport + "' and destination_airport = '" + departure_airport + "'");
	ResultSet res = st3.executeQuery("select * from t1 cross join t2");
		
	while(res.next()) {
		out.print("Destination-bound Flight Number: " + res.getString("t1.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res.getString("t1.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res.getString("t1.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res.getString("t1.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res.getString("t1.destination_airport")); %>
		<br/>
		<%if(res.getString("t1.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res.getString("t1.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res.getString("t1.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res.getString("t1.aircraft_id")); %>
		<br />
		<br />
		<% 
		
		out.print("Returning Flight Number: " + res.getString("t2.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res.getString("t2.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res.getString("t2.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res.getString("t2.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res.getString("t2.destination_airport")); %>
		<br/>
		<%if(res.getString("t2.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res.getString("t2.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res.getString("t2.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res.getString("t2.aircraft_id")); %>
		<br />
		<br /> <%
	}
	
	
	db.closeConnection(con);
	
}
catch (Exception e) {
	out.print(e);
}
%>

</body>
</html>