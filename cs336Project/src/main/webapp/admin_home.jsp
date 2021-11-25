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
Generate Reservations by Flight Number: <input type="text" name="fnum"/> 
<input type="submit" name="command" value="Generate By Flight Number"/>
<br/>
Generate Reservations by Customer Name: First Name: <input type="text" name="fname"/> Last Name: <input type="text" name="lname"/> 
<input type="submit" name="command" value="Generate By Customer Name"/>
<br/>
Generate Summary Revenue from a Flight: <input type="text" name="fnum2"/> 
<input type="submit" name="command" value="Generate Flight Revenue"/>
</form>
<br/>
The following are all users available on the platform that can be manipulated:
<br/>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet res = st.executeQuery("select * from user");
while(res.next()) {
	if(!res.getString("type").equals("A")) { %>
	<% out.println("User Id: " + res.getString("id") + " | " + "Username: " + res.getString("username") + " | " + "Password: " + res.getString("password") + " | " + "User type: " + res.getString("type")); %>
	<br/>
	<%		
	}
	
}
%>
</body>
</html>