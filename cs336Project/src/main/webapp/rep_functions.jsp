<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Representative Changes</title>
</head>
<body>
<%
if(request.getParameter("command").equals("Add Airport")) {
	%>
	<form method="post" action = rep_changes.jsp>
	New 3-Letter Airport ID: <input type="text" name="airport_id"/>
	<input type="submit" name="command" value="Add New Airport"/>
	</form>
	<%
}
else if(request.getParameter("command").equals("Edit Airport")) {
	%>
	<form method = "post" action = rep_changes.jsp>
	Change Airport Id from: <input type="text" name="from_port"/> To: <input type="text" name="to_port"/> 
	 <input type="submit" name="command" value="Edit Airport"/>
	</form>
	<% 
}
else if(request.getParameter("command").equals("Delete Airport")) {
	%>
	<form method = "post" action = rep_changes.jsp>
	 Delete Airport with ID: <input type="text" name="aiport_id"/> 
	 <input type="submit" name="command" value="Delete Airport"/>
	</form>
	<%
}
else if(request.getParameter("command").equals("Edit Flight")) {
	%>
	Please enter the Flight Number and Airline ID of the flight you wish to edit. Note blank fields will be considered no change.
	<form method = "post" action=rep_changes.jsp>
	Flight Number and Airline ID to edit: <input type="text" name="edit_number"/> <input type="text" name="edit_id"/>
	flight Number: <input type="text" name="flight_number"/>
	airline_id: <input type="text" name="airline_id"/>
	<br/>
	departure_time(YYYY-MM-DD HH:MM:SS): <input type="text" name="departure_time"/>
	arrival_time(YYYY-MM-DD HH:MM:SS): <input type="text" name="arrival_time"/>
	<br/>
	departure_airport(ID): <input type="text" name="departure_airport"/>
	destination_airport(ID): <input type="text" name="destination_airport"/>
	isDomestic(0 for NO or 1 for YES): <input type="text" name="isDomestic"/>
	<br/>
	airport_id: <input type="text" name="airport_id"/>
	aircraft_id: <input type="text" name="aircraft_id"/>
	price: <input type="text" name="price"/>
	<br/>
	<input type="submit" name="command" value="Make Changes"/>
	</form>
	<%
}
else if(request.getParameter("command").equals("Add Flight")) {
	%>
	please enter all the following information:
	<br/>
		<form method = "post" action=rep_changes.jsp>
	flight Number: <input type="text" name="flight_number"/>
	airline_id: <input type="text" name="airline_id"/>
	<br/>
	departure_time(YYYY-MM-DD HH:MM:SS): <input type="text" name="departure_time"/>
	arrival_time(YYYY-MM-DD HH:MM:SS): <input type="text" name="arrival_time"/>
	<br/>
	departure_airport(ID): <input type="text" name="departure_airport"/>
	destination_airport(ID): <input type="text" name="destination_airport"/>
	isDomestic(0 for NO or 1 for YES): <input type="text" name="isDomestic"/>
	<br/>
	airport_id: <input type="text" name="airport_id"/>
	aircraft_id: <input type="text" name="aircraft_id"/>
	price: <input type="text" name="price"/>
	<br/>
	<input type="submit" name="command" value="Add Flight"/>
	</form>
	<%
		
}
else if(request.getParameter("command").equals("Delete Flight")) {
	%>
	Please enter the Flight Number and Airlline Id of the flight you wish to delete:
	<br/>
	<form method="post" action=rep_changes.jsp>
	Flight Number: <input type="text" name="flight_number"/> Airline ID: <input type="text" name="airline_id"/>
	<br/>
	<input type="submit" name="command" value="Delete Flight"/>
	</form>
	<%
}
else if(request.getParameter("command").equals("Add Aircraft")) {
	%>
	Please enter the following information to create and Aircraft:
	<br/>
	<form method="post" action=rep_changes.jsp>
	AircraftId(Integer): <input type="text" name="id"/> Airline ID(2 character ID): <input type="text" name="airline_id"/>
	<br/>
	Operating days(enter 3 letter string of days seprated by commas. Please do not use spaces): <input type="text" name="opdays"/>
	<br/>
	Number of Seats in First-Class: <input type = "text" name="numseats_first"/>
	<br/>
	Number of Seats in Business-Class: <input type = "text" name="numseats_business"/>
	<br/>
	Number of Seats in Economy-Class: <input type = "text" name="numseats_economy"/>
	<br/>
	<input type="submit" name="command" value="Add Aircraft"/>
	</form>
	<%
}
else if(request.getParameter("command").equals("Edit Aircraft")) {
	%>
	Please enter the information you want to change for an Aircraft. Any empty fields will be treated as no change:
	<br/>
	<form method="post" action=rep_changes.jsp>
	AircraftId to edit(must be filled in) : <input type="text" name="changeid"/>
 	<br/>
	AircraftId(Integer): <input type="text" name="id"/> Airline ID(2 character ID): <input type="text" name="airline_id"/>
	<br/>
	Operating days(enter 3 letter string of days seprated by commas. Please do not use spaces): <input type="text" name="opdays"/>
	<br/>
	Number of Seats in First-Class: <input type = "text" name="numseats_first"/>
	<br/>
	Number of Seats in Business-Class: <input type = "text" name="numseats_business"/>
	<br/>
	Number of Seats in Economy-Class: <input type = "text" name="numseats_economy"/>
	<br/>
	<input type="submit" name="command" value="Edit Aircraft"/>
	</form>
	<%
}
else if(request.getParameter("command").equals("Delete Aircraft")) {
	%>
	Please enter the information for the Aircraft you want to delete:
	<br/>
	<form method="post" action=rep_changes.jsp>
	Aircraft ID to delete : <input type="text" name="id"/>
	<input type="submit" name="command" value="Delete Aircraft"/>
	</form>
	<%
}
else if(request.getParameter("command").equals("Retrieve Waiting List")) {
	%>
	<form method="post" action=rep_changes.jsp>
	Flight Number to Retrieve Waiting List For : <input type="text" name="fnum"/>
	<input type="submit" name="command" value="Retrieve Waiting List"/>
	</form>
	<%
}
else if(request.getParameter("command").equals("Produce List")) {
	%>
	<form method="post" action=rep_changes.jsp>
	Airport ID : <input type="text" name="id"/>
	<input type="submit" name="command" value="Produce List"/>
	</form>
	<%
}
else if(request.getParameter("command").equals("Reply")) {
	%>
	<form method="post" action=rep_changes.jsp>
	Please enter the ID of the question you would like to answer as well as your answer. Note that questions that already have answers will be replaced with the new answer.
	<br/>
	Question ID: <input type="text" name="id"/>
	<br/> Answer: <input type="text" name="ans"/> <input type="submit" name="command" value="Answer Question"/>
	<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select * from questions");
	ResultSetMetaData resmeta = res.getMetaData();
	while(res.next()) { %>
	<br/>
	<br/>
	<%
	out.print("Question ID " + res.getString("qid") + ": ");
	out.print(res.getString("question")); %>
	<br/>
	<% 
	out.print("Answer : " + res.getString("answer"));
	}
	%>
	</form>
	<%
}
%>
</body>
</html>