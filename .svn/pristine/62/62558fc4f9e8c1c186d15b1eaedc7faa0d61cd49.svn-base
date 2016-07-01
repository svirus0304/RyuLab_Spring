<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file = "common_new.jsp" %>
<%
	System.out.println("--------------------- selectAll.jsp ------------------------");
	PlatformRequest platformRequest = this.proc_input(request);  
	in_vl = platformRequest.getVariableList();
	in_dl = platformRequest.getDatasetList();
	
	String strTable = in_vl.getValueAsString("table");
	System.out.println("strTable : "+strTable);//test
	
	try {	
		if(conn!=null)
		{
			
			StringBuffer sbSql = new StringBuffer();
								
			sbSql.append(" SELECT *	")
			     .append("FROM ").append(strTable);
			System.out.println("sbSql : "+sbSql.toString());//test

			pstmt = conn.prepareStatement(sbSql.toString());
			
			rs = pstmt.executeQuery(); 
			
			out_dl.addDataset("output", this.makeDataSet(rs,"output"));
			
 		   this.setResultMessage(0, "OK",out_vl);
		}
	
	} catch(Exception ex) { 
        this.setResultMessage(-1, ex.getMessage(),out_vl);
	} finally {
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			}catch(Exception e) {}
		}
		if(conn != null) {
			try {
				conn.close();
			}catch(Exception e) {}
		}
	}
    proc_output(response,out,out_vl,out_dl);
%>