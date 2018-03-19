<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8" />
<script src="/crawling/js/jquery-3.3.1.min.js"></script>
<title>Crawling Status</title>
</head>
<body>
<!--언론사 추가시 테이블 tr 추가해주세요-->
<table border=1 width=600>
	<tr>
		<td width="30%">언론사</td><td width="70%">크롤링 상태</td>
	</tr>
	<tr>
		<td>ohmynews</td><td id ="ohmynews">진행중...</td>
	</tr>
	<tr>
		<td>yonhapnews</td><td id ="yonhapnews">진행중...</td>
	</tr>	
</table>
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
	var url = unron_company + ".jsp";
	$.ajax({
		type: "POST",
		url: "/crawling/crawler/"+url,
		data : {
			status : "success",
		},
		cache : false,
		dataType : "json",
		timeout: 30000, 
		success : function(resdata){
			var html = "";
			document.getElementById(unron_company).innerHTML = "크롤링 성공";
			
			//db insert
			sendTo_insertDB(resdata, unron_company);
		},
		error : function(){
			document.getElementById(unron_company).innerHTML = "크롤링 실패";
		}
	})
}



function sendTo_insertDB(newsdata, unronsa){
	var url = "/crawling/insertDB/insertdb.jsp";
	document.getElementById(unronsa).innerHTML = "DB 대조중";
	$.ajax({
		type: "POST",
		url: url,
		data : {
			status : "success",
			company : unronsa,
			jsonString : JSON.stringify(newsdata),
		},
		dataType : "text",
		timeout : 30000,
		success : function(restext){
			if(restext.replace(/\r\n/gi,"").replace(/ /gi,"" == "success")){
				document.getElementById(unronsa).innerHTML = "모든 진행상황이 성공적으로 끝났습니다.";	
			}else{
				//입력서버로 갔지만 sql 에러가 나면 오류 출력
				document.getElementById(unronsa).innerHTML = restext;	
			}
		},
		error: function(){
			//입력서버로 도달하지 못했을시
			document.getElementById(unronsa).innerHTML = "입력서버 전송 에러, json 형태,서버주소를 확인 해주세요";
		}
	})
}
</script>
</body>
</html>