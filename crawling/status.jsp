<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page info="copyright by Chi Woo Park, email:qkrcldn12@gmail.com"%>
<% 
response.setHeader("cache-control","no-cache"); 
response.setHeader("expires","0"); 
response.setHeader("pragma","no-cache"); 
%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8" />
<script src="/crawling/js/jquery-3.3.1.min.js"></script>
<script src="/crawling/bootstrap-3.3.2-dist/js/bootstrap.js"></script>
<link rel="stylesheet" href="/crawling/bootstrap-3.3.2-dist/css/bootstrap.css" />
<style>
div.error_sector{
	bbackground-color:#eaeaea;
}
</style>
<title>Crawling Status</title>
</head>
<body>
<center>
<!--언론사 추가시 테이블 tr 추가해주세요-->
<table width=1600>
	<tr>
		<td width=50%>
			<h2>Crawling Agent Server</h2>
		</td>
		<td width=50% align=right>
			<h2><span id="clock"></span></h2>
		</td>
	</tr>
</table>
<table border=0 style="width:1600">
	<tr>
		<td style="width:1200">
			<table class="table">
				<thead>
					<tr>
						<th>
							Crawling status
						</th>
					</tr>
				</thead>
				<tr>
					<td>
						<table class="table table-bordered" width=100%>
							<thead>
								<tr>
									<th>언론사</th><th colspan=2>상태</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td width="24%">ohmynews</td><td width="68%" id ="ohmynews">...</td><td width="8%" id ="ohmynews_"></td>
								</tr>
								<tr>
									<td>yonhapnews</td><td id ="yonhapnews">...</td><td id ="yonhapnews_"></td>
								</tr>
								<tr>
									<td>donga</td><td id ="donga">...</td><td id ="donga_"></td>
								</tr>
								<tr>
									<td>khan</td><td id ="khan">...</td><td id ="khan_"></td>
								</tr>
								<tr>
									<td>hani</td><td id ="hani">...</td><td id ="hani_"></td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td style="width:400" rowspan=3 valign="top">
			<table class="table">
				<thead>
					<tr>
						<th>
							Server status
						</th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td>
							<table class="table table-bordered" width=100%>
								<tr>
									<td style="height:590">
										<div id="cpu_status"></div>
										<div id="chart_div" style="width: 400px; height: 120px;"></div>
										<div id="mem_status"></div>
										<table>
											<tr>
												<td>
													<span id="chart_div3" style="width: 400px; height: 120px;"></span>
												</td>
												<td>
													<span id="chart_div2" style="width: 400px; height: 120px;"></span>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</td>
	</tr>
	<tr>
		<td style="width:1200">
			<table class="table">
				<thead>
				<tr>
					<th>
						Data status
					</th>
				</tr>
				</thead>
				<tr>
					<td>
						<table class="table table-bordered" width=100%>
							<thead>
								<tr>
									<th width="12.5%">언론사</th><th width="12%">크롤링 전 데이터</th><th width="12%">이번 데이터</th><th width="12%">중복데이터</th><th width="13%">크롤링 후 데이터</th><th width="15%">시작시간</th><th width="15%">종료시간</th><th width="12.5%">걸린시간</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>ohmynews</td><td id="ohmynews_before"></td><td id ="ohmynews_data">0</td><td id ="ohmynews_duplication">0</td><td id="ohmynews_total">0</td><td id="ohmynews_start"></td><td id="ohmynews_end"></td><td id="ohmynews_runtime"></td>
								</tr>
								<tr>
									<td>yonhapnews</td><td id="yonhapnews_before"></td><td id ="yonhapnews_data">0</td><td id ="yonhapnews_duplication">0</td><td id ="yonhapnews_total">0</td><td id="yonhapnews_start"></td><td id="yonhapnews_end"></td><td id="yonhapnews_runtime"></td>
								</tr>
								<tr>
									<td>donga</td><td id="donga_before"></td><td id ="donga_data">0</td><td id ="donga_duplication">0</td><td id ="donga_total">0</td><td id="donga_start"></td><td id="donga_end"></td><td id="donga_runtime"></td>
								</tr>
								<tr>
									<td>khan</td><td id="khan_before"></td><td id ="khan_data">0</td><td id ="khan_duplication">0</td><td id ="khan_total">0</td><td id="khan_start"></td><td id="khan_end"></td><td id="khan_runtime"></td>
								</tr>
								<tr>
									<td>hani</td><td id="hani_before"></td><td id ="hani_data">0</td><td id ="hani_duplication">0</td><td id ="hani_total">0</td><td id="hani_start"></td><td id="hani_end"></td><td id="hani_runtime"></td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td style="width:1200">
			<table class="table">
				<thead>
					<tr>
						<th>
							Error info
						</th>
					</tr>
				</thead>
					<tr>
						<tbody>			
							<td>
								<table class="table table-bordered">
									<tr>
										<td>
											<div class="error_sector">
												<div id="ohmynews_error"></div>
												<div id="ohmynews_error_send"></div>
												<div id="yonhapnews_error"></div>
												<div id="yonhapnews_error_send"></div>
												<div id="donga_error"></div>
												<div id="donga_error_send"></div>
												<div id="khan_error"></div>
												<div id="khan_error_send"></div>	
												<div id="hani_error"></div>
												<div id="hani_error_send"></div>		
											</div>
										</td>
									</tr>
								</table>
							</td>
						<tbody>
					</tr>
			</table>
		</td>
	</tr>
