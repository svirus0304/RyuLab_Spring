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
import org.springframework.web.servlet.ModelAndView;

import com.ryulab.spring.DAO.Board.BoardDAOImp;
import com.ryulab.spring.DTO.BoardDTO;
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
	@RequestMapping(value = "/board_main", method = RequestMethod.POST)
	public String board_main(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_main");
		
		return "board/board_main";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_board", method = RequestMethod.POST)
	public String board_board(Model model, String page) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_board - page : "+page);
		if (page.equals("[object Object]")) {
			page="1";
		}//
		
		//json 불러오기
		String json_mem=boardDaoImp.getHttpHTML("select * from member");//op 형태로 바꾸기
		System.out.println("json_mem : "+json_mem);
		List<MemberDTO> mem_list=boardDaoImp.getAllMember(json_mem);
		
		//json_board 불러오기
		String json_board=boardDaoImp.getHttpHTML("select * from board order by board_num desc");
		System.out.println("json_board : "+json_board);
		List<BoardDTO> board_list=boardDaoImp.getBoardList(json_board);
		
//		//test
//		List<MemberDTO> list_mem=boardDaoImp.getAllMember();
//		for (int i = 0; i < list_mem.size(); i++) {
//			System.out.println("list_mem.get "+i+" : "+list_mem.get(i).getMem_id());
//		}//test
		
		//
		model.addAttribute("page",page);
		model.addAttribute("json_board", json_board);
		model.addAttribute("json_mem", json_mem);
		model.addAttribute("mem_list",mem_list);
		model.addAttribute("board_list",board_list);
		return "board/board_board";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_write", method = RequestMethod.POST)
	public String board_write(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_write");
		
		return "board/board_write";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_write_save", method = RequestMethod.POST)
	public ModelAndView board_write_save(Model model,BoardDTO board_dto) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_write_save - board_dto. id : "+board_dto.getBoard_id()+" / title : "+board_dto.getBoard_title()+" / content : "+board_dto.getBoard_content());
		//insert 하기
		ModelAndView mav=new ModelAndView("/board_board");
		return mav;
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_test", method = RequestMethod.POST)
	public String board_test(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_test");
		
		return "board/board_test";
	}
	
}//BoardController
