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
	
	
		
	ResultSet res = st.executeQuery("select * from flight where departure_time like '" + departure_date + "%' and departure_airport = '" + departure_airport + "' and destination_airport = '" + arrival_airport + "'");
	%>
	
	<p> Non-Stop Flights </p>
	
	<% while(res.next()) {
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
	
	Statement st1 = con.createStatement();
	Statement st2 = con.createStatement();
	Statement st3 = con.createStatement();
	st1.executeUpdate("create temporary table t1 select * from flight where departure_time like '" + departure_date + "%' and departure_airport = '" + departure_airport + "' and destination_airport <> '" + arrival_airport + "'");
	st2.executeUpdate("create temporary table t2 select * from flight where destination_airport = '" + arrival_airport + "'");
	ResultSet res2 = st3.executeQuery("select * from t1, t2 where t1.destination_airport = t2.departure_airport and t2.departure_time > t1.arrival_time"); %>
	
	<p>One Stop Flights</p>
	
	<% while(res2.next()) {
		out.print("Flight Number: " + res2.getString("t1.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res2.getString("t1.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res2.getString("t1.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res2.getString("t1.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res2.getString("t1.destination_airport")); %>
		<br/>
		<%if(res2.getString("t1.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res2.getString("t1.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res2.getString("t1.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res2.getString("t1.aircraft_id")); %>
		<br />
		<br />
		
	<%out.print("Second Flight Number: " + res2.getString("t2.flight_number")); %>
	<br/>
	<%out.println("Departure Time: " + res2.getString("t2.departure_time")); %> 
	<br/>
	<%out.println("Arrival Time: " + res2.getString("t2.arrival_time")); %>
	<br/>
	<%out.println("Departure Airport: " + res2.getString("t2.departure_airport")); %>
	<br/>
	<%out.println("Destination Airport: " + res2.getString("t2.destination_airport")); %>
	<br/>
	<%if(res2.getString("t2.isDomestic").equals("1")) {
		out.println("Domestic Flight"); 
		}
		else {
			out.println("International Flight");
		}%>
		<br/>
	<%out.println("Airline: " + res2.getString("t2.airline_id")); %>
	<br/>
	<%out.println("Airport: " + res2.getString("t2.airport_id")); %>
	<br/>
	<%out.println("Aircraft: " + res2.getString("t2.aircraft_id")); %>
	<br/>
	<%out.println("Total Price: " + res2.getInt("t1.price") + res2.getInt("t2.price")); %>
	<br />
	<br />
	
	<%
	}
	
	Statement st4 = con.createStatement();
	Statement st5 = con.createStatement();
	Statement st6 = con.createStatement();
	Statement st7 = con.createStatement();
	st4.executeUpdate("create temporary table s1 select * from flight where departure_time like '" + departure_date + "%' and departure_airport = '" + departure_airport + "' and destination_airport <> '" + arrival_airport + "'");
	st5.executeUpdate("create temporary table s2 select * from flight where destination_airport <> '" + arrival_airport + "'");
	st6.executeUpdate("create temporary table s3 select * from flight where destination_airport = '" + arrival_airport + "'");
	ResultSet res3 = st7.executeQuery("select * from s1, s2, s3 where s1.destination_airport = s2.departure_airport and s2.departure_time > s1.arrival_time and s2.destination_airport = s3.departure_airport and s3.departure_time > s2.arrival_time"); %>
	
	<p>Two Stop Flights</p>
	
	<% while(res3.next()) {
		out.print("Flight Number: " + res3.getString("s1.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res3.getString("s1.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res3.getString("s1.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res3.getString("s1.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res3.getString("s1.destination_airport")); %>
		<br/>
		<%if(res3.getString("s1.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res3.getString("s1.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res3.getString("s1.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res3.getString("s1.aircraft_id")); %>
		<br />
		<br />
		<%
		
		out.print("Second Flight Number: " + res3.getString("s2.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res3.getString("s2.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res3.getString("s2.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res3.getString("s2.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res3.getString("s2.destination_airport")); %>
		<br/>
		<%if(res3.getString("s2.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res3.getString("s2.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res3.getString("s2.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res3.getString("s2.aircraft_id")); %>
		<br />
		<br />
		<%
		
		out.print("Third Flight Number: " + res3.getString("s3.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res3.getString("s3.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res3.getString("s3.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res3.getString("s3.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res3.getString("s3.destination_airport")); %>
		<br/>
		<%if(res3.getString("s3.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res3.getString("s3.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res3.getString("s3.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res3.getString("s3.aircraft_id")); %>
		<br />
		<%out.println("Total Price: " + res3.getString("s1.price") + res3.getString("s2.price") + res3.getString("s3.price")); %>
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