</table>


<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
google.charts.load('current', {'packages':['gauge']});
google.charts.setOnLoadCallback(drawChart);
//<!-------------------------- 크롤러 추가 부분----------------------
//언론사 크롤러 추가시 getArticle_Ajax(<언론사이름>); 이렇게 한개만 추가해주세요
//언론사 이름은 소문자만 사용해주세요
//크롤러는 /crawling/crawler 디렉토리에 넣어주세요
$(function(){
		startTime();
		getArticle_Ajax("ohmynews");
		getArticle_Ajax("yonhapnews");
		getArticle_Ajax("donga");
		getArticle_Ajax("khan");
		getArticle_Ajax("hani");	
		refresh_timer();
});

function refresh_timer() {
	setInterval(function() {
		getArticle_Ajax("ohmynews");
		getArticle_Ajax("yonhapnews");
		getArticle_Ajax("donga");
		getArticle_Ajax("khan");
		getArticle_Ajax("hani");
	}, 1*180*1000);
}
function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
          ['USED', 0],
          ['USER', 0],
		  ['SYSTEM',0],
		  ['IOWAIT',0]
        ]);

		var data3 = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
          ['FREE', 0],
        ]);
		
		var data2 = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
          ['USED', 0],
		  ['BF/CACHE', 0],
        ]);

        var options = {
          width: 400, height: 150,
          redFrom: 90, redTo: 100,
          yellowFrom:75, yellowTo: 90,
          minorTicks: 5
        };
		
		var options3 = {
          width: 140, height: 150,
          redFrom: 0, redTo: 10,
          yellowFrom:10, yellowTo: 25,
          minorTicks: 5
        };
		
        var options2 = {
          width: 280, height: 150,
          redFrom: 90, redTo: 100,
          yellowFrom:75, yellowTo: 90,
          minorTicks: 5
        };
		
		
        var chart = new google.visualization.Gauge(document.getElementById('chart_div'));
		var chart2 = new google.visualization.Gauge(document.getElementById('chart_div2'));
		var chart3 = new google.visualization.Gauge(document.getElementById('chart_div3'));

		chart3.draw(data3, options3);
		chart2.draw(data2, options2);
        chart.draw(data, options);

        setInterval(function() {
		url = "/crawling/serverstatus/status.json";
		var mem_free = 100;
		var mem_used = 0;
		var mem_used_per = 0;
		var cpu_free = 100;
		var cpu_used = 0;
		var cpu_used_per = 0;
			$.ajax({
				type: "POST",
				url: url,
				cache: false,
				dataType: "json",
				success : function(resdata){
					var cpustat ="";
					var memstat = "";
					$.each(resdata, function(entryIndex, entry){
						cpustat += "<table class='table'><thead><tr><th>CPU INFO</th></tr></thead>";
						cpustat += "<tbody>";
						cpustat += "<tr>";
						cpustat += "<table class='table table-bordered'>";
						cpustat += "<tr>";
						cpustat += "<td style='width:20%'>TOTAL</td><td style='width:20%'>USED</td><td style='width:20%'>USER</td><td style='width:20%'>SYSTEM</td><td style='width:20%'>IOWAIT</td>";
						cpustat += "</tr>";
						cpustat += "<tr>";
						cpustat += "<td>"+entry.CPU_FREE+"</td><td>"+entry.CPU_USED+"</td><td>"+entry.CPU_USER+"</td><td>"+entry.CPU_SYSTEM+"</td><td>"+ entry.CPU_IOWAIT+"</td>";
						cpustat += "</tr>";
						cpustat += "</table>";
						cpustat += "<tbody>";
						cpustat += "</table>";
						
						memstat += "<table class='table'><thead><tr><th>MEM INFO</th></tr></thead>";
						memstat += "<tbody>";
						memstat += "<tr>";
						memstat += "<table class='table table-bordered'>";
						memstat += "<tr>";
						memstat += "<td style='width:25%'>TOTAL</td><td style='width:25%'>FREE</td><td style='width:25%'>USED</td><td style='width:25%'>BUFF/CACHE</td>";
						memstat += "</tr>";
						memstat += "<tr>";
						memstat += "<td>"+(entry.MEM_TOTAL / 1024).toFixed(1)+"mb</td><td>"+(entry.MEM_FREE / 1024).toFixed(1)+"mb</td><td>"+(entry.MEM_USED / 1024).toFixed(1)+"mb</td><td>"+ (entry.MEM_BUFFCACHE / 1024).toFixed(1)+"mb</td>";
						memstat += "</tr>";
						memstat += "</table>";
						memstat += "<tbody>";
						memstat += "</table>";						
						
						mem_used = entry.MEM_USED;
						cpu_used = entry.CPU_USED;
						var cpu_user = entry.CPU_USER;
						var cpu_system = entry.CPU_SYSTEM;
						var cpu_iowait = entry.CPU_IOWAIT;
						var mem_shared_per = entry.MEM_SHARED;
						var mem_buffcache_per = entry.MEM_BUFFCACHE;
						var mem_free_per = entry.MEM_FREE;
						
						cpu_used_per = 100 * (cpu_used / 100);
						mem_used_per = 100 * (mem_used / entry.MEM_TOTAL);
						mem_shared_per = 100 * (mem_shared_per / entry.MEM_TOTAL);
						mem_buffcache_per = 100 * (mem_buffcache_per / entry.MEM_TOTAL);
						mem_free_per = 100 * (mem_free_per / entry.MEM_TOTAL);
						
						  data.setValue(0, 1, Math.round(cpu_used_per));
						  data.setValue(1, 1, Math.round(cpu_user));
						  data.setValue(2, 1, Math.round(cpu_system));
						  data.setValue(3, 1, Math.round(cpu_iowait));
						  
						  data3.setValue(0, 1, Math.round(mem_free_per));
						  
						  data2.setValue(0, 1, Math.round(mem_used_per));
						  data2.setValue(1, 1, Math.round(mem_buffcache_per));
						  chart.draw(data, options);
						  chart2.draw(data2, options2);
						  chart3.draw(data3, options3);
					});
					document.getElementById("cpu_status").innerHTML = cpustat;
					document.getElementById("mem_status").innerHTML = memstat;
				},
				error : function(request, status, error){
					
				}
			})
		  //alert(mem_used);
        }, 2000);
}

