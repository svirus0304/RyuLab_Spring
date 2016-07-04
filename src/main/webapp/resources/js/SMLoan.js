$(document).ready(function(){
	//-------------------------------------------------------------------------------------------------------------------------
	function toggleCheck(obj,trIndex,tdIndex){
		console.log("--------------------------- toggleCheck ---------------------------");
		var $trList=$(".table tr");
		var status=obj.prop("checked");
		 console.log("$trList.length : "+$trList.length+" / status : "+status+" / trIndex : "+trIndex+" / tdIndex : "+tdIndex);
		for(var i=parseInt(trIndex);i<$trList.length;i++){//밑으로 다 적용
			var $checkBox=$trList.eq(i).find("input[name=attend]:eq("+tdIndex+")");
			$checkBox.prop("checked",status);
			var $attendSpan=$trList.eq(i).find(".attendSpan:eq("+tdIndex+")");
			var $deductSelect=$trList.eq(i).find("select[name=deductSelect]:eq("+tdIndex+")");
			var $onePlaceResult=$trList.eq(i).find(".onePlaceResult:eq("+tdIndex+")");
			if($checkBox.prop("checked")==true){//참석시
				$attendSpan.text("(참석)").css("color","green");
				setDeductSelDisable($deductSelect,false);//공제선택enable
			}else{//불참시
				$attendSpan.text("(불참)").css("color","gray");
				$onePlaceResult.text("");//결과span 내용 지운다.
				setDeductSelDisable($deductSelect,true);//공제선택disable
			}//else
		}//for
	}//toggleCheck
	
	//-------------------------------------------------------------------------------------------------------------------------
	function ssom(trIndex){
		console.log("--------------------------- ssom ---------------------------");
		var $tr=$(".table tr").eq(trIndex);//해당tr
		var $treat=$tr.find("input[name=treat]");//'쏨'checkbox
		var $deductSelect=$tr.find("select[name=deductSelect]");//공제유형
		var $attend=$tr.find("input[name=attend]");//참석여부
		
		var price=$tr.find("input[name=placePay]").val();//1차금액
		var n=$tr.find("input[name=attend]:checked").length;//참석인원
		var $deductAmount=$tr.find("input[name=deductAmount]");//공제금액
		var $payerSelect=$tr.find("select[name=payerSelect]:eq("+(trIndex-2)+")");//결제자
		var payerIdx=$payerSelect.find(":selected").index()-1;//결제자 index
		var test=$tr.text();
		console.log("trdIndex : "+trIndex+" /payerIdx : "+payerIdx+"/ price : "+price+" / n : "+n+" / text() : "+test);
		if($treat.prop("checked")==true){//쏨 true
			//공제 - "쏘임공제"로 바꾸기
			$deductSelect.each(function(itemIndex){//공제유형들 돌리기 대기
				if($attend.eq(itemIndex).prop("checked")==true){//참석자라면
					$(this).val("쏘임공제");
					setDeductSelDisable($(this),false,trIndex);
					//공제금액 자동으로 적어주기
					$deductAmount.val(price/n);(price/n)+"-"+(price/n)+"<br>= "+(price/n)-(price/n)
				}//if
			})//each
			//결제자 다시 세팅 - attend-check,deductSelect-공제: 없음
			$deductSelect.eq(payerIdx).val("공제: 없음");
			setDeductAmoDisable($deductSelect.eq(payerIdx),trIndex);
		}else{//쏨 false
			//"공제: 없음"로 바꾸기
			$deductSelect.each(function(itemIndex){
				$(this).val("공제: 없음");
				setDeductAmoDisable($(this),trIndex);
			})//each
		}//else
		nBbang(trIndex);//n빵
	}//ssom

	//-------------------------------------------------------------------------------------------------------------------------
	function setDeductSelDisable(obj,status,trIndex){
		console.log("--------------------------- setDeductSelDisable ---------------------------");
		console.log("setDeductSelDisable1 - obj : "+obj+" / status"+status);
		if(status==true){
			obj.val("공제: 없음");
		}//if
		obj.prop("disabled",status);
		setDeductAmoDisable(obj,trIndex);
	}//setDeductDisable
	
	//-------------------------------------------------------------------------------------------------------------------------
	function setDeductAmoDisable(selObj,trIndex){
		console.log("--------------------------- setDeductAmoDisable ---------------------------");
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
		}//else
	}//setDeductDisable
	
	//-------------------------------------------------------------------------------------------------------------------------
	//nBbang stage당 n빵 계산 [.nBbangTd / .nBbangDiv / .table tr]
	function nBbang(trIndex){
		console.log("--------------------------- nBbang ---------------------------");
		//해당 행
		var $tr=$(".table tr:eq("+trIndex+")");
		//금액(placePay)
		var placePay=$tr.find("input[name=placePay]").val();
		//쏨여부 true - n=1 / false - n=checkList.length
		var n=$tr.find("input[name=attend]:checked").length;
		var treat=$tr.find("input[name=treat]").prop("checked");
		var $per=$tr.find(".per");//"각"->"혼자"
		var $thanks=$tr.find(".thanks");//"각"->"혼자"
		var payer=$tr.find("select[name=payerSelect]").val();//결제자
		if(treat==true){//'쏨' 일때	
			$per.text(payer+"♥");
			$thanks.text(payer+"잘뭇다!!");
		}else{//'안쏠때'
			$per.text("각");
			$thanks.text("");
		}//else
		
		//공제정산 deductSum/(n-notDeductNum) [총 공제액 / 공제:없음인 사람들 수]
		console.log("placePay : "+placePay+" / n : "+n+" / treat : "+treat+" / payer : "+payer);
		var deductSum=0;
		var notDeductNum=0;
		var $deductSelect=$tr.find("select[name=deductSelect]");
		$deductSelect.each(function(itemIndex){
			var $deductAmount=$(this).parent().find("input[name=deductAmount]");
			var $attend=$(this).parent().find("input[name=attend]");
			if($(this).val()!="공제: 없음"){//공제받는 사람 공제액 합산
				 deductSum+=parseInt($deductAmount.val());
			}//if
			if($attend.prop("checked")==true && $(this).val()=="공제: 없음"){//참석자중 '공제:없음' 일때
			notDeductNum+=1;
			}//if
		})//each
		
		console.log("deductSum : "+deductSum+" / notDeductNum : "+notDeductNum);
		//n빵에 뿌리기
		var result=(placePay/n)+(deductSum/notDeductNum);
		if(deductSum>0){//공제 있을 시 식 적어주기
			$tr.find(".formula").text((placePay/n)+"+"+(deductSum/notDeductNum)+"=");
		}else{//공제 없을 시 식 삭제
			$tr.find(".formula").text("");
		}//else
		$tr.find(".nBbangSpan").text(result);//n빵에 가격 적어주기
		onePlaceResult(trIndex);//공제부분으로 넘어가기
		console.log("--------------------------- nBbang END---------------------------");
	}//nBbang()
	
	//-------------------------------------------------------------------------------------------------------------------------
	//onePlaceResult 1차 정산
	function onePlaceResult(trIndex){
		console.log("--------------------------- onePlaceResult ---------------------------");
		console.log("onePlaceResult - trIndex : "+trIndex);
		var $tr=$(".table tr:eq("+trIndex+")");
		var $deductSelect=$tr.find("select[name=deductSelect]");
		var n=$tr.find("input[name=attend]:checked").length;//참석자 수
		$deductSelect.each(function(itemIndex){
			var $checkBox=$tr.find("input[name=attend]:eq("+itemIndex+")");//참석여부
			var $onePlaceResult=$tr.find(".onePlaceResult:eq("+itemIndex+")");//결과표시하는곳
			var price=parseInt($tr.find("input[name=placePay]").val());//총액
			var deductAmount=parseInt($tr.find("input[name=deductAmount]:eq("+itemIndex+")").val());//공제액
			var $treat=$tr.find("input[name=treat]");//쏨여부
			var resultPrice=parseInt($tr.find(".nBbangSpan").text());
			//"쏨"일때 - 똑같노?
			if($treat.prop("checked")==true){
				if($(this).val()=="공제: 없음"){//공제:없음 일때 (결제자(쏜사람))
					$onePlaceResult.text(resultPrice+"원");
				}else{//공제받는놈들
					$onePlaceResult.html((price/n)+"-"+deductAmount+"<br>="+((price/n)-deductAmount)+"원");
				}//else
			//"쏨" 아닐때
			}else if($treat.prop("checked")==false){
				if($(this).val()=="공제: 없음"){//공제: 없음 일때
					$onePlaceResult.text(resultPrice+"원");
				}else{//공제받는놈들
					$onePlaceResult.html((price/n)+"-"+deductAmount+"<br>="+((price/n)-deductAmount)+"원");
				}//else
			}//elseif
			//'불참'이면 onePlaceResult 에 결과 지우기
			if($checkBox.prop("checked")==false){
				$onePlaceResult.text("");
			}//if
		})//each
	}//onePlaceResult()
	////////////////////////////////////////////////////////////////////////////
	
	//stage 높이 자동설정 (floatRight에 맞춰)
	$(".table .placeTd .stage").css("height",$(".table .placeTd .floatRight").css("height"));
	//floatRight input 길이 자동설정(select에 맞춰)
	$(".table .placeTd .floatRight input").css("width",$(".table .placeTd .floatRight select[name=payerSelect]").css("width"));
	//floatRight input focus 시 자동 select
	$("input").on("focus",function(){
		$(this).select();
	})//onfocus
	
	//결제자 선택 시 나머지 결제자(밑으로만) 모두 바뀌게
	$("select[name=payerSelect]").each(function(itemIndex){//select 대기(index 얻기 위함)
		var trIndex=itemIndex+2;
		$(this).on("change",function(){//한개가 바뀌었을때
			/*var test=$(this).find(":selected").index();//젤 간편(밑에 두개도 됨)
			/*var test=$(this).find("option").index($(this).find(":selected"));*/
			/*var test=$("select[name=payerSelect] :selected").index();*/
			var list=$("select[name=payerSelect]");
			var payer=$(this).val();
			for (var i=itemIndex; i < list.length; i++) {
				list.eq(i).val(payer);
			}//for
			ssom(trIndex);
		})//onchange
	})//each
	
	//"쏨" 체크시  select[name=deductSelect]-'쏘임공제'로 모두 교체
	$(".table tr").each(function(trIndex){
		var $tr=$(this);
		var $treat=$tr.find("input[name=treat]");
		$treat.on("change",function(){//treat은 1tr에 한개밖에 없어서 each 안해도 되겠지
			ssom(trIndex);
		})//onchange
	})//each
	
	//참석 선택/해제 시 나머지 결제자(밑으로만) 모두 바뀌게
	$(".table tr").each(function(trIndex){
		var $checkBox=$(this).find("input[name=attend]");
		$checkBox.each(function(tdIndex){
			$(this).on("change",function(){
				toggleCheck($(this),trIndex,tdIndex);
				nBbang(trIndex);
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
		$deductAmount=$(this).find("input[name=deductAmount]");
		$deductAmount.each(function(itemIndex){
			$(this).on("keyup",function(e){
				nBbang(trIndex);
			})//onchange
		})//each
	})//each
	
	//stage당 회식비 입력시(keyup)마다 nBbang 호출
	$(".table tr").each(function(trIndex){
			$(this).find("input[name=placePay]").on("keyup",function(e){
				nBbang(trIndex);
			})//onkeyup
	})//each
	
})//ready