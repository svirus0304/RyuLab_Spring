<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ryu Lab</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
.btnGroup {
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
.btn {
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
.btnWrap{
	width: 100px;
	height: 50px;
	display:inline-block;
}
.btn:hover {
	cursor: pointer;
	background-color: white;
}
.btn5{
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
/* ---------------------------------------------------------- */
.militaryMae{
	width:150px;
	margin-top:-20px;;
	margin-left:-150px;;
	position:absolute;
}
.aboveTheMoney{
	margin-top:80px;
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
	
	$(".btn1").click(function(){//버튼1 클릭 시
		$(".result").html("<img src='resources/img/aboveTheMoney.png' class='aboveTheMoney'>")
	});//btn1
	
	$(".btn2").click(function(){//버튼2 클릭시
		$.get(
			"json",
			{
				idx:"2"
			},
			function(res){
				$(".name").text(res.name);
				$(".age").text(res.age);
			},//func
			"json"
		);
	});//btn2
	
	$(".btn3").click(function(){//ajax2, ajax3버튼 클릭시(페이지전환(=템플릿가능))
		$.post(//post형식으로 보낸다.
			"changePage",//컨트롤러의 /chagePage 로 보낸다.
			{
				pagename:$(this).text()//파라미터 pagename에 ajax2 또는 ajax3을 보낸다(클릭한 게 보내진다.)
			},
			function(res){
				$(".result").html(res);//성공시 result 클래스 div에 페이지 전체를 불러온다.
			}//func
		);
	});//btn3
	
	$(".btn4").click(function(){
		$.ajax({
				url:"board_main",
				type:"get",
				dataType:"text",
				success:function(data){
					$(".result").html(data);
				}
		});//ajax
	})//btn4
	
	$(".btn5").click(function(){
		$.ajax({
				url:"random_main",
				type:"get",
				dataType:"text",
				success:function(data){
					$(".result").html(data);
				}
		});//ajax
	})//btn4
	
	$(".btn6").click(function(){
		$.ajax({
				url:"loan_main",
				type:"get",
				dataType:"text",
				success:function(data){
					$(".result").html(data);
				}
		});//ajax
	})//btn4
	
});
</script>
</head>
<body>
<div class="btnGroup">
<img src="resources/img/militaryMae.png" class="militaryMae">
	<div class="btn btn1">버튼1</div>
	<div class="btn btn2">버튼2</div>
	<div class="btn btn3">ajax2</div>
	<div class="btn btn3">ajax3</div>
	<div class="btn btn4">게시판</div>
	<div class="btn btn5">
		<img src="resources/img/pigBG.png" class="pigBG">
		<span class="mainTitle">로또번호뽑기</span>
	</div>
	<div class="btn btn6">
		<img src="resources/img/smloan.png" class="smloan">
		<span class="mainTitle">슬메론</span>
	</div>
</div>
<div class="result">
	<img src="resources/img/aboveTheMoney.png" class="aboveTheMoney">
</div>

</body>
</html>