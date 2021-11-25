<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Created</title>
</head>
<body>
<%
if(request.getParameter("command").equals("Create")) {
if(!request.getParameter("type").equals("C") && !request.getParameter("type").equals("R")) {
	out.println("Sorry, but that type of user is not suported. Please try again");
	%>
	<a href="admin_home.jsp">Return Home</a>
	<% 		
}
else { %>
Congratulations, the User has been created.
<a href="admin_home.jsp">Return Home</a>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
ResultSet res = st.executeQuery("select * from user");
String newid = "";
while(res.next()) {
	newid = String.valueOf(Integer.parseInt(res.getString("id")) + 1);
} 
PreparedStatement ps = con.prepareStatement("insert into user(id,username,password,type)" + "Values (?,?,?,?)");
ps.setString(1,newid);
ps.setString(2,request.getParameter("username"));
ps.setString(3,request.getParameter("password"));
ps.setString(4,request.getParameter("type"));
ps.executeUpdate();
}
}
else if(request.getParameter("command").equals("Edit")) {
	if(!request.getParameter("type").equals("C") && !request.getParameter("type").equals("R") && !request.getParameter("type").equals("")) {
		out.println("Sorry, but that type of user is not suported. Please try again");
		%>
		<a href="admin_home.jsp">Return Home</a>
		<% 		
	}
	else {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select * from user where id = " + request.getParameter("id"));
	if(!res.next()) {
		out.print("Sorry, there is no user with the id provided. Please try again");
		%>
		<a href="admin_home.jsp">Return Home</a>
		<% 
	}
	else {
	String id = request.getParameter("id");
	Statement st2 = con.createStatement();
	if(!request.getParameter("username").equals("")) {
		PreparedStatement ps = con.prepareStatement("update user set username = ? where id = ?");
		ps.setString(1,request.getParameter("username"));
		ps.setString(2,id);
		ps.executeUpdate();
	}
	if(!request.getParameter("password").equals("")) {
		PreparedStatement ps = con.prepareStatement("update user set password = ? where id = ?");
		ps.setString(1,request.getParameter("password"));
		ps.setString(2,id);
		ps.executeUpdate();
	}
	if(!request.getParameter("type").equals("")) {
		PreparedStatement ps = con.prepareStatement("update user set type = ? where id = ?");
		ps.setString(1,request.getParameter("type"));
		ps.setString(2,id);
		ps.executeUpdate();
	}
	%>
	The user has been edited.
	<a href="admin_home.jsp">Return Home</a>
	<%
	}
	}
}
else {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select * from user where id =" + request.getParameter("id"));
	if(!res.next()) {
		out.print("Sorry, there is no user with the id provided. Please try again");
		%>
		<a href="admin_home.jsp">Return Home</a>
		<% 
	}
	else {
		PreparedStatement ps = con.prepareStatement("delete from user where id = ?");
		ps.setString(1,request.getParameter("id"));
		ps.executeUpdate();
		out.println("The user has been deleted.");
		%>
		<br/>
		<a href="admin_home.jsp">Return Home</a>
		<% 
	}
	
}
%>
</body>
</html>