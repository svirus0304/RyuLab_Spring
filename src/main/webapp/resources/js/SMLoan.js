$(document).ready(function(){
	
	//-------------------------------------------------------------------------------------------------------------------------
	//통화표시만들기
	function toCurrency(num){
		return Number(num).toLocaleString();
	}//toCurrency
	//통화->숫자로 바꾸기
	function toNum(currency){
		var curArr;
		try {
			curArr=currency.split(",");
		} catch (e) {
			console.log("[ toNum() 에러1 => currency : 0으로 임시 교체 ] : "+e.message);
			try {
				currency="0";
				curArr=currency.split(",");
			} catch (e) {
				console.log("[ toNum() 에러2 ] : "+e.message);
			}//catch
		}//catch
		var num=0;
		for(var i=0;i<curArr.length;i++){
			num+=curArr[i];
		}//for
		return parseInt(num);
	}//toNum
	//-------------------------------------------------------------------------------------------------------------------------
	function toggleCheck(obj,trIndex,itemIndex){
		console.log("--------------------------- toggleCheck ---------------------------");
		var $trList=$(".table tr");
		var status=obj.prop("checked");
		 console.log("$trList.length : "+$trList.length+" / status : "+status+" / trIndex : "+trIndex+" / itemIndex : "+itemIndex);
		for(var i=parseInt(trIndex);i<$trList.length;i++){//밑으로 다 적용
			console.log(">>>>>>>>>>>>>>>>>> toggleCheck : "+i);
			var $tr=$trList.eq(i);
			var $attend=$tr.find("input[name=attend]:eq("+itemIndex+")");
			$attend.prop("checked",status);//체크박스 상태 바꾼다.
//			alert("toggleCheck : "+$attend.prop("checked"));
			var $attendSpan=$tr.find(".attendSpan:eq("+itemIndex+")");
			var $deductSelect=$tr.find("select[name=deductSelect]:eq("+itemIndex+")");
			var $oneFormula=$tr.find(".oneFormula:eq("+itemIndex+")");
			var $oneResult=$tr.find(".oneResult:eq("+itemIndex+")");
			if($attend.prop("checked")==true){//참석시
				$attendSpan.text("(참석)").css("color","green");
				setDeductSelDisable($deductSelect,false,trIndex);//공제선택enable
			}else{//불참시
				$attendSpan.text("(불참)").css("color","gray");
				setDeductSelDisable($deductSelect,true,trIndex);//공제선택disable
			}//else
		}//for
//		nBbang(trIndex);
	}//toggleCheck
	
	//-------------------------------------------------------------------------------------------------------------------------
	function ssom(trIndex){
		console.log("--------------------------- ssom ---------------------------");
		var $tr=$(".table tr").eq(trIndex);//해당tr
		var $treat=$tr.find("input[name=treat]");//'쏨'checkbox
		var $deductSelect=$tr.find("select[name=deductSelect]");//공제유형
		var $attend=$tr.find("input[name=attend]");//참석여부
		
		var price=toNum($tr.find("input[name=placePay]").val());//1차금액
		var n=$tr.find("input[name=attend]:checked").length;//참석인원
		var $deductAmount=$tr.find("input[name=deductAmount]");//공제금액
		var $payerSelect=$tr.find("select[name=payerSelect]");//결제자
		var payerIdx=$payerSelect.find(":selected").index()-1;//결제자 index
		//결제자 '참석'으로 바꾸기
		$attend.eq(payerIdx).prop("checked",true);
		toggleCheck($attend.eq(payerIdx), trIndex, payerIdx);
		console.log("trIndex : "+trIndex+" /payerIdx : "+payerIdx+"/ price : "+price+" / n : "+n);
		//쏨 true
		if($treat.prop("checked")==true){//
			//공제 - "쏘임공제"로 바꾸기
			$deductSelect.each(function(itemIndex){//공제유형들 돌리기 대기
				if($attend.eq(itemIndex).prop("checked")==true){//참석자라면
					$(this).val("쏘임공제");
					setDeductSelDisable($(this),false,trIndex);
					//공제금액 자동으로 적어주기
					$deductAmount.val(toCurrency((price/n).toFixed(0)));
				}//if
			})//each
			//결제자 다시 세팅 - attend-check,deductSelect-공제: 없음
			$deductSelect.eq(payerIdx).val("공제: 없음");
			setDeductAmoDisable($deductSelect.eq(payerIdx),trIndex);
		}else{//쏨 false
			//"공제: 없음"로 바꾸기 - "쏘임공제" 였다면
			$deductSelect.each(function(itemIndex){
				if($(this).val()=="쏘임공제"){
					$(this).val("공제: 없음");
					setDeductAmoDisable($(this),trIndex);
				}//if
			})//each
		}//else
		nBbang(trIndex);//n빵
	}//ssom

	//-------------------------------------------------------------------------------------------------------------------------
	function setDeductSelDisable(obj,status,trIndex){
//		alert("2 setDeductSelDisable - obj.val() : "+obj.val()+" / status : "+status);
		console.log("--------------------------- setDeductSelDisable ---------------------------");
		console.log("setDeductSelDisable1 - obj.val() : "+obj.val()+" / status : "+status);
		if(status==true){
			obj.val("공제: 없음");
		}//if
		obj.prop("disabled",status);
		setDeductAmoDisable(obj,trIndex);
	}//setDeductDisable
	
	//-------------------------------------------------------------------------------------------------------------------------
	function setDeductAmoDisable(selObj,trIndex){
		console.log("--------------------------- setDeductAmoDisable ---------------------------");
		console.log("selObj.val() : "+selObj.val()+" / trIndex : "+trIndex);
		var $obj=selObj.parent().find("input[name=deductAmount]");
//		alert("3 setDeductAmoDisable - $obj.val() : "+$obj.val()+" / trIndex : "+trIndex);
		var $attend=$obj.parent().find("input[name=attend]");
		if(selObj.val()=="공제: 없음"){
			$obj.prop("disabled",true);
			$obj.val("공제금액(원)");
			$obj.parent().find(".oneFormula").text(" ");
//			$obj.parent().find(".oneResult").text("0");
		}else {
			$obj.prop("disabled",false);
			$obj.val("0");
		}//else
		//'불참'이면 onePlaceResult 에 결과 지우기
		if($attend.prop("checked")==false){
			$obj.parent().find(".oneFormula").text(" ");
			$obj.parent().find(".oneResult").text("0");
		}//if
		nBbang(trIndex);
	}//setDeductDisable
	
	//-------------------------------------------------------------------------------------------------------------------------
	//nBbang stage당 n빵 계산 [.nBbangTd / .nBbangDiv / .table tr]
	function nBbang(trIndex){
//		alert("4 nBbang - trIndex : "+trIndex);
		console.log("--------------------------- nBbang ---------------------------");
		console.log("trIndex : "+trIndex);
		//해당 행
		var $tr=$(".table tr:eq("+trIndex+")");
		//금액(placePay)
		var placePay=toNum($tr.find("input[name=placePay]").val());
		//쏨여부 true - n=1 / false - n=checkList.length
		var n=$tr.find("input[name=attend]:checked").length;
		var treat=$tr.find("input[name=treat]").prop("checked");
		var $per=$tr.find(".per");//"각"->"혼자"
		var $thanks=$tr.find(".thanks");//"각"->"혼자"
		var payer=$tr.find("select[name=payerSelect]").val();//결제자
		if(treat==true){//'쏨' 일때	
			$per.text("♥"+payer+"♥");
			$thanks.text(payer+" 잘뭇다!!");
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
			if($attend.prop("checked")==true){//참석자중
				if($(this).val()!="공제: 없음"){//공제받는 사람 공제액 합산
					deductSum+=toNum($deductAmount.val());
				}//if
				if($(this).val()=="공제: 없음"){//'공제:없음' 일때
					notDeductNum+=1;
				}//if
			}//if
		})//each
		
		console.log("deductSum : "+deductSum+" / notDeductNum : "+notDeductNum);
		//n빵에 뿌리기
		var result=(placePay/n)+(deductSum/notDeductNum);
		if(deductSum>0){//공제 있을 시 식 적어주기
			$tr.find(".formula").text(toCurrency((placePay/n).toFixed(0))+"+"+toCurrency((deductSum/notDeductNum).toFixed(0))+"=");
		}else{//공제 없을 시 식 삭제
			$tr.find(".formula").text(" ");
		}//else
		$tr.find(".nBbang").text(toCurrency(result.toFixed(0)));//n빵에 가격 적어주기
//		$(this).text($(this).text().split(/(?=(?:\d{3})+(?:\.|$))/g).join(','));//통화표시  
//		$tr.find(".nBbang").html("<fmt:formatNumber type='currency' value='"+result.toFixed(0)+"'/>");//n빵에 가격 적어주기
		onePlaceResult(trIndex);//공제부분으로 넘어가기
	}//nBbang()
	
	//-------------------------------------------------------------------------------------------------------------------------
	//onePlaceResult 1차 정산
	function onePlaceResult(trIndex){
//		alert("5 onePlaceResult : "+trIndex);
//		alert("5-1")
		console.log("--------------------------- onePlaceResult ---------------------------");
		var $tr=$(".table tr:eq("+trIndex+")");
		var $deductSelect=$tr.find("select[name=deductSelect]");
		var n=$tr.find("input[name=attend]:checked").length;//참석자 수
		console.log("onePlaceResult - trIndex : "+trIndex+" / n : "+n);
		$deductSelect.each(function(itemIndex){
//			alert("5-2")
			var $attend=$tr.find("input[name=attend]:eq("+itemIndex+")");//참석여부
			var $oneFormula=$tr.find(".oneFormula:eq("+itemIndex+")");//결과표시하는곳
			var $oneResult=$tr.find(".oneResult:eq("+itemIndex+")");//결과표시하는곳
			var price=toNum($tr.find("input[name=placePay]").val());//총액
			var deductAmount=toNum($tr.find("input[name=deductAmount]:eq("+itemIndex+")").val());//공제액
			var $treat=$tr.find("input[name=treat]");//쏨여부
			var resultPrice=toNum($tr.find(".nBbang").text());
			//참가자중(불참이면 넘어간다)
			if($attend.prop("checked")==true){
//				alert("5-3")
				if($treat.prop("checked")==true){//"쏨"일때 - 똑같노?
//					alert("5-4")
					if($(this).val()=="공제: 없음"){//공제:없음 일때 (결제자(쏜사람))
//						alert("5-5")
						$oneFormula.text(" ");
						$oneResult.text(toCurrency(resultPrice));
					}else if ($(this).val()!="공제: 없음"){//공제받는놈들(쏘인놈들)
//						alert("5-6")
						$oneFormula.text(toCurrency((price/n).toFixed(0))+"-"+toCurrency(deductAmount));
						$oneResult.text(toCurrency(((price/n).toFixed(0)-deductAmount)));
					}//elseif
				}else if($treat.prop("checked")==false){//"쏨" 아닐때
//					alert("5-7")
					if($(this).val()=="공제: 없음"){//참가자중 공제: 없음 일때(지돈다낼때)
//						alert("5-8")
						$oneFormula.text(" ");
						$oneResult.text(toCurrency((price/n))) ;
					}else if($(this).val()!="공제: 없음"){//참가자중 공제받는놈들
//						alert("5-9")
						$oneFormula.text(toCurrency((price/n).toFixed(0))+"-"+toCurrency(deductAmount));
						$oneResult.text(toCurrency(((price/n).toFixed(0)-deductAmount)));
					}//else
				}//elseif
			}//if
			//'불참'이면 onePlaceResult 에 결과 지우기
//			if($attend.prop("checked")==false){
//				$oneFormula.text(" ");
//				$oneResult.text("0");
//			}//if
		})//each
		finalResult();
	}//onePlaceResult()
	
	function finalResult(){
//		alert("6 finalResult() ");
		console.log("--------------------------- finalResult ---------------------------");
		var $tr=$(".table tr");//행
		//tr 갯수 구하기
		var $payerSelect=$("select[name=payerSelect]");
		var $finalResultDiv=$(".finalResultDiv");
		var payerList=new Array();//tr 갯수(결제자list) (payerSelect 의 idx 0이 아닌거중에 안겹치는 결제자 갯수)
		$payerSelect.each(function(){
			if($(this).find(":selected").index()!=0){
				console.log("1 - $(this).find(\":selected\").index() : "+$(this).find(":selected").index()+" / payerList.length : "+payerList.length);
				if(payerList.length==0){//최초 - 리스트에 담는다
					payerList.push($(this).val());
					console.log("2 - payerList.length : "+payerList.length+" / payerList[0] : "+payerList[0]);
				}else if(payerList.length>0){//두번째 부터는 - 중복체크
					var flag=true;
					for(var i=0;i<payerList.length;i++){//한바퀴 돌려보고
						if(payerList[i]==$(this).val()){//중복이면
							flag=false;//중복 - false 가 된다.
							console.log("3 - flag : "+flag);
						}//if
					}//for
					if(flag==true){//중복 아니면
						payerList.push($(this).val());//담는다.
						console.log("4 - payerList["+i+"] : "+payerList[i]);
					}//if
				}//if
			}//if
		})//payerSelect each
		//
		console.log("5 - payerList.length : "+payerList.length);
		//td갯수 구하기
		var memNum=parseInt($("input[name=hidden_memNum]").val());//총 맴바 몇명?
		console.log("6 - memNum : "+memNum);
		//합산 구하기 - 누구한테 총 얼마줘야되는지
			//2차원배열 숫자(0)로 초기화 - tr : payerList / td : memNum
		var sumList=new Array();
		for(var i=0;i<payerList.length;i++){
			sumList[i]=new Array();
			for(var j=0;j<memNum;j++){
				sumList[i][j]=0;
				console.log("7 - 데이타 배열 0으로 초기화 - sumList["+i+"]["+j+"] : "+sumList[i][j]);
			}//for i
		}//for j
			//tr 돌려서 tr결제자 == payerList 결제자 라면 sumList에 합산
		for(var i=0;i<payerList.length;i++){
			$tr.each(function(trIndex){
				var $payerSelect=$(this).find("select[name=payerSelect]");
				var $oneResult=$(this).find(".oneResult");
				if($payerSelect.val()==payerList[i]){
					console.log("8 - $payerSelect.val() : "+$payerSelect.val()+" / payerList[i] : "+payerList[i]);
					$oneResult.each(function(itemIndex){
						sumList[i][itemIndex]+=toNum($(this).text());
					})//oneResult each
				}//if
			})// tr each
		}//for

		//test
		for(var i=0;i<sumList.length;i++){
			for(var j=0;j<sumList[0].length;j++){
				console.log("9 - sumList["+i+"]["+j+"] : "+sumList[i][j]);
			}//for i
		}//for j
		
		//표 그리기
		var table="";
		table+="<table class='finalResultTable' align='center' border=1>";
		for(var i=0;i<payerList.length;i++){
			table+="	<tr>";
			table+="		<td>"+payerList[i]+"에게</td>";
			for(var j=0;j<memNum;j++){
				table+="		<td>"+sumList[i][j]+"</td>";
			}//for
			table+="	</tr>";
		}//for
		table+="</table>";
		$finalResultDiv.html(table);//표 붙여넣기
	}//finalResult();
	
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
				ssom(trIndex);
			}//for
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
		$(this).find("input[name=attend]").each(function(itemIndex){
			$(this).on("change",function(){
				toggleCheck($(this),trIndex,itemIndex);
//				nBbang(trIndex);
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
				var num=toNum($(this).val());
				var cur=toCurrency(num);
				$(this).val(cur);
				nBbang(trIndex);
			})//onchange
		})//each
	})//each
	
	//stage당 회식비 입력시(keyup)마다 nBbang 호출
	$(".table tr").each(function(trIndex){
			$(this).find("input[name=placePay]").on("keyup",function(e){
				var num=toNum($(this).val());
				var cur=toCurrency(num);
				$(this).val(cur);
				ssom(trIndex);
			})//onkeyup
	})//each
	
})//ready