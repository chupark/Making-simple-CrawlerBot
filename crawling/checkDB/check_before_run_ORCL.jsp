<%@ page contentType="application/json; charset=utf-8" %>
<%@ page session="true" import="java.util.*" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page info="copyright by Chi Woo Park, email:qkrcldn12@gmail.com"%>
<%request.setCharacterEncoding("UTF-8");%>

<%
Connection conn = null;
Statement stmt = null;
ResultSet rset = null;
String unronsa = request.getParameter("company");
int orderNum = 0;
String status_msg = "";
String sql = "";
if(unronsa == null){
	return;
}else if(unronsa.equals("")){
	return;
}

try{
	//DBMS연결
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.23.99:1521:QKRCLDNQKR","CHIWOO","CHIWOO");
	stmt = conn.createStatement();
	sql = "SELECT COUNT(DOMAIN) FROM CRAWLING_NEWS WHERE DOMAIN='"+unronsa+"'";
	rset = stmt.executeQuery(sql);
	while(rset.next()){
		orderNum = rset.getInt(1);
	}

	stmt.execute(sql);
	status_msg="{\"success\":\""+orderNum+"\"}";
	rset.close();
	stmt.close();
	conn.close();
	} catch(SQLException ex) {
		status_msg = "{\"fail\":\""+ex+"\"'}";
	} catch(Exception e){
		status_msg = "{\"fail\":\""+e+"\"}";
	}finally {
		if (rset != null) try { rset.close(); } catch(SQLException ex) {}
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
<%=status_msg%>