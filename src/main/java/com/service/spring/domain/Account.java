package com.service.spring.domain;

import java.sql.Date;

public class Account {
	private int accId;
	private Date accDate;
	private boolean accIncome;
	private String accCategory;
	private long accAmount;
	private String accEtc;
	private String accDesc;
	private String accPayment;
	
	public Account() {}

	public Account(Date accDate, boolean accIncome, String accCategory, int accAmount, String accEtc,
			String accDesc, String accPayment) {
		this.accDate = accDate;
		this.accIncome = accIncome;
		this.accCategory = accCategory;
		this.accAmount = accAmount;
		this.accEtc = accEtc;
		this.accDesc = accDesc;
		this.accPayment = accPayment;
	}
	
	public Account(int accId, Date accDate, boolean accIncome, String accCategory, int accAmount, String accEtc,
			String accDesc, String accPayment) {
		this.accId = accId;
		this.accDate = accDate;
		this.accIncome = accIncome;
		this.accCategory = accCategory;
		this.accAmount = accAmount;
		this.accEtc = accEtc;
		this.accDesc = accDesc;
		this.accPayment = accPayment;
	}

	public int getAccId() {
		return accId;
	}

	public void setAccId(int accId) {
		this.accId = accId;
	}

	public Date getAccDate() {
		return accDate;
	}

	public void setAccDate(Date accDate) {
		this.accDate = accDate;
	}

	public boolean isAccIncome() {
		return accIncome;
	}

	public void setAccIncome(boolean accIncome) {
		this.accIncome = accIncome;
	}

	public String getAccCategory() {
		return accCategory;
	}

	public void setAccCategory(String accCategory) {
		this.accCategory = accCategory;
	}

	public long getAccAmount() {
		return accAmount;
	}

	public void setAccAmount(int accAmount) {
		this.accAmount = accAmount;
	}

	public String getAccEtc() {
		return accEtc;
	}

	public void setAccEtc(String accEtc) {
		this.accEtc = accEtc;
	}

	public String getAccDesc() {
		return accDesc;
	}

	public void setAccDesc(String accDesc) {
		this.accDesc = accDesc;
	}

	public String getAccPayment() {
		return accPayment;
	}

	public void setAccPayment(String accPayment) {
		this.accPayment = accPayment;
	}

	@Override
	public String toString() {
		return "Account [accId=" + accId + ", accDate=" + accDate + ", accIncome=" + accIncome + ", accCategory="
				+ accCategory + ", accAmount=" + accAmount + ", accEtc=" + accEtc + ", accDesc=" + accDesc
				+ ", accPayment=" + accPayment + "]";
	}
}
