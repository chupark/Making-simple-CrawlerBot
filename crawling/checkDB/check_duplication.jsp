<%@ page contentType="application/json; charset=utf-8" %>
<%@ page session="true" import="java.util.*" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import = "org.json.*" %>
<%@ page info="copyright by Chi Woo Park, email:qkrcldn12@gmail.com"%>
<%request.setCharacterEncoding("UTF-8");%>

<%!
//Oracle DB 삽입용 String Converter
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
String json_news = request.getParameter("jsonString");

String title = "";
String aTag = "";
String updateDate = "";
String sql = "";
String ermsg = "";

int duplication_count = 0;
int linecnt = 0;

JSONArray arr = new JSONArray(json_news);

try{
	//DBMS연결
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost/CRAWLING_NEWS?useSSL=false","root","honor4me1241q@");
	stmt = conn.createStatement();
	sql = "SELECT ATAG FROM CRAWLING_NEWS WHERE DOMAIN='"+unronsa+"'";
	rset = stmt.executeQuery(sql);
	while(rset.next()){
		for(int i = 0; i < arr.length(); i++){
			aTag = strConverterForDB(arr.getJSONObject(i).getString("aTag"));
			if(rset.getString(1).equals(aTag)){
				duplication_count++;
			}
			linecnt++;
		}
	}
	
	ermsg="{\"success\":\""+duplication_count+"\"}";
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