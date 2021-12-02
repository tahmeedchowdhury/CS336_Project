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
if(request.getParameter("command").equals("Add New Airport")) {
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
String airport_id = request.getParameter("airport_id");
ResultSet res = st.executeQuery("select * from airport where airport_id = '" + airport_id + "'");
if(res.next()) {
	out.print("Sorry, this Airport already exists. Cannot add."); %>
	<a href="rep_home.jsp">Return Home</a>
	<%
}
else{
PreparedStatement ps = con.prepareStatement("insert into airport(airport_id) values('" + airport_id + "')");
ps.executeUpdate();
out.print("New Aiport Added!");
%>
<a href="rep_home.jsp">Return Home</a>
<%
}
}
else if(request.getParameter("command").equals("Edit Airport")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String fromport = request.getParameter("from_port");
	String toport = request.getParameter("to_port");
	ResultSet res = st.executeQuery("select * from airport where airport_id = '" + fromport + "'");
	if(!res.next()) {
		out.print("Sorry, no airports with this ID exist."); %>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
	else {
		PreparedStatement ps = con.prepareStatement("update airport set airport_id = '" + toport + "' where airport_id = '" + fromport + "'");
		PreparedStatement ps3 = con.prepareStatement("update flight set destination_airport = '" + toport + "' where destination_airport = '" + fromport + "'");
		PreparedStatement ps4 = con.prepareStatement("update flight set departure_airport = '" + toport + "' where departure_airport = '" + fromport + "'");
		PreparedStatement ps5 = con.prepareStatement("update ticket_for set destination_airport = '" + toport + "' where destination_airport = '" + fromport + "'");
		PreparedStatement ps6 = con.prepareStatement("update ticket_for set departure_airport = '" + toport + "' where departure_airport = '" + fromport + "'");
		ps.executeUpdate();
		ps3.executeUpdate();
		ps4.executeUpdate();
		ps5.executeUpdate();
		ps6.executeUpdate();
		out.print("Airport Editted!"); %>
		<a href="rep_home.jsp">Return Home</a>
		<% 
	}
	
}
else if(request.getParameter("command").equals("Delete Airport")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String airport_id = request.getParameter("aiport_id");
	ResultSet res = st.executeQuery("select * from airport");
	if(!res.next()) {
		out.print("Sorry, no airports with this id exist. "); %>
		<a href="rep_home.jsp">Return Home</a>
		<%
	}
	else {
		PreparedStatement ps = con.prepareStatement("delete from airport where airport_id = '" + airport_id + "'");
		ps.executeUpdate();
		out.print("Aiport Deleted."); %>
		<a href="rep_home.jsp">Return Home</a>
		<%
	}
}
else if(request.getParameter("command").equals("Make Changes")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String edit_number = request.getParameter("edit_number");
	String edit_id = request.getParameter("edit_id");
	String isInternational = "";
	if(request.getParameter("isDomestic").equals("1")) {
		isInternational = "0";
	}
	else if (request.getParameter("isDomestic").equals("0")){
		isInternational = "1";
	}
	else {
		isInternational = "";
	}
	String[] vals = {request.getParameter("flight_number"),request.getParameter("departure_time"),request.getParameter("arrival_time"),request.getParameter("departure_airport"),request.getParameter("destination_airport"),request.getParameter("isDomestic"),isInternational,request.getParameter("airport_id"),request.getParameter("aircraft_id"),request.getParameter("airline_id"),request.getParameter("price")};
	ResultSet res = st.executeQuery("select * from flight");
	ResultSetMetaData resmeta = res.getMetaData();
	int cols = resmeta.getColumnCount();
	try {
	for(int i = 1; i<= cols; i++) {
		if(!vals[i-1].equals("")) {
			if(resmeta.getColumnName(i).equals("flight_number") || resmeta.getColumnName(i).equals("isDomestic") || resmeta.getColumnName(i).equals("isInternational") || resmeta.getColumnName(i).equals("aircraft_id") || resmeta.getColumnName(i).equals("price")){
			PreparedStatement ps = con.prepareStatement("update flight set " + resmeta.getColumnName(i) + "=" + vals[i-1] +" where flight_number = " + edit_number + " and airline_id = '" + edit_id +"'");
			ps.executeUpdate();
			}
			else {
			PreparedStatement ps = con.prepareStatement("update flight set " + resmeta.getColumnName(i) + "='" + vals[i-1] +"' where flight_number = " + edit_number + " and airline_id = '" + edit_id +"'");
			ps.executeUpdate();
		}
	}
	}
	out.print("Changes to flight made."); %>
	<a href="rep_home.jsp">Return Home</a>
	<%
	}
	catch(Exception e) {
		out.print("Sorry, Updates could not be made. Please check that all information is inputted correctly and there are no duplicate flights."); %>
		<a href="rep_home.jsp">Return Home</a>
		<%
		e.printStackTrace();
	}
	
}
else if(request.getParameter("command").equals("Add Flight")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String isInternational = "";
	if(request.getParameter("isDomestic").equals("1")) {
		isInternational = "0";
	}
	else{
		isInternational = "1";
	}
	
	try {
		PreparedStatement ps = con.prepareStatement("insert into flight(flight_number,departure_time,arrival_time,departure_airport,destination_airport,isDomestic,isInternational,airport_id,aircraft_id,airline_id,price) values(?,?,?,?,?,?,?,?,?,?,?)");
		ps.setString(1,request.getParameter("flight_number"));
		ps.setString(2,request.getParameter("departure_time"));
		ps.setString(3,request.getParameter("arrival_time"));
		ps.setString(4,request.getParameter("departure_airport"));
		ps.setString(5,request.getParameter("destination_airport"));
		ps.setString(6,request.getParameter("isDomestic"));
		ps.setString(7,isInternational);
		ps.setString(8,request.getParameter("airport_id"));
		ps.setString(9,request.getParameter("aircraft_id"));
		ps.setString(10,request.getParameter("airline_id"));
		ps.setString(11,request.getParameter("price"));
		ps.executeUpdate();
		out.print("New Flight Added."); %>
		<a href="rep_home.jsp">Return Home</a>
		<%
	}
	catch(Exception e) {
		e.printStackTrace();
		out.print("Sorry, the flight could not be added. Please check that information is entered in the correct format and there are no duplicat flights numbers from the same airline company."); %>
		<br/>
		<a href="rep_home.jsp">Return Home</a>
		<%
	}
}
else if(request.getParameter("command").equals("Delete Flight")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String fnum = request.getParameter("flight_number");
	String id = request.getParameter("airline_id");
	try {
		PreparedStatement ps = con.prepareStatement("delete from flight where flight_number =" + fnum + " and airline_id = '" + id + "'");
		ps.executeUpdate();
		out.print("Flight Successfully Deleted"); %>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
	catch(Exception e) {
		out.print("Sorry, but the flight you are trying to delete cannot be found. Please re-enter the information and try again."); %>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
}
else if(request.getParameter("command").equals("Add Aircraft")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	try {
		PreparedStatement ps = con.prepareStatement("insert into aircraft(aircraft_id,operating_days,airline_id,numseats_first,numseats_business,numseats_economy) values (?,?,?,?,?,?)");
		ps.setString(1,request.getParameter("id"));
		ps.setString(2,request.getParameter("opdays"));
		ps.setString(3,request.getParameter("airline_id"));
		ps.setString(4,request.getParameter("numseats_first"));
		ps.setString(5,request.getParameter("numseats_business"));
		ps.setString(6,request.getParameter("numseats_economy"));
		ps.executeUpdate();
		out.print("Aricraft Successfully Added."); %>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
	catch(Exception e) {
		out.print("Sorry, but the Aircraft you are trying to add cannot be added. Please re-enter the information and try again."); %>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
}
else if(request.getParameter("command").equals("Edit Aircraft")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String changeid = request.getParameter("changeid");
	String[] vals = {request.getParameter("id"),request.getParameter("opdays"),request.getParameter("airline_id"),request.getParameter("numseats_first"),request.getParameter("numseats_business"),request.getParameter("numseats_economy")};
	ResultSet res = st.executeQuery("select * from aircraft");
	ResultSetMetaData resmeta = res.getMetaData();
	int cols = resmeta.getColumnCount();
	try {
	for(int i = 1; i<= cols; i++) {
		if(!vals[i-1].equals("")) {
			if(resmeta.getColumnName(i).equals("aircraft_id")|| resmeta.getColumnName(i).equals("numseats_first") || resmeta.getColumnName(i).equals("numseats_business") || resmeta.getColumnName(i).equals("numseats_economy")) {
			PreparedStatement ps = con.prepareStatement("update aircraft set " + resmeta.getColumnName(i) + "=" + vals[i-1] +" where aircraft_id = " + changeid);
			ps.executeUpdate();
			}
			else {
			PreparedStatement ps = con.prepareStatement("update aircraft set " + resmeta.getColumnName(i) + "='" + vals[i-1] +"' where aircraft_id = " + changeid);
			ps.executeUpdate();
		}
	}
	}
	out.print("Changes to Aircraft Made."); %>
	<a href="rep_home.jsp">Return Home</a>
	<%
	}
	catch(Exception e) {
		out.print("Sorry, Updates could not be made. Please check that all information is inputted correctly and there are no duplicate aircrafts."); %>
		<a href="rep_home.jsp">Return Home</a>
		<%
		e.printStackTrace();
	}
	
}
else if(request.getParameter("command").equals("Delete Aircraft")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String id = request.getParameter("id");
	try {
		PreparedStatement ps = con.prepareStatement("delete from aircraft where aircraft_id = " + id);
		ps.executeUpdate();
		out.print("Aircraft Successfully Deleted"); %>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
	catch(Exception e) {
		out.print("Sorry, but the Aircraft you are trying to delete cannot be deleted. Please make sure the Aircraft exists and the ID is correct."); %>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
}
else if(request.getParameter("command").equals("Retrieve Waiting List")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String fnum = request.getParameter("fnum");
	ResultSet res = st.executeQuery("select first_name,second_name from waiting_list where flight_number = " + fnum);
	out.print("The following customers are on the waiting list for this particular flight");
	try {
		while(res.next()) {
			%>
			<br/>
			<%
			out.print(res.getString("first_name") + " " + res.getString("last_name"));
		}
		%>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
	catch(Exception e) {
		out.print("Sorry, but the Waiting List for this Flight cannot be retreived. Please check that the Flight Number was correct."); %>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
}
else if(request.getParameter("command").equals("Produce List")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String id = request.getParameter("id");
	ResultSet res = st.executeQuery("select * from flight where departure_airport = '" + id + "' or destination_airport = '" + id + "'");
	ResultSetMetaData resmeta = res.getMetaData();
	int cols = resmeta.getColumnCount();
	out.print("The following flights either depart from or arrive to the given Airport: ");
	try {
		while(res.next()) {
			%>
			<br/>
			<br/>
			<%
			for(int i = 1; i <= cols; i++) {
				out.print(resmeta.getColumnName(i) + ": " + res.getString(i) + "  ||  ");
			}
		}
		%>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
	catch(Exception e) {
		out.print("Sorry, but the Flights List for this Airport cannot be retreived. Please check that the Airport ID was correct."); %>
		<a href = "rep_home.jsp">Return Home</a>
		<%
	}
}
else if(request.getParameter("command").equals("Answer Question")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String id = request.getParameter("id");
	String ans = request.getParameter("ans");
	try{
	PreparedStatement ps = con.prepareStatement("update questions set answer = '" + ans + "' where qid = " + id);
	ps.executeUpdate();
	out.print("Thank you for answering"); %>
	<br/>
	<a href="rep_home.jsp">Return Home</a>
	<%
	}
	catch(Exception e) {
		out.print("Sorry, the question with the ID provided cannot be answered. Please make sure it is the correct ID."); %>
		<a href="rep_home.jsp">Return Home</a>
		<%
	}
}
	
%>
</body>
</html>