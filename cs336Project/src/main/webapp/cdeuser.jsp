<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create/Delete/Edit a User</title>
</head>
<body>
<%
String command = request.getParameter("command");
String input = request.getParameter("input");
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
if(command.equals("Create User")) {
	%>
	<form method="get" action="userfunctions.jsp">
	Please enter the username, password, and type of user to create below:
	<br/>
	Username: <input type="text" name="username"/>
	Password: <input type="text" name="password"/>
	<br/>
	Type(Either R for Representative or C for Customer): <input type="text" name="type"/>
	<br/>
	First Name: <input type="text" name="fname"/>
	Last Name: <input type="text" name="lname"/>
	<input type="submit" name="command" value ="Create"/>
	<br/>
	<a href="admin_home.jsp">Return Home</a>
	</form>
	<% 
}
else if(command.equals("Edit User")) {
	%>
	<form method="get" action="userfunctions.jsp">
	Please enter the values to change(If field is left blank, then no change will be made to that field):
	<br/>
	Id of User to Edit: <input type="text" name="id"/>
	<br/>
	Change Username to: <input type="text" name="username"/>
	<br/>
	Change Password to: <input type="text" name="password"/>
	<br/>
	Change Type(Either R for Representative or C for Customer) to: <input type="text" name="type"/>
	<br/>
	Change First Name: <input type="text" name="fname"/>
	<br/>
	Change Last Name: <input type="text" name="lname"/>
	<input type="submit" name="command" value ="Edit"/>
	<br/>
	<a href="admin_home.jsp">Return Home</a>
	</form>
	<%
}
else if(command.equals("Delete User")) {
	%>
	<form method="get" action="userfunctions.jsp">
	Please enter the id of the user you wish to delete: <input type="text" name="id"/>
	<br/>
	<input type="submit" name="command" value="Delete"/>
	</form>
	<% 
} %>
</body>
</html>