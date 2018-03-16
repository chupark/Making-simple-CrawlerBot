<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import= "org.apache.http.HttpEntity" %>
<%@ page import= "org.apache.http.HttpResponse" %>
<%@ page import= "org.apache.http.NameValuePair" %>
<%@ page import= "org.apache.http.ParseException" %>
<%@ page import= "org.apache.http.client.HttpClient" %>
<%@ page import= "org.apache.http.client.entity.UrlEncodedFormEntity" %>
<%@ page import= "org.apache.http.client.methods.HttpGet" %>
<%@ page import= "org.apache.http.client.methods.HttpPost" %>
<%@ page import= "org.apache.http.impl.client.DefaultHttpClient" %>
<%@ page import= "org.apache.http.message.BasicNameValuePair" %>
<%@ page import= "org.apache.http.params.HttpConnectionParams" %>
<%@ page import= "org.apache.http.util.EntityUtils" %>
<%@ page import= "org.apache.http.conn.ClientConnectionManager" %>
<%@ page import= "org.apache.http.params.HttpParams" %>
<%@ page import= "org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>

<html>
<head>
<%!
DefaultHttpClient client;
	/**
	 *HttpClient 재사용가능 서버 통신시 세션 유지 위함 HttpClient 4.5.2 -> https://hc.apache.org/downloads.cgi
	 */
public DefaultHttpClient getThreadSafeClient(){
	if(client != null){
		return client;
	}
	client = new DefaultHttpClient();
	ClientConnectionManager mgr = client.getConnectionManager();
	HttpParams params = client.getParams();
	client = new DefaultHttpClient(new ThreadSafeClientConnManager(params, mgr.getSchemeRegistry()), params);
	
	return client;
}
//로그인이 되있으면... 트루로 보내용
public String goLogin(){
	return goXML("http://192.168.23.99:8080/L18/login.jsp", true);
}
//로그인이 안됬으면 false 에용///그래서 null이 들어오겠죠
public String goXML(String getURL){
	return goXML(getURL, false);
}

//여기에서 이제 데이터를 담습니다
public String goXML(String getURL, Boolean loginFlag){
	String Result = null;
	
	HttpClient client = getThreadSafeClient();
	
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if(loginFlag){ //여기가 post / get 파라메터를 전달하는 곳
		nameValuePairs.add(new BasicNameValuePair("username", "kopoctc"));
		nameValuePairs.add(new BasicNameValuePair("userpasswd", "kopoctc"));
	}
	
	try{
		post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
		HttpResponse responsePost = null;
		
		responsePost = client.execute(post);
		HttpEntity resEntity = responsePost.getEntity();
		
		if(resEntity != null){
			Result = EntityUtils.toString(resEntity,"utf-8").trim();
		}
	} catch (Exception e){
		e.printStackTrace();
	} finally {
		
	}
	return Result;
}
%>
</head>
<body>
<h1>성적 조회<h1>
<%
	String ret = goLogin();
	ret = goXML("http://192.168.23.99:8080/crawling/ohmynews.jsp");
	//out.println(ret);
	
	try {
		//DocumentBuilderFactory 객체 생성
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		//DocumentBuilder 객체 생성
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		ByteArrayInputStream is = new ByteArrayInputStream(ret.getBytes("utf-8"));
		//builder를 이용하여 XML 파싱하여 Document 객체 생성
		Document doc = builder.parse(is);
		
		//생성된 document에서 각 요소들을 접근하여 데이터를 저장함
		Element root = doc.getDocumentElement();
		NodeList tag_name = doc.getElementsByTagName("name");
		NodeList tag_studentid = doc.getElementsByTagName("studentid");
		NodeList tag_kor = doc.getElementsByTagName("kor");
		NodeList tag_eng = doc.getElementsByTagName("eng");
		NodeList tag_mat = doc.getElementsByTagName("mat");
		
		int kor = 0;
		int eng = 0;
		int mat = 0;		
		
	for (int i = 0; i < tag_name.getLength(); i++){
		kor = Integer.parseInt(tag_kor.item(i).getFirstChild().getNodeValue());
		eng = Integer.parseInt(tag_eng.item(i).getFirstChild().getNodeValue());
		mat = Integer.parseInt(tag_mat.item(i).getFirstChild().getNodeValue());
		out.println("<tr>");
		out.println("<td width=100>"+tag_name.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_studentid.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_kor.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_eng.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_mat.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+(kor + eng + mat)+"</td>");
		out.println("<td width=100>"+(kor + eng + mat)/3+"</td>");		
		}
	out.println("</table>");		
	} catch (Exception e){
		out.println(e);
	}
%>
</body>
</html>