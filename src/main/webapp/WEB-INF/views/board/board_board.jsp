<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.btnsDiv{
	margin:auto;
}
.pageNum{
	float:left;
}
.writeBtn{
	float:right;
}
.boardTable{
	margin:auto;
	width:100%;
	text-align: center;
	border-collapse: collapse;
}
.trTitle{
	background-color: #E4F7BA;
	height:50px;
}
.trTitle .board_num,.trTitle .board_view{
	font-size: 12px;
}
.board_num{
	width:5%;
}
.board_title{
	width:50%;
}
.board_id{
	width:10%;
}
.board_view{
	width:5%;
}
.board_date{
	width:20%;
}
.pageDiv{
	margin:auto;
	text-align:center;
	background-color: #FFB2D9;
}
</style>
<script>
$(document).ready(function(){
	
	//글쓰기
	function board_write(){
		//@세션id 없으면 빠꾸시키기
		$.ajax({
			url:"board_write",
			type:"post",
			dataType:"text",
			data:{
				//mem_id:mem_id;//@세션id체크
			},
			success:function(data){
				$(".boardDiv").html(data);
			},
			error:function(){alert("ajax에러");}
		})
	}//board_write()
	
/////////////////////////////////////////////////////////////////////////////
	
	//글쓰기 클릭시
	$(".writeBtn").click(function(){
		board_write();
	})//click
	
})//ready
</script>
</head>
<body>
<%-- <p>json_mem : ${json_mem }</p>
<p>json_board : ${json_board }</p> --%>
<div class="btnsDiv">
	<span class="pageNum">page : ${page }</span>
	<span class="writeBtn"><a href="#">글쓰기</a></span>
</div>
<table border=1 class="boardTable">
	<tr class="trTitle">
		<td class="board_num">번호</td>
		<td class="board_title">제목</td>
		<td class="board_id">작성자</td>
		<td class="board_view">조회수</td>
		<td class="board_date">작성일</td>
	</tr>
	<c:forEach var="fors" items="${board_list }">
		<tr class="trItem">
			<td class="board_num">${fors.board_num}</td>
			<td class="board_title"><a href="#">${fors.board_title}</a></td>
			<td class="board_id">${fors.mem_nickname}</td>
			<td class="board_view">${fors.board_view}</td>
			<td class="board_date">${fors.board_date}</td>
		</tr>
	</c:forEach>
</table>
<div class="pageDiv"></div>
</body>
</html>
