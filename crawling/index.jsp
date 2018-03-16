<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "org.jsoup.Jsoup, 
				   org.w3c.dom.*,
				   org.jsoup.nodes.Document, 
				   org.jsoup.select.Elements, 
				   org.jsoup.nodes.Element,
				   org.json.JSONObject,
				   org.json.JSONArray" 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/crawling/js/jquery-3.3.1.min.js"></script>
<script>
function ohMyNewStatus(loading_Status){
	document.getElementById("ohMyNews").innerHTML = loading_Status;
}
</script>
<title>Oh my news</title>
</head>
<body>
<table border=1 width=400>
	<tr>
		<td width="50%">언론사</td><td>Loading status</td>
	</tr>
	<tr>
		<td width="50%">오마이뉴스</td><td id="ohMyNews">Loading...</td>
	</tr>
</table>
<script>
ohMyNewStatus("Loading...");
</script>
<!-- 오마이뉴스 크롤링 -->
<%
	//json 변수
	JSONArray array = new JSONArray();
	JSONObject json = new JSONObject();
	String jsonArticle = "";
	for(int i = 1; i <= 20; i++){
		//사이트 url
        String URL = "http://www.ohmynews.com/NWS_Web/ArticlePage/Total_Article.aspx?PAGE_CD=N0120&pageno="+i;
		//기사 관련 변수
        String title = "";
        String aTag = "";
        String updateDate = "";
        //돔구조 파싱
        Document doc = Jsoup.connect(URL).get();
        
        //태그를 기준으로 각 엘리먼트에 접근
        //<div class=hi> => doc.select("div.hi")
        Elements elem = doc.select("div.news_list")
        				   .select("div.cont");
	              
        //엘리먼트 갯수만큼 반복문을 돔 => 돌때마다 커서가 1씩 증가함
        for(Element e: elem){
        	title = e.select("dt").select("[href]").text(); 				//기사 제목 a태그가 두개여서 난잡하게 처리
        	if(e.select("dt").select("[href]").attr("href").startsWith("http")){	//링크 절대경로가있고 상대경로가 있음..
        		aTag = e.select("dt").select("[href]").attr("href");
        	}else{
        		aTag = "http://www.ohmynews.com" + e.select("dt").select("[href]").attr("href");
        	}
        	//작성일
        	updateDate = "20"+e.select("p.source").text()
    					  	   .substring(e.select("p.source").text().lastIndexOf("l") + 1);
        	JSONObject item = new JSONObject();
        	item.put("title", title);
        	item.put("aTag", aTag);
        	item.put("updateDate", updateDate);
        	array.put(item);
        	//out.println("기사제목 : " + title + "<br>");
        	//out.println("링크 : " + aTag + "<br>");
        	//out.println("작성일 : "+ updateDate +"<br><br>");
        }
	}
	json.put("ohMyNews", array);
	jsonArticle = json.toString();
	out.println("제이슨 아티클 : " + jsonArticle);
%>
<script>
$(document).ready(function(){
	sendAjax();
});

var url = "http://localhost:8080/crawling/insertDB/"
function sendAjax(){
	$.ajax({
		type: "POST",
		url: url + ohmynewsInsert.jsp,
		data : <%=jsonArticle%>
		contentType : "application/json",
		cache: false,
		success : function(){
			alert("성공");
		},
		error : function(){
			alert("에러");
		}
	})
	
}
</script>
</body>
</html>