//------------------------------------------------------------->
// 처리중 컬러 : #ffbf35
// 처리완료 컬러 : #41fc63
// 최종완료 컬러 : yellow
//이 아래는 수정 하지 마세요
function getArticle_Ajax(unronsa){
	document.getElementById(unronsa+"_error").innerHTML = "";
	document.getElementById(unronsa+"_error_send").innerHTML = "";
	//크롤링 전 데이터 체크
	check_before_running(unronsa);
	crawling_start(unronsa);
	
	document.getElementById(unronsa).innerHTML = "기사 수집중";
	document.getElementById(unronsa+"_").style.backgroundColor = "#ffbf35";
	var url = unronsa + ".jsp";
	var recod = 0;
	$.ajax({
		type: "POST",
		url: "/crawling/crawler/"+url,
		cache : false,
		dataType : "json",
		timeout: 30000, 
		success : function(resdata){
			document.getElementById(unronsa).innerHTML = "수집 성공";
			document.getElementById(unronsa+"_").style.backgroundColor = "yellow";
			//이번에 크롤링한 데이터 갯수
			$.each(resdata, function(entryIndex, entry){
				recod++;
			});
			document.getElementById(unronsa+"_data").innerHTML = recod;
			
			//db 중복 체크
			check_duplication(resdata, unronsa);
		},
		error : function(request,status,error){
			insert_error(unronsa, "getArticle_Ajax", "수집 실패 json문자 형태 주소를 확인해주세요",
						  request.status, request.responseText, error);
			document.getElementById(unronsa).innerHTML = "수집 실패, json문자 형태, 주소를 확인해주세요";
			document.getElementById(unronsa+"_").style.backgroundColor = "red";
			document.getElementById(unronsa+"_error").innerHTML = "["+unronsa+"] getArticle_Ajax 에러 <br>"+
																	"code["+request.status+"]<br>"+
																	"message ["+request.responseText+"]<br>"+
																	"error ["+ error+"]";
		}
	})
}
<!--변경전 데이터 확인
function check_before_running(unronsa){
	var url = "/crawling/checkDB/check_before_run.jsp";
	$.ajax({
		type: "POST",
		url: url,
		cache: false,
		dataType: "json",
		timeout: 30000,
		data: {
			company : unronsa,
		}, 
		success : function(resdata,request,status,error){
			var result_status = "";
			var result_msg="";
			$.each(resdata, function(entryIndex, entry){
				result_status = entryIndex;
				result_msg = entry;
			});
			if(result_status = "success"){
				document.getElementById(unronsa+"_before").innerHTML = result_msg;
			}else{
				document.getElementById(unronsa).innerHTML = "변경전 체크 서버 에러 "+result_msg;
				document.getElementById(unronsa+"_").style.backgroundColor = "red";
				insert_error(unronsa, "check_before_running", "sql 에러",
						  request.status, request.responseText, error);
			}
		},
		error : function(request, status, error){
			insert_error(unronsa, "check_before_running", "변경전 데이터 조회 실패, 언론사이름, 주소를 확인해주세요",
						  request.status, request.responseText, error);
			document.getElementById(unronsa).innerHTML = "변경전 데이터 조회 실패, 언론사이름, 주소를 확인해주세요";
			document.getElementById(unronsa+"_").style.backgroundColor = "red";
			document.getElementById(unronsa+"_error").innerHTML = "["+unronsa+"] check_before_running 에러 <br>"+
																	"code["+request.status+"]<br>"+
																	"message ["+request.responseText+"]<br>"+
																	"error ["+ error+"]";			
		}
	})
}


