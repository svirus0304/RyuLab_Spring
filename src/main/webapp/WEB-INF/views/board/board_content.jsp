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
<script type="text/javascript" src="resources/smartEditor/js/HuskyEZCreator.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- 폰트어썸 -->
<script src="https://use.fontawesome.com/a82b5b62b1.js"></script>

<style>
.board_contentTable{
	width:80%;
	margin:auto;
	text-align: center;
	border-collapse: collapse;
}
.board_contentTable td{
	padding:10px;
}
.tdTitle{
	background-color: #FFEBFF;
}
.tdItem.board_content{
	height:300px;
	text-align:left;
	vertical-align: top;
}
.board_contentTable input,.board_contentTable textarea{
	width:100%;
}
</style>
<script>
	// 	초기화 - smartEditor 불러오기
	var oEditors = [];
		
$(document).ready(function(){

	//
	function board_board(page){
		$.ajax({
			url:"board_board",
			type:"post",
			dataType:"text",
			data:{
				page:page
			},
			success:function(res){
				$(".boardDiv").html(res);
			},
			error:function(jqXHR){
				$(".boardDiv").html(jqXHR.responseText);
			}
		})
	}//goBoard_Board()
	///////////////////////////////////////////////
	//수정 버튼
	$("#modifyBtn").click(function(){
		//smartEditor 내용을 textarea로 옮겨준다.
		oEditors.getById["board_content"].exec("UPDATE_CONTENTS_FIELD", []);
		//ajax로 업뎃
		$.ajax({
			url:"board_modify",
			type:"post",
			dataType:"text",
			data:{
				board_num:$(".tdItem.board_num").text(),
				board_title:$("input[name=board_title]").val(),
				board_content:$("#board_content").val()
			},
			success:function(res){
				alert("수정 완료!");
			},
			error:function(jqXHR){
				$(".boardDiv").html(jqXHR.responseText);
			}
		})//ajax
		board_board($("#page").val());
	})
	
	//삭제버튼
	$("#deleteBtn").click(function(){
		var result=confirm("진짜 삭제 하시겠습니까?");
		if(result==true){
			$.ajax({
				url:"board_delete",
				type:"post",
				dataType:"text",
				data:{
					board_num:$(".tdItem.board_num").text()
				},
				success:function(res){
				},
				error:function(jqXHR){
					$(".boardDiv").html(jqXHR.responseText);
				}
			})//ajax
			board_board($("#page").val());
		}//if
	})
	
	//돌아가기 버튼
	$("#goBackBtn").click(function(){
		board_board($("#page").val());
	})
	
})//ready
</script>
</head>
<body>
<input type="hidden" id="page" value="${page }">
<table class="board_contentTable" border=1>
	<tr>
		<td class="tdTitle board_num">번호</td>
		<td class="tdItem board_num">${board_dto.board_num }</td>
		<td class="tdTitle board_id">작성자</td>
		<td class="tdItem board_id">${board_dto.mem_nickname}(${board_dto.board_id })</td>
		<td class="tdTitle board_view">조회수</td>
		<td class="tdItem board_view">${board_dto.board_view }</td>
		<td class="tdTitle board_date">작성일</td>
		<td class="tdItem board_date">${board_dto.board_date }</td>
	</tr>
	<tr>
		<td class="tdTitle board_title">제목</td>
		<td class="tdItem board_title" colspan=7>
			<c:choose>
				<c:when test="${!sessionID.equals('guest') && board_dto.board_id.equals(sessionID) }">
					<input type="text" name="board_title" value="${board_dto.board_title }">
				</c:when>
				<c:otherwise>
					${board_dto.board_title }
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<td class="tdItem board_content" colspan=8>
			<c:choose>
				<c:when test="${!sessionID.equals('guest') && board_dto.board_id.equals(sessionID) }">
					<script>//smartEditor 불러오기
						nhn.husky.EZCreator.createInIFrame({
						    oAppRef: oEditors,
						    elPlaceHolder: "board_content",
						    sSkinURI: "resources/smartEditor/SmartEditor2Skin.html",
						    fCreator: "createSEditor2"
						});
					</script>
					<textarea rows="20" cols="100" id="board_content" name="board_content">
						${board_dto.board_content }
					</textarea>
				</c:when>
				<c:otherwise>
					${board_dto.board_content }
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
</table><br>
<div class="btnDiv">
	<c:if test="${!sessionID.equals('guest') && board_dto.board_id.equals(sessionID) }">
		<button id="modifyBtn">수정</button>
		<button id="deleteBtn">삭제</button>
	</c:if>
	<button id="goBackBtn">돌아가기</button>
</div><br>
<div class="replyDiv" style="width:80%;text-align: left;margin:auto;">
<!-- 	닉네임(아이디),사진, 내용, 시간, 좋아요, 싫어요, 답글 (몇개) -->

	<div class="reply_write" style="border:1px solid gray;padding-top: 3px;padding-left: 3px;">
		아이디<br><br>
		<textarea rows="3" cols="100"></textarea>
		<div style="text-align:right;border-top:1px solid lightgray;">
			<button type="button" class="btn btn-default" style="initial;">등록</button>
		</div>
	</div>	
	<hr style="border-color:gray;">
	<i class="fa fa-user" aria-hidden="true">닉네임(아이디)</i><br><br>
	내용내용내용내용내용<br><br>
	(시간) | 신고<br>
	<div style="border: 1px solid lightgray;width:100px;padding:2px;float:left;">답글(갯수)</div>
	<div style="border: 1px solid lightgray;width:50px;padding:2px;float:right;">
		<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
		(갯수)
	</div>
	<div style="border: 1px solid lightgray;width:50px;padding:2px;float:right;">
		<i class="fa fa-thumbs-o-down" aria-hidden="true"></i>
		(갯수)
	</div>
	
	
</div>
</body>
</html>