<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ryu Lab</title>
<script type="text/javascript" src="//code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
.btnGroup2 {
	border-radius:20px 20px 0px 0px;
	margin:auto;
	width:80%;
	height:60px;
	text-align: center;
	background-color:#F6F6F6;
	
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
.btn:hover {
	cursor: pointer;
	background-color: white;
}
.btn5{
	width:120px;
}

.result {
	border-radius:0px 0px 20px 20px;
	overflow:auto;
	width: 80%;
	height: 550px;
	background-color: lightyellow;
	margin:auto;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	$(".btn1").click(function(){//버튼1 클릭 시
		$.get(//get 방식으로 ajax 사용
			"json",//컨트롤러의 /json로 보낸다.
			{
				idx:"1"//idx라는 파라미터를 1로 보내준다.
			},//-> 컨트롤러의 /json으로 넘어간다
			function(res){//컨트롤러 갔다와서 성공시 할 행동들.
				$(".name").text(res.name);//name클래스 div에 json.jsp에서 불러온 name을 적는다.
				$(".age").text(res.age);//age클래스 div에 json.jsp에서 불러온 age를 적는다.
			},
			"json"//json 형태로 불러온다. ("text"(기본) / "json" / "xml") - 주로 json 쓴다. / 페이지 전체 불러오려면 text로 불러와야된다.
		);
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
<div class="btnGroup2">
	<div class="btn btn1">버튼1</div>
	<div class="btn btn2">버튼2</div>
	<div class="btn btn3">ajax2</div>
	<div class="btn btn3">ajax3</div>
	<div class="btn btn4">게시판</div>
	<div class="btn btn5">랜덤숫자만들기</div>
</div>
<div class="result">
이름 : <span class="name">${name }</span><br>
나이 : <span class="age">${age }</span><br>
</div>

</body>
</html>