$(document).ready(function(){
	// 	초기화 - smartEditor 불러오기
	var oEditors = [];
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
	//댓글 등록
	function comment_reg(comment_content,comment_parent_index){
		$.ajax({
			url:"board_comment_reg",
			type:"post",
			dataType:"text",
			data:{
				page:$("#page").val(),
				board_num:$(".tdItem.board_num").text(),
				comment_id:$("#comment_id").text(),
			    comment_content:comment_content,
			    comment_parent_index:comment_parent_index
			},
			success:function(res){
				if(comment_parent_index == 0){//댓글이라면
					$(".boardDiv").html(res);
				}else{//대댓이라면
					$("input[name=comment_index]").each(function(idx){
						if($(this).val() == comment_parent_index){
							$(this).parent().parent().find(".recmtDiv").html(res);
						}//if
					})//each
				}//else
			},
			error:function(jqXHR){
				$(".boardDiv").html(jqXHR.responseText);
			}
		})//ajax
	}
	//좋아요
	function comment_like(obj){
		var comment_index=obj.parent().find("input[name=comment_index]").val();
		$.ajax({
			url:"board_comment_like",
			type:"post",
			dataType:"json",
			data:{
				comment_index:comment_index
			},
			success:function(res){
				obj.find(".likeSpan").text(res.result);
			},
			error:function(jqXHR){
				$(".boardDiv").html(jqXHR.responseText);
			}
		})//ajax
	}//
	//싫어요
	function comment_dislike(obj){
		var comment_index=obj.parent().find("input[name=comment_index]").val();
		$.ajax({
			url:"board_comment_dislike",
			type:"post",
			dataType:"json",
			data:{
				comment_index:comment_index
			},
			success:function(res){
				obj.find(".dislikeSpan").text(res.result);
			},
			error:function(jqXHR){
				$(".boardDiv").html(jqXHR.responseText);
			}
		})//ajax
	}//
	//댓글삭제
	function comment_del(comment_index,comment_parent_index){
		$.ajax({
			url:"board_comment_del",
			type:"post",
			dataType:"text",
			data:{
				page:$("#page").val(),
				board_num:$(".tdItem.board_num").text(),
				comment_index:comment_index,
				comment_parent_index:comment_parent_index
			},
			success:function(res){
				if(comment_parent_index==0){//댓글이라면
					$(".boardDiv").html(res);
				}else{//대댓이라면
					$("input[name=comment_index]").each(function(idx){
						if($(this).val() == comment_parent_index){
							$(this).parent().parent().find(".recmtDiv").html(res);
						}//if
					})//each
				}//else
			},
			error:function(jqXHR){
				$(".boardDiv").html(jqXHR.responseText);
			}
		})//ajax
	}
	//
	
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
	//등록 버튼(댓글)
	$("#reply_reg_btn").click(function(){
		var comment_content=$(this).parent().parent().find(".comment_content").val();
// 		alert(comment_content);
		comment_reg(comment_content,0);
	})
	//좋아요 버튼
	$(".likeBtn").click(function(){
		comment_like($(this));
	})
	//싫어요 버튼
	$(".dislikeBtn").click(function(){
		comment_dislike($(this));
	})
	//답글 버튼
	$(".recmtBtn").click(function(){
		$(this).parent().parent().find(".recmtDiv").toggle();
	})//click
	//대댓등록 버튼
	$(".recmt_reg_btn").click(function(){
		var comment_content=$(this).parent().parent().find(".comment_content").val();
		var comment_parent_index = $(this).parent().parent().parent().parent().find("input[name=comment_index]").val();
// 		alert(comment_content+" //////////// "+comment_parent_index);
		comment_reg(comment_content,comment_parent_index);
	})
	//댓글 삭제 버튼
	$(".cmt_del").click(function(){
		var comment_index=$(this).parent().find("input[name=comment_index]").val();
		var comment_parent_index=$(this).parent().parent().parent().parent().find("input[name=comment_index]").val();
		if (comment_index == comment_parent_index) {
			comment_parent_index=0;
		}
		comment_del(comment_index,comment_parent_index);
	})
})//ready