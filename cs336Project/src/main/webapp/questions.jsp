<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Questions and Answers</title>
</head>
<body>
<h1>Questions and Answers</h1>
<p>Please look below for asked questions and their answers. Feel free to search or ask your own questions by entering keywords into the text input below!</p>
<form method = "get" action = addquestion.jsp>
Please enter a question or search terms here: <input type="text" name="keywords"/>
<input type="submit" name="command" value="Search"/>
<input type="submit" name="command" value="Ask Question"/>
</form>
<%
ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();
try {
	Statement st = con.createStatement();
	ResultSet res = st.executeQuery("select * from questions");
	while(res.next()) {
		%>
		<br/>
		<% out.println("Q: " + res.getString("question"));%>
		<br/>
		<% out.println("A: " + res.getString("answer"));%>
		<br/>
		<%
	};
}

catch(Exception e) {
	e.printStackTrace();
}
%>
</body>
</html>