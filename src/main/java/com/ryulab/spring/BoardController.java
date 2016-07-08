package com.ryulab.spring;


import java.net.HttpURLConnection;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ryulab.spring.DAO.Board.BoardDAOImp;
import com.ryulab.spring.DTO.MemberDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
	@Resource(name="boardDao")
	private BoardDAOImp boardDaoImp;
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_main", method = RequestMethod.GET)
	public String board_main(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_main");
		
		return "board/board_main";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_board", method = RequestMethod.GET)
	public String board_board(Model model, String page) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_board - page : "+page);
		if (page.equals("[object Object]")) {
			page="1";
		}//
		
		//json 불러오기
		String json=boardDaoImp.getHttpHTML("select * from member");
		System.out.println("json : "+json);
		
		//test
		List<MemberDTO> list_mem=boardDaoImp.getAllMember();
		for (int i = 0; i < list_mem.size(); i++) {
			System.out.println("list_mem.get "+i+" : "+list_mem.get(i).getMem_id());
		}//test
		
		//
		model.addAttribute("page",page);
		model.addAttribute("json", json);
		model.addAttribute("list_mem",list_mem);
		return "board/board_board";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_test", method = RequestMethod.POST)
	public String board_test(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_test");
		String json=boardDaoImp.getHttpHTML("select * from member");
		
		return "board_test";
	}
	
}//BoardController
