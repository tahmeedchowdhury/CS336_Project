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
	ResultSet res = st.executeQuery("select * from ticket t join ticket_for tf on t.first_name='" + fname + "' and t.last_name='" + lname + "' and t.number = tf.number");
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
	int count = 0;
	while(res.next()) {
		count++;
		total = total + Double.valueOf(res.getString("total_fare"));
	}
	out.print("The total revenue for this Flight is: " + total);
	%>
	<br/>
	<%
	out.print("The number of tickets purchased for this flight is: " + count);
	%>
	<br/>
	<a href="admin_home.jsp">Return Home</a>
	<%
}
%>
</body>
</html>