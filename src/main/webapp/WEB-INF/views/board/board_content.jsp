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

<script src="resources/js/board.js"></script>
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
.recmtBtn,.likeBtn,.dislikeBtn:hover{
	cursor:pointer;
}
.cmt_del:hover{
	cursor:pointer;
}
</style>
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
	
	<!-- 댓글쓰기 -->
	<div class="reply_write" style="border:1px solid gray;padding-top: 3px;padding-left: 3px;text-align: center;">
		<div style="text-align:left;padding-left: 15px;">${member_dto.mem_nickname }(<span id="comment_id">${member_dto.mem_id }</span>)</div>
		<textarea rows="3" cols="100" style="resize:none;width:99%;" class="comment_content"></textarea>
		<div style="text-align:right;border-top:1px solid lightgray;">
			<button type="button" class="btn btn-default btn-sm" id="reply_reg_btn">등록</button>
		</div>
	</div>	
	
	<!-- 	댓글들 -->
	<hr style="border-color:lightgray;">
	<c:forEach var="fors" items="${comment_list }">
		<c:choose>
			<c:when test="${fors.comment_parent_index==0 }">
				<div>
					<div>
						<input type="hidden" name="comment_index" value="${fors.comment_index}">
						<i class="fa fa-user" aria-hidden="true">${fors.mem_nickname }(${fors.comment_id })</i>
						<!-- 만약 세션id와 같으면 '삭제'버튼 생기게 -->
						<c:if test="${!sessionID.equals('guest') && sessionID.equals(fors.comment_id) }">
							<div class="cmt_del" style="width:40px;float:right;text-align: center;border:1px solid lightgray;">
								삭제
							</div>
						</c:if>
						<br><br>
						&nbsp;${fors.comment_content }<br><br>
						<span style="color:gray;">${fors.comment_date }</span><br>
						<div class="recmtBtn" style="border: 1px solid lightgray;width:60px;padding:2px;float:left;text-align: center;">답글(<span class="recmt_num">${fors.comment_recmt_count }</span>)</div>
						<div class="dislikeBtn" style="border: 1px solid lightgray;width:50px;padding:2px;float:right;text-align: center;">
							<i class="fa fa-thumbs-o-down" aria-hidden="true"></i>
							<span class="dislikeSpan">${fors.comment_dislike }</span>
						</div>
						<div class="likeBtn" style="border: 1px solid lightgray;width:50px;padding:2px;float:right;text-align: center;">
							<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
							<span class="likeSpan">${fors.comment_like }</span>
						</div><br>
					</div>
					<hr style="border-color:lightgray;">
					
					<!-- 대댓 -->
					<div class="recmtDiv" style="display:none;background-color: #FCFCFC;padding-left:30px;margin-top:-20px;padding-top:20px;">
						
						<!-- 대댓들보기 -->
						<c:forEach var="fors2" items="${comment_list }" varStatus="status">
							<c:if test="${fors2.comment_parent_index == fors.comment_index}">
								<div>
									<input type="hidden" name="comment_index" value="${fors2.comment_index}">
									<i class="fa fa-user" aria-hidden="true">${fors2.mem_nickname }(${fors2.comment_id })</i><br><br>
									&nbsp;${fors2.comment_content }<br><br>
									<span style="color:gray;">${fors2.comment_date }</span>
									<div class="dislikeBtn" style="border: 1px solid lightgray;width:50px;padding:2px;float:right;text-align: center;">
										<i class="fa fa-thumbs-o-down" aria-hidden="true"></i>
										<span class="dislikeSpan">${fors2.comment_dislike }</span>
									</div>
									<div class="likeBtn" style="border: 1px solid lightgray;width:50px;padding:2px;float:right;text-align: center;">
										<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
										<span class="likeSpan">${fors2.comment_like }</span>
									</div><br>
								</div>
								<hr style="border-color:lightgray;">
							</c:if>
						</c:forEach>
						
						<!-- 대댓달기 -->
						<div class="reply_write" style="border:1px solid gray;padding-top: 3px;padding-left: 3px;text-align: center;">
						<div style="text-align:left;padding-left: 20px;">${member_dto.mem_nickname }(<span id="comment_id">${member_dto.mem_id }</span>)</div>
							<textarea rows="3" cols="100" style="resize:none;width:99%" class="comment_content"></textarea>
							<div style="text-align:right;border-top:1px solid lightgray;">
								<button type="button" class="btn btn-default btn-sm recmt_reg_btn">등록</button>
							</div>
						</div>
							
					<hr style="border-color:lightgray;margin-left:-20px;">
					</div>
				<!--  -->			
				</div>
			</c:when>
		</c:choose>
	</c:forEach>
	
	
</div>
</body>
</html>