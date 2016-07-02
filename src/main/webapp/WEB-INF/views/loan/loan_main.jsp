<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>슬메론</title>
<style>
.motherDiv{
	text-align:center;
	padding-top: 150px;
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
	width: 100px;
	height: 30px;
}
.initDiv input[name=member]{
	text-align: center;
	font-size: 12px;
	width: 300px;
	height:30px;
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
				$(".tableDiv").html("<hr>");
				$(".tableDiv").append(data);
			}//success
		})//ajax
	})//initBtn Click
	
})//ready
</script>
</head>
<body>
<div class="motherDiv">
	<div class="groupDiv">
		<div class="logoDiv">
			<img src="resources/img/logo.jpg">
		</div>
		<div class="initDiv">
			<table align="center">
				<tr>
					<td>
						총 몇차?<br>
						<input type="number" name="placeNum">
					</td>
				</tr>
				<tr>
					<td>
						모든 참석 인원 이름<br>
						<font size="2">(스페이스로 구분  ex)슬메 지혜 )</font><br>
						<input type="text" name="member">
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
<div class="tableDiv"></div>
</body>
</html>