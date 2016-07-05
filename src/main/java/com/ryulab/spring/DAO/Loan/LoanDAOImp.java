package com.ryulab.spring.DAO.Loan;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.ibatis.session.SqlSession;

public class LoanDAOImp implements LoanDAO{
	
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	/*@Override
	public List<BannerDTO> bannerList() {
		List<BannerDTO> list=sqlSession.selectList("bannerList");
		return list;
	}

	@Override
	public BannerDTO bannerDto(String bann_num) {
		BannerDTO dto=(BannerDTO) sqlSession.selectOne("bannerDto", bann_num);
		return dto;
	}

	@Override
	public void imgModi(Map<String, String> map) {
		int sel=sqlSession.update("imgModi", map);
	}

	@Override
	public void bannerDel(String bann_num) {
		int sel=sqlSession.delete("bannerDel", bann_num);
	}
	@Override
	public void bannerModi(BannerDTO dto) {
		int sel=sqlSession.update("bannerModi", dto);
	}
	@Override
	public int bann_num_max(){
		int num=(Integer)sqlSession.selectOne("bann_num_max")+1;
		return num;
	}

	@Override
	public void bannerReg(BannerDTO dto) {
		int sel=sqlSession.insert("bannerReg", dto);
	}

	public List<BannerDTO> bannerSearch(String name) {
		List<BannerDTO> list=sqlSession.selectList("bannerSearch", name);
		return list;
	}

	public void bannerOnOff(String bann_num, String bann_use) {
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("bann_num", bann_num);
		map.put("bann_use", bann_use);
		sqlSession.update("bannerOnOff", map);		
	}

	public int bann_use_max() {
		int max=(Integer)sqlSession.selectOne("bann_use_max");
		return max;
	}

	public List<BannerDTO> bannerUseList() {
		List<BannerDTO> list=sqlSession.selectList("bannerUseList");
		return list;
	}*/
	
}
