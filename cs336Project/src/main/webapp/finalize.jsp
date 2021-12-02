<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Finalize Reservation</title>
</head>
<body>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement st = con.createStatement();
String[] fnum = request.getParameterValues("fnum");
String[] id = request.getParameterValues("id");
String cl = request.getParameter("class");
/*ResultSet res = st.executeQuery("select * from flight");
ResultSet res2 = st.executeQuery("select * from aircraft");
ResultSetMetaData resmeta = res.getMetaData();
ResultSetMetaData res2meta = res2.getMetaData(); */
boolean wait = false;
float totalfare = 0;
try{
	for(int i = 0; i < fnum.length; i++) {
		ResultSet res = st.executeQuery("select * from flight where flight_number =" + fnum[i] + " and airline_id = '" + id[i] + "'");
		res.next();
		String acid = res.getString("aircraft_id");
		Statement st2 = con.createStatement();
		ResultSet res2 = st2.executeQuery("select count(*) as count from ticket_for where flight_number = " + fnum[i] + " and airline_id ='" + id[i] + "' and class ='" + cl + "'");
		res2.next();
		Statement st3 = con.createStatement();
		ResultSet res3 = st3.executeQuery("select * from aircraft where aircraft_id = " + acid);
		res3.next();
		totalfare = totalfare + res.getFloat("price");
		if(res2.getInt("count") >= res3.getInt("numseats_"+cl)) {
			out.print("Sorry, but it seems Flight " + fnum[i] + " of Airline " + id[i] + "is full. You will be placed on the waiting list for this flight. Your other flights will be cancelled."); %>
			<br/>
			<a href="home.jsp">Return Home</a>
			<%
			wait = true;
			PreparedStatement ps = con.prepareStatement("insert into waiting_list(id,airline_id,flight_number) values(?,?,?)");
			ps.setString(1,String.valueOf(session.getAttribute("id")));
			ps.setString(2,id[i]);
			ps.setString(3,fnum[i]);
			ps.executeUpdate();
			break;
		}
	}
	if(wait == false) {
		ResultSet tn = st.executeQuery("select * from ticket");
		String newnum = "";
		while(tn.next()) {
			newnum = String.valueOf(Integer.parseInt(tn.getString("number")) + 1);
		} 
		PreparedStatement ps2 = con.prepareStatement("insert into ticket(number,booking_fee,purchase_time,first_name,last_name,total_fare,isOne_way,isRound_trip,id) values(?,?,?,?,?,?,?,?,?)");
		ps2.setString(1,newnum);
		ps2.setString(2,String.valueOf(fnum.length * 30));
		ps2.setTimestamp(3, new java.sql.Timestamp(new java.util.Date().getTime()));
		ps2.setString(4,String.valueOf(session.getAttribute("first_name")));
		ps2.setString(5,String.valueOf(session.getAttribute("last_name")));
		ps2.setString(6,String.valueOf(totalfare + fnum.length * 30));
		if(request.getParameter("trip_type").equals("round")) {
		ps2.setString(7,"0");
		ps2.setString(8,"1");
		}
		else {
			ps2.setString(7,"1");
			ps2.setString(8,"0");
		}
		ps2.setString(9,String.valueOf(session.getAttribute("id")));
		ps2.executeUpdate();
		Statement st4 = con.createStatement();
		Statement st5 = con.createStatement();
		Statement st6 = con.createStatement();
		for(int i = 0; i < fnum.length; i++) {
			ArrayList<Integer> taken = new ArrayList<Integer>();
			ResultSet res4 = st4.executeQuery("select * from ticket_for where class = '" + cl + "' and flight_number = " + fnum[i] + " and airline_id = '" + id[i] + "'");
			ResultSet res5 = st5.executeQuery("select * from flight where flight_number = " + fnum[i] + " and airline_id = '" + id[i] + "'");
			res5.next();
			String acid = res5.getString("aircraft_id");
			ResultSet res6 = st6.executeQuery("select * from aircraft where aircraft_id = " + acid);
			res6.next();
			int seats = 0;
			int seatnum = 0;
			while(res4.next()) {
				taken.add(res4.getInt("seat_number"));
			}
			if(cl.equals("first")) {
			 	seats = res6.getInt("numseats_" + cl);
				Random r = new Random();
				seatnum = r.nextInt((seats+1) - 1) + 1;
				while(taken.contains(seatnum)) {
					seatnum = r.nextInt((seats+1) - 1) + 1;
				}
			}
			else if(cl.equals("business")) {
				seats = res6.getInt("numseats_" + cl) + res6.getInt("numseats_first");
				Random r = new Random();
				seatnum = r.nextInt((seats+1) - (res6.getInt("numseats_first") + 1)) + (res6.getInt("numseats_first") + 1);
				while(taken.contains(seatnum)) {
					seatnum = r.nextInt((seats+1) - (res6.getInt("numseats_first") + 1)) + (res6.getInt("numseats_first") + 1);
				}
			}
			else if(cl.equals("economy")) {
				seats = res6.getInt("numseats_" + cl) + res6.getInt("numseats_business") + res6.getInt("numseats_first");
				Random r = new Random();
				seatnum = r.nextInt((seats+1) - (res6.getInt("numseats_first") + res6.getInt("numseats_business") + 1)) + (res6.getInt("numseats_first") + res6.getInt("numseats_business") + 1);
				while(taken.contains(seatnum)) {
					seatnum = r.nextInt((seats+1) - (res6.getInt("numseats_first") + res6.getInt("numseats_business") + 1)) + (res6.getInt("numseats_first") + res6.getInt("numseats_business") + 1);
				}
			}

			PreparedStatement ps3 = con.prepareStatement("insert into ticket_for(number,flight_number,airline_id,class,destination_airport,departure_airport,seat_number,departure_time) values(?,?,?,?,?,?,?,?)");
			ps3.setString(1,newnum);
			ps3.setString(2,fnum[i]);
			ps3.setString(3,id[i]);
			ps3.setString(4,cl);
			ps3.setString(5,res5.getString("destination_airport"));
			ps3.setString(6,res5.getString("departure_airport"));
			ps3.setString(7,String.valueOf(seatnum));
			ps3.setString(8,res5.getString("departure_time"));
			ps3.executeUpdate();
		}
		out.print("Congralutaions, your ticket has been reserved. Thank you for using our service."); %>
		<br/>
		<a href="home.jsp">Return Home</a>
		<%
	}
}
catch(Exception e) {
	out.print("Sorry, something went wrong. Please check that the flight information you entered is correct and formatted properly.");
	e.printStackTrace();%>
	<br/>
	<a href="home.jsp">Return Home</a>
	<%
}

%>
</body>
</html>