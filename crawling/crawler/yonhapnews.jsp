<%@ page language="java" contentType="application/json; charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@ page info="copyright by Chi Woo Park, email:qkrcldn12@gmail.com"%>
<%@ page import = "org.jsoup.Jsoup, 
				   org.w3c.dom.*,
				   org.jsoup.nodes.Document, 
				   org.jsoup.select.Elements, 
				   org.jsoup.nodes.Element,
				   org.json.*" %>
<%
	//**************************************************** NOTICE ***************************************************
	// 이 페이지는 Crawler bot 페이지 입니다.
	// Oracle 최적화모드 이므로.. 다른 DB를 쓰신다면 insertdb.jsp 페이지를 고쳐주세요
	// 언론사 변수는 모두 소문자로 통일해주세요.
	// 페이지 자체가 뉴스기사 크롤링 결과를 json DOM 구조입니다.
	// 중개서버 status.jsp 에서 json 결과를 파싱해갑니다.
	// title      >> 기사 제목
	// aTag       >> 기사 링크 (a태그)
	// updateDate >> 기사 등록 날짜
	//***************************************************************************************************************
	
	
	//*************************************************   page info  ************************************************
	// 오마이뉴스 크롤링 봇 (yonhapnews Crawler)
	// 오마이뉴스 메인 기사를 크롤링 해옵니다
	// Jsoup 라이브러리를 사용, 웹 페이지를 DOM 구조로 크롤링
	// 태그별로 속성, value 추출 가능
	// 언론사 이름은 소문자로 지정해주세요
	   int maximumPage = 20; //크롤링해올 총 페이지 개수
	   String newsName = "yonhapnews"; // 언론사 이름 소문자로 해주세요!!
	//***************************************************************************************************************
	
	String flag = request.getParameter("status");
	//json 변수
	JSONArray array = new JSONArray();
	String jsonArticle = "";
	for(int i = 1; i <= maximumPage; i++){
		//사이트 url
        String URL = "http://www.yonhapnewstv.co.kr/browse/page/"+i;
		//기사 관련 변수
        String title = "";
        String aTag = "";
        String updateDate = "";
		
        //돔구조 파싱
        Document doc = Jsoup.connect(URL).get();
		
        //태그를 기준으로 각 엘리먼트에 접근 
		//<!--HEAD---------------------------------------------------이곳 수정하세요-----------------------------
        // for ex) <div class=hi> => doc.select("div.hi")
        Elements elem = doc.select("div.data");
	              
        //엘리먼트 갯수만큼 반복문을 돔 => 돌때마다 커서가 1씩 증가함
		//<!--BODY 크롤러 추가시 태그만 잘 찾아서 [제목 : title, href링크 : aTag, 작성일, updateDate 에 써주세요]--
        for(Element e: elem){
			//<!--제목 수정부
        	title = e.select("h2.title").select("[href]").text().replaceAll("\"", ""); 				//기사 제목 a태그가 두개여서 난잡하게 처리
			//<!--기사 A태그 수정부
        	if(e.select("h2.title").select("[href]").attr("href").startsWith("http")){	//링크 절대경로가있고 상대경로가 있음..
        		aTag = e.select("h2.title").select("[href]").attr("href").replaceAll("\"", "");
        	}else{
        		aTag = "http://www.yonhapnewstv.co.kr" + e.select("h2.title").select("[href]").attr("href").replaceAll("\"", "");
        	}
        	//<!--작성일 수정부
        	updateDate = e.select("span.time").text();
        	JSONObject item = new JSONObject();
        	item.put("title", title);
        	item.put("aTag", aTag);
        	item.put("updateDate", updateDate);
        	array.put(item);
        	//out.println("기사제목 : " + title + "<br>");
        	//out.println("링크 : " + aTag + "<br>");
        	//out.println("작성일 : "+ updateDate +"<br><br>");
        }
		//--BODY -------------------------------------------------------------------------------->
		//--HEAD------------------------------------------------------------------------------------------>
	}
	jsonArticle = array.toString();
%>
<%=jsonArticle%>
