<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
h2{text-align:center;}
.boardDiv{
	margin:auto;
	width:80%;
	height:80%;
	background-color:#E4F7BA;
}
.pageDiv{
	margin:auto;
	text-align:center;
	background-color: #FFB2D9;
}
</style>

<script>
$(document).ready(function board(page){
	$.ajax({
		url:"board_board",
		type:"post",
		dataType:"text",
		data:{
				page:page
				},
		success:function(data){
			$(".boardDiv").html(data);
		},
		error:function(){alert("에러");}
	});//ajax
})
</script>

</head>
<body>
<h2>board_main.jsp</h2>

<div class="boardDiv"></div>
<div class="pageDiv"></div>
</body>
</html>