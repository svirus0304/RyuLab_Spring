package com.ryulab.spring.DTO;

public class PagingDTO {
	private int totalData;//총 데이터 개수
	private int dataPerPage;//페이지당 데이타 개수
	private int currPage;//현재 페이지
	private int totalPage;//총페이지
	private int startNum;//현재 페이지에서 첫 글번호
	private int endNum;//현재 페이지에서 마지막 글번호
	
	private int block; //보이는 블락 개수
	private int totalBlock;//총 블락 개수
	private int currBlock;
	private int startBlock;
	private int endBlock;
	private int prevBlock;
	private int nextBlock;
	
	public PagingDTO(int totalData,int dataPerPage,int currPage,int block) {
		this.totalData=totalData;
		this.dataPerPage=dataPerPage;
		this.currPage=currPage;
		this.block=block;
		this.totalPage=(int)Math.ceil((double)totalData/dataPerPage);
		this.startNum=(currPage*dataPerPage)-dataPerPage;//현재 페이지에서 첫 글번호x -> limitNum
		this.endNum=(currPage*dataPerPage);//현재 페이지에서 마지막 글번호
		
		this.block=block; //보이는 블락 개수
		this.totalBlock=totalPage;//총 블락 개수
		this.currBlock=currPage;
		this.startBlock=currPage-block;
		this.endBlock=currPage+block;
		this.prevBlock=currBlock-1;
		this.nextBlock=currBlock+1;
	}//const
	
	public int getTotalData() {
		return totalData;
	}
	public void setTotalData(int totalData) {
		this.totalData = totalData;
	}
	public int getDataPerPage() {
		return dataPerPage;
	}
	public void setDataPerPage(int dataPerPage) {
		this.dataPerPage = dataPerPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getCurrPage() {
		return currPage;
	}
	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	public int getEndNum() {
		return endNum;
	}
	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}
	public int getBlock() {
		return block;
	}
	public void setBlock(int block) {
		this.block = block;
	}
	public int getTotalBlock() {
		return totalBlock;
	}
	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}
	public int getCurrBlock() {
		return currBlock;
	}
	public void setCurrBlock(int currBlock) {
		this.currBlock = currBlock;
	}
	public int getStartBlock() {
		return startBlock;
	}
	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}
	public int getEndBlock() {
		return endBlock;
	}
	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}
	public int getPrevBlock() {
		return prevBlock;
	}
	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}
	public int getNextBlock() {
		return nextBlock;
	}
	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}
	
}
