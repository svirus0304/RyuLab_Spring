$(document).ready(function(){
	function toggleCheck(obj,trIndex,tdIndex){
		console.log("toggleCheck 1");
		var $trList=$(".table tr");
		var status=obj.prop("checked");
		 console.log("$trList.length : "+$trList.length+" / status : "+status+" / trIndex : "+trIndex+" / tdIndex : "+tdIndex);
		for(var i=parseInt(trIndex);i<$trList.length;i++){
		console.log("toggleCheck 2");
			var $checkBox=$trList.eq(i).find("input[name=attend]:eq("+tdIndex+")");
		console.log("toggleCheck 2-2");
			$checkBox.prop("checked",status);
		console.log("toggleCheck 2-3");
			var $attendSpan=$trList.eq(i).find(".attendSpan:eq("+tdIndex+")");
		console.log("toggleCheck 2-4");
			var $deductSelect=$trList.eq(i).find("select[name=deductSelect]:eq("+tdIndex+")");
		console.log("toggleCheck 2-5");
			if($checkBox.prop("checked")==true){
		console.log("toggleCheck 3");
				$attendSpan.text("(참석)").css("color","green");
				setDeductSelDisable($deductSelect,false);
			}else{
		console.log("toggleCheck 4");
				$attendSpan.text("(불참)").css("color","gray");
				setDeductSelDisable($deductSelect,true);
			}//else
		}//for
	}//toggleCheck
	
	function setDeductSelDisable(obj,status,trIndex){
		console.log("setDeductSelDisable1 - obj : "+obj+" / status"+status);
		if(status==true){
		console.log("setDeductSelDisable 2");
			obj.val("공제: 없음");
		}
		console.log("setDeductSelDisable 3");
		obj.prop("disabled",status);
		setDeductAmoDisable(obj,trIndex);
		console.log("setDeductSelDisable 4");
	}//setDeductDisable
	
	function setDeductAmoDisable(selObj,trIndex){
		var obj=selObj.parent().find("input[name=deductAmount]");
		if(selObj.val()=="공제: 없음"){
			obj.prop("disabled",true);
			obj.val("공제금액(원)");
			obj.parent().find(".onePlaceResult").text("");
			nBbang(trIndex);
		}else {
			obj.prop("disabled",false);
			obj.val("0");
			nBbang(trIndex);
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
			var test=$(this).find(":selected").index();//젤 간편(밑에 두개도 됨)
			/*var test=$(this).find("option").index($(this).find(":selected"));*/
			/*var test=$("select[name=payerSelect] :selected").index();*/
			alert(test);
			var list=$("select[name=payerSelect]");
			var payer=$(this).val();
			for (var i=index; i < list.length; i++) {
				list.eq(i).val(payer);
			}//for
		})//onchange
	})//each
	
	//"쏨" 체크시  select[name=deductSelect]-'쏘임공제'로 모두 교체
	$(".table tr").each(function(trIndex){
		var $treat=$(this).find("input[name=treat]");
		var $deductSelect=$(this).find("select[name=deductSelect]");
		var $attend=$(this).find("input[name=attend]");
		$treat.on("change",function(){
			if($(this).prop("checked")==true){//쏨 true
				$deductSelect.each(function(itemIndex){
					if($attend.eq(itemIndex).prop("checked")==true){//참석자라면
						$(this).val("쏘임공제");
						setDeductSelDisable($(this),false,trIndex);
					}//if
				})//each
			}else{//쏨 false
				$deductSelect.each(function(itemIndex){
					$(this).val("공제: 없음");
					setDeductAmoDisable($(this),trIndex);
				})//each
			}//else
			nBbang(trIndex);//n빵
		})//onchange
	})//each
	
	//참석 선택/해제 시 나머지 결제자(밑으로만) 모두 바뀌게
	$(".table tr").each(function(trIndex){
		console.log("참석1");
		var $checkBox=$(this).find("input[name=attend]");
		$checkBox.each(function(tdIndex){
		console.log("참석2");
			$(this).on("change",function(){
		console.log("참석3");
				toggleCheck($(this),trIndex,tdIndex);
				nBbang(trIndex);
		console.log("참석4");
			});//onchange
		})//checkBox each
	})//tr each
	
	//공제 선택 시 - 공제금액 disable-false
	$(".table tr").each(function(trIndex){
		$(this).find("select[name=deductSelect]").each(function(itemIndex){
			$deductSelect=$(this);
			$deductSelect.on("change",function(){
				setDeductAmoDisable($(this),trIndex);
			})//onchange
		})//each
	})//each
	
	//공제금액 입력 시
	$(".table tr").each(function(trIndex){
		console.log("공제금액입력 1- trIndex : "+trIndex);
		$deductAmount=$(this).find("input[name=deductAmount]");
		console.log("공제금액입력 2");
		$deductAmount.each(function(itemIndex){
		console.log("공제금액입력 3");
			$(this).on("keyup",function(e){
		console.log("공제금액입력 4 - trIndex : "+trIndex);
				nBbang(trIndex);
		console.log("공제금액입력 5");
			})//onchange
		})//each
	})//each
	
	//stage당 회식비 입력시(keyup)마다 nBbang 호출
	$(".table tr").each(function(trIndex){
			$(this).find("input[name=placePay]").on("keyup",function(e){
				nBbang(trIndex);
			})//onkeyup
	})//each
	
	//nBbang stage당 n빵 계산 [.nBbangTd / .nBbangDiv / .table tr]
	function nBbang(trIndex){
		console.log("n빵 - trIndex : "+trIndex);
		//해당 행
		var $tr=$(".table tr:eq("+trIndex+")");
		//금액(placePay)
		var placePay=$tr.find("input[name=placePay]").val();
		//쏨여부 true - n=1 / false - n=checkList.length
		var n=$tr.find("input[name=attend]:checked").length;
		var treat=$tr.find("input[name=treat]").prop("checked");
		console.log("n빵 2");
		if(treat==true){	n=1; }//if
		console.log("n빵 3");
		$tr.find(".nBbangSpan").text(placePay/n);
		console.log("n빵 4");
		onePlaceResult(trIndex);//공제부분으로 넘어가기
		console.log("n빵 5");
	}//nBbang()
	
	function onePlaceResult(trIndex){
		console.log("onePlaceResult - trIndex : "+trIndex);
		var $tr=$(".table tr:eq("+trIndex+")");
		var $deductSelect=$tr.find("select[name=deductSelect]");
		console.log("onePlaceResult 2");
		$deductSelect.each(function(itemIndex){
			console.log("onePlaceResult 3");
			if($(this).val()=="공제: 없음"){
				console.log("onePlaceResult 4");
				$tr.find(".onePlaceResult:eq("+itemIndex+")").text($tr.find(".nBbangSpan").text()+"원");
			}else{
				console.log("onePlaceResult 5");
				var nBbangPrice=parseInt($tr.find(".nBbangSpan").text());
				var deductAmount=parseInt($tr.find("input[name=deductAmount]:eq("+itemIndex+")").val());
				$tr.find(".onePlaceResult:eq("+itemIndex+")").html(nBbangPrice+"-"+deductAmount+"<br>="+(nBbangPrice-deductAmount)+" 원");
			}//else
		})//each
		console.log("onePlaceResult END");
	}//onePlaceResult()
	
})//ready