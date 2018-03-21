<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,org.json.*" %>
<%@ page info="copyright by Chi Woo Park, email:qkrcldn12@gmail.com"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8" />
<script src="/crawling/js/jquery-3.3.1.min.js"></script>
<title>article view</title>
<style>
a {
	color: blue; text-decoration: none;
}	
a:hover{
	color: red; text-decoration: underline;
}	
td.board{
	border-top:1px solid black;
}
td.board_bott{
	border-top:1px solid black;
	border-bottom:1px solid black;
}
tr.grey{
	background-color:#e5e179;
}
tr.light_grey{
	background-color:#eaeaea;
}
tr.heavy_grey{
	background-color:#dbdbdb;
}
</style>
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
String search_Option = request.getParameter("search_Option");
if(search_Option == null){
	search_Option = "모두선택";
}

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
	//<!--------------------------- 페 이 징 변 수 ----------------------------------
	int bottomStart = 1;
	int bottomEnd = 10;
	int bottomMaxpage = 1;
	int nextPage = 11;
	int backPage = 1;
	int pageShow = 10;
	int totalRecod = 0;
	int totalPage = 0;	
	int i = 0;
	int j = 1;
	
	//바닥 페이지 네비게이션 설정
	if(curpageNum % bottomEnd == 0){
		if(curpageNum == bottomEnd){
			bottomStart = curpageNum / bottomEnd;
		}else{
			bottomStart = (((curpageNum / bottomEnd) - 1) * bottomEnd) + 1;
		}
		nextPage = curpageNum + 1;
	}else{
		bottomStart = (curpageNum / bottomEnd) * bottomEnd + 1;
		nextPage = (((curpageNum / bottomEnd) + 1) * bottomEnd) + 1;
	}
	
	
	while(rset.next()){
	totalRecod = rset.getInt(1);	
	};
	//총 페이지 계산
	if (totalRecod % pageShow == 0){
		totalPage = totalRecod / pageShow;
	}else {
		totalPage = (totalRecod / pageShow) + 1;
	}
	//--------------------------------------------------------------------------> 

	sql = "SELECT DOMAIN FROM CRAWLING_NEWS GROUP BY DOMAIN";
	rset = stmt.executeQuery(sql);
	out.println("<table><tr><td>");
	out.println("<select name='domain' id='domain' style='height:25;padding:0px'>");
	out.println("<option value='모두선택'>모두선택</option>");
	out.println(search_Option);
	while(rset.next()){
		//도메인 필터
		if(search_Option.equals(rset.getString(1))){
			out.println("<option value='"+rset.getString(1)+"' selected"+
							">"+rset.getString(1)+"</option>");
		}else{
			out.println("<option value='"+rset.getString(1)+"'>"+rset.getString(1)+"</option>");
		}
	}
	out.println("</select>");
	out.println("</td><td>");
	out.println("<input type='button' id='selectDomain' name='selectDomain'"+
					" onclick='domainFilter()' value='필터'>");
	out.println("</td></tr></table>");
	//<!------------------------------- 레코드 출력 sql ------------------------------
	if(search_Option.equals("모두선택")){
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
	}else{
		if(curpageNum == 1){
		sql = "SELECT * FROM("+
				"SELECT ROW_NUMBER() OVER(ORDER BY UPDATEDATE DESC) zNUM, "+
					 "DOMAIN, "+
					 "TITLE, "+
					 "ATAG, "+
					 "TO_char(UPDATEDATE,'yyyy-mm-dd') AS UPDATE_DATE "+
				"FROM CRAWLING_NEWS A"+
				" WHERE DOMAIN='"+search_Option+"'"+
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
					"WHERE DOMAIN='"+search_Option+"'"+
					")X WHERE X.zNUM BETWEEN "+strt+" and "+endt;
		}		
	}
	rset = stmt.executeQuery(sql);
	//<!-------------------------------내용 출력----------------------------------
	//헤더
	out.println("<table width=850 border=0 cellspacing=0>");
	out.println("<tr class=grey><td class=board height=30 style='border-right:1px solid black;'>언론사</td>"+
				"<td class=board style='border-right:1px solid black;'>제목</td>"+
				"<td class=board >작성일</td></tr>");
	//내용
	int evenNum = 0;
	while(rset.next()){
		if (evenNum % 2 == 0){
			out.println("<tr class=light_grey>");
		}else{
			out.println("<tr class=heavy_grey>");
		}
		out.println("<td class=board height=30 width='18%' style='border-right:1px solid black;'>");
		out.println(rset.getString(2));
		out.println("</td>");
		out.println("<td class=board width='70%' style='border-right:1px solid black;'>");
		out.println("<a href='"+rset.getString(4)+"' target='_blank'>"+rset.getString(3)+"</a>");
		out.println("</td>");
		out.println("<td class=board width='12%' >");
		out.println(rset.getString(5));
		out.println("</td>");
		out.println("</tr>");
		evenNum++;
	}
	out.println("</table>");
	
	//----------------------------------------------------------------->
	
	//<!--------------------- 페이지 네비게이션 출력-----------------------------------------------------
	out.println("<table width=850 border=0 cellspacing=0>");
	out.println("<tr><td class=board align=center>");
	if(bottomStart >10){
		out.println("<button type=button style='width:80;height:25;background-color:white;border:0;cursor:pointer' "+
					"id=pg"+Integer.toString(bottomStart - 1)+
					" value="+Integer.toString(bottomStart - 1)+" onclick='movePage(this);'>"+
					"뒤로</button>&nbsp;");
	}
	
	for(i = bottomStart; i < bottomStart + 10; i++){
		if(i == curpageNum){
			out.println("<input type=button style='width:35;height:25;background-color:white;border:0;"+
						"cursor:pointer;font-weight:bold;color:red' "+
						"id=pg"+Integer.toString(i)+
						" value="+Integer.toString(i)+" onclick='movePage(this);'/>");
		}else{
			out.println("<input type=button style='width:35;height:25;background-color:white;border:0;cursor:pointer' "+
						"id=pg"+Integer.toString(i)+
						" value="+Integer.toString(i)+" onclick='movePage(this);'/>");			
		}
		if(i == totalPage){
			break;
		}
	}
	
	if (i < totalPage){
		out.println("<button type=button style='width:80;height:25;background-color:white;border:0;cursor:pointer' "+
					"id=pg"+(Integer.toString(i))+
					" value="+Integer.toString(i)+" onclick='movePage(this);'>"+
					"앞으로</button>");		
	}
	out.println("</td></tr>");
	out.println("</table>");
	//------------------------------------------------------------------------------------------>
	
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