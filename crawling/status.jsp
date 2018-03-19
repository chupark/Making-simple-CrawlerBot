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
<table border=1 width=800>
	<tr>
		<td width="50%">언론사</td><td width="50%">크롤링 상태</td>
	</tr>
	<tr>
		<td width="50%">ohmynews</td><td id ="ohmynews" width="50%">진행중...</td>
	</tr>
	<tr>
		<td width="50%">yonhapnews</td><td id ="yonhapnews" width="50%">진행중...</td>
	</tr>	
</table>
<script>
//언론사 크롤러 추가시 getArticle_Ajax(<언론사이름>); 이렇게 한개만 추가해주세요
//언론사 이름은 소문자만 사용해주세요
//크롤러는 /crawling/crawler 디렉토리에 넣어주세요

$(function(){
	getArticle_Ajax("ohmynews");
	getArticle_Ajax("yonhapnews");
});


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
			sendTo_insertDB(resdata, unron_company);
			//$("#test").val(html);
		},
		error : function(){
			document.getElementById(unron_company).innerHTML = "크롤링 실패";
		}
	})
}

function sendTo_insertDB(newsdata, unronsa){
	var url = "insertdb.jsp";
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
			}
		},
		error: function(){
			document.getElementById(unronsa).innerHTML = "insert server error";
		}
	})
	
}


</script>
</body>
</html>