<!--중복 데이터 확인
function check_duplication(newsdata, unronsa){
	var url = "/crawling/checkDB/check_duplication.jsp";
	document.getElementById(unronsa+"_").style.backgroundColor = "#ffbf35";
	document.getElementById(unronsa).innerHTML = "DB대조중 : 중복체크";
	$.ajax({
		type: "POST",
		url: url,
		data : {
			company : unronsa,
			jsonString : JSON.stringify(newsdata),
		},
		dataType : "json",
		timeout : 30000,
		success : function(resdata,request,status,error){
			var result_status = "";
			var result_msg="";
			$.each(resdata, function(entryIndex, entry){
				result_status = entryIndex; //성공시 파싱할 문자
				result_msg = entry;
			});
			if(result_status == "success"){ //성공시 success 문자 파싱
				document.getElementById(unronsa).innerHTML = "DB 중복체크 완료";
				document.getElementById(unronsa+"_").style.backgroundColor = "#41fc63";
				document.getElementById(unronsa+"_duplication").innerHTML = result_msg;
				sendTo_insertDB(newsdata, unronsa);
			}else{
				//중복체크 페이지로 갔지만 sql 오류일시 오류메세지 출력
				document.getElementById(unronsa).innerHTML = "중복체크 서버 에러 "+result_msg;
				document.getElementById(unronsa+"_").style.backgroundColor = "red";
				insert_error(unronsa, "check_duplication", "sql 에러",
						  request.status, request.responseText, error);
			}
		},
		error: function(request,status,error){
			//입력서버로 도달하지 못했을시
			insert_error(unronsa, "check_duplication", "중복체크 서버 도달 불가 json형태 주소를 확인해주세요",
						  request.status, request.responseText, error);
			document.getElementById(unronsa).innerHTML = "중복체크 서버 도달 불가, json형태, 주소를 확인해주세요";
			document.getElementById(unronsa+"_").style.backgroundColor = "red";
			document.getElementById(unronsa+"_error").innerHTML = "["+unronsa+"] check_duplication 에러 <br>"+
																	"code["+request.status+"]<br>"+
																	"message ["+request.responseText+"]<br>"+
																	"error ["+ error+"]";
		}
	})
}

