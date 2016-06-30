<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file = "common_new.jsp" %>
<%
System.out.println("--------------------- trans_sample_new.jsp ------------------------");

	PlatformRequest platformRequest = this.proc_input(request);  
	in_vl = platformRequest.getVariableList();
	in_dl = platformRequest.getDatasetList();

	Dataset in_ds = in_dl.getDataset("input");
	Statement stmt =  conn.createStatement();
	
	String strTable=in_vl.getValueAsString("table");

	try 
	{	
		int RowCnt = in_ds.getRowCount();
		int i;
	
		String RowStatus;
		String sql01 = "";
		String sql02 = "";
		StringBuffer sbSql = null;


System.out.println("Dataset : " + in_ds);
		//삭제
		RowCnt = in_ds.getDeleteRowCount();

		for ( i = 0 ; i < RowCnt ; i++ )
		{
			sql01 = "DELETE FROM "+strTable+" WHERE col1 = '" + in_ds.getDeleteColumn(i,"col1").getString() + "'";
			System.out.println("sql01 : "+sql01);
			stmt.execute(sql01);
		}

		//뭔가 다른것이다.
		RowCnt = in_ds.getRowCount();

		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = in_ds.getRowStatus(i);
		
			sbSql = new StringBuffer();

System.out.println("------------ RowStatus : " + RowStatus);
			if ( RowStatus.equals("insert") )
			{ 
System.out.println("------------ 1 -------------");
				sbSql.append(" insert into cs_test (col1,col_int,col_dec,col_num,col_num2,col_date) ");
				sbSql.append("             values (");
				sbSql.append(checkNullString(in_ds.getColumn(i,"COL1").getString()));
				sbSql.append(",");
				sbSql.append(in_ds.getColumn(i,"COL_INT").getDouble());
				sbSql.append(",");
				sbSql.append(in_ds.getColumn(i,"COL_DEC").getDouble());
				sbSql.append(",");
				sbSql.append(in_ds.getColumn(i,"COL_NUM").getDouble());
				sbSql.append(",");
				sbSql.append(in_ds.getColumn(i,"COL_NUM2").getDouble());
				sbSql.append(",");
				sbSql.append(" to_date('").append(in_ds.getColumn(i,"COL_DATE").getString()).append("')");
				sbSql.append(")");
			
			}
			else if ( RowStatus.equals("update") )
			{
System.out.println("------------ 2 -------------");
				sbSql.append(" update "+strTable+" set ");
System.out.println("------------ 2-1 -------------");
				sbSql.append("                    COL_INT= ");
System.out.println("------------ 2-2 -------------");
				sbSql.append(in_ds.getColumn(i,"COL_INT").getDouble());
System.out.println("------------ 2-3 -------------");
				sbSql.append(",");
System.out.println("------------ 2-4 -------------");
				sbSql.append("                    col_dec= ");
System.out.println("------------ 2-5 -------------");
				sbSql.append(in_ds.getColumn(i,"COL_DEC").getDouble());
System.out.println("------------ 2-6 -------------");
				sbSql.append(",");
System.out.println("------------ 2-7 -------------");
				sbSql.append("                    col_num= ");
System.out.println("------------ 2-8 -------------");
				sbSql.append(in_ds.getColumn(i,"COL_NUM").getDouble());
				sbSql.append(",");
				sbSql.append("                    COL_NUM2= ");
System.out.println("------------ 2-9 -------------");
				sbSql.append(in_ds.getColumn(i,"COL_NUM2").getDouble());
System.out.println("------------ 2-10 -------------");
				sbSql.append(",");
System.out.println("------------ 2-11 -------------");
				sbSql.append("                    col_date= ");
System.out.println("------------ 2-12 -------------");
				sbSql.append(" to_date('").append(in_ds.getColumn(i,"COL_DATE").getString()).append("')");
System.out.println("------------ 2-13 -------------");
				sbSql.append(" WHERE col1 = '");
				sbSql.append(checkNullString(in_ds.getColumn(i,"COL1").getString()));
				sbSql.append("'");
System.out.println("------------ 2-end -------------");

			}
System.out.println("sbSql : " + sbSql);			
			stmt.execute(sbSql.toString());
		}
		
	   this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
       this.setResultMessage(-1, ex.toString(),out_vl);
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
		if(stmt != null) {
			try {
				stmt.close();
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