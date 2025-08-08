package com.service.spring.domain;

public class PInfo {
	private int memId;
	private double height;
	private double weight;
	private double bMI;
	
	public PInfo() {}

	public PInfo(int memId, double height, double weight) {
		this.memId = memId;
		this.height = height;
		this.weight = weight;
	}

	public int getMemId() {
		return memId;
	}

	public void setMemId(int memId) {
		this.memId = memId;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(double height) {
		this.height = height;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public double getbMI() {
		return bMI;
	}

	public void setBMI(double bMI) {
		this.bMI = bMI;
	}

	@Override
	public String toString() {
		return "PInfo [memId=" + memId + ", height=" + height + ", weight=" + weight + ", bMI=" + bMI + "]";
	}

	
	
}
