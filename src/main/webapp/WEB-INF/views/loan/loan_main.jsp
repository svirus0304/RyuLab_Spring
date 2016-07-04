<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>슬메론</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
.motherDiv{
	text-align:center;
	padding-top: 150px;
	transition:all 0.5s ease-in-out;
}
.groupDiv{
	text-align: center;
	border:1px solid;
	margin:auto;
	background-color: white;
}
.logoDiv{
	width:300px;
	margin:auto;
	display:inline-block;
	text-align: center;
}
.logoDiv img{
	width:300px;
}
.initDiv{
	display:inline-block;
	margin:auto;
	text-align:center;
	font-size: 20px;
}
.initDiv table{
	float:left;
	text-align:center;
	width:300px;
}
.initDiv input{
	text-align: center;
	font-size: 15px;
	width: 50px;
	height: 30px;
}
.initDiv input[name=member]{
	text-align: center;
	font-size: 12px;
	width: 300px;
	height:30px;
}
.initDiv .resultDiv{
	height:10px;
	font-size: 10px;
	color: #FF3636;
}

/* fadeIn */
@-webkit-keyframes fadeIn { from { opacity:0; opacity: 1\9; /* IE9 only */ } to { opacity:1; } }
@-moz-keyframes fadeIn { from { opacity:0; opacity: 1\9; /* IE9 only */ } to { opacity:1; } }
@keyframes fadeIn { from { opacity:0; opacity: 1\9; /* IE9 only */ } to { opacity:1; } }

.fade-in {
	opacity:0;  /* make things invisible upon start */
	-webkit-animation:fadeIn ease-in 1;  /* call our keyframe named fadeIn, use animattion ease-in and repeat it only 1 time */
	-moz-animation:fadeIn ease-in 1;
	animation:fadeIn ease-in 1;

	-webkit-animation-fill-mode:forwards;  /* this makes sure that after animation is done we remain at the last keyframe value (opacity: 1)*/
	-moz-animation-fill-mode:forwards;
	animation-fill-mode:forwards;

	-webkit-animation-duration:0.5s;
	-moz-animation-duration:0.5s;
	animation-duration:0.5s;
}
.tableDiv{
	display:none;
}
</style>
<script>
$(document).ready(function(){
	//로고,div 크기조정
	var initDiv_height=parseInt($(".initDiv").css("height").split("px")[0]);
	$(".logoDiv img").css("height",initDiv_height);
	var logoDiv_width=parseInt($(".logoDiv").css("width").split("px")[0]);
	$(".logoDiv").css("width",logoDiv_width);
	var initDiv_width=parseInt($(".initDiv").css("width").split("px")[0]);
	$(".groupDiv").css("width",logoDiv_width+initDiv_width+10);
	//input focus 시 select
	$("input").on("focus",function(){
		$(this).select();
	})
	
	//'확인' 버튼 클릭 시
	$(".initBtn").click(function(){
		var placeNum=$("input[name=placeNum]").val();
		var member=$("input[name=member]").val();
		$.ajax({
			url:"loan_table",
			type:"get",
			dataType:"text",
			data:{
				placeNum:placeNum,
				member:member
			},
			success:function(data){
				$(".motherDiv").css("padding-top","10px");
				$(".tableDiv").css("display","block");
				$(".tableDiv").html("<hr>");
				$(".tableDiv").append(data);
			}//success
		})//ajax
	})//initBtn Click
	
	//placeNum focus
	var $placeNum=$(".initDiv input[name=placeNum]");
	$placeNum.select();
	
	//몇 차 최대수 제한 (10)
	$placeNum.on("keyup",function(){
		$(".initDiv .resultDiv").text("");
		if($(this).val()<1 || $(this).val()>10){
			$(".initDiv .resultDiv").text("최소1차, 최대10차까지 가능하단다.");
			$(this).val(1);
			$(this).select();
		}//if
	})//onkeyup
	
	//enter
	$placeNum.on("keydown",function(e){
		if(e.keyCode==13){
			$(".initDiv input[name=member]").select();
		}//if
	})//onkeydown placeNUM
	var $member=$(".initDiv input[name=member]");
	$member.on("keydown",function(e){
		if(e.keyCode==13){
			$(".initBtn").click();
		}//if
	})//onkeydown member
	
})//ready
</script>
</head>
<body>
<div class="motherDiv">
	<div class="groupDiv">
		<div class="logoDiv">
			<img src="resources/img/logo4.jpg">
		</div>
		<div class="initDiv">
			<table align="center">
				<tr>
					<td>
						몇차까지갔노~ <input type="number" name="placeNum" value=5 min=1 max=10>차
						<div class="resultDiv"></div>
					</td>
				</tr>
				<tr>
					<td>
						모든 참석 인원 이름<br>
						<font size="2">(스페이스로 구분  [ex]슬메 지혜 인석기 식환 왕구 )</font><br>
						<input type="text" name="member" value="슬메 지혜 인석기 식환 왕구">
					</td>
				</tr>
				<tr>
					<td>
						<button class="initBtn">확인</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<div class="tableDiv fade-in"></div>
</body>
</html>