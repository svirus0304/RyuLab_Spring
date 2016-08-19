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
.trItem td{
	padding: 5px;
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
	background-color: none;
}
.currPage{
	font-size: 25px;
	font-style: bold;
	color:red;
}
</style>
<script>
$(document).ready(function(){
	//제목 정렬
	$(".board_title:gt(0)").css("text-align","left").css("padding-left","20px");
	///////////////////////////////////////////////////////////
	
	//글쓰기
	function board_write(){
		//@세션id 없으면 빠꾸시키기 -> GUEST 로 쓰기
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
	
	//제목 클릭 시
	function board_content(board_num,page){
		
		$.ajax({
			url:"board_content",
			type:"post",
			dataType:"text",
			data:{
				board_num:board_num,
				page:page
			},
			success:function(res){
				$(".boardDiv").html(res);
			},
			error:function(jqXHR){
				$(".boardDiv").html(jqXHR.responseText);
			}
		})
	}//board_view
	
	function board_board(page){
		$.ajax({
			url:"board_board",
			type:"post",
			dataType:"text",
			data:{
					page:page
					},
			success:function(data){
				$(".boardDiv").html(data);
			},
			error:function(){alert("에러");}
		});//ajax
	}
/////////////////////////////////////////////////////////////////////////////
	
	//글쓰기 클릭시
	$(".writeBtn").click(function(){
		board_write();
	})//click
	
	//제목 클릭시 -> 내용 보러 ㄱ
	$(".board_title a").click(function(){
		var board_num=$(this).parent().parent().find(".board_num").text();
		var page=$("#page").text();
		board_content(board_num,page);
	})
	
	//페이지번호 클릭시
	$(".pageA").click(function(){
		var page=$(this).text();
		board_board(page);
	})
	
})//ready
</script>
</head>
<body>
<%-- <p>json_mem : ${json_mem }</p>
<p>json_board : ${json_board }</p> --%>
<div class="btnsDiv">
	<span class="pageNum">page : &nbsp;</span><span class="pageNum" id="page">${page }</span>
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
	<c:forEach var="fors" items="${board_list }" varStatus="status">
		<tr class="trItem">
			<td class="board_num">${fors.board_num}</td>
			<td class="board_title">
				<a href="#">${fors.board_title}</a>
				<c:if test="${comment_count[status.index] != 0 }"> 
					<span style="">&nbsp;(${comment_count[status.index] })</span>
				</c:if>
			</td>
			<td class="board_id">${fors.mem_nickname}</td>
			<td class="board_view">${fors.board_view}</td>
			<td class="board_date">${fors.board_date}</td>
		</tr>
	</c:forEach>
</table>
<div class="pageDiv">
	<c:forEach begin="1" end="${pagingDTO.totalBlock }" varStatus="idx">
		<c:choose>
			<c:when test="${idx.count==pagingDTO.currPage }">
				<span>[</span>
				<a class="pageA currPage" href="#">${idx.count}</a>
				<span>]</span>
			</c:when>
			<c:otherwise>
				<span>[</span>
				<a class="pageA" href="#">${idx.count}</a>
				<span>]</span>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</div>
</body>
</html>
