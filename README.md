# Making-simple-CrawlerBot

## 개발 환경

<table>
<tr>
<td>ubuntu linux</td><td>16.04.3 LTS</td>
</tr>
<tr>
<td>자바 버전</td><td>jdk 1.8.0_151</td>
</tr>
<tr>
<td>데이터베이스</td><td>Oracle 12C R2</td>
</tr>
<tr>
<td>라이브러리</td><td>jsoup, org.w3c.dom, org.json</td>
</tr>
<tr>
<td>웹브라우저</td><td>chrome</td>
</tr>
</table>

## 계통도

![enter image description here](https://github.com/chupark/Making-simple-CrawlerBot/blob/master/crawling_drawing.PNG)

## 중계서버

### status.jsp

   - crawler 디렉터리의 각 언론사 크롤러 봇 호출
   - insertdb 호출


## 간단한 크롤러 봇

### 사용법

   1.
   - copy & paste **news.jsp <src : crawling/crawler>
   - title : Find title element on yourDomain.html or something...
   - aTag : Find href(a tag) element on yourDomain.html or something...
   - updateDate : Find date element on yourDomain.html or something...

   2.
   - Go to <src crawling/status.jsp> and just add function like 'getArticle_Ajax("yourDomain"); bottom of the $(function(){
   - !IMPORTANT! You have to give a same name to yourDomain.html and 'getArticle_Ajax("yourDomain");
   - !for example! google.html & getArticle_Ajax("google.html"); 
   - If you want to monitor about Crawling status. add "tr, td tag" in the <table></table>

   3.
   - Change your JDBC Connection <src : crawling/insertDB/insertdb.jsp >

   4.
   - refresh status.jsp 
   