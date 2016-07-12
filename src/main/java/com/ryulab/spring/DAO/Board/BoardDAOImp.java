package com.ryulab.spring.DAO.Board;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

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
				result += line+"\n";
			}
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
		
			result=result.substring(1);
			
//			별 지랄을 다 떨어서 얻은 결과, 웹으로 부터 불러온 String은 여기 자바 내에서 만든 String과 달랐다. (syso 해보면 똑같아서 못찾아서 개삽질 존나함)
//			웹으로 불러온 String과 자바에서 직접 만든 String을 똑같이 만들어놓고 (String result="{"id":"hello"}") 길이 측정 결과 (.length)
//			웹String이 1개가 더 많다고 나왔다. 그래서 계속 unexpected character ( ) at position 0 에러가 떴던 것이다.
//			해결 : 웹String 젤 앞글자를 잘라버리면 된다. 시발.. 이게 내 삶의 3일을 가져갔다
//			어쨌든 지금은 존나 행복하다
//			
//			String result2="      {\"id\":\"result2\"}";
//			String result2=result.getBytes("UTF-8").toString();
//			String test="{\"id\":\"hello\"}";
//			byte bytes1[]=result.getBytes("utf-8");
//			byte bytes2[]=result2.getBytes("utf-8");
//			byte bytes3[]=result3.getBytes("utf-8");
//			byte bytesT[]=test.getBytes("utf-8");
//			
//			char char1=result.charAt(0);
//			char char2=result2.charAt(0);
//			char char3=result3.charAt(0);
//			char charT=test.charAt(0);
//			
//			String nResult1=result.substring(1);
//			String nResult2=result.substring(1);
//			String nResult3=result.substring(1);
//			String nResultT=test.substring(1);
//			
//			System.out.println("result : "+result+"/ length : "+result.length()+" / byte : "+bytes1[0]+" / char : "+char1+" / nResult : "+nResult1);
//			System.out.println("result2 : "+result2+"/ length : "+result2.length()+" / byte : "+bytes2[0]+" / char : "+char2+" / nResult : "+nResult2);
//			System.out.println("result3 : "+result3+"/ length : "+result3.length()+" / byte : "+bytes3[0]+" / char : "+char3+" / nResult : "+nResult3);
//			System.out.println("test : "+test+"/ length : "+test.length()+" / byte : "+bytesT[0]+" / char : "+charT+" / nResult : "+nResultT);
			/////////////////////////////////////////////////////////////////
//			ArrayList availableCharset = new ArrayList();
//			String[] charsetArray = {"utf-8", "euc-kr","ksc5601","x-windows-949","iso-8859-1", "x-IBM949","x-IBM949C"};  //한글 CHARSET
//			String testStr = result2;
//
//			//모든 Charset 조회
//			Iterator it = Charset.availableCharsets().keySet().iterator(); 
//			while (it.hasNext()) {
//				availableCharset.add((String) it.next());
//			}
//
//			for (int i = 0; i < charsetArray.length; i++) {
//				for (int j = 0; j < charsetArray.length; j++) {
//					System.out.println(charsetArray[i]+"로 문자를 읽어서 " + charsetArray[j] +"로 변경-->" +new String(testStr.getBytes(charsetArray[i]), charsetArray[j]));
//				}
//			}
			/////////////////////////////////////////////////////////////////
			
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
