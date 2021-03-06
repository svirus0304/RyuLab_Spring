<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>슬메론</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="resources/js/SMLoan.js"></script>
<style>
.table{
	font-size: 14px;
	text-align: center;
	border-collapse: collapse;
	border-color: lightgray;
}
.table input{
	width:100px;
	height:20px;
	font-size:12px;
	text-align: center;
}
.trTitle{
	font-size:18px;
}
.trName{
	font-size:15px;
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
	width:16px;
	height:16px;
}
.nBbangTd{
	width:100px;
}
.nBbangDiv{
	font-size:17px;
}
.desc{
	font-size:12px;
	color: gray;
}
.formula{
	font-size:15px;
}
.thanks{
	color:#FFBB00;
	font-size: 20px;
}
.finalResultTable{
	border-collapse:collapse;
	border-color: lightgray;
	width:100%;
	font-size: 14px;
	text-align: center;
}
.finalResultTable td{
	height:50px;
}
</style>
<script>
$(document).ready(function(){
})
</script>
</head>
<body>
<input type="hidden" name="hidden_memNum" value="${memList.size() }"> 
	<table class="table" align="center" border=1 style="width:initial;">
		<tr class="trTitle">
			<td rowspan=2></td>
			<td colspan="${memList.size() }">맴바</td>
			<td rowspan=2 class="nBbangTd">n빵</td>
		</tr>
		<tr class="trName">
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
					<div><input type="text" name="placePay" value="0"></div>
<!-- 					<div><input type="text" name="placePay" value="금액(원)"></div> -->
				</div>
			</td>
			<c:forEach var="fors" items="${memList }" varStatus="colStatus">
			<td class="member${colStatus.index }" ><!-- 열 관리를 위해 열에 클래스 이름을 부여한다. -->
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
				<span class="oneFormula">  </span><br>
				=<span class="oneResult">0</span>원
			</td>
		</c:forEach>
			<td class="nBbangTd">
				<div class="nBbangDiv">
					<span class="desc"></span><br>
					<span class="formula"></span><br>
					<div class="nBbangDiv">
						<span class="per">각</span><span class="nBbang">0</span>원<br>
					</div>
					<span class="thanks"></span>
				</div>
			</td>
		</tr>
		</c:forEach>
	</table><br>
<div class="finalResultDiv"></div>
</body>
</html>