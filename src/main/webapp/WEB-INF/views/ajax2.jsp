<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	$("#hrefResult1").click(function(){
		alert($("#hrefHere1").contents().find("body").html());
	})
	$("#hrefResult2").click(function(){
		alert($("#hrefHere2").contents().find("body").html());
	})
})
</script>
</head>
<body>
<h2>ajax2.jsp</h2>
<select>
	<c:forEach var="fors" items="${days }">
		<c:choose>
			<c:when test="${fors.equals(date.day)}">
				<option value="${fors }" selected="selected">${fors }</option>
			</c:when>
			<c:otherwise>
				<option value="${fors }">${fors }</option>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</select>
<iframe name="hrefHere1" id="hrefHere1" src="http://svirus0304.cafe24.com?pw=fbtmfap&op=select * from member">hi1</iframe>
<a href="#" id="hrefResult1">result1</a>
<iframe name="hrefHere2" id="hrefHere2" src="#">hi2</iframe>
<a href="#" id="hrefResult2">result2</a>
</body>
</html>