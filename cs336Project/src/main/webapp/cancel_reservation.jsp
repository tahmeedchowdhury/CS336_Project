<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cancel a Reservation</title>
</head>
<body>
Below are your Reservations. Please enter the ticket number for the reservation you want to be cancelled.
<br/>
<form method="post" action=cancel_finalize.jsp>
Ticket Number: <input type="number" name="number"/>
<input type="submit" name="command" value="Cancel Reservation"/> 
</form>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet res = st.executeQuery("select * from ticket where id =" + String.valueOf(session.getAttribute("id")) + " and total_fare <> 10");
ResultSetMetaData resmeta = res.getMetaData();
int cols = resmeta.getColumnCount();
while(res.next()) { %>
<br/>
<br/>
<%
for(int i = 1; i <= cols; i++) {
	if(!resmeta.getColumnName(i).equals("first_name") && !resmeta.getColumnName(i).equals("last_name") && !resmeta.getColumnName(i).equals("id")) {
		out.print(resmeta.getColumnName(i) + ": " + res.getString(i) + "  ||  ");
	}
}
}
%>
</body>
</html>o