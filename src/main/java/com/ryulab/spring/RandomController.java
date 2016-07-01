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

@Controller
public class RandomController {
	
	private static final Logger logger = LoggerFactory.getLogger(RandomController.class);
	
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/random_main", method = RequestMethod.GET)
	public String board_main(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/random_main");
		
		return "random/random_main";
	}
	
}//BoardController
