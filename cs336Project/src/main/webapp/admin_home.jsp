<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administrator HomePage</title>
</head>
<body>
Hi there, Administrator <%=session.getAttribute("user")%> <a href ="logout.jsp">Log Out</a>
<br/>
Please Select from the options below.
<br/>
User Manipulation: 
<form method="post" action=cdeuser.jsp>
<input type="submit" name="command" value="Create User"/>
<input type="submit" name="command" value="Delete User"/>
<input type="submit" name="command" value="Edit User"/>
</form>
<br/>
<form method="get" action=stats.jsp>
Obtain Sales Report for a Particular Month(Enter a number from 1-12. Must be two digits): <input type="text" name="month"/>
<input type="submit" name="command" value="Sales Report"/>
<br/>
Generate Reservations by Flight Number. Enter Flight Number: <input type="text" name="fnum"/>
<input type="submit" name="command" value="Generate By Flight Number"/>
<br/>
Generate Reservations by Customer Name: First Name: <input type="text" name="fname"/> Last Name: <input type="text" name="lname"/> 
<input type="submit" name="command" value="Generate By Customer Name"/>
<br/>
Generate Summary Revenue from a Flight. Enter Flight number : <input type="text" name="fnum2"/> Enter Airline ID: <input type="text" name="id"/>
<input type="submit" name="command" value="Generate Flight Revenue"/>
<br/>
Generate Summary Revenue from an Airline(Enter Airline ID): <input type="text" name="airline_id"/> 
<input type="submit" name="command" value="Generate Airline Revenue"/>
<br/>
<%
ApplicationDB db0 = new ApplicationDB();
Connection con0 = db0.getConnection();
Statement st0 = con0.createStatement();
ResultSet res0 = st0.executeQuery("select * from airline_company");
out.print("The following is a list of available airlines: ");
while(res0.next()) {
	out.print(res0.getString("airline_id") + ", ");
}
%>
<br/>
Generate Revenue from a Customer(Enter Customer ID): <input type="text" name="customer_id">
<input type="submit" name="command" value="Generate Customer Revenue"/>
<br/>
Find Customer Who Generated Most Revenue: <input type="submit" name="command" value="Find Customer"/>
<br/>
Generate List of 3 Most Active Flights: <input type="submit" name="command" value="Generate List"/>
</form>
<br/>
The following are all users available on the platform:
<br/>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet res = st.executeQuery("select * from user");
while(res.next()) {
	if(!res.getString("type").equals("A")) { %>
	<% out.println("User Id: " + res.getString("id") + " | " + "Username: " + res.getString("username") + " | " + "Password: " + res.getString("password") + " | " + "User type: " + res.getString("type") + " | " + "User First Name: " + res.getString("first_name") + " | " + "User Last Name: " + res.getString("last_name")); %>
	<br/>
	<%		
	}
	
}
%>
</body>
</html>