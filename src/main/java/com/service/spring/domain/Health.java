package com.service.spring.domain;

public class Health {
	private int healId;
	private String healName;
	private int healAmount;
	private boolean healDone;
	
	public Health() {}

	public Health(String healName, int healAmount, boolean healDone) {
		this.healName = healName;
		this.healAmount = healAmount;
		this.healDone = healDone;
	}
	
	public Health(int healId, String healName, int healAmount, boolean healDone) {
		this.healId = healId;
		this.healName = healName;
		this.healAmount = healAmount;
		this.healDone = healDone;
	}
	
	public int getHealId() {
		return healId;
	}

	public void setHealId(int healId) {
		this.healId = healId;
	}

	public String getHealName() {
		return healName;
	}

	public void setHealName(String healName) {
		this.healName = healName;
	}

	public int getHealAmount() {
		return healAmount;
	}

	public void setHealAmount(int healAmount) {
		this.healAmount = healAmount;
	}

	public boolean isHealDone() {
		return healDone;
	}

	public void setHealDone(boolean healDone) {
		this.healDone = healDone;
	}

	@Override
	public String toString() {
		return "Health [healId=" + healId + ", healName=" + healName + ", healAmount=" + healAmount + ", healDone="
				+ healDone + "]";
	}
	
	
}