//<!------------------------ 기사 삽입
function sendTo_insertDB(newsdata, unronsa){
	var url = "/crawling/insertDB/mysqlinsert.jsp";
	document.getElementById(unronsa+"_").style.backgroundColor = "#ffbf35";
	//삽입 수행
	document.getElementById(unronsa).innerHTML = "DB대조중 : 삽입";
	$.ajax({
		type: "POST",
		url: url,
		data : {
			company : unronsa,
			jsonString : JSON.stringify(newsdata),
		},
		dataType : "json",
		timeout : 30000,
		success : function(restext,request,status,error){
			var result_status = "";
			var result_msg = "";
			$.each(restext, function(entryIndex, entry){
				result_status = entry; //성공시 파싱할 문자
			});
			if(result_status == "success"){ //성공시 success 문자 파싱
				document.getElementById(unronsa).innerHTML = "데이터 삽입 완료";
				document.getElementById(unronsa+"_").style.backgroundColor = "yellow";
				check_total(unronsa);
			}else{
				//insert 페이지로 갔지만 sql 오류일시 오류메세지 출력
				document.getElementById(unronsa).innerHTML = result_status;
				insert_error(unronsa, "sendTo_insertDB", "sql 에러",
						  request.status, request.responseText, error);
			}
		},
		error: function(request,status,error){
			insert_error(unronsa, "sendTo_insertDB", "입력서버 도달 불가 json 형태, 서버주소를 확인 해주세요",
						  request.status, request.responseText, error);
			//비교서버로 도달하지 못했을시
			document.getElementById(unronsa).innerHTML = "입력서버 도달 불가, json 형태, 서버주소를 확인 해주세요";
			document.getElementById(unronsa+"_").style.backgroundColor = "red";
			document.getElementById(unronsa+"_error").innerHTML = "["+unronsa+"] sendTo_insertDB 에러 <br>"+
																	"code["+request.status+"]<br>"+
																	"message ["+request.responseText+"]<br>"+
																	"error ["+ error+"]";
		}
	})
}

