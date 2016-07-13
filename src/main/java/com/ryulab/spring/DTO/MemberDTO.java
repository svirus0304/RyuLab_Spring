package com.ryulab.spring.DTO;

public class MemberDTO {
	private String mem_id;
	private String mem_pw;
	private String mem_email;
	private String mem_nickname;
	private int mem_use;
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pw() {
		return mem_pw;
	}
	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	public String getMem_nickname() {
		return mem_nickname;
	}
	public void setMem_nickname(String mem_nickname) {
		this.mem_nickname = mem_nickname;
	}
	public int getMem_use() {
		return mem_use;
	}
	public void setMem_use(int mem_use) {
		this.mem_use = mem_use;
	}
	
}
