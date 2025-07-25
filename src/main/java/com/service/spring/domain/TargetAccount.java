package com.service.spring.domain;

public class TargetAccount {
	private int memId;
	private int year;
	private int month;
	private long targetAcc;
	
	public TargetAccount() {}
	public TargetAccount(int memId, int year, int month, long targetAcc) {
		super();
		this.memId = memId;
		this.year = year;
		this.month = month;
		this.targetAcc = targetAcc;
	}
	
	public int getMemId() {
		return memId;
	}
	public void setMemId(int memId) {
		this.memId = memId;
	}
	
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	
	public long getTargetAcc() {
		return targetAcc;
	}
	public void setTargetAcc(long targetAcc) {
		this.targetAcc = targetAcc;
	}
	
	@Override
	public String toString() {
		return "TargetAccount [memId=" + memId + ", year=" + year + ", month=" + month + ", targetAcc=" + targetAcc + "]";
	}
}
