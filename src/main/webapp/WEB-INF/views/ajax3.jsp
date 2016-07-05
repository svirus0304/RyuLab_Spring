<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//code.jquery.com/jquery-latest.min.js"></script>
<style>
.result1{
}
.result2{
}
</style>
<script>
$(document).ready(function(){
	//통화표시만들기
	function toCurrency(num){
		return Number(num).toLocaleString();
	}//toCurrency
	//통화->숫자로 바꾸기
	function toNum(currency){
		var curArr=currency.split(",");
		var num=0;
		for(var i=0;i<curArr.length;i++){
			num+=curArr[i];
		}//for
		return parseInt(num);
	}//toNum
	var num1=toCurrency(123456789);
	var num2=toNum(num1);
	$(".result1").text(num1);
	$(".result2").text(num2);
})
</script>
</head>
<body>
<h2>숫자->통화표시 만들기</h2>
<div class="result1"></div>
<h2>통화->숫자로 바꾸기</h2>
<div class="result2"></div>
</body>
</html>