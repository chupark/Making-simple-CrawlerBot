<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page info="copyright by Chi Woo Park, email:qkrcldn12@gmail.com"%>
<html>
<head>
</head>
<script src="/crawling/js/jquery-3.3.1.min.js"></script>
<script>
$( document ).ready(function() {
	$.ajax({
			type: "POST",
			url: "/crawling/view/select.jsp",
			dataType: "text",
			cache: false,
			timeout : 20000,
			success: function(resdata){
				$('.article').html(resdata);
			},
			error: function(resdata){
				alert(resdata);
			}
		})
})

function movePage(buttonID){
	var obj = buttonID;
	var btnValue = obj.value;
	var obj2 = document.getElementById("domain");
	var domainAddress = obj2.value;
	$.ajax({
		type: "POST",
		url: "/crawling/view/select.jsp",
		dataType: "text",
		data: {
			curpage: btnValue,
			search_Option: domainAddress,
		},
		cache: false,
		timeout : 20000,
		success: function(resdata){
			$('.article').html(resdata);
		},
		error: function(resdata){
			alert(resdata);
		}
	})
}

function domainFilter(){
	var obj = document.getElementById("domain");
	var domainAddress = obj.value;
	$.ajax({
		type: "POST",
		url: "/crawling/view/select.jsp",
		dataType: "text",
		data: {
			search_Option: domainAddress,
		},
		cache: false,
		timeout : 20000,
		success: function(resdata){
			$('.article').html(resdata);
		},
		error: function(resdata){
			alert(resdata);
		}		
	})
}
</script>
<body>
<div class="article">
</div>
</body>
</html>