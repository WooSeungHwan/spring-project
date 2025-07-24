package com.service.spring.domain;

import java.util.List;

public class Member {
	private int memId;
	private String email;
	private String password;
	private String nickname;
	private String gender;
	private String profileImg;
	
	private Goal goal;

	public Member() {}

	public Member(String email, String password, String nickname, String gender, String profileImg, Goal goal) {
		this.email = email;
		this.password = password;
		this.nickname = nickname;
		this.gender = gender;
		this.profileImg = profileImg;
		this.goal = goal;
	}
	
	public Member(int memId, String email, String password, String nickname, String gender, String profileImg, Goal goal) {
		this.memId = memId;
		this.email = email;
		this.password = password;
		this.nickname = nickname;
		this.gender = gender;
		this.profileImg = profileImg;
		this.goal = goal;
	}

	public int getMemId() {
		return memId;
	}

	public void setMemId(int memId) {
		this.memId = memId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public Goal getGoal() {
		return goal;
	}

	public void setGoal(Goal goal) {
		this.goal = goal;
	}

	@Override
	public String toString() {
		return "Member [memId=" + memId + ", email=" + email + ", password=" + password + ", nickname=" + nickname
				+ ", gender=" + gender + ", profileImg=" + profileImg + ", goal=" + goal + "]";
	}

	
}
