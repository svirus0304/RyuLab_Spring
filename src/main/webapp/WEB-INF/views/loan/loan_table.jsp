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
.table{
	font-size: 14px;
	text-align: center;
	border-collapse: collapse;
	border-bottom: lightgray;
}
.table input{
	width:100px;
	height:20px;
	font-size:12px;
	text-align: center;
}
.table .nameTd{
	width:50px;
}
.table .placeTd{
	text-align: center;
}
</style>
<script>
$(document).ready(function(){
	
	//결제자 선택 시 나머지 결제자(밑으로만) 모두 바뀌게
	$("select[name=payerSelect]").each(function(index){//select 대기(index 얻기 위함)
		$(this).on("change",function(){//한개가 바뀌었을때
			var list=$("select[name=payerSelect]");
			var payer=$(this).val();
			for (var i=index; i < list.length; i++) {
				list.eq(i).val(payer);
			}//for
		})//onchange
	})//each
	
	//체크선택/해제 시 나머지 결제자(밑으로만) 모두 바뀌게
	$(".table tr").each(function(trIndex){
		var trList=$(".table tr");
		$(this).find("td").each(function(tdIndex){
			var checkBox=$(this).find("input[name=attend]");
			checkBox.click(function(){
				var status=$(this).prop("checked");
				for(var i=trIndex;i<trList.length;i++){
					var checkBox=trList.eq(i).find("td:eq("+tdIndex+")").find("input[name=attend]");
					var attendSpan=trList.eq(i).find("td:eq("+tdIndex+")").find(".attendSpan");
					checkBox.prop("checked",status);
					if(checkBox.prop("checked")==true){
						attendSpan.text("(참석)").css("color","green");
					}else{
						attendSpan.text("(불참)").css("color","gray");
					}//else
					
				}//for
			})//click
			
		})//td each
	})//tr each
	
	/* //체크선택/해제 시 '참가''불참' 바뀌게
	var checkBox=$(".table input[name=attend]");
	checkBox.each(function(){
		$(this).on("change",function(){
			if($(this).prop("checked")==true){
				$(this).parent().find(".attendSpan").text("(참석)");
			}else{
				$(this).parent().find(".attendSpan").text("(불참)");
			}//else
		})//onchange
	})//each */
	
	
})//ready
</script>
</head>
<body>
총 몇차? : ${placeNum}<br>
맴바 : ${member }<br>
<table class="table" align="center" border=1 style="width:initial;">
	<tr>
		<td></td>
	<c:forEach var="fors" items="${memList }">
		<td class="nameTd">
			${fors.name}
		</td>
	</c:forEach>
	</tr>
	<c:forEach var="fors" varStatus="status" begin="1" end="${placeNum }">
	<tr>
		<td class="placeTd">
			<div>${status.index }차</div>
			<div>장소 : <input type="text" name="placeName"></div>
			<div>
				<select name="payerSelect">
					<option>-- 결제자 선택 --</option>
					<c:forEach var="fors" items="${memList }">
						<option>${fors.name}</option>
					</c:forEach>
				</select>
			</div>
			<div>금액 : <input type="number" name="placePay">원</div>
		</td>
		<c:forEach var="fors" items="${memList }">
		<td>
			<input type="checkbox" name="attend" checked="checked">
			<span class="attendSpan" style="color:green;">(참석)</span>
		</td>
	</c:forEach>
	</tr>
	</c:forEach>
</table>
</body>
</html>