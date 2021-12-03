<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
 try {
String un = request.getParameter("username");   
String pass = request.getParameter("password");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
Statement st3 = con.createStatement();
ResultSet res = st.executeQuery("select * from user where username='" + un + "' and password='" + pass + "'");
ResultSet res2 = st2.executeQuery("select * from user where username='" + un + "' or password='" + pass + "'");
ResultSet res3 = st3.executeQuery("select id from user where id = (select max(id) from user)");
if(request.getParameter("command").equals("Log In")) {
	 if(res.next()) {
		 session.setAttribute("user", un);
		 session.setAttribute("id",res.getString("id"));
		 session.setAttribute("type",res.getString("type"));
		 session.setAttribute("first_name",res.getString("first_name"));
		 session.setAttribute("last_name",res.getString("last_name"));
		 out.println("welcome " + un);
		 out.println("<a href='logout.jsp'>Log out</a>");
	     response.sendRedirect("loggedin.jsp");
	 }
	 else {
		 out.println("Invalid username or password <a href='index.jsp'>try again</a>");
	 }
}
else {
	if(un.length() == 0 || pass.length() == 0){
		 out.println("Enter a valid value for username and password");
	}else{
	if(res2.next()) {
		out.println("Sorry, that username and/or password is already taken. Please try again");
		 out.println("<a href='index.jsp'>Back to Login Page</a>");
	}
	else {
	String newid = "";
	while(res3.next()) {
		newid = String.valueOf(Integer.parseInt(res3.getString("id")) + 1);
	} 
	PreparedStatement ps = con.prepareStatement("insert into user(id,username,password,type)" + "Values (?,?,?,?)");
	ps.setString(1,newid);
	ps.setString(2,un);
	ps.setString(3,pass);
	ps.setString(4,"C");
	ps.executeUpdate();
	out.println("Congratulations, you have been successfully registered. You may log in now");
	out.println("<a href='index.jsp'>Back to Login Page</a>");
	}
}
}
 } 
 catch(Exception e) {
	e.printStackTrace();
	out.print(con);
}
 finally {
	con.close();
 }
%>
</body>
</html>