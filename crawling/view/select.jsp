<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,org.json.*" %>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8" />
<script src="/crawling/js/jquery-3.3.1.min.js"></script>
<title>article view</title>
</head>
<body>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rset = null;
String sql = "";

JSONArray array = new JSONArray();
JSONObject json = new JSONObject();
String jsonArticle = "";

String curpage = request.getParameter("curpage");
int curpageNum = 1;
if (curpage != null){
	curpageNum = Integer.parseInt(curpage);
}

try{
	//DBMS연결
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.23.99:1521:QKRCLDNQKR","CHIWOO","CHIWOO");
	stmt = conn.createStatement();
	
	sql = "SELECT COUNT(DOMAIN) FROM CRAWLING_NEWS";
	rset = stmt.executeQuery(sql);
	//<!----- 페 이 징 변 수 ----------------------------------
	int bottomStart = 1;
	int bottomEnd = 10;
	int bottomMaxpage = 1;
	int nextPage = 11;
	int backPage = 1;
	
	if(curpageNum % 10 == 0){
		if(curpageNum == 10){
			bottomStart = curpageNum / 10;
		}else{
			bottomStart = (((curpageNum / 10) - 1) * 10) + 1;
		}
		nextPage = curpageNum + 1;
	}else{
		bottomStart = (curpageNum / 10) * 10 + 1;
		nextPage = (((curpageNum / 10) + 1) * 10) + 1;
	}
	int pageShow = 10;
	int totalRecod = 0;
	int totalPage = 0;	
	
	while(rset.next()){
	totalRecod = rset.getInt(1);	
	};
	if (totalRecod % 10 == 0){
		totalPage = totalRecod / pageShow;
	}else {
		totalPage = (totalRecod / pageShow) + 1;
	}
	//------------------------------------------------------> 

	if(curpageNum == 1){
	sql = "SELECT * FROM("+
			"SELECT ROW_NUMBER() OVER(ORDER BY UPDATEDATE DESC) zNUM, "+
				 "DOMAIN, "+
				 "TITLE, "+
				 "ATAG, "+
				 "TO_char(UPDATEDATE,'yyyy-mm-dd') AS UPDATE_DATE "+
			"FROM CRAWLING_NEWS A "+
			")X WHERE X.zNUM BETWEEN 1 and 10";
	}else{
		int strt = (curpageNum * pageShow) - pageShow + 1;
		int endt = curpageNum * pageShow;
		sql = "SELECT * FROM("+
				"SELECT ROW_NUMBER() OVER(ORDER BY UPDATEDATE DESC) zNUM, "+
					 "DOMAIN, "+
					 "TITLE, "+
					 "ATAG, "+
					 "TO_char(UPDATEDATE,'yyyy-mm-dd') AS UPDATE_DATE "+
				"FROM CRAWLING_NEWS A "+
				")X WHERE X.zNUM BETWEEN "+strt+" and "+endt;
	}
	rset = stmt.executeQuery(sql);
	
	out.println("<table>");
	out.println("<tr><td>언론사</td><td>제목</td><td>작성일</td></tr>");
	while(rset.next()){
		out.println("<tr>");
		out.println("<td>");		
		out.println(rset.getString(2));
		out.println("</td>");
		out.println("<td>");
		out.println("<a href='"+rset.getString(4)+"'>"+rset.getString(3)+"</a>");
		out.println("</td>");
		out.println("<td>");		
		out.println(rset.getString(5));
		out.println("</td>");
		out.println("</tr>");
	}
	out.println("<table>");
	if(bottomStart >10){
		out.println("<button type=button id=pg"+Integer.toString(bottomStart - 1)+
					" value="+Integer.toString(bottomStart - 1)+" onclick='callAlert(this);'>"+
					"뒤로</button>");
	}
	int i = 0;
	int j = 1;
	for(i = bottomStart; i < bottomStart + 10; i++){
		out.println("<input type=button id=pg"+Integer.toString(i)+
					" value="+Integer.toString(i)+" onclick='callAlert(this);'/>");
		if(i == totalPage){
			break;
		}
	}
	if (i < totalPage){
		out.println("<button type=button id=pg"+(Integer.toString(i + 1))+
					" value="+Integer.toString(i + 1)+" onclick='callAlert(this);'>"+
					"앞으로</button>");		
	}
	
	
	
	rset.close();
	stmt.close();
	conn.close();
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
</body>
</html>