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
	 *HttpClient ���밡�� ���� ��Ž� ���� ���� ���� HttpClient 4.5.2 -> https://hc.apache.org/downloads.cgi
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
//�α����� ��������... Ʈ��� ������
public String goLogin(){
	return goXML("http://192.168.23.99:8080/L18/login.jsp", true);
}
//�α����� �ȉ����� false ����///�׷��� null�� ��������
public String goXML(String getURL){
	return goXML(getURL, false);
}

//���⿡�� ���� �����͸� ����ϴ�
public String goXML(String getURL, Boolean loginFlag){
	String Result = null;
	
	HttpClient client = getThreadSafeClient();
	
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if(loginFlag){ //���Ⱑ post / get �Ķ���͸� �����ϴ� ��
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
<h1>���� ��ȸ<h1>
<%
	String ret = goLogin();
	ret = goXML("http://192.168.23.99:8080/crawling/ohmynews.jsp");
	//out.println(ret);
	
	try {
		//DocumentBuilderFactory ��ü ����
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		//DocumentBuilder ��ü ����
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		ByteArrayInputStream is = new ByteArrayInputStream(ret.getBytes("utf-8"));
		//builder�� �̿��Ͽ� XML �Ľ��Ͽ� Document ��ü ����
		Document doc = builder.parse(is);
		
		//������ document���� �� ��ҵ��� �����Ͽ� �����͸� ������
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