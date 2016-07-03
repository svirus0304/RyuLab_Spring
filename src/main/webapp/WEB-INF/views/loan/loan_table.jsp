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
	width:170px;
}
.table .placeTd div{
	text-align: right;
}
.table .placeTd .floatRight{
	float:right;
}
.table .placeTd .stage{
	float:left;
	display: table;
}
.table .placeTd .stageInner{
	display:table-cell;
	font-size:25px;
	vertical-align:middle;
}
.table .placeTd .stageInner .treatDiv{
	font-size:15px;
}
.table .placeTd .stageInner .treatDiv input{
	width:15px;
	height:15px;
}
.nBbangTd{
	width:100px;
}

</style>
<script>
//function들
$(document).ready(function(){
	function toggleCheck(obj,trIndex,tdIndex){
		var $trList=$(".table tr");
		var status=obj.prop("checked");
		/* alert("$trList.length : "+$trList.length+" / status : "+status+" / tdIndex : "+tdIndex); */
		for(var i=trIndex;i<$trList.length;i++){
			var $checkBox=$trList.eq(i).find("input[name=attend]:eq("+tdIndex+")");
			$checkBox.prop("checked",status);
			var $attendSpan=$trList.eq(i).find(".attendSpan:eq("+tdIndex+")");
			var $deductSelect=$trList.eq(i).find("select[name=deductSelect]:eq("+tdIndex+")");
			if($checkBox.prop("checked")==true){
				$attendSpan.text("(참석)").css("color","green");
				setDeductSelDisable($deductSelect,false);
			}else{
				$attendSpan.text("(불참)").css("color","gray");
				setDeductSelDisable($deductSelect,true);
			}//else
		}//for
	}//toggleCheck
	function setDeductSelDisable(obj,status){
		if(status==true){
			obj.val("공제: 없음");
		}
		obj.prop("disabled",status);
		setDeductAmoDisable(obj,obj.parent().find("input[name=deductAmount]"),status);
	}//setDeductDisable
	function setDeductAmoDisable(selObj,obj){
		if(obj==null){obj=selObj.parent().find("input[name=deductAmount]")}
		if(selObj.val()=="공제: 없음"){
			obj.prop("disabled",true);
			obj.val("공제금액(원)");
			obj.parent().find(".onePlaceResult").text("");
			nBbang(trIndex);
		}else {
			obj.prop("disabled",false);
			obj.val("0");
		}
	}//setDeductDisable
	
	//-------------------------------------------------------------------------------------------------------------------------
	
	//stage 높이 자동설정 (floatRight에 맞춰)
	$(".table .placeTd .stage").css("height",$(".table .placeTd .floatRight").css("height"));
	//floatRight input 길이 자동설정(select에 맞춰)
	$(".table .placeTd .floatRight input").css("width",$(".table .placeTd .floatRight select[name=payerSelect]").css("width"));
	//floatRight input focus 시 자동 select
	$("input").on("focus",function(){
		$(this).select();
	})
	
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
	
	//"쏨" 체크시  select[name=deductSelect]-'쏘임공제'로 모두 교체
	$(".table tr").each(function(trIndex){
		var $tr=$(this);
		var $treat=$tr.find("input[name=treat]");
		var $deductSelect=$tr.find("select[name=deductSelect]");
		$treat.on("change",function(){
			if($(this).prop("checked")==true){//쏨 true
				$deductSelect.each(function(){
					$(this).val("쏘임공제");
					setDeductSelDisable($(this),false);//"공제: 없음"으로 바꾸는 메소드
				})//each
			}else{//쏨 false
				$deductSelect.each(function(){
					$(this).val("공제: 없음");
					setDeductAmoDisable($(this), null);
				})//each
			}//else
			nBbang(trIndex);//n빵
		})//onchange
	})//each
	
	//참석 선택/해제 시 나머지 결제자(밑으로만) 모두 바뀌게
	$(".table tr").each(function(trIndex){
		var $checkBox=$(this).find("input[name=attend]");
		$checkBox.each(function(tdIndex){
			$(this).on("change",function(){
				toggleCheck($(this),trIndex,tdIndex);
				nBbang(trIndex);
			});//onchange
		})//checkBox each
	})//tr each
	
	//공제 선택 시 - 공제금액 disable-false
	$(".table select[name=deductSelect]").each(function(){
		$deductSelect=$(this);
		$deductSelect.on("change",function(){
			setDeductAmoDisable($(this), null);
		})//onchange
	})//each
	
	//공제금액 입력 시
	$(".table tr").each(function(trIndex){
		$deductAmount=$(this).find("input[name=deductAmount]");
		$deductAmount.on("keyup",function(e){
			nBbang(trIndex);
		})//onchange
	})//each
	
	//stage당 회식비 입력시(keyup)마다 nBbang 호출
	$(".table tr").each(function(trIndex){
			$(this).find("input[name=placePay]").on("keyup",function(e){
				nBbang(trIndex);
			})//onkeyup
	})//each
	
	//nBbang stage당 n빵 계산 [.nBbangTd / .nBbangDiv / .table tr]
	function nBbang(trIndex){
		//해당 행
		var $tr=$(".table tr:eq("+trIndex+")");
		//금액(placePay)
		var placePay=$tr.find("input[name=placePay]").val();
		//쏨여부 true - n=1 / false - n=checkList.length
		var n=$tr.find("input[name=attend]:checked").length;
		var treat=$tr.find("input[name=treat]").prop("checked");
		if(treat==true){	n=1; }//if
	//공제(deduct)
		//공제아닌사람 불러오기 (select[name=deductSelect].val()=="공제: 없음")
		//공제한사람의 공제금액 불러오기
			//금액disable 아닌사람들 중에 (select[name=deductAmount].is)
			//금액
		$tr.find(".nBbangSpan").text(placePay/n);
		onePlaceResult(trIndex);
	}//nBbang()
	
	function onePlaceResult(trIndex){
		var $tr=$(".table tr:eq("+trIndex+")");
		var $deductSelect=$tr.find("select[name=deductSelect]");
		$deductSelect.each(function(itemIndex){
			if($(this).val()=="공제: 없음"){
				$tr.find(".onePlaceResult:eq("+itemIndex+")").text($tr.find(".nBbangSpan").text()+"원");
			}else{
				var nBbangPrice=parseInt($tr.find(".nBbangSpan").text());
				var deductAmount=parseInt($tr.find("input[name=deductAmount]").val());
				$tr.find(".onePlaceResult:eq("+itemIndex+")").html(nBbangPrice+"-"+deductAmount+"<br>="+(nBbangPrice-deductAmount)+" 원");
			}//else
		})//each
	}//onePlaceResult()
	
})//ready
</script>
</head>
<body>
<table class="table" align="center" border=1 style="width:initial;">
	<tr>
		<td rowspan=2></td>
		<td colspan="${memList.size() }">맴바</td>
		<td rowspan=2 class="nBbangTd">n빵</td>
	</tr>
	<tr>
	<c:forEach var="fors" items="${memList }">
		<td class="nameTd">
			${fors.name}
		</td>
	</c:forEach>
	</tr>
	<c:forEach var="fors" varStatus="status" begin="1" end="${placeNum }">
	<tr>
		<td class="placeTd">
			<div class="stage">
				<div class="stageInner">
					${status.index }차<br>
					<div class="treatDiv">쏨<input type="checkbox" name="treat"></div>
				</div>
			</div>
			<div class="floatRight">
				<div><input type="text" name="placeName" value="장소"></div>
				<div>
					<select name="payerSelect">
						<option>-- 결제자 선택 --</option>
						<c:forEach var="fors" items="${memList }">
							<option>${fors.name}</option>
						</c:forEach>
					</select>
				</div>
				<div><input type="text" name="placePay" value="금액(원)"></div>
			</div>
		</td>
		<c:forEach var="fors" items="${memList }" varStatus="colStatus">
		<td class="member${colStatus.index }"><!-- 열 관리를 위해 열에 클래스 이름을 부여한다. -->
			<input type="checkbox" name="attend" checked="checked" style="width:30px;"><br>
			<span class="attendSpan" style="color:green;font-size:11px;">(참석)</span><br>
			<select name="deductSelect">
				<option>공제: 없음</option>
				<optgroup label="공제사유">
					<option>택시비공제</option>
					<option>대리비공제</option>
					<option>미남공제</option>
					<option>미녀공제</option>
					<option>백수공제</option>
					<option>쏘임공제</option>
				</optgroup>
			</select>
			<input type="text" name="deductAmount" value="공제금액(원)" disabled="disabled"><br>
			<span class="onePlaceResult"></span>
			
		</td>
	</c:forEach>
		<td class="nBbangTd"><div class="nBbangDiv">각 <span class="nBbangSpan">0</span>원</div></td>
	</tr>
	</c:forEach>
</table>
</body>
</html>