<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search for Flights</title>
</head>
<body>

<br>
		<form method="get" action="flighttype.jsp"> <%--change action--%>
			<select name="trip_type" size=1>
				<option value="one_way_set">One Way Flights (set date)</option>
				<option value="round_trip_set">Round Trip Flights (set date)</option>
				<option value="one_way_flex">One Way Flights (flexible dates)</option>
				<option value="round_trip_flex">Round Trip Flights (flexible dates)</option>
			</select>&nbsp;<br> 
			
			<%--><tr>
				<td>Departing Airport</td><td><input type="text" name="depart_airport"></td>
				<td>Destination Airport</td><td><input type="text" name="dest_airport"></td>
			</tr>
			
			<tr>
				<td>Departure Date</td><td><input type="date" name="depart_date"></td>
				<td>Return Date</td><td><input type="date" name="return_date"></td>
			</tr>--%>
			
			<input type="submit" value="submit">
		</form>
	<br>

</body>
</html>