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
	st.executeUpdate("create temporary table t1 select * from flight where DATE(DATE_ADD(departure_time, INTERVAL 3 DAY)) >= '" + departure_date + "' and DATE(DATE_ADD(departure_time, INTERVAL -3 DAY)) <= '" + departure_date + "'and departure_airport = '" + departure_airport + "' and destination_airport = '" + arrival_airport + "'");
	st2.executeUpdate("create temporary table t2 select * from flight where DATE(DATE_ADD(departure_time, INTERVAL 3 DAY)) >= '" + return_date + "' and DATE(DATE_ADD(departure_time, INTERVAL -3 DAY)) <= '" + return_date + "' and departure_airport = '" + arrival_airport + "' and destination_airport = '" + departure_airport + "'");
	ResultSet res = st3.executeQuery("select * from t1 cross join t2"); %>
	
	<p>Non-Stop Flights</p> <%
		
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
		<%out.println("Price: " + res.getString("price")); %>
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
		<%out.println("Price: " + res.getString("price")); %>
		<br />
		<br /> <%
	}
	
	Statement st4 = con.createStatement();
	Statement st5 = con.createStatement();
	Statement st6 = con.createStatement();
	st4.executeUpdate("create temporary table t1 select * from flight where DATE(DATE_ADD(departure_time, INTERVAL 3 DAY)) >= '" + departure_date + "' and DATE(DATE_ADD(departure_time, INTERVAL -3 DAY)) <= '" + departure_date + "' and departure_airport = '" + departure_airport + "' and destination_airport <> '" + arrival_airport + "'");
	st5.executeUpdate("create temporary table s2 select * from flight where destination_airport = '" + arrival_airport + "'");
	ResultSet res2 = st6.executeQuery("select * from s1, s2 where s1.destination_airport = s2.departure_airport and s2.departure_time > s1.arrival_time");
	
	Statement st7 = con.createStatement();
	Statement st8 = con.createStatement();
	Statement st9 = con.createStatement();
	st7.executeUpdate("create temporary table t2 select * from flight where DATE(DATE_ADD(departure_time, INTERVAL 3 DAY)) >= '" + return_date + "' and DATE(DATE_ADD(departure_time, INTERVAL -3 DAY)) <= '" + return_date + "' and departure_airport = '" + arrival_airport + "' and destination_airport <> '" + departure_airport + "'");
	st8.executeUpdate("create temporary table r2 select * from flight where destination_airport = '" + departure_airport + "'");
	ResultSet res3 = st9.executeQuery("select * from r1, r2 where r1.destination_airport = r2.departure_airport and r2.departure_time > r1.arrival_time");%>
	
	<p>One Stop Flights</p>
	
	<% while(res2.next()) {
		out.print("Flight Number: " + res2.getString("s1.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res2.getString("s1.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res2.getString("s1.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res2.getString("s1.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res2.getString("s1.destination_airport")); %>
		<br/>
		<%if(res2.getString("s1.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res2.getString("s1.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res2.getString("s1.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res2.getString("s1.aircraft_id")); %>
		<br />
		<br />
		
	<%out.print("Second Flight Number: " + res2.getString("s2.flight_number")); %>
	<br/>
	<%out.println("Departure Time: " + res2.getString("s2.departure_time")); %> 
	<br/>
	<%out.println("Arrival Time: " + res2.getString("s2.arrival_time")); %>
	<br/>
	<%out.println("Departure Airport: " + res2.getString("s2.departure_airport")); %>
	<br/>
	<%out.println("Destination Airport: " + res2.getString("s2.destination_airport")); %>
	<br/>
	<%if(res2.getString("s2.isDomestic").equals("1")) {
		out.println("Domestic Flight"); 
		}
		else {
			out.println("International Flight");
		}%>
		<br/>
	<%out.println("Airline: " + res2.getString("s2.airline_id")); %>
	<br/>
	<%out.println("Airport: " + res2.getString("s2.airport_id")); %>
	<br/>
	<%out.println("Aircraft: " + res2.getString("s2.aircraft_id")); %>
	<br/>
	<%out.println("Total Price: " + res2.getInt("s1.price") + res2.getInt("s2.price")); %>
	<br />
	<br />
	<%}%>
	
	Returning Flight
	
	<%while(res3.next()) {
		out.print("Flight Number: " + res3.getString("r1.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res3.getString("r1.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res3.getString("r1.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res3.getString("r1.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res3.getString("r1.destination_airport")); %>
		<br/>
		<%if(res3.getString("r1.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res3.getString("r1.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res3.getString("r1.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res3.getString("r1.aircraft_id")); %>
		<br />
		<br />
		
	<%out.print("Second Flight Number: " + res3.getString("r2.flight_number")); %>
	<br/>
	<%out.println("Departure Time: " + res3.getString("r2.departure_time")); %> 
	<br/>
	<%out.println("Arrival Time: " + res3.getString("r2.arrival_time")); %>
	<br/>
	<%out.println("Departure Airport: " + res3.getString("r2.departure_airport")); %>
	<br/>
	<%out.println("Destination Airport: " + res3.getString("r2.destination_airport")); %>
	<br/>
	<%if(res3.getString("r2.isDomestic").equals("1")) {
		out.println("Domestic Flight"); 
		}
		else {
			out.println("International Flight");
		}%>
		<br/>
	<%out.println("Airline: " + res3.getString("r2.airline_id")); %>
	<br/>
	<%out.println("Airport: " + res3.getString("r2.airport_id")); %>
	<br/>
	<%out.println("Aircraft: " + res3.getString("r2.aircraft_id")); %>
	<br/>
	<%out.println("Total Price: " + res3.getInt("r1.price") + res3.getInt("r2.price")); %>
	<br />
	<br /> <%
	}
	
	Statement st10 = con.createStatement();
	Statement st11 = con.createStatement();
	Statement st12 = con.createStatement();
	Statement st13 = con.createStatement();
	st10.executeUpdate("create temporary table t1 select * from flight where DATE(DATE_ADD(departure_time, INTERVAL 3 DAY)) >= '" + departure_date + "' and DATE(DATE_ADD(departure_time, INTERVAL -3 DAY)) <= '" + departure_date + "' and departure_airport = '" + departure_airport + "' and destination_airport <> '" + arrival_airport + "'");
	st11.executeUpdate("create temporary table a2 select * from flight where destination_airport <> '" + arrival_airport + "'");
	st12.executeUpdate("create temporary table a3 select * from flight where destination_airport = '" + arrival_airport + "'");
	ResultSet res4 = st13.executeQuery("select * from a1, a2, a3 where a1.destination_airport = a2.departure_airport and a2.departure_time > a1.arrival_time and a2.destination_airport = a3.destination_airport and a3.departure_time > a2.arrival_time"); 
	
	Statement st14 = con.createStatement();
	Statement st15 = con.createStatement();
	Statement st16 = con.createStatement();
	Statement st17 = con.createStatement();
	st14.executeUpdate("create temporary table t2 select * from flight where DATE(DATE_ADD(departure_time, INTERVAL 3 DAY)) >= '" + return_date + "' and DATE(DATE_ADD(departure_time, INTERVAL -3 DAY)) <= '" + return_date + "' and departure_airport = '" + arrival_airport + "' and destination_airport <> '" + departure_airport + "'");
	st15.executeUpdate("create temporary table b2 select * from flight where destination_airport <> '" + departure_airport + "'");
	st16.executeUpdate("create temporary table b3 select * from flight where destination_airport = '" + departure_airport + "'");
	ResultSet res5 = st17.executeQuery("select * from b1, b2, b3 where b1.destination_airport = b2.departure_airport and b2.departure_time > b1.arrival_time and b2.destination_airport = b3.destination_airport and b3.departure_time > b2.arrival_time");%>
	
	<p>Two Stop Flights</p>
	
	<% while(res4.next()) {
		out.print("Flight Number: " + res4.getString("a1.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res4.getString("a1.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res4.getString("a1.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res4.getString("a1.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res4.getString("a1.destination_airport")); %>
		<br/>
		<%if(res4.getString("a1.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res4.getString("a1.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res4.getString("a1.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res4.getString("a1.aircraft_id")); %>
		<br />
		<br />
		<%
		
		out.print("Second Flight Number: " + res4.getString("a2.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res4.getString("a2.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res4.getString("a2.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res4.getString("a2.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res4.getString("a2.destination_airport")); %>
		<br/>
		<%if(res4.getString("a2.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res4.getString("a2.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res4.getString("a2.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res4.getString("a2.aircraft_id")); %>
		<br />
		<br />
		<%
		
		out.print("Third Flight Number: " + res4.getString("a3.flight_number")); %>
		<br/>
		<%out.println("Departure Time: " + res4.getString("a3.departure_time")); %> 
		<br/>
		<%out.println("Arrival Time: " + res4.getString("a3.arrival_time")); %>
		<br/>
		<%out.println("Departure Airport: " + res4.getString("a3.departure_airport")); %>
		<br/>
		<%out.println("Destination Airport: " + res4.getString("a3.destination_airport")); %>
		<br/>
		<%if(res3.getString("a3.isDomestic").equals("1")) {
			out.println("Domestic Flight"); 
			}
			else {
				out.println("International Flight");
			}%>
			<br/>
		<%out.println("Airline: " + res4.getString("a3.airline_id")); %>
		<br/>
		<%out.println("Airport: " + res4.getString("a3.airport_id")); %>
		<br/>
		<%out.println("Aircraft: " + res4.getString("a3.aircraft_id")); %>
		<br />
		<%out.println("Total Price: " + res4.getString("a1.price") + res4.getString("a2.price") + res4.getString("a3.price")); %>
		<br />
		<br />
		<%
		}
		
		while(res5.next()) {
			out.print("Flight Number: " + res5.getString("b1.flight_number")); %>
			<br/>
			<%out.println("Departure Time: " + res5.getString("b1.departure_time")); %> 
			<br/>
			<%out.println("Arrival Time: " + res5.getString("b1.arrival_time")); %>
			<br/>
			<%out.println("Departure Airport: " + res5.getString("b1.departure_airport")); %>
			<br/>
			<%out.println("Destination Airport: " + res5.getString("b1.destination_airport")); %>
			<br/>
			<%if(res5.getString("b1.isDomestic").equals("1")) {
				out.println("Domestic Flight"); 
				}
				else {
					out.println("International Flight");
				}%>
				<br/>
			<%out.println("Airline: " + res5.getString("b1.airline_id")); %>
			<br/>
			<%out.println("Airport: " + res5.getString("b1.airport_id")); %>
			<br/>
			<%out.println("Aircraft: " + res5.getString("b1.aircraft_id")); %>
			<br />
			<br />
			<%
			
			out.print("Second Flight Number: " + res5.getString("b2.flight_number")); %>
			<br/>
			<%out.println("Departure Time: " + res5.getString("b2.departure_time")); %> 
			<br/>
			<%out.println("Arrival Time: " + res5.getString("b2.arrival_time")); %>
			<br/>
			<%out.println("Departure Airport: " + res5.getString("b2.departure_airport")); %>
			<br/>
			<%out.println("Destination Airport: " + res5.getString("b2.destination_airport")); %>
			<br/>
			<%if(res5.getString("b2.isDomestic").equals("1")) {
				out.println("Domestic Flight"); 
				}
				else {
					out.println("International Flight");
				}%>
				<br/>
			<%out.println("Airline: " + res5.getString("b2.airline_id")); %>
			<br/>
			<%out.println("Airport: " + res5.getString("b2.airport_id")); %>
			<br/>
			<%out.println("Aircraft: " + res5.getString("b2.aircraft_id")); %>
			<br />
			<br />
			<%
			
			out.print("Third Flight Number: " + res5.getString("b3.flight_number")); %>
			<br/>
			<%out.println("Departure Time: " + res5.getString("b3.departure_time")); %> 
			<br/>
			<%out.println("Arrival Time: " + res5.getString("b3.arrival_time")); %>
			<br/>
			<%out.println("Departure Airport: " + res5.getString("b3.departure_airport")); %>
			<br/>
			<%out.println("Destination Airport: " + res5.getString("b3.destination_airport")); %>
			<br/>
			<%if(res5.getString("b3.isDomestic").equals("1")) {
				out.println("Domestic Flight"); 
				}
				else {
					out.println("International Flight");
				}%>
				<br/>
			<%out.println("Airline: " + res5.getString("b3.airline_id")); %>
			<br/>
			<%out.println("Airport: " + res5.getString("b3.airport_id")); %>
			<br/>
			<%out.println("Aircraft: " + res5.getString("b3.aircraft_id")); %>
			<br />
			<%out.println("Total Price: " + res5.getString("b1.price") + res5.getString("b2.price") + res5.getString("b3.price")); %>
			<br />
			<br />
		
	<%}
	
	
	db.closeConnection(con);

}


catch (Exception e) {
	out.print(e);
}
%>


</body>
</html>