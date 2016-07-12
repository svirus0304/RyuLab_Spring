package com.ryulab.spring.DAO.Board;


import java.io.BufferedReader;
import java.io.Console;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.net.ssl.HttpsURLConnection;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.ryulab.spring.DTO.MemberDTO;

public class BoardDAOImp implements BoardDAO {

	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//http 열고 소스 가져오기 //////////////////////////////////////////////////////
	@Override
	public String getHttpHTML(String op) {
		URL url;
		HttpURLConnection conn;
//		HttpsURLConnection conn;
		BufferedReader rd;
		String line;
		String result = "";
		try {
			result+=" [1]\n";
			url = new URL("http://svirus0304.cafe24.com");
			result+="[2]\n";
			conn = (HttpURLConnection) url.openConnection();
			result+="[3]\n";
			conn.setRequestMethod("POST");
			result+="[4]\n";
			conn.setRequestProperty("Referer", "http://svirus0304.cafe24.com");
			result+="[5]\n";
//			conn.setRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2)");
			conn.setRequestProperty("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36");
			result+="[6]\n";

			String postParam = "pw=fbtmfap&op="+op;
			result+="[7]\n";
			conn.setDoOutput(true);
			result+="[8]\n";
			OutputStream out_stream = conn.getOutputStream();
			result+="[9]\n";
			out_stream.write( postParam.getBytes("UTF-8") );
			result+="[10]\n";
			out_stream.flush();
			result+="[11]\n";
			out_stream.close();
			result+="[12]\n";
			conn.getInputStream();
			result+="[13]\n";

			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			result+="[14]\n";
			while ((line = rd.readLine()) != null) {
				result += line+"\n";
			}
			result+="[15]\n";
			rd.close();
		} catch (IOException e) {
			result+="--------------------------- 에라 --------------------------- \n";
			result+=e.getMessage();
			e.printStackTrace();
		} catch (Exception e) {
			result+="--------------------------- 에라 --------------------------- \n";
			result+=e.getMessage();
			e.printStackTrace();
		}
		
		result+="[16]\n";
		result=result.substring(1);
			
//			웹으로 부터 불러온 String은 여기 자바 내에서 만든 String과 달랐다. (syso 해보면 똑같아서 못찾음)
//			웹으로 불러온 String과 자바에서 직접 만든 String을 똑같이 만들어놓고 (String result="{"id":"hello"}") 길이 측정 결과 (.length)
//			웹String이 1개가 더 많다고 나왔다. 그래서 계속 unexpected character ( ) at position 0 에러가 떴던 것이다.
//			해결 : 웹String 젤 앞글자를 잘라버리면 된다.
		return result;
	}//
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	@Override
	public List<MemberDTO> getAllMember(String json) {
		List<MemberDTO> mem_list=new ArrayList<MemberDTO>();
		JSONParser parser=new JSONParser();
		try {
			JSONArray jsonArr=(JSONArray)parser.parse(json);
			for (int i = 0; i < jsonArr.size(); i++) {
				JSONObject jsonObject=(JSONObject) jsonArr.get(i);
				MemberDTO mem_dto=new MemberDTO();
				mem_dto.setMem_id(jsonObject.get("mem_id").toString());
				mem_dto.setMem_pw(jsonObject.get("mem_pw").toString());
				mem_dto.setMem_email(jsonObject.get("mem_email").toString());
				mem_dto.setMem_nickname(jsonObject.get("mem_nickname").toString());
				mem_list.add(mem_dto);
				System.out.println(mem_dto.getMem_id()+" / "+mem_dto.getMem_pw()+" / "+mem_dto.getMem_email()+" / "+mem_dto.getMem_nickname());
			}//for
		} catch (ParseException e) {
			e.printStackTrace();
		}//catch
		return mem_list;
	}//getAllMember
	//------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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
