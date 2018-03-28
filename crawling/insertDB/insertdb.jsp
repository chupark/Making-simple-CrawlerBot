<%@ page session="true" import="java.util.*" %>
<%@ page contentType="application/json; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import = "org.json.*" %>
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
String json_news = request.getParameter("jsonString");
if (unronsa == null){
	return;
}
if (json_news == null){
	return;
}
String title = "";
String aTag = "";
String updateDate = "";
String sql = "";
String ermsg = "";

int rownumber = 0;

JSONArray arr = new JSONArray(json_news);

try{
	//DBMS¿¬°á
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.23.99:1521:QKRCLDNQKR","CHIWOO","CHIWOO");
	stmt = conn.createStatement();
	sql = "SELECT NVL(MAX(NUM),1) FROM CRAWLING_NEWS";
	rset = stmt.executeQuery(sql);
	while(rset.next()){
		rownumber = rset.getInt(1);
	}
	
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
						"INSERT (CN.NUM, CN.DOMAIN, CN.TITLE, CN.ATAG, CN.UPDATEDATE) "+
						"VALUES ("+rownumber+", '"+unronsa+"', '"+title+"', '"+aTag+"', TO_DATE('"+updateDate+"', 'YYYY-MM-DD HH24:MI'))";
			stmt.execute(sql);
			rownumber++;
		}
		
	ermsg="{\"status\":\"success\"}";
	rset.close();
	stmt.close();
	conn.close();
	} catch(SQLException ex) {
		ermsg = "{\"status\":\""+ex+"\"'}";
	} catch(Exception e){
		ermsg = "{\"status\":\""+e+"\"}";
	}finally {
		if (rset != null) try { rset.close(); } catch(SQLException ex) {}
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
<%=ermsg%>