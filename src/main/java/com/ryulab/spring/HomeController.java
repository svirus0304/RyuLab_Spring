package com.ryulab.spring;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String ajax1(Locale locale, Model model, String name,String age) {
		
		model.addAttribute("name",name);
		model.addAttribute("age",age);
		return "ajax1";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/json", method = RequestMethod.GET)
	public String json(Model model, String idx) {//idx 라는 파라미터를 받는다.
		String name="";
		String age="";
		if (idx.equals("1")) {//idx가 1이면
			name="RYU";//이름 RYU
			age="29";//나이 29로 지정.
		}else if (idx.equals("2")) {//idx가 2면
			name="PARK";//이름 PARK
			age="27";//나이 27로 지정
		}
		
		model.addAttribute("name",name);//저장
		model.addAttribute("age",age);//하고
		return "json";//json.jsp로 넘어간다.
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/changePage", method = RequestMethod.POST)
	public String ajax2(Model model, String pagename) {
		System.out.println("------------------------------------------------");
		System.out.println("/changePage - pagename : "+pagename);
		List<Integer> days=new ArrayList<Integer>();
		for (int i = 0; i < 30; i++) {
			days.add(i+1);
		}//for
		
		model.addAttribute("days", days);
		return pagename;
	}
	
}
