package com.ryulab.spring;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

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
	@RequestMapping(value = "/member_join", method = RequestMethod.GET)
	public String member_join(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/member_join");
		return "member/member_join";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/member_idCheck", method = RequestMethod.POST)
	public String member_idCheck(Model model,String mem_id) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/member_idCheck - mem_id : "+mem_id);
		String result="0";
		//db에서 개수 확인
		int idCheck=memberDaoImp.idCheck(mem_id);
		//0이면 사용가능 (result=1)
		if (idCheck==0) {
			result="1";
		}
		//1이면 사용불가 (result=0) : default
		
		model.addAttribute("result", result);
		return "member/member_join_result";
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
		System.out.println("result : "+result);
//		ModelAndView mav=new ModelAndView("member/member_join_result");
//		mav.addObject("result", result);
		model.addAttribute("result", result);
		return "member/member_join_result";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/member_login", method = RequestMethod.POST)
	public String member_login(Model model,String mem_id,String mem_pw,HttpSession session) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/member_login - mem_id :"+mem_id+" / mem_pw : "+mem_pw);
		Map<String, String> map_login=new HashMap<String, String>();
		map_login.put("mem_id", mem_id);
		map_login.put("mem_pw", mem_pw);
		String result="0";
		String say="";
		int loginResult=memberDaoImp.login(map_login);
		if (loginResult==1) {
			session.setAttribute("mem_id", mem_id);
			result="1";
			say="로그인 성공!";
		}else if(loginResult==0){
			say="로그인 실패...";
		}else{
			result="-1";
			say="이건 뭔 경우고?? loginResult : "+loginResult;
		}
		System.out.println("result : "+result+" / say : "+say);
		model.addAttribute("result", result);
		model.addAttribute("say", say);
		return "member/member_login";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/member_logout", method = RequestMethod.GET)
	public String member_logout(Model model,HttpSession session) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/member_logout -session.mem_id : "+session.getAttribute("mem_id"));
		session.invalidate();
		model.addAttribute("result", "1");
		model.addAttribute("say", "로그아웃 되었습니다.");
		return "member/member_logout";
	}
	
}//MemberController
