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
	text-align: center;
}
.title{
	width:100px;
	float:left;
}
.submitDiv{
	text-align: center;
}
.submitDiv button{
	width:70px;
}
</style>
<script>
function goSubmit(){
	var data=$("#submitForm").serialize();
	$.ajax({
		url:"member_join_add",
		type:"post",
		dataType:"json",
		data:data,
		success:function(res){
			$(".joinDiv").text(res.result);
		},
		error:function(jqXHR){
			$(".joinDiv").html(jqXHR.status+"<br>"+jqXHR.responseText);
		}
	})
}//goSubmit()
</script>
</head>
<body>
<div class="joinDiv">
		<fieldset class="joinFieldSet">
		<legend class="joinLegend">회원가입</legend><br><br>
			<form method="post" id="submitForm">
				<div class="title">아이디 :</div><input type="text" name="mem_id" style="width:100px;"><p>
				<div class="title">패스워드 :</div><input type="password" name="mem_pw" style="width:100px;"><p> 
				<div class="title">이메일 :</div><input type="email" name="mem_email" style="width:150px;"><p> 
				<div class="title">별명 :</div><input type="text" name="mem_nickname" style="width:100px;"><br><br><br> 
			</form>
			<div class="submitDiv"><button onclick="goSubmit()">가입</button></div> 
		</fieldset>
</div>
</body>
</html>