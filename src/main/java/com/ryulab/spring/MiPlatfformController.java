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
public class MiPlatfformController {
	
	private static final Logger logger = LoggerFactory.getLogger(MiPlatfformController.class);
	
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/selectAll", method = RequestMethod.GET)
	public String selectAll(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/selectAll");
		
		return "MiPlatform/selectAll";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/MiPlatform_MiPlatform", method = RequestMethod.GET)
	public String MiPlatform_MiPlatform(Model model, String page) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/MiPlatform_MiPlatform - page : "+page);
		
		model.addAttribute("page",page);
		return "MiPlatform/MiPlatform_MiPlatform";
	}
	
}//BoardController
