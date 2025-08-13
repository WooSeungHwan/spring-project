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

	public Friend(int friendId, int mem1Id, int mem2Id, String status) {
	    this.friendId = friendId;
	    this.mem1Id = mem1Id;
	    this.mem2Id = mem2Id;
	    this.status = status;
	}
	
	public int getFriendId() {
		return friendId;
	}

	public void setFriendId(int friendId) {
		this.friendId = friendId;
	}

	public int getMem1Id() {
		return mem1Id;
	}

	public void setMem1Id(int mem1Id) {
		this.mem1Id = mem1Id;
	}

	public int getMem2Id() {
		return mem2Id;
	}

	public void setMem2Id(int mem2Id) {
		this.mem2Id = mem2Id;
	}

	public int getMemberIdMin() {
		return memberIdMin;
	}

	public void setMemberIdMin(int memberIdMin) {
		this.memberIdMin = memberIdMin;
	}

	public int getMemberIdMax() {
		return memberIdMax;
	}

	public void setMemberIdMax(int memberIdMax) {
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