package com.ryulab.spring.DAO.Board;

import java.util.List;

import com.ryulab.spring.DTO.BoardDTO;
import com.ryulab.spring.DTO.MemberDTO;

public interface BoardDAO {
	
	List<MemberDTO> getAllmember();
//	List<MemberDTO> getAllMember(String json);//webDB방식
//	String getHttpHTML(String op);//webDB방식때 http 연결메소드
	List<BoardDTO> getBoardList();
//	List<BoardDTO> getBoardList(String json_board); //webDB방식
	
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
