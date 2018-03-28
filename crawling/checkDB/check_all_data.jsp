<%@ page contentType="application/json; charset=utf-8" %>
<%@ page session="true" import="java.util.*" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page info="copyright by Chi Woo Park, email:qkrcldn12@gmail.com"%>
<%request.setCharacterEncoding("UTF-8");%>

<%!
//Oracle DB »ðÀÔ¿ë String Converter
public String strConverterForDB(String inputString){
	inputString = inputString.replaceAll(";","&#59").
							  replaceAll("'","&#39").
							  replaceAll("\\\\","");
				 
	return inputString;
}
%>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rset = null;
String unronsa = request.getParameter("company");

String title = "";
String aTag = "";
String updateDate = "";
String sql = "";
String ermsg = "";

int total_recod = 0;

try{
	//DBMS¿¬°á
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost/CRAWLING_NEWS?useSSL=false","root","honor4me1241q@");
	stmt = conn.createStatement();
	sql = "SELECT COUNT(*) FROM CRAWLING_NEWS WHERE DOMAIN='"+unronsa+"'";
	rset = stmt.executeQuery(sql);
	while(rset.next()){
		total_recod = rset.getInt(1);
	}
	
	
	ermsg="{\"success\":\""+total_recod+"\"}";
	rset.close();
	stmt.close();
	conn.close();
	} catch(SQLException ex) {
		ermsg = "{\"fail\":\""+ex+"\"'}";
	} catch(Exception e){
		ermsg = "{\"fail\":\""+e+"\"}";
	}finally {
		if (rset != null) try { rset.close(); } catch(SQLException ex) {}
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
<%=ermsg%>