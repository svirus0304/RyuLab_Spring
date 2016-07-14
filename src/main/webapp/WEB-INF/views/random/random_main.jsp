<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RANDOM</title>
<script type="text/javascript" src="//code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
.wrapDiv{
	padding-top: 200px;
	padding-bottom: 200px;
}
.numbersDiv{
	width:800px;
	margin:auto;
	text-align: center;
	background-color: black;
	border-radius:100px;
}
.numbers{
	color:#FFBB00;
	font-size:80px;
	width: 100px;
	text-align: center;
	margin-left: 5px;
	margin-right: 5px;
}
.pigNum{
	position: absolute;
	width: 115px;
	z-index: 1;
	-webkit-transition:ease-in 1s;
}
.pigNum:HOVER{
	cursor:pointer;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$(".pigNum").each(function(idx){
		$(this).click(function(){
			$(this).css("z-index","100");
			$(this).css("margin","auto");
			$(this).css("margin-left","-5000px");
			$(this).css("margin-top","-5000px");
			$(this).css("width","10000px");
			setTimeout(function(){$(".pigNum:eq("+idx+")").hide()},1000);
		})//click
	})//each
});//ready
</script>
</head>
<body>
<div class="wrapDiv">
	<div class="numbersDiv">
		<c:forEach var="fors" items="${numbers }" varStatus="status">
			<img src="resources/img/pigNum.png" class="pigNum">		
			<input type="text" name="num${status.index}" class="numbers" value="${fors }">
		</c:forEach>
	</div>
</div>
</body>
</html>