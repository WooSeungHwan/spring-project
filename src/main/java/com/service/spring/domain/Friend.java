package com.service.spring.domain;

public class Friend {
    private int friendId;
    private int mem1Id;
    private int mem2Id;
    private int memberIdMin;
    private int memberIdMax;
    private String status;
    
	public Friend() {
		super();
		// TODO Auto-generated constructor stub
	}
		
	public Friend(int mem1Id, int mem2Id, String status) {
        this.mem1Id = mem1Id;
        this.mem2Id = mem2Id;
        this.memberIdMin = Math.min(mem1Id, mem2Id);
        this.memberIdMax = Math.max(mem1Id, mem2Id);
        this.status = status;
    }

	public Friend(Integer friendId, Integer mem1Id, Integer mem2Id, String status) {
	    this.friendId = friendId;
	    this.mem1Id = mem1Id;
	    this.mem2Id = mem2Id;
	    this.status = status;
	}
	
	public Integer getFriendId() {
		return friendId;
	}
	public void setFriendId(Integer friendId) {
		this.friendId = friendId;
	}
	public Integer getMem1Id() {
		return mem1Id;
	}
	public void setMem1Id(Integer mem1Id) {
		this.mem1Id = mem1Id;
	}
	public Integer getMem2Id() {
		return mem2Id;
	}
	public void setMem2Id(Integer mem2Id) {
		this.mem2Id = mem2Id;
	}
	public Integer getMemberIdMin() {
		return memberIdMin;
	}
	public void setMemberIdMin(Integer memberIdMin) {
		this.memberIdMin = memberIdMin;
	}
	public Integer getMemberIdMax() {
		return memberIdMax;
	}
	public void setMemberIdMax(Integer memberIdMax) {
		this.memberIdMax = memberIdMax;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Friend [mem1Id=" + mem1Id + ", mem2Id=" + mem2Id + ", status=" + status + "]";
	}
    
    
}