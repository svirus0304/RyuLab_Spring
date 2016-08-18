package com.ryulab.spring.DAO.Board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ryulab.spring.DTO.BoardDTO;
import com.ryulab.spring.DTO.MemberDTO;
import com.ryulab.spring.DTO.PagingDTO;

public interface BoardDAO {
	
	List<MemberDTO> getAllmember();
//	List<MemberDTO> getAllMember(String json);//webDB방식
//	String getHttpHTML(String op);//webDB방식때 http 연결메소드
	List<BoardDTO> getAllBoardList();
	List<BoardDTO> getBoardList(PagingDTO pagingDTO);
//	List<BoardDTO> getBoardList(String json_board); //webDB방식
	void addBoard_view(String board_num);
	BoardDTO getBoard(String board_num);
	void modifyBoard(Map<String, String> map);
	void deleteBoard(String board_num);
	List<HashMap<String, String>> getAllComment(String board_num);
	void addComment(Map<String, Object> map);
	HashMap<String, Object> getOneComment(String comment_index);
	void addLike(String comment_index);
	void addDislike(String comment_index);
	/*List<BannerDTO> bannerList();
	BannerDTO bannerDto(String bann_num);
	void imgModi(Map<String, String> map);
	void bannerDel(String bann_num);
	void bannerModi(BannerDTO dto);
	int bann_num_max();
	void bannerReg(BannerDTO dto);
	List<BannerDTO> bannerSearch(String name);
	void bannerOnOff(String bann_num, String bann_use);
	int bann_use_max();
	List<BannerDTO> bannerUseList();*/
}//bannerDAO
