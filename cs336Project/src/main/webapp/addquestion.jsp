<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search/Add Question</title>
</head>
<body>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
String command = request.getParameter("command");
String keywords = request.getParameter("keywords");
Statement st = con.createStatement();
ResultSet res = st.executeQuery("select * from questions");
boolean found = false;
if(command.equals("Search")) {
	out.println("Results of your Search:");
	%>
	<br/>
	<% 
	while(res.next()) {
		if(res.getString("question").contains(keywords) || res.getString("answer").contains(keywords)) {
			found = true;
			%>
			<br/>
			<%out.println("Q: " + res.getString("question"));%>
			<br/>
			<% out.println("A: " + res.getString("answer"));%>
			<br/>
			<%
		}
	}
	if(found == false) {
		out.println("Sorry. No questions or answers contained the keywords you've searched for. Please try again"); %>
		<br/>
		<% 
	}
}
else {
	String latestqid = "";
	while(res.next()) {
		latestqid = String.valueOf(Integer.parseInt(res.getString("qid"))); 
	}
	latestqid = String.valueOf(Integer.parseInt(latestqid) + 1);
	PreparedStatement ps = con.prepareStatement("insert into questions(qid,question,id,answer)" + "Values (?,?,?,?)");
	ps.setString(1,latestqid);
	ps.setString(2,keywords);
	ps.setString(3,(String)session.getAttribute("id"));
	ps.setString(4,"To be answered");
	ps.executeUpdate();
	out.println("Thank you for your question. We will ge back to you with an answer soon!");
}
%>
<a href='questions.jsp'>Return to the Questions Page</a>
</body>
</html>