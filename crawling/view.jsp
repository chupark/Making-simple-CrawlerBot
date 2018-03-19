<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
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

function callAlert(buttonID){
	var obj = buttonID;
	var btnValue = obj.value;
	$.ajax({
		type: "POST",
		url: "/crawling/view/select.jsp",
		dataType: "text",
		data: {
			curpage: btnValue,
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