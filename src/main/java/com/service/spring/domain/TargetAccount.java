package com.service.spring.domain;

public class TargetAccount {
	private int memId;
	private int month;
	private long targetAcc;
	
	public TargetAccount() {}
	public TargetAccount(int memId, int month, long targetAcc) {
		super();
		this.memId = memId;
		this.month = month;
		this.targetAcc = targetAcc;
	}
	
	public int getMemId() {
		return memId;
	}
	public void setMemId(int memId) {
		this.memId = memId;
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
		return "TargetAccount [memId=" + memId + ", month=" + month + ", targetAcc=" + targetAcc + "]";
	}
}
