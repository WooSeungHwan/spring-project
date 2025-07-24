package com.service.spring.domain;

import java.time.LocalDate;

public class Account {
	private int accId; 				// column: acc_id
	private LocalDate accDate;			// column: acc_date
	private boolean accIncome;		// column: acc_income
	private String accCategory;		// column: acc_category
	private long accAmount;			// column: acc_amount
	private String accEtc;			// column: acc_etc
	private String accDesc;			// column: acc_desc
	private String accPayment;		// column: acc_payment
	
	private int memId;				// column: mem_id
	
	public Account() {}

	public Account(LocalDate accDate, boolean accIncome, String accCategory, int accAmount, String accEtc,
			String accDesc, String accPayment, int memId) {
		this.accDate = accDate;
		this.accIncome = accIncome;
		this.accCategory = accCategory;
		this.accAmount = accAmount;
		this.accEtc = accEtc;
		this.accDesc = accDesc;
		this.accPayment = accPayment;
		this.memId = memId;
	}
	
	public Account(int accId, LocalDate accDate, boolean accIncome, String accCategory, int accAmount, String accEtc,
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

	public LocalDate getAccDate() {
		return accDate;
	}

	public void setAccDate(LocalDate accDate) {
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

	public void setAccAmount(long accAmount) {
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

	public int getMemId() {
		return memId;
	}

	public void setMemId(int memId) {
		this.memId = memId;
	}

	@Override
	public String toString() {
		return "Account [accId=" + accId + ", accDate=" + accDate + ", accIncome=" + accIncome + ", accCategory="
				+ accCategory + ", accAmount=" + accAmount + ", accEtc=" + accEtc + ", accDesc=" + accDesc
				+ ", accPayment=" + accPayment + ", memId=" + memId + "]";
	}


}
