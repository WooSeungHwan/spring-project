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

    // Getter/Setter (필수)
    public int getGoalLv() {
        return goalLv;
    }

    public void setGoalLv(int goalLv) {
        this.goalLv = goalLv;
    }

    public String getGoalName() {
        return goalName;
    }

    public void setGoalName(String goalName) {
        this.goalName = goalName;
    }

    public int getGoalExp() {
        return goalExp;
    }

    public void setGoalExp(int goalExp) {
        this.goalExp = goalExp;
    }

	@Override
	public String toString() {
		return "Goal [goalLv=" + goalLv + ", goalName=" + goalName + ", goalExp=" + goalExp + "]";
	}
}
