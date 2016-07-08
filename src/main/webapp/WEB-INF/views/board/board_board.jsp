<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>board_board.jsp</h2>

<p>page : ${page }</p>
<table border=1>
	<tr>
		<td>id</td>
		<td>email</td>
		<td>nickname</td>
	</tr>
	<c:forEach var="fors" items="${list_mem }">
		<tr>
			<td>${fors.mem_id }</td>
			<td>${fors.mem_email }</td>
			<td>${fors.mem_nickname }</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>