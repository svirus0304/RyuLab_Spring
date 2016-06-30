<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java"%>
<%@ page import="com.tobesoft.platform.*" %>
<%@ page import="com.tobesoft.platform.data.*" %>
<%@ page import="com.tobesoft.platform.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ include file="connector.jsp" %>

<%System.out.println("--------------------- trans.jsp ------------------------");%>
<%!/*********** 공통함수 *************/
//DataSet 값 가져오기, 단, "null"을 ""로
public String dsGet(Dataset ds,int rowno,String id) throws Exception
{
	String value;
	value=ds.getColumn(rowno, id).getString();
	if(value==null)
			return "";
	else
			return value; 
}
%>

<%//************** service api 초기화
//input 부분 초기화
VariableList in_vl=new VariableList();
DatasetList in_dl=new DatasetList();
PlatformRequest pReq=new PlatformRequest(request,"utf-8");

//web server에서 xml수신 및 parsing
pReq.receiveData();

//List획득 및 Dataset, 변수 획득
in_vl=pReq.getVariableList();
in_dl=pReq.getDatasetList();
Dataset ds=in_dl.getDataset("input");
String in_var=in_vl.getValueAsString("table");

/** Output 부분 초기화 **/
VariableList out_vl = new VariableList();
DatasetList  out_dl = new DatasetList();

for(int i=0;i<ds.getColumnCount();i++){

	System.out.println("getColumnID : "+ds.getColumnID(i));
	
}
%>

<%
String SQL = "";
int	i;
try {
/******** Dataset을 INSERT, UPDATE처리 ********/
for(i=0;i<ds.getRowCount();i++)
{
	String row_status = ds.getRowStatus(i);
	if( row_status.equals("insert") == true )
	{
		SQL = "insert into base_sawon_U ( name, sabun, dept, jikgup, gender, ipsa_date, marry, email, smemo ) values ( " +
				"'" + dsGet(ds,i,"name") + "'," + 
				"'" + dsGet(ds,i,"sabun") + "'," + 
				"'" + dsGet(ds,i,"dept") + "'," +  
				"'" + dsGet(ds,i,"jikgup") + "'," +
				"'" + dsGet(ds,i,"gender") + "'," +
				"'" + dsGet(ds,i,"ipsa_date") + "'," +
				"'" + dsGet(ds,i,"marry") + "'," +
				"'" + dsGet(ds,i,"email") + "'," +				
				"'" + dsGet(ds,i,"smemo") + "' )";
	}
	else if( row_status.equals("update") == true )
	{
		String org_name = ds.getOrgColumn(i,"name").getString(); 
		SQL = "update base_sawon_U set " +
				"name = '" + dsGet(ds,i,"name") + "'," + 
				"sabun = '" + dsGet(ds,i,"sabun") + "'," +
				"dept = '" + dsGet(ds,i,"dept") + "'," +  
				"jikgup = '" + dsGet(ds,i,"jikgup") + "'," +
				"gender = '" + dsGet(ds,i,"gender") + "'," +
				"ipsa_date = '" + dsGet(ds,i,"ipsa_date") + "'," +
				"marry = '" + dsGet(ds,i,"marry") + "'," +
				"email = '" + dsGet(ds,i,"email") + "'," +
				"smemo = '" + dsGet(ds,i,"smemo") + "' " +
				"where " +
				"name = " + "'" + org_name + "'";
	}
	stmt.executeUpdate(SQL);
}
/****** Dataset을 DELETE처리 ****/
for( i = 0 ; i< ds.getDeleteRowCount() ; i++ )
{
	String name = ds.getDeleteColumn(i,"name").getString();
	
	if( name == null )
	{
		name= "";
	}
	
	SQL = "delete from base_sawon_U where " +
			"name = " + "'" + name + "'";
	stmt.executeUpdate(SQL);
}


/********* 변수를 VariableList에 추가 ************/
out_vl.addStr("ErrorCode", "0");
out_vl.addStr("ErrorMsg", "SUCC");
out_vl.addStr("out_var", in_var);
}
catch ( SQLException e ) {
out_vl.addStr("ErrorCode", "-1");
out_vl.addStr("ErrorMsg", e.getMessage());
out_vl.addStr("out_var", in_var);
}

/******** JDBC Close ********/
if ( stmt != null ) try { stmt.close(); } catch (Exception e) {}
if ( conn != null ) try { conn.close(); } catch (Exception e) {}


%>