//마지막 과정
function check_total(unronsa){
	var url = "/crawling/checkDB/check_all_data.jsp";
	document.getElementById(unronsa+"_").style.backgroundColor = "#ffbf35";
	document.getElementById(unronsa).innerHTML = "총 데이터 조회중..";
	$.ajax({
		type: "POST",
		url: url,
		data: {
			company: unronsa,
		},
		dataType: "json",
		timeout: 30000,
		success : function(restext,request,status,error){
			var result_status = "";
			var result_msg = 10;
			$.each(restext, function(entryIndex, entry){
				result_status = entryIndex; //성공시 파싱할 문자
				result_msg = entry;
			});
			if(result_status == "success"){
				document.getElementById(unronsa).innerHTML = "모든 과정이 성공적으로 끝났습니다.";
				document.getElementById(unronsa+"_total").innerHTML = result_msg;
				document.getElementById(unronsa+"_").style.backgroundColor = "#41fc63";
				crawling_end(unronsa)				;
			}else{
				insert_error(unronsa, "check_total", "sql 에러",
						  request.status, request.responseText, error);
			}
		},
		error : function(request,status,error){
			insert_error(unronsa, "check_total", "레코드 확인서버 도달 불가",
						  request.status, request.responseText, error);
			document.getElementById(unronsa).innerHTML = "레코드 확인서버 도달 불가";
			document.getElementById(unronsa+"_").style.backgroundColor = "red";
			document.getElementById(unronsa+"_error").innerHTML = "["+unronsa+"] check_total 에러 <br>"+
																	"code["+request.status+"]<br>"+
																	"message ["+request.responseText+"]<br>"+
																	"error ["+ error+"]";
		}
	})	
}
//<!------------------도메인------에러가난 함수--------에러 커스텀메세지----------에러코드-------에러 정보------에러메세지
function insert_error(unronsa, error_function, error_custom_message, error_code, error_info, error_message){
	var url = "/crawling/insertDB/mysqlinsertError.jsp";
	var unronsa_error = document.getElementById(unronsa+"_error").innerHTML;
	crawling_end(unronsa);
	$.ajax({
		type: "POST",
		url: url,
		data: {
			company : unronsa,
			erfunction : error_function,
			ercustom : error_custom_message,
			ercode : error_code,
			erinfo : error_info,
			ermsg : error_message,
		},
		dataType: "json",
		timeout: 30000,
		success : function(restext){
			var result_status = "";
			var result_msg = "";
			$.each(restext, function(entryIndex, entry){
				result_status = entryIndex; //성공시 파싱할 문자
				result_msg = entry;
			});
			if(result_status == "success"){
				document.getElementById(unronsa+"_error_send").innerHTML = "error ["+unronsa+"] : 서버로 로그가 전송되었습니다.";
			}else{
				document.getElementById(unronsa+"_error_send").innerHTML = "error ["+unronsa+"] : 로그 전송 실패<br>"+result_msg;
			}
		},
		error : function(resdata, request,status,error){
			document.getElementById(unronsa+"_error_send").innerHTML = "로그 전송 실패 제작자에게 문의하세요";
		}
	})
}

function crawling_start(unronsa){
	var today = new Date();
	var yyyy = today.getFullYear();
	var mm = today.getMonth() + 1;
	var dd = today.getDate();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
	h = checkTime(h);
    m = checkTime(m);
    s = checkTime(s);
	mm = checkTime(mm);
	dd = checkTime(dd);
    document.getElementById(unronsa+"_start").innerHTML =
    yyyy+ "-" + mm + "-" + dd + " " + h + ":" + m + ":" + s;
}

function crawling_end(unronsa){
	var today = new Date();
	var yyyy = today.getFullYear();
	var mm = today.getMonth() + 1;
	var dd = today.getDate();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
    h = checkTime(h);
    m = checkTime(m);
    s = checkTime(s);
	mm = checkTime(mm);
	dd = checkTime(dd);
    document.getElementById(unronsa+"_end").innerHTML =
    yyyy+ "-" + mm + "-" + dd + " " + h + ":" + m + ":" + s;
	
	var start_time = document.getElementById(unronsa+"_start").innerHTML;
	var s_yyyy = start_time.substring(0,4) * 1;
	var s_mm = (start_time.substring(5,7) - 1) * 1;
	var s_dd = start_time.substring(8,10) * 1;
    var s_h = start_time.substring(11,13) * 1;
    var s_m = start_time.substring(14,16) * 1;
    var s_s = start_time.substring(17,19) * 1;
	
	var start_dt = new Date(s_yyyy, s_mm, s_dd, s_h, s_m, s_s);
	var runing_time = today.getTime() - start_dt.getTime();
	runing_time = runing_time / 1000;
	//alert(runing_time);
	document.getElementById(unronsa+"_runtime").innerHTML =
    runing_time.toFixed(1) + " 초";
}


function startTime() {
    var today = new Date();
	var yyyy = today.getFullYear();
	var mm = today.getMonth() + 1;
	var dd = today.getDate();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();
	mm = checkTime(mm);
	dd = checkTime(dd);
    m = checkTime(m);
    s = checkTime(s);
    document.getElementById('clock').innerHTML =
    yyyy+ "년 " + mm + "월 " + dd + "일 " + h + ":" + m + ":" + s;
    var t = setTimeout(startTime, 500);
}
function checkTime(i) {
    if (i < 10) {i = "0" + i}; // 숫자가 10보다 작을 경우 앞에 0을 붙여줌
    return i;
}
</script>
</center>
</body>
</html>







