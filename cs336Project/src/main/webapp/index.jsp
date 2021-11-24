<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Airport</title>
</head>
<body>
<div id="Login Form"> 
<form method="get" action = log_reg.jsp>
	<table>
		<tr>    
			<td>Username</td><td><input type="text" name="username"></td>
		</tr>
		<tr>
			<td>Password</td><td><input type="password" name="password"></td>
		</tr>
	</table>
	<input type="submit" name="command" value="Log In">
	<input type="submit" name="command" value="Register">
</form>
</div>
</body>
</html>