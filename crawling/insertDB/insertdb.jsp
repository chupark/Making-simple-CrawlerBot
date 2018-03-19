<%@ page session="true" import="java.util.*" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import = "org.json.*" %>
<%request.setCharacterEncoding("UTF-8");%>

<%!
//Oracle DB »ðÀÔ¿ë String Converter
public String strConverterForDB(String inputString){
	inputString = inputString.replaceAll("\\.","").
							replaceAll(";","&#59").
							replaceAll("'","&#39").
							replaceAll("\\\\","");
				 
	return inputString;
}
%>
<%
Connection conn = null;
Statement stmt = null;
String aa = request.getParameter("status");
String unronsa = request.getParameter("company");
String json_news = request.getParameter("jsonString");

String title = "";
String aTag = "";
String updateDate = "";
String sql = "";

JSONArray arr = new JSONArray(json_news);
JSONObject jsonObject = new JSONObject();
	

try{
	//DBMS¿¬°á
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.23.99:1521:QKRCLDNQKR","CHIWOO","CHIWOO");
	stmt = conn.createStatement();
	
		for(int i = 0; i < arr.length(); i++){
			title = strConverterForDB(arr.getJSONObject(i).getString("title"));
			aTag = strConverterForDB(arr.getJSONObject(i).getString("aTag"));
			updateDate = strConverterForDB(arr.getJSONObject(i).getString("updateDate"));
			sql = "MERGE "+
					"INTO CRAWLING_NEWS CN "+
						"USING DUAL "+
						"ON (CN.ATAG = '"+aTag+"') "+
					"WHEN MATCHED THEN "+
					    "UPDATE SET CN.TITLE = '"+title+"', CN.UPDATEDATE = TO_DATE('"+updateDate+"', 'YYYY-MM-DD HH24:MI') "+
					    "WHERE CN.ATAG = '"+aTag+"' "+
					"WHEN NOT MATCHED THEN "+
						"INSERT (CN.DOMAIN, CN.TITLE, CN.ATAG, CN.UPDATEDATE) "+
						"VALUES ('"+unronsa+"', '"+title+"', '"+aTag+"', TO_DATE('"+updateDate+"', 'YYYY-MM-DD HH24:MI'))";
			stmt.execute(sql);
		}
	out.println("success");
	stmt.close();
	conn.close();
	} catch(SQLException ex) {
		out.println(ex);
	} catch(Exception e){
		out.println(e);
	}finally {
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>