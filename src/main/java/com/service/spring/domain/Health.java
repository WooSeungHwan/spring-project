package com.service.spring.domain;

import java.time.LocalDate;

public class Health {
	private int healId;
	private String healName;
	private int healAmount;
	private boolean healDone;
	private int memId;
	private LocalDate healDate;
	
	public Health() {}

	public Health(String healName, int healAmount, boolean healDone, int memId) {
		this.healName = healName;
		this.healAmount = healAmount;
		this.healDone = healDone;
		this.memId = memId;
	}
	
	public Health(int healId, String healName, int healAmount, boolean healDone, int memId) {
		this.healId = healId;
		this.healName = healName;
		this.healAmount = healAmount;
		this.healDone = healDone;
		this.memId = memId;
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
	
	public int getMemId() {
		return memId;
	}

	public void setMemId(int memId) {
		this.memId = memId;
	}

	public LocalDate getHealDate() {
		return healDate;
	}

	public void setHealDate(LocalDate healDate) {
		this.healDate = healDate;
	}

	@Override
	public String toString() {
		return "Health [healId=" + healId + ", healName=" + healName + ", healAmount=" + healAmount + ", healDone="
				+ healDone + ", memId=" + memId + ", healDate=" + healDate + "]";
	}


	
	
}
