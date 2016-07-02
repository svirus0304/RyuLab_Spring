package com.ryulab.spring;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ryulab.spring.DAO.Loan.LoanDAOImp;
import com.ryulab.spring.DTO.LoanDTO;

@Controller
public class LoanController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoanController.class);
	
	@Resource(name="loanDao")
	private LoanDAOImp loanDAOImp;
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/loan_main", method = RequestMethod.GET)
	public String loan_main(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/loan_main");
		
		return "loan/loan_main";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/loan_table", method = RequestMethod.GET)
	public String loan_table(Model model,String placeNum,String member) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/loan_table - placeNum : "+placeNum+" / member : "+member);
		//맴버 리스트 만들기
		String[] memListArray=member.split(",");
		List<LoanDTO> memList=new ArrayList<LoanDTO>();
		for (int i = 0; i < memListArray.length; i++) {
			System.out.println(memListArray[i]);
			LoanDTO loanDTO=new LoanDTO();
			loanDTO.setName(memListArray[i]);
			memList.add(loanDTO);
		}
		model.addAttribute("member",member);
		model.addAttribute("memList",memList);
		model.addAttribute("placeNum", placeNum);
		return "loan/loan_table";
	}
	
}//LoanController
