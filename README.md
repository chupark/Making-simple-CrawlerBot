# Making-simple-CrawlerBot

## ���� ȯ��

<table>
<tr>
<td>ubuntu linux</td><td>16.04.3 LTS</td>
</tr>
<tr>
<td>�ڹ� ����</td><td>jdk 1.8.0_151</td>
</tr>
<tr>
<td>�����ͺ��̽�</td><td>Oracle 12C R2</td>
</tr>
<tr>
<td>���̺귯��</td><td>jsoup, org.w3c.dom, org.json</td>
</tr>
<tr>
<td>��������</td><td>chrome</td>
</tr>
</table>

## ���뵵

![enter image description here](https://github.com/chupark/Making-simple-CrawlerBot/blob/master/crawling_drawing.PNG)

## �߰輭��

### status.jsp

   - crawler ���͸��� �� ��л� ũ�ѷ� �� ȣ��
   - insertdb ȣ��


## ������ ũ�ѷ� ��

### ����

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
   