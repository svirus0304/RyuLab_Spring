$(document).ready(function(){

	
	///////////////////////////////////////////////////////////////////////////
	
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