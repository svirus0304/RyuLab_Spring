<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>슬메론</title>
<style>
.table{
	font-size: 14px;
	text-align: center;
}
.table input{
	width:100px;
	height:20px;
	font-size:12px;
	text-align: center;
}
.table .nameTd{
	width:50px;
}
.table .placeTd{
	text-align: center;
}
</style>
</head>
<body>
총 몇차? : ${placeNum}<br>
맴바 : ${member }<br>
<table class="table" align="center" border=1 style="width:initial;">
	<tr>
		<td></td>
	<c:forEach var="fors" items="${memList }">
		<td class="nameTd">
			${fors.name}
		</td>
	</c:forEach>
	</tr>
	<c:forEach var="fors" varStatus="status" begin="1" end="${placeNum }">
	<tr>
		<td class="placeTd">
			${status.index }차<br>
			장소 : 
			<input type="text" name="placeName"><br>
			<select>
				<option>-- 결제자 선택 --</option>
				<c:forEach var="fors" items="${memList }">
					<option>${fors.name}</option>
				</c:forEach>
			</select>
		</td>
		<c:forEach var="fors" items="${memList }">
		<td>
			<input type="checkbox" name="" checked>
		</td>
	</c:forEach>
	</tr>
	</c:forEach>
</table>
</body>
</html>