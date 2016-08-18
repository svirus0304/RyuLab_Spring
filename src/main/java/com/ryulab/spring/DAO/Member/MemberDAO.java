package com.ryulab.spring.DAO.Member;

import java.util.List;
import java.util.Map;

import com.ryulab.spring.DTO.BoardDTO;
import com.ryulab.spring.DTO.MemberDTO;

public interface MemberDAO {
	
	List<MemberDTO> getAllmember();
	MemberDTO getOneMember(String mem_id);
	int addMember(MemberDTO memberDTO);
	int login(Map<String, String> map_login);
	int idCheck(String mem_id);
	
}//bannerDAO
