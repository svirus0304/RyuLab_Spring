package com.ryulab.spring;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ryulab.spring.DAO.Random.RandomDAOImp;

@Controller
public class RandomController {
	
	private static final Logger logger = LoggerFactory.getLogger(RandomController.class);
	
	@Resource(name="randomDao")
	private RandomDAOImp randomDaoImp;
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/random_main", method = RequestMethod.GET)
	public String board_main(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/random_main");
		List<Integer> numbers=randomDaoImp.makeNumbers();
		model.addAttribute("numbers", numbers);
		return "random/random_main";
	}
	
}//BoardController
