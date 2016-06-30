<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java"%>
<%@ page import="com.tobesoft.platform.*" %>
<%@ page import="com.tobesoft.platform.data.*" %>
<%@ page import="com.tobesoft.platform.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
System.out.println("--------------------- connector.jsp --------------------------");
Connection conn=null;
Statement stmt=null;
ResultSet rs=null;

String db_driver="oracle.jdbc.driver.OracleDriver"; 
String db_url="jdbc:oracle:thin:@127.0.0.1:1521:xe";
String db_user="ryusm"; 
String db_password="1234"; 

try
{ 
	Class.forName(db_driver);
	try
	{ 
		conn = DriverManager.getConnection(db_url,db_user,db_password); 
		stmt=conn.createStatement();
		System.out.println("연결성공 success"); 
	}catch(Exception e){ 
		System.out.println("DB에 연결할 수 없습니다. fail to connect" + e.toString()); 
		conn = null;
	} 
}catch(ClassNotFoundException e){ 
	System.out.println("JDBC 드라이버를 찾을 수 없습니다. jdbc driver not found" + e); 
	conn = null;
	
} 
%>

<%!
/******** 결과 XML 생성 및 Web Server로 전달 ******/
public void sendOutput(HttpServletResponse response,JspWriter out,VariableList out_vl,DatasetList out_dl) throws Exception
{
	out.clearBuffer();
	PlatformResponse pRes = new PlatformResponse(response, PlatformRequest.XML, "utf-8");
	pRes.sendData(out_vl, out_dl);
}//sendOutput


%>
