package com.ryulab.spring;


import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ryulab.spring.DAO.Member.MemberDAOImp;
import com.ryulab.spring.DTO.MemberDTO;
@Controller
public class MemberController {
	@Resource(name="memberDao")
	private MemberDAOImp memberDaoImp;
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/member_join", method = RequestMethod.POST)
	public String member_join(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/member_join");
		return "member/member_join";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/member_join_add", method = RequestMethod.POST)
	public String member_join_add(Model model,MemberDTO memberDTO) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/member_join_add - memberDTO. id : "+memberDTO.getMem_id()+" / nickname : "+memberDTO.getMem_nickname());
		String result="";
		int sel=memberDaoImp.addMember(memberDTO);
		if (sel==1) {
			result="회원가입성공!";
		}else if(sel==0){
			result="회원가입실패...";
		}
//		ModelAndView mav=new ModelAndView("member/member_join_result");
//		mav.addObject("result", result);
		model.addAttribute("result", result);
		return "member/member_join_result";
	}
	
}//MemberController
