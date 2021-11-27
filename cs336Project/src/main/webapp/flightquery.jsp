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
	
	if (request.getParameter("trip_type").equals("one_way_set")) {
		
		Statement st = con.createStatement();
		String departure_date = request.getParameter("depart_date");
		String departure_airport = request.getParameter("depart_airport");
		String arrival_airport = request.getParameter("dest_airport");
		ResultSet res = st.executeQuery("select * from flight where '" + departure_date + "' = departure_date and '" + departure_airport + "' = departure_airport and '" + arrival_airport + "' = destination airport");
		
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
	}
	
	else if (request.getParameter("trip_type").equals("round_trip_set")) {
		
		Statement st = con.createStatement();
		Statement st2 = con.createStatement();
		Statement st3 = con.createStatement();
		String departure_date = request.getParameter("depart_date");
		String departure_date_2 = request.getParameter("return_date");
		String departure_airport = request.getParameter("depart_airport");
		String arrival_airport = request.getParameter("dest_airport");
		ResultSet res = st.executeQuery("create temporary table t1 select * from flight where '" + departure_date + "' = departure_date and '" + departure_airport + "' = departure_airport and '" + arrival_airport + "' = destination airport");
		ResultSet res2 = st2.executeQuery("create temporary table t2 select * from flight where '" + departure_date_2 + "' = departure_date and '" + arrival_airport + "' = departure_airport and '" + departure_airport + "' = destination airport");
		ResultSet res3 = st3.executeQuery("select * from t1 cross join t2");
		
		while(res3.next()) {
			out.print("Destination-Bound Flight Number: " + res3.getString("t1.flight_number")); %>
			<br/>
			<%out.println("Departure Time: " + res3.getString("t1.departure_time")); %> 
			<br/>
			<%out.println("Arrival Time: " + res3.getString("t1.arrival_time")); %>
			<br/>
			<%out.println("Departure Airport: " + res3.getString("t1.departure_airport")); %>
			<br/>
			<%out.println("Destination Airport: " + res3.getString("t1.destination_airport")); %>
			<br/>
			<%if(res3.getString("t1.isDomestic").equals("1")) {
				out.println("Domestic Flight"); 
				}
				else {
					out.println("International Flight");
				}%>
				<br/>
			<%out.println("Airline: " + res3.getString("t1.airline_id")); %>
			<br/>
			<%out.println("Airport: " + res3.getString("t1.airport_id")); %>
			<br/>
			<%out.println("Aircraft: " + res3.getString("t1.aircraft_id")); %>
			<br />
			<br />
			
			<%out.print("Returning Flight Number: " + res3.getString("t2.flight_number")); %>
			<br/>
			<%out.println("Departure Time: " + res3.getString("t2.departure_time")); %> 
			<br/>
			<%out.println("Arrival Time: " + res3.getString("t2.arrival_time")); %>
			<br/>
			<%out.println("Departure Airport: " + res3.getString("t2.departure_airport")); %>
			<br/>
			<%out.println("Destination Airport: " + res3.getString("t2.destination_airport")); %>
			<br/>
			<%if(res3.getString("t2.isDomestic").equals("1")) {
				out.println("Domestic Flight"); 
				}
				else {
					out.println("International Flight");
				}%>
				<br/>
			<%out.println("Airline: " + res3.getString("t2.airline_id")); %>
			<br/>
			<%out.println("Airport: " + res3.getString("t2.airport_id")); %>
			<br/>
			<%out.println("Aircraft: " + res3.getString("t2.aircraft_id")); %>
			<br />
			<br />
			<% 
		}
		
	}
	
	else if (request.getParameter("trip_type").equals("one_way_flex")) {
		
		Statement st = con.createStatement();
		String departure_date = request.getParameter("depart_date");
		String departure_airport = request.getParameter("depart_airport");
		String arrival_airport = request.getParameter("dest_airport");
		ResultSet res = st.executeQuery("select * from flight where '" + departure_date + "' <= departure_date + 3 and '" + departure_date + "' >= departure_date - 3 and '" + departure_airport + "' = departure_airport and '" + arrival_airport + "' = destination airport");
		
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
		
	}
	
	else {
		
		Statement st = con.createStatement();
		Statement st2 = con.createStatement();
		Statement st3 = con.createStatement();
		Statement st4 = con.createStatement();
		String departure_date = request.getParameter("depart_date");
		String departure_date_2 = request.getParameter("return_date");
		String departure_airport = request.getParameter("depart_airport");
		String arrival_airport = request.getParameter("dest_airport");
		ResultSet res = st.executeQuery("create temporary table t1 select * from flight where '" + departure_date + "' <= departure_date + 3 and '" + departure_date + "' >= departure_date - 3 and '" + departure_airport + "' = departure_airport and '" + arrival_airport + "' = destination airport");
		ResultSet res2 = st2.executeQuery("create temporary table t2 select * from flight where '" + departure_date_2 + "' <= departure_date + 3 and '" + departure_date_2 + "' >= departure_date - 3 and '" + arrival_airport + "' = departure_airport and '" + departure_airport + "' = destination airport");
		ResultSet res3 = st3.executeQuery("create temporary table t3 select * from t1 cross join t2");
		ResultSet res4 = st4.executeQuery("select * from t3 where t1.departure_date < t2.departure_date");
		
		while(res4.next()) {
			out.print("Destination-Bound Flight Number: " + res4.getString("t1.flight_number")); %>
			<br/>
			<%out.println("Departure Time: " + res4.getString("t1.departure_time")); %> 
			<br/>
			<%out.println("Arrival Time: " + res4.getString("t1.arrival_time")); %>
			<br/>
			<%out.println("Departure Airport: " + res4.getString("t1.departure_airport")); %>
			<br/>
			<%out.println("Destination Airport: " + res4.getString("t1.destination_airport")); %>
			<br/>
			<%if(res4.getString("t1.isDomestic").equals("1")) {
				out.println("Domestic Flight"); 
				}
				else {
					out.println("International Flight");
				}%>
				<br/>
			<%out.println("Airline: " + res4.getString("t1.airline_id")); %>
			<br/>
			<%out.println("Airport: " + res4.getString("t1.airport_id")); %>
			<br/>
			<%out.println("Aircraft: " + res4.getString("t1.aircraft_id")); %>
			<br />
			<br />
			
			<%out.print("Returning Flight Number: " + res4.getString("t2.flight_number")); %>
			<br/>
			<%out.println("Departure Time: " + res4.getString("t2.departure_time")); %> 
			<br/>
			<%out.println("Arrival Time: " + res4.getString("t2.arrival_time")); %>
			<br/>
			<%out.println("Departure Airport: " + res4.getString("t2.departure_airport")); %>
			<br/>
			<%out.println("Destination Airport: " + res4.getString("t2.destination_airport")); %>
			<br/>
			<%if(res4.getString("t2.isDomestic").equals("1")) {
				out.println("Domestic Flight"); 
				}
				else {
					out.println("International Flight");
				}%>
				<br/>
			<%out.println("Airline: " + res4.getString("t2.airline_id")); %>
			<br/>
			<%out.println("Airport: " + res4.getString("t2.airport_id")); %>
			<br/>
			<%out.println("Aircraft: " + res4.getString("t2.aircraft_id")); %>
			<br />
			<br />
			<% 
		}
		
	}
	
	db.closeConnection(con);
	
}

catch (Exception e) {
	out.print(e);
}

%>

</body>
</html>