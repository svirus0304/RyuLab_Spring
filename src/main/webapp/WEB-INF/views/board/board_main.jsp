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
	width:90%;
	height:80%;
}

</style>

<script>
$(document).ready(function(){
	//시작시 boardDiv에 첫페이지 불러온다.
	var page=1;
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
})//ready
</script>

</head>
<body>
<h2></h2>
<div class="boardDiv"></div>
</body>
</html>