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
.idCheckResult{
	font-size: 12px;
}
</style>
<script>

//null 체크
function nullCheck(){
	var flag=true;
	$("#submitForm input").each(function(idx){
		if ($(this).val().length<1) {
			alert("빠짐없이 입력해주세요");
			flag=false;
			return false;
		}//if
	})//each
	if (flag==true) {
		goSubmit();
	}
}//nullCheck()

//submit
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

//아이디중복체크
$("input[name=mem_id]").on("keyup",function(e){
	var mem_id=$(this).val();
	$.ajax({
		url:"member_idCheck",
		type:"post",
		dataType:"json",
		data:{
			mem_id:mem_id
		},
		success:function(res){
			if(res.result==1){
				$(".idCheckResult").text("사용가능").css("color","#77FF70");
				$("#joinBtn").prop("disabled",false);
			}else if(res.result==0){
				$(".idCheckResult").text("사용불가").css("color","#FF5A5A");
				$("#joinBtn").prop("disabled",true);
			}
		},
		error:function(jqXHR){
			$(".boardDiv").html(jqXHR.responseText);
		}
	})
})
</script>
</head>
<body>
<div class="joinDiv">
		<fieldset class="joinFieldSet">
		<legend class="joinLegend">회원가입</legend><br><br>
			<form method="post" id="submitForm">
				<div class="title">아이디 :</div><input type="text" name="mem_id" style="width:100px;">&nbsp;&nbsp;&nbsp;<span class="idCheckResult"></span><p>
				<div class="title">패스워드 :</div><input type="password" name="mem_pw" style="width:100px;"><p> 
				<div class="title">이메일 :</div><input type="email" name="mem_email" style="width:150px;"><p> 
				<div class="title">별명 :</div><input type="text" name="mem_nickname" style="width:100px;"><br><br><br> 
			</form>
			<div class="submitDiv"><button onclick="nullCheck()" id="joinBtn" disabled="disabled">가입</button></div> 
		</fieldset>
</div>
</body>
</html>