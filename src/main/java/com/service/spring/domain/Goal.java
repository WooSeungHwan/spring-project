package com.service.spring.domain;

public class Goal {
	private int goalLv;
	private String goalName;
	private int goalExp;
	
	public Goal() {}

	public Goal(int goalLv, String goalName, int goalExp) {
		this.goalLv = goalLv;
		this.goalName = goalName;
		this.goalExp = goalExp;
	}

	@Override
	public String toString() {
		return "Goal [goalLv=" + goalLv + ", goalName=" + goalName + ", goalExp=" + goalExp + "]";
	}
	
	
}
