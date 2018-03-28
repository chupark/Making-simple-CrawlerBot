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
span p {
  overflow: hidden; 
  text-overflow: ellipsis;
  white-space: nowrap; 
  width: 480px;
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
String filter_Option = request.getParameter("filter_Option");
String search_Option = request.getParameter("search_Option");
if(filter_Option == null){
	filter_Option = "";
}else if(filter_Option.equals("모두선택")){
	filter_Option = "";
}else{
	filter_Option = filter_Option.toLowerCase();
}

if(search_Option == null){
	search_Option = "";
}else{
	search_Option = search_Option.toLowerCase();
}

int curpageNum = 1;
if (curpage != null){
	curpageNum = Integer.parseInt(curpage);
}


try{
	//DBMS연결
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost/CRAWLING_NEWS?useSSL=false","root","honor4me1241q@");
	stmt = conn.createStatement();
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

	if(search_Option != null && filter_Option.equals("")){
		sql = "SELECT COUNT(*) FROM CRAWLING_NEWS"+
				" WHERE LOWER(TITLE) LIKE '%"+search_Option+"%'";
	}else if(search_Option != null && filter_Option != null){
		sql = "SELECT COUNT(DOMAIN) FROM CRAWLING_NEWS"+
				" WHERE DOMAIN='"+filter_Option+"' AND TITLE LIKE '%"+search_Option+"%'";	
	}else{
		sql = "SELECT COUNT(DOMAIN) FROM CRAWLING_NEWS";
	}
	rset = stmt.executeQuery(sql);	
	
	while(rset.next()){
		totalRecod = rset.getInt(1);	
	}
	
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
	while(rset.next()){
		//도메인 필터
		if(filter_Option.equals(rset.getString(1))){
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
	out.println("</td>");
	out.println("<td>");
	out.println("<input type='text' id='search' name='search' value='"+search_Option+"' "+
					"style='height:25;width:300' autocomplete='off'/>");
	out.println("</td>");
	out.println("<td>");
	out.println("<input type='button' id='do_search' name='selectDomain'"+
				" onclick='domainFilter()' value='검색'>");
	out.println("</td>");
	out.println("<form>");
	out.println("</tr>");
	out.println("</table>");
	
	//<!------------------------------- 레코드 출력 sql ------------------------------
	if(filter_Option.equals("")){
		if(curpageNum == 1){
			sql = "SELECT DOMAIN, ATAG, TITLE, UPDATEDATE "+
							"FROM CRAWLING_NEWS "+
							"WHERE LOWER(TITLE) LIKE '%"+search_Option+"%'"+
							"ORDER BY UPDATEDATE DESC, NUM "+
							"LIMIT 0, 10";
		}else{			
			sql = "SELECT DOMAIN, ATAG, TITLE, UPDATEDATE "+
							"FROM CRAWLING_NEWS "+
							"WHERE LOWER(TITLE) LIKE '%"+search_Option+"%'"+
							"ORDER BY UPDATEDATE DESC, NUM "+
							"LIMIT "+((curpageNum - 1) * pageShow)+", 10";
		}
	}else if(search_Option.equals("") && !filter_Option.equals("")){
		if(curpageNum == 1){
			sql = "SELECT DOMAIN, ATAG, TITLE, UPDATEDATE "+
							"FROM CRAWLING_NEWS "+
							"WHERE DOMAIN = '"+filter_Option+"' "+
							"ORDER BY UPDATEDATE DESC, NUM "+
							"LIMIT 0, 10";
		}else{
			int strt = (curpageNum * pageShow) - pageShow + 1;
			int endt = curpageNum * pageShow;
			sql = "SELECT DOMAIN, ATAG, TITLE, UPDATEDATE "+
							"FROM CRAWLING_NEWS "+
							"WHERE DOMAIN = '"+filter_Option+"' "+
							"ORDER BY UPDATEDATE DESC, NUM "+
							"LIMIT "+((curpageNum - 1) * pageShow)+", 10";
		}

	}else{
		if(curpageNum == 1){
			sql = "SELECT DOMAIN, ATAG, TITLE, UPDATEDATE "+
							"FROM CRAWLING_NEWS "+
							"WHERE DOMAIN = '"+filter_Option+"' AND LOWER(TITLE) LIKE '%"+search_Option+"%'"+
							"ORDER BY UPDATEDATE DESC, NUM "+
							"LIMIT 0, 10";
		}else{
			sql = "SELECT DOMAIN, ATAG, TITLE, UPDATEDATE "+
							"FROM CRAWLING_NEWS "+
							"WHERE DOMAIN = '"+filter_Option+"' AND LOWER(TITLE) LIKE '%"+search_Option+"%'"+
							"ORDER BY UPDATEDATE DESC, NUM "+
							"LIMIT "+((curpageNum - 1) * pageShow)+", 10";
		}
	}
	rset = stmt.executeQuery(sql);
	//<!-------------------------------내용 출력----------------------------------
	//헤더
	out.println("<table width=1000 border=0 cellspacing=0>");
	out.println("<tr class=grey><td class=board height=30 width=20% style='border-right:1px solid black;'>언론사</td>"+
				"<td class=board width=60% style='border-right:1px solid black;'>제목</td>"+
				"<td class=board width=20% >작성일</td></tr>");
	//내용
	int evenNum = 0;
	while(rset.next()){
		if (evenNum % 2 == 0){
			out.println("<tr class=light_grey>");
		}else{
			out.println("<tr class=heavy_grey>");
		}
		out.println("<td class=board height=30 style='border-right:1px solid black;'>");
		out.println(rset.getString(1));
		out.println("</td>");
		out.println("<td class=board style='border-right:1px solid black;'>");
		out.println("<a href='"+rset.getString(2)+"' target='_blank'><span><p>"+rset.getString(3)+"</p></span></a>");
		out.println("</td>");
		out.println("<td class=board >");
		out.println(rset.getString(4).substring(0,16));
		out.println("</td>");
		out.println("</tr>");
		evenNum++;
	}
	if(evenNum == 0){
		out.println("<tr class=light_grey>");
		out.println("<td align=center colspan=3>검색 결과가 없습니다</td>");
		out.println("</tr>");
	}
	out.println("</table>");
	
	//----------------------------------------------------------------->
	
	//<!--------------------- 페이지 네비게이션 출력-----------------------------------------------------
	out.println("<table width=1000 border=0 cellspacing=0>");
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
		if(i >= totalPage){
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