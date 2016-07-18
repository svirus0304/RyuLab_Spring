package com.ryulab.spring.DAO.Member;

import java.util.List;

import com.ryulab.spring.DTO.BoardDTO;
import com.ryulab.spring.DTO.MemberDTO;

public interface MemberDAO {
	
	List<MemberDTO> getAllmember();
	int addMember(MemberDTO memberDTO);
	
}//bannerDAO
