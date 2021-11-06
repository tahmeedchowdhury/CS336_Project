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
Statement stmt = con.createStatement();
String str = "SELECT * FROM bars";
ResultSet result = stmt.executeQuery(str);
while(result.next()) {
	result.getString("name");
}
db.closeConnection(con);
 } 
 catch(Exception e) {
	e.printStackTrace();
	out.print(con);
} 
%>
</body>
</html>