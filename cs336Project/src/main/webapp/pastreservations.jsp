<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import='' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

try {
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	
	ResultSet res = st.executeQuery("select * from ticket where id_number = " + session.getAttribute("id") + " and DATE(purchase_time) < CURDATE()");
	
	while (res.next()) {
		
		ResultSetMetaData rsmd = res.getMetaData();
		
	}
	
}

catch (Exception e) {
	out.print(e);
}

%>

</body>
</html>