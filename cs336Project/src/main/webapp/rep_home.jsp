<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Customer Representative Home</title>
</head>
<body>
Hi there customer Representative <%=session.getAttribute("user")%>
<a href="logout.jsp">Log Out</a>
<br/>
<form method="post" action=rep_functions.jsp>
Make A Flight Reservation on Behalf of Another user:<input type="submit" name="command" value="Make Reservations"/>
<br/>
<br/>
Edit A User's Flight Reservations: <input type="submit" name="command" value="Edit Reservations"/>
<br/>
<br/>
Add, Edit, Or Delete Airports: <input type="submit" name="command" value="Add Airport"/> <input type="submit" name="command" value="Edit Airport"/> <input type="submit" name="command" value="Delete Airport"/>
<br/>
<br/>
Add, Edit, Or Delete Flights: <input type="submit" name="command" value="Add Flight"/> <input type="submit" name="command" value="Edit Flight"/> <input type="submit" name="command" value="Delete Flight"/>
<br/>
<br/>
Add, Edit, Or Delete Aircrafts: <input type="submit" name="command" value="Add Aircraft"/> <input type="submit" name="command" value="Edit Aircraft"/> <input type="submit" name="command" value="Delete Aircraft"/>
<br/>
<br/>
Retrieve Waiting List for A Flight: Enter Flight Number: <input type="submit" name="command" value="Retrieve Waiting List"/>
<br/>
<br/>
Produce A List of Flights for a given Airport: <input type="submit" name="command" value="Produce List"/>
<br/>
<br/>
Reply to Users' Questions: <input type="submit" name="command" value="Reply"/>
</form>
</body>
</html>