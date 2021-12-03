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
<br/>
<form method="post" action=flights.jsp>
<input type="submit" name="command" value="Check Flights"/>
</form>
<br />
<form method="post" action=questions.jsp>
<input type="submit" name="command" value="Ask a Question"/>
</form>
<br/>
<form method="post" action=reserve.jsp>
<input type="submit" name="command" value="Make A Reservation"/>
</form>
<br/>
<form method="post" action=flight_stats.jsp>
<input type="submit" name="command" value="View Past Flight Reservations"/>
<br/>
<br/>
<input type="submit" name="command" value="View Upcoming Flights"/>
</form>
<br/>
<form method="post" action=cancel_reservation.jsp>
<input type="submit" name="command" value="Cancel A Reservation"/>
</form>
<br/>
<a href='logout.jsp'>Log out</a>
<br/>
<br/>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet res = st.executeQuery("select * from waiting_list where id =" + String.valueOf(session.getAttribute("id")));
if(res.next()) {
	Statement st1 = con.createStatement();
	ResultSet res1 = st1.executeQuery("select * from flight where flight_number =" + res.getString("flight_number") + " and airline_id = '" + res.getString("airline_id") + "'");
	res1.next();
	String acid = res1.getString("aircraft_id");
	Statement st2 = con.createStatement();
	ResultSet res2 = st2.executeQuery("select count(*) as count from ticket_for where flight_number = " + res.getString("flight_number") + " and airline_id ='" + res.getString("airline_id") + "' and class ='first'");
	res2.next();
	Statement st4 = con.createStatement();
	ResultSet res4 = st4.executeQuery("select count(*) as count from ticket_for where flight_number = " + res.getString("flight_number") + " and airline_id ='" + res.getString("airline_id") + "' and class ='business'");
	res4.next();
	Statement st5 = con.createStatement();
	ResultSet res5 = st5.executeQuery("select count(*) as count from ticket_for where flight_number = " + res.getString("flight_number") + " and airline_id ='" + res.getString("airline_id") + "' and class ='economy'");
	res5.next();
	Statement st3 = con.createStatement();
	ResultSet res3 = st3.executeQuery("select * from aircraft where aircraft_id = " + acid);
	res3.next();
	int fopen = res3.getInt("numseats_first") - res2.getInt("count");
	int bopen = res3.getInt("numseats_business") - res4.getInt("count");
	int eopen = res3.getInt("numseats_economy") - res5.getInt("count");
	if(fopen > 0 || bopen > 0 && eopen > 0) {
		out.print("This is a notification that a flight you are in the waiting list for has an open seat. The flight information is Flight Number " + res.getString("flight_number") + " and Airline ID " + res.getString("airline_id") + ".There are currently " + fopen + " first-class seats available, " + bopen + " business-class seats available, and " + eopen + " economy-class seats available. Please click the button below to remove yourself from the waiting list, or you may remain and keep getting notifications of future changes.");
		%>
		<br/>
		<form method="post" action=remove.jsp>
		Remove yourself from the Waiting List: <input type="submit" name="command" value="Remove"/>
		<input type="hidden" name="fnum" value = <%=res.getString("flight_number")%> />
		<input type="hidden" name="id" value = <%=res.getString("airline_id")%> />
		</form>
		<%
	}
}
%>
</body>
</html>