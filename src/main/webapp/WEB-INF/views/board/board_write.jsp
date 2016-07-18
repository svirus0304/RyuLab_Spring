<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/smartEditor/js/HuskyEZCreator.js"></script>
<style>
.tableDiv{
	width:740px;
	margin:auto;
}
.boardTable{
	width:100%;
	text-align: center;
}
.boardTable tr{
}
.tdTitle{
	width:10%;
}
.tdTitleText{
	width:90%;
}
input[name=board_title]{
	width:95%;
}
#ir1{
	margin:auto;
}
</style>

<script>
$(document).ready(function(){
	
	//초기화 - smartEditor 불러오기
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "board_content",
	    sSkinURI: "resources/smartEditor/SmartEditor2Skin.html",
	    fCreator: "createSEditor2"
	});
	
	// ‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
// 	function submit(formObj) {
// 	    // 에디터의 내용이 textarea에 적용된다.
// 	    oEditors.getById["board_content"].exec("UPDATE_CONTENTS_FIELD", []);
// 	    // 에디터의 내용에 대한 값 검증은 이곳에서
// 	    // document.getElementById("ir1").value를 이용해서 처리한다.
// 	    alert(formObj.serialize());
// 	    try {
// 	    	formObj.submit();
// 	        // elClickedObj.form.submit();
// 	    } catch(e) {
// 	    	e.printStackTrace();
// 	    }//catch
// 	}//submit
	
	function submit(formObj) {
	    // 에디터의 내용이 textarea에 적용된다.
	    oEditors.getById["board_content"].exec("UPDATE_CONTENTS_FIELD", []);
		$.ajax({
			url:"board_write_save",
			type:"post",
			dataType:"text",
			data:formObj.serialize(),
			success:function(data){
				$(".boardDiv").html(data);
			},
			error:function(jqXHR){alert("ajax에러 : "+jqXHR.status+"\n"+jqXHR.responseText);}
		})//ajax
	}//submit
	
	//////////////////////////////////////////////////
	
	$(".submitBtn").click(function(){
		submit($("#writeForm"));
	})
	
})//ready
</script>

</head>
<body>
<div class="tableDiv">
<form action="board_write_save" method="post" id="writeForm">
	<table class="boardTable">
		<tr>
			<td class="tdTitle">제목 : </td>
			<td class="tdTitleText"><input type="text" name="board_title"></td>
		</tr>		
		<tr>
			<td colspan=2><textarea name="board_content" id="board_content" rows="20" cols="100">내용을 입력하세요.</textarea></td>
		</tr>		
	</table><br>
</form>
	<div class="submitDiv">
		<button class="submitBtn">확인</button>
		<button class="backBtn">돌아가기</button>
	</div>
</div>
</body>
</html>