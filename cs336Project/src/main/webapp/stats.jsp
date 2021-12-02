<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Statistics</title>
</head>
<body>
<%
if(request.getParameter("command").equals("Sales Report")) {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	String month = request.getParameter("month");
	if(Integer.parseInt(month) < 0 || Integer.parseInt(month) > 12) {
		out.print("Please enter a proper month of the year.");
		%>
		<br/>
		<a href="admin_home.jsp">Return Home</a>
		<%
	}
	else {
		Statement st = con.createStatement();
		double total = 0;
		ResultSet res = st.executeQuery("select * from ticket where month(purchase_time) = " + month);
		while(res.next()) {
			total = total + Double.valueOf(res.getString("total_fare"));
		}
		out.println("The total money made last month from ticket sales is: " + String.valueOf(total)); %>
		<a href="admin_home.jsp">Return Home</a>
		<%
	}
}
else if(request.getParameter("command").equals("Generate By Customer Name")) {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select * from ticket t join ticket_for tf using(number) where t.first_name='" + fname + "' and t.last_name='" + lname + "'");
	out.print("The following are the reservations made by: " + fname + " " + lname);
	%>
	<br/>
	<%
	ResultSetMetaData resmeta = res.getMetaData();
	int cols = resmeta.getColumnCount();
	%>
	<%
	while(res.next()) {
		%>
		<br/>
		<br/>
		<%
		for(int i = 1; i <= cols; i++) {
			out.print(resmeta.getColumnName(i) + ": " + res.getString(i) + "  ||  ");
		}
	}
}
else if(request.getParameter("command").equals("Generate By Flight Number")) {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	String fnum = request.getParameter("fnum");
	ResultSet res = st.executeQuery("select * from ticket t join ticket_for tf on t.number = tf.number where flight_number =" + fnum);
	ResultSetMetaData resmeta = res.getMetaData();
	int cols = resmeta.getColumnCount();
	out.print("The following is a list of Reservations with the Flight Number: " + fnum); %>
	<br/>
	<% 
	while(res.next()) {
		%>
		<br/>
		<%
		for(int i = 1; i <= cols; i++) {
			out.print(resmeta.getColumnName(i) + ": " + res.getString(i) + "  ||  ");
		}
	}
}
else if(request.getParameter("command").equals("Generate Flight Revenue")) {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	String fnum = request.getParameter("fnum2");
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select * from ticket t join ticket_for tf on t.number = tf.number where flight_number =" + fnum);
	double total = 0;
	while(res.next()) {
		total = total + Double.valueOf(res.getString("total_fare"));
		out.print("The revenue from ticket number " + res.getString("number") + " is " + res.getString("total_fare")); %>
		<br/>
		<%
	}
	out.print("The total revenue for this Flight is: " + total);
	%>
	<br/>
	<%
	%>
	<br/>
	<a href="admin_home.jsp">Return Home</a>
	<%
}
else if(request.getParameter("command").equals("Generate Airline Revenue")) {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	String airline_id = request.getParameter("airline_id");
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select * from ticket t join ticket_for tf on t.number = tf.number where tf.airline_id='" + airline_id + "'");
	double total = 0;
	while(res.next()) {
		total = total + Double.valueOf(res.getString("total_fare"));
		out.print("The revenue from ticket number " + res.getString("number") + " is " + res.getString("total_fare")); %>
		<br/>
		<% 
	}
	out.print("The total revenue for this Airline company is: " + total);
	%>
	<br/>
	<%
	%>
	<br/>
	<a href="admin_home.jsp">Return Home</a>
	<%
}
else if(request.getParameter("command").equals("Generate Customer Revenue")) {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	String customer_id = request.getParameter("customer_id");
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select * from ticket t join ticket_for tf on t.number = tf.number where t.id_number=" + customer_id);
	double total = 0;
	while(res.next()) {
		total = total + Double.valueOf(res.getString("total_fare"));
		out.print("The revenue from ticket number " + res.getString("number") + " is " + res.getString("total_fare")); %>
		<br/>
		<% 
	}
	out.print("The total revenue for this Customer is: " + total);
	%>
	<br/>
	<%
	%>
	<br/>
	<a href="admin_home.jsp">Return Home</a>
	<%
}
else if(request.getParameter("command").equals("Find Customer")) {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select * from (select t.first_name, t.last_name, t.id,sum(t.total_fare) as sum from ticket t group by t.first_name) as totals where sum = (select max(sum) from (select t.first_name, t.last_name, t.id,sum(t.total_fare) as sum from ticket t group by t.first_name) as totals)");
	String fname = "";
	String lname = "";
	String id = "";
	double fare = 0;
	while(res.next()) {
			fname = res.getString("first_name");
			lname = res.getString("last_name");
			id = res.getString("id");
			fare = Integer.parseInt(res.getString("sum"));
	}
	out.print("The Customer who generated the most revenue is " + fname + " " + lname + "(id: " + id + ") with a total of " + fare);
	%>
	<br/>
	<%
	%>
	<br/>
	<a href="admin_home.jsp">Return Home</a>
	<%
	
}
else if(request.getParameter("command").equals("Generate List")) {
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select f.flight_number, f.airline_id, f.departure_airport, f.destination_airport, count(f.flight_number and f.airline_id) as count from flight f join ticket_for tf on f.flight_number = tf.flight_number and f.airline_id = tf.airline_id group by f.flight_number order by count desc");
	int count = 1;
	while(res.next() && count < 4) {
		out.print(count + ": " + "Flight Number " + res.getString("flight_number") + " going from " + res.getString("departure_airport") + " to " + res.getString("destination_airport") + " with a total of " + res.getString("count") + " ticket(s)"); %>
		<br/>
		<%
		count++;
	}
	%>
	<a href="admin_home.jsp">Return Home</a>
	<%
}
%>
</body>
</html>