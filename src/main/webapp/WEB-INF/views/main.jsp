<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ryu Lab</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
.smBtnGroup {
	display:block;
	border-radius:20px 20px 0px 0px;
	margin:auto;
	width:80%;
	min-width:800px;
	text-align: center;
	background-color:#F6F6F6;
	overflow: auto;
	padding-left:10px;
	padding-right:10px;
}
.smBtn {
	border-radius:5px;
	margin-top:5px;
	margin-left:-2px;
	margin-right:-2px;
	display:inline-block;
	width: 100px;
	height: 50px;
	background-color: lightgray;
	text-align: center;
	line-height: 50px;
}
.smBtnWrap{
	width: 100px;
	height: 50px;
	display:inline-block;
}
.smBtn:hover {
	cursor: pointer;
	background-color: white;
}
.smBtn5{
	width:120px;
}

.result {
	display:block;
	border-radius:0px 0px 20px 20px;
	overflow:auto;
	width:80%;
	min-width:800px;
	min-height:550px;
	background-color: lightyellow;
	margin:auto;
	padding-left:10px;
	padding-right:10px;
	padding-bottom:20px;
	margin-bottom: 30px;
	text-align: center;
}
.mainTitle{
	position:relative;
	z-index: 10;
}
/* ------------------- 로그인div --------------------- */
.loginDiv{
	width:300px;
	margin:auto;
	z-index: 100;
	position:absolute;
	left:50%;
	top:50%;
	-webkit-transform:translate(-50%,-50%);
	transform:translate(-50%,-50%);
	background-color: #FFEBFF;
	display: none;
}
.loginField{
	margin:auto;
}
.login_title{
	width:100px;
	float:left;
}
.loginResultSpan{
	color:#FF24A3;
}
/* ---------------------------------------------------------- */
.militaryMae{
	width:150px;
	margin-top:-20px;;
	margin-left:-150px;;
	position:absolute;
}
.aboveTheMoney{
	margin-top:80px;
	width:80%;
}
.pigBG{
	margin-left:0px;
	margin-top:-15px;
	width:100px;
	position: absolute;
}
.smloan{
	margin-left:-25px;
	margin-top:-5px;
	width:100px;
	height:60px;
	position: absolute;
	z-index: 5;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	$(".smBtn1").click(function(){//버튼1 클릭 시
		$(".result").html("<img src='resources/img/aboveTheMoney.png' class='aboveTheMoney'>")
	});//smBtn1
	
	$(".smBtn2").click(function(){//버튼2 클릭시
		$.get(//post로는 json 못 불러오는듯..
			"json",
			{
				idx:"2"
			},
			function(res){
				$(".result").text(res.name);
				$(".result").append(res.age);
			},//func
			"json"
		);
	});//smBtn2
	
	$(".smBtn3").click(function(){//ajax2, ajax3버튼 클릭시(페이지전환(=템플릿가능))
		$.post(//post형식으로 보낸다.
			"changePage",//컨트롤러의 /chagePage 로 보낸다.
			{
				pagename:$(this).text()//파라미터 pagename에 ajax2 또는 ajax3을 보낸다(클릭한 게 보내진다.)
			},
			function(res){
				$(".result").html(res);//성공시 result 클래스 div에 페이지 전체를 불러온다.
			}//func
		);
	});//smBtn3
	
	//게시판
	$(".smBtn4").click(function(){
		$.ajax({
				url:"board_main",
				type:"post",
				dataType:"text",
				success:function(data){
					$(".result").html(data);
				}
		});//ajax
	})//smBtn4
	
	//로또번호뽑기
	$(".smBtn5").click(function(){
		$.ajax({
				url:"random_main",
				type:"get",
				dataType:"text",
				success:function(data){
					$(".result").html(data);
				}
		});//ajax
	})//smBtn5
	
	//슬메론
	$(".smBtn6").click(function(){
		$.ajax({
				url:"loan_main",
				type:"get",
				dataType:"text",
				success:function(data){
					$(".result").html(data);
				}
		});//ajax
	})//smBtn6
	
	//회원가입
	$(".smBtn7").click(function(){
		$.ajax({
				url:"member_join",
				type:"get",
				dataType:"text",
				success:function(data){
					$(".result").html(data);
					$("input[name=mem_id]").focus();
				}
		});//ajax
	})//smBtn7
	
	//로그인 창
	$(".smBtn8").click(function(){
		$(".loginDiv").show();
		$(".loginDiv input[name=mem_id]").focus();
	})//smBtn8
	
	//패스워드에서 enter 시 -> 로그인버튼 클릭()
	$("input[name=mem_pw]").on("keydown",function(e){
		if (e.keyCode==13) {
			$(".loginsmBtn").click();
		}
	})
	
	//로그인창에서 esc 시 -> 닫기
	$(".loginDiv").on("keydown",function(e){
		if(e.keyCode==27){
			$(".loginCancelsmBtn").click();
		}
	})
	
	//로그인 버튼
	$(".loginsmBtn").click(function(){
		var data=$("#loginForm").serialize();
		$.ajax({
				url:"member_login",
				type:"post",
				dataType:"json",
				data:data,
				success:function(data){
					$(".loginResultSpan").text(data.say);
					$(".smBtn9").css("display","inline-block");//로그아웃버튼 활성화
					if(data.result=="1"){//로그인성공시
						$(".smBtn7").hide();//회원가입버튼 감춤
						$(".smBtn8").hide();//로그인버튼 감춤
						$(".loginDiv input").val("");//아뒤비번 지움
						$(".loginDiv span").text("");//상태지움
						$(".loginDiv").hide();//self 감춤
					}//if
				},
				error:function(jqXHR){
					$(".result").html(jqXHR.status+"<br>"+jqXHR.responseText);
				}
		});//ajax
	})//loginsmBtn
	
	//로그인 취소
	$(".loginCancelsmBtn").click(function(){
		$(".loginDiv").hide();
	})//loginsmBtn
	
	//로그아웃
	$(".smBtn9").click(function(){
		$.ajax({
				url:"member_logout",
				type:"get",
				dataType:"json",
				success:function(data){
					$(".smBtn7").css("display","inline-block");//회원가입버튼 활성화
					$(".smBtn9").hide();//로그아웃버튼 감춤
					$(".smBtn8").css("display","inline-block");//로그인버튼 활성화
				}
		});//ajax
	})//smBtn9
	
});
</script>
</head>
<body>
<div class="smBtnGroup">
<img src="resources/img/militaryMae.png" class="militaryMae">
	<div class="smBtn smBtn1">버튼1</div>
	<div class="smBtn smBtn2">버튼2</div>
	<div class="smBtn smBtn3">ajax2</div>
	<div class="smBtn smBtn3">ajax3</div>
	<div class="smBtn smBtn4">게시판</div>
	<div class="smBtn smBtn5">
		<img src="resources/img/pigBG.png" class="pigBG">
		<span class="mainTitle">로또번호뽑기</span>
	</div>
	<div class="smBtn smBtn6">
		<img src="resources/img/smloan.png" class="smloan">
		<span class="mainTitle">슬메론</span>
	</div>
	<c:choose>
		<c:when test="${mem_id.equals('guest') }">
			<div class="smBtn smBtn7">회원가입</div>
			<div class="smBtn smBtn8">로그인</div>
			<div class="smBtn smBtn9" style="display:none;">로그아웃</div>
		</c:when>
		<c:otherwise>
			<div class="smBtn smBtn7" style="display:none;">회원가입</div>
			<div class="smBtn smBtn8" style="display:none;">로그인</div>
			<div class="smBtn smBtn9">로그아웃</div>
		</c:otherwise>	
	</c:choose>
</div>
<div class="loginDiv">
	<fieldset class="loginField">
		<legend>로그인</legend>
		<form method="post" id="loginForm">
			<div class="login_title">아이디 : </div><input type="text" name="mem_id" style="width:150px;"><p>
			<div class="login_title">패스워드 : </div><input type="password" name="mem_pw" style="width:150px;"><p>
		</form>
		<center>
			<span class="loginResultSpan"></span><br>
			<button class="loginsmBtn" style="width:100px">로그인</button>&nbsp;
			<button class="loginCancelsmBtn" style="width:100px">취소</button>
		</center>
	</fieldset>
</div>
<div class="result">
	<img src="resources/img/aboveTheMoney.png" class="aboveTheMoney">
</div>

</body>
</html>