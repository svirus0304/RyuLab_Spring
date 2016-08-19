package com.ryulab.spring;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ryulab.spring.DAO.Board.BoardDAOImp;
import com.ryulab.spring.DAO.Member.MemberDAOImp;
import com.ryulab.spring.DTO.BoardDTO;
import com.ryulab.spring.DTO.MemberDTO;
import com.ryulab.spring.DTO.PagingDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
	@Resource(name="boardDao")
	private BoardDAOImp boardDaoImp;
	@Resource(name="memberDao")
	private MemberDAOImp memberDaoImp;
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_main", method = RequestMethod.POST)
	public String board_main(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_main");
		
		//DB불러와지는지 테스트
//		List<MemberDTO> list=boardDaoImp.getAllmember();
//		for (int i = 0; i < list.size(); i++) {
//			System.out.println("id : "+list.get(i).getMem_id()+" / nickname : "+list.get(i).getMem_nickname());
//		}
		return "board/board_main";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_board", method = RequestMethod.POST)
	public String board_board(Model model, String page) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_board - page : "+page);
		if ( page==null || page.equals("") || page.equals("[object Object]")) {
			page="1";
		}//
		
		//web DB방식 - heroku -> cafe24 못불러와서(400 bad request) 방식 교체.
//		//json 불러오기
//		String json_mem=boardDaoImp.getHttpHTML("select * from member");//op 형태로 바꾸기
//		System.out.println("json_mem : "+json_mem);
//		List<MemberDTO> mem_list=boardDaoImp.getAllMember(json_mem);
//		
//		//json_board 불러오기
//		String json_board=boardDaoImp.getHttpHTML("select * from board order by board_num desc");
//		System.out.println("json_board : "+json_board);
//		List<BoardDTO> board_list=boardDaoImp.getBoardList(json_board);
		
		//boardList 불러오기
		List<BoardDTO> board_list_all=boardDaoImp.getAllBoardList();
		
		//페이징
		PagingDTO pagingDTO=new PagingDTO(board_list_all.size(), 10, Integer.parseInt(page), 3);
		System.out.println("pagingDTO.");
		
		//페이지의 boardList 불러오기
		List<BoardDTO> board_list=boardDaoImp.getBoardList(pagingDTO);
		System.out.println("board_list.size : "+board_list.size());
		
		//댓글갯수 뽑아내기
		List<Integer> comment_count=new ArrayList<Integer>();
		for(int i=0;i<board_list.size();i++){
			int count=boardDaoImp.getComment_count(board_list.get(i).getBoard_num());
			comment_count.add(count);
		}
		
		model.addAttribute("pagingDTO",pagingDTO);
		model.addAttribute("page",page);
		model.addAttribute("board_list",board_list);
		model.addAttribute("comment_count",comment_count);
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
	public ModelAndView board_write_save(Model model,BoardDTO board_dto,HttpSession session) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_write_save - board_dto. id : "+board_dto.getBoard_id()+" / title : "+board_dto.getBoard_title()+" / content : "+board_dto.getBoard_content());
		//insert 하기
		board_dto.setBoard_id((String)session.getAttribute("mem_id"));
		boardDaoImp.addBoard(board_dto);
		//*board_board로 넘겨주기
		ModelAndView mav=new ModelAndView(board_board(model, "1"));//*중요
		return mav;
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_content", method = RequestMethod.POST)
	public String board_content(Model model,String board_num,String page,HttpSession session,String comment_parent_index) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_content - board_num : "+board_num+" / page : "+page+" / session.mem_id : "+session.getAttribute("mem_id") + " / comment_parent_index : "+comment_parent_index);
		//조회수 올려주기
		boardDaoImp.addBoard_view(board_num);
		//내용 불러오기
		BoardDTO board_dto=boardDaoImp.getBoard(board_num);
		System.out.println("board_dto.content : "+board_dto.getBoard_content());
		//세션으로 회원 정보 불러오기
		MemberDTO member_dto=memberDaoImp.getOneMember((String)session.getAttribute("mem_id"));
		//댓글들 불러오기
		List<HashMap<String, String>> comment_list=boardDaoImp.getAllComment(board_num);
		logger.info("comment_list : {}",comment_list);
		//
		model.addAttribute("page", page);
		model.addAttribute("sessionID", session.getAttribute("mem_id"));
		model.addAttribute("member_dto", member_dto);
		model.addAttribute("board_dto", board_dto);
		model.addAttribute("comment_list", comment_list);
		
		if(comment_parent_index != null && Integer.parseInt(comment_parent_index)!=0){
			model.addAttribute("comment_parent_index", comment_parent_index);
			return "board/board_recmt";
		}
		return "board/board_content";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_modify", method = RequestMethod.POST)
	public String board_modify(Model model,String board_num,String board_title,String board_content) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_modify - board_num : "+board_num+" / board_content : "+board_content);
		Map<String, String> map=new HashMap<String, String>();
		map.put("board_num", board_num);
		map.put("board_title", board_title);
		map.put("board_content", board_content);
		boardDaoImp.modifyBoard(map);
		
		return "board/board_test";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_delete", method = RequestMethod.POST)
	public String board_delete(Model model,String board_num) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_delete - board_num : "+board_num);
		boardDaoImp.deleteBoard(board_num);
		
		return "board/board_test";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_comment_reg", method = RequestMethod.POST)
	public ModelAndView board_comment_reg(Model model,@RequestParam Map<String,Object> map,HttpSession session) {
		System.out.println("--------------------------------------------------------------");
		logger.info("map : {}",map);
		boardDaoImp.addComment(map);
		boardDaoImp.addCount((String)map.get("comment_parent_index"));
		ModelAndView mav=new ModelAndView(board_content(model, (String)map.get("board_num"), (String)map.get("page"),session,(String)map.get("comment_parent_index")));
		return mav;
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_comment_del", method = RequestMethod.POST)
	public ModelAndView board_comment_del(Model model,@RequestParam Map<String,Object> map,HttpSession session) {
		System.out.println("---------------------------------    board_comment_del    -------------------------------------");
		logger.info("map : {}",map);
		boardDaoImp.delComment((String)map.get("comment_index"));
		if(Integer.parseInt((String)map.get("comment_parent_index"))!=0){
			boardDaoImp.delCount((String)map.get("comment_parent_index"));
		}
		ModelAndView mav=new ModelAndView(board_content(model, (String)map.get("board_num"), (String)map.get("page"),session,(String)map.get("comment_parent_index")));
		return mav;
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_comment_like", method = RequestMethod.POST)
	public String board_comment_like(Model model,String comment_index) {
		System.out.println("---------------------------------------------------------------");
		logger.info("comment_index : {}",comment_index);
		boardDaoImp.addLike(comment_index);
		HashMap<String, Object> comment_map=boardDaoImp.getOneComment(comment_index);
		String like=comment_map.get("comment_like").toString();
		model.addAttribute("result", like);
		return "board/board_json";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_comment_dislike", method = RequestMethod.POST)
	public String board_comment_dislike(Model model,String comment_index) {
		System.out.println("---------------------------------------------------------------");
		logger.info("comment_index : {}",comment_index);
		boardDaoImp.addDislike(comment_index);
		HashMap<String, Object> comment_map=boardDaoImp.getOneComment(comment_index);
		String dislike=comment_map.get("comment_dislike").toString();
		model.addAttribute("result", dislike);
		return "board/board_json";
	}
	//////////////////////////////////////////////////////////////////
	@RequestMapping(value = "/board_test", method = RequestMethod.POST)
	public String board_test(Model model) {
		System.out.println("---------------------------------------------------------------");
		System.out.println("/board_test");
		
		return "board/board_test";
	}
	
}//BoardController
