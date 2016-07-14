package com.ryulab.spring.DAO.Random;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.ibatis.session.SqlSession;

public class RandomDAOImp implements RandomDAO{
	
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<Integer> makeNumbers() {
		List<Integer> numbers=new ArrayList<Integer>();
		Random random=new Random();
		int num;
		
		for(int i=0;true;i++){
			num=random.nextInt(46);
			System.out.println("num "+i+" : "+num);
			numbers.add(num);
			if(numbers.get(0)==0){//첫숫자 0이면 삭제
				numbers.remove(0);
				i-=1;
			}//if
			for (int j = 0; j < numbers.size()-1; j++) {//중복검사(중복이면 삭제)
				if (numbers.get(i)==numbers.get(j)) {
					numbers.remove(i);
					i-=1;
				}//if
			}//for
			if (numbers.size()==6) {//숫자 6개 다 채워지면 break;
				break;
			}//if
		}//for
		
		//test
		System.out.println("*********** numbers ************");
		for (int i = 0; i < numbers.size(); i++) {
			System.out.println(numbers.get(i));
		}//test
		
		return numbers;
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
