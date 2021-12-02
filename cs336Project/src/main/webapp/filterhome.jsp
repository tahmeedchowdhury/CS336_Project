<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>HomePage</title>
</head>
<body>
<h1 style="align-self:center; font-size: 36px">Welcome <%=session.getAttribute("user")%></h1>
<p> Please select an option below </p>

<br />


<% out.println("Sort Flights by criteria: "); %>  
							  
		<br>
		<form method="get" action="sortFlight.jsp"> <%--change action--%>
			<select name="sort_type" size=1>
				<option value="price">Sort by price</option>
				<option value="take-off time">Sort by take-off time</option>
				<option value="landing_time">Sort by landing time</option>
				<option value="duration_of_flight">Sort by duration of flight</option>
			</select>&nbsp;<br>

		<input type="submit" value="submit">
		</form>
	<br>

<% out.println("Or, Filter list of Flights by critera: "); %>

<br>
Filter by price: 
<br>
		<form method="get" action="priceFilter.jsp">
			<table>
				<tr>    
					<td>Price</td><td><input type="text" name="price"></td>
				</tr>
			</table>
			<input type="submit" value="Search Flights!">
		</form>
	<br>

Filter by number of stops: 
<br>
		<form method="get" action="numOfStopsFilter.jsp">
			<table>
				<tr>    
					<td>Number of Stops</td><td><input type="text" name="numOfStops"></td>
				</tr>
			</table>
			<input type="submit" value="Search Flights!">
		</form>
	<br>

Filter by airline: 
<br>
		<form method="get" action="airlineFilter.jsp">
			<table>
				<tr>    
					<td>Airline Name</td><td><input type="text" name="airline"></td>
				</tr>
			</table>
			<input type="submit" value="Search Flights!">
		</form>
	<br>

Filter by take-off time:
<br>
		<form method="get" action="takeoffTimeFilter.jsp">
			<table>
				<tr>    
					<td>Departure Time</td><td><input type="time" name="takeoffTime"></td>
				</tr>
			</table>
			<input type="submit" value="Search Flights!">
		</form>
	<br>

Filter by landing time: 
<br>
		<form method="get" action="landingTimeFilter.jsp">
			<table>
				<tr>    
					<td>Arrival Time</td><td><input type="time" name="landingTime"></td>
				</tr>
			</table>
			<input type="submit" value="Search Flights!">
		</form>
	<br>

</body>
</html>