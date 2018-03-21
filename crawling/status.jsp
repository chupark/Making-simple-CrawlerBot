<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page info="copyright by Chi Woo Park, email:qkrcldn12@gmail.com"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8" />
<script src="/crawling/js/jquery-3.3.1.min.js"></script>
<title>Crawling Status</title>
</head>
<body>
<!--언론사 추가시 테이블 tr 추가해주세요-->
<h2>크롤링 중계서버</h2>
<table border=1 width=600>
	<tr>
		<td width="30%">언론사</td><td width="70%">상태</td>
	</tr>
	<tr>
		<td>ohmynews</td><td id ="ohmynews">...</td>
	</tr>
	<tr>
		<td>yonhapnews</td><td id ="yonhapnews">...</td>
	</tr>	
</table>
<br/>
<%=getServletInfo()%>
<script>
//<!-------------------------- 크롤러 추가 부분----------------------
//언론사 크롤러 추가시 getArticle_Ajax(<언론사이름>); 이렇게 한개만 추가해주세요
//언론사 이름은 소문자만 사용해주세요
//크롤러는 /crawling/crawler 디렉토리에 넣어주세요
$(function(){
	getArticle_Ajax("ohmynews");
	getArticle_Ajax("yonhapnews");
}); 
//------------------------------------------------------------->

//이 아래는 수정 하지 마세요
function getArticle_Ajax(unron_company){
	document.getElementById(unron_company).innerHTML = "기사 수집중";
	var url = unron_company + ".jsp";
	$.ajax({
		type: "POST",
		url: "/crawling/crawler/"+url,
		cache : false,
		dataType : "json",
		timeout: 30000, 
		success : function(resdata){
			document.getElementById(unron_company).innerHTML = "수집 성공";
			
			//db insert
			sendTo_insertDB(resdata, unron_company);
		},
		error : function(){
			document.getElementById(unron_company).innerHTML = "수집 실패, 문자 형태, 주소를 확인해주세요";
		}
	})
}

//<!------------------------ 기사 삽입
function sendTo_insertDB(newsdata, unronsa){
	var url = "/crawling/insertDB/insertdb.jsp";
	document.getElementById(unronsa).innerHTML = "DB 대조중";
	$.ajax({
		type: "POST",
		url: url,
		data : {
			company : unronsa,
			jsonString : JSON.stringify(newsdata),
		},
		dataType : "json",
		timeout : 30000,
		success : function(restext){
			var result_status = "";
			$.each(restext, function(entryIndex, entry){
				result_status = entry; //성공시 파싱할 문자
			});
			if(result_status == "success"){ //성공시 success 문자 파싱
				document.getElementById(unronsa).innerHTML = "모든 과정이 성공적으로 끝났습니다.";
			}else{
				//insert 페이지로 갔지만 sql 오류일시 오류메세지 출력
				document.getElementById(unronsa).innerHTML = result_status;
			}
		},
		error: function(){
			//입력서버로 도달하지 못했을시
			document.getElementById(unronsa).innerHTML = "입력서버 전송 에러, json 형태, 서버주소를 확인 해주세요";
		}
	})
}
</script>
</body>
</html>