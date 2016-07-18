<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
.joinDiv{
	margin-top:100px;
	text-align:center;
}
.joinFieldSet{
	width:300px;
	margin:auto;
	text-align: left;
}
.joinLegend{
	text-align: left;
}
.title{
	width:100px;
	float:left;
}
.submitDiv{
	text-align: center;
}
</style>
<script>
function GoSubmit(){
	$.ajax({
		url:"member_join_add",
		type:"post",
		dataType:"json",
		data:$("#submitForm").serialize(),
		success:function(data){
			$(".boardDiv").html(data.result);
		},
		error:function(jqXHR){$(".boardDiv").html(jqXHR.responseText)}
	})
}
</script>
</head>
<body>
<div class="joinDiv">
	<form action="" method="post" id="submitForm">
		<fieldset class="joinFieldSet">
		<legend class="joinLegend">회원가입</legend><p>
			<div class="title">아이디 :</div><input type="text" name="mem_id" style="width:100px;"><p>
			<div class="title">패스워드 :</div><input type="password" name="mem_pw" style="width:100px;"><p> 
			<div class="title">이메일 :</div><input type="email" name="mem_email" style="width:150px;"><p> 
			<div class="title">별명 :</div><input type="text" name="mem_nickname" style="width:100px;"><p> 
			<div class="submitDiv"><button onclick="GoSubmit()">가입</button></div> 
		</fieldset>
	</form>
</div>
</body>
</html>