<%@page session="true" import="java.util.*" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%request.setCharacterEncoding("UTF-8");%>
<html>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rset = null;
%>
<%
try{
	//DBMS연결
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.23.99:1521:QKRCLDNQKR","CHIWOO","CHIWOO");
	stmt = conn.createStatement();
	
	if(conn != null){
		out.println("오라클 연결 성공!");
	}
	
	if(rset != null){
		rset.close();
	}
	
	//stmt.close();
	//conn.close();
	} catch(SQLException ex) {
		out.println(ex);
	} catch(Exception e){
		out.println(e);
	}finally {
		if (rset != null) try { rset.close(); } catch(SQLException ex) {}
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
</html>