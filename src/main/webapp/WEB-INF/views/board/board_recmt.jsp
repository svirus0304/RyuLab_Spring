<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>        
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="resources/js/board.js"></script>
<!-- 대댓들보기 -->
<c:forEach var="fors2" items="${comment_list }" varStatus="status">
	<c:if test="${fors2.comment_parent_index == comment_parent_index}">
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