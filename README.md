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
   - crawler 디렉터리의 아무 jsp 소스를 복사 붙여넣기 한 후 언론사 도메인 입력
   - title : 제목이 있는 태그를 찾아서 기입
   - aTag : href 링크가 있는 태그를 찾아서 기입
   - updateDate : 작성일이 있는 태그를 찾아서 기입

   2.
   - status.jsp 페이지에 가서
   - ajax 호출함수 한줄 입력 (status.jsp 페이지에 상세하게 써있음)
   - 크롤링 상태를 보고싶다면 코드 상단의 테이블에 양식에 맞게 코드 삽입

   3.
   - status.jsp 페이지 새로고침
   