package com.ryulab.spring.DAO.Board;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.ryulab.spring.DTO.MemberDTO;

public class BoardDAOImp implements BoardDAO {

	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<MemberDTO> getAllMember() {
		/*List<MemberDTO> mem_list=sqlSession.selectList("getAllMember");*/

		//test
		List<MemberDTO> mem_list=new ArrayList<MemberDTO>();
		MemberDTO mem_dto=new MemberDTO();
		mem_dto.setMem_id("test");
		mem_dto.setMem_pw("1234");
		mem_dto.setMem_email("test@test.com");
		mem_dto.setMem_nickname("테스트");
		mem_list.add(mem_dto);
		//test END
		return mem_list;
	}

	
	//http 열고 소스 가져오기 //////////////////////////////////////////////////////
	@Override
	public String getHttpHTML(String op) {
		URL url;
		HttpURLConnection conn;
		BufferedReader rd;
		String line;
		String result = "";
		try {
			url = new URL("http://svirus0304.cafe24.com");
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2)");

			String postParam = "pw=fbtmfap&op="+op;
			conn.setDoOutput(true);
			OutputStream out_stream = conn.getOutputStream();
			out_stream.write( postParam.getBytes("UTF-8") );
			out_stream.flush();
			out_stream.close();
			conn.getInputStream();

			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			while ((line = rd.readLine()) != null) {
				result += line + "\n";
			}
			rd.close();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(result);
		
		//JSON 읽기 - json-simple-1.1.1.jar 추가
		//parsing하기
		JSONParser parser=new JSONParser();
		try {
			Object obj=JSONValue.parseWithException(result);
			JSONObject jsonObj=(JSONObject)obj;
//			JSONArray jsonArr=(JSONArray)obj;
//			JSONObject jsonObj=(JSONObject)parser.parse(result);
//			JSONArray jsonArr=(JSONArray)parser.parse(result);
			System.out.println("오브젝트 갯수 : "+jsonObj.size());//갯수
		} catch (Exception e) {
			System.out.println("---------------- json parsing error ---------------");
			e.printStackTrace();
		}
		
		
		
		return result;
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
