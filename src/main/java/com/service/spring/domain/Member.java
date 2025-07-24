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
	
	private List<Account> accounts;
	private List<Health> healths;
	private List<Todo> Todos;
	private List<Note> notes;
	
	public Member() {}

	public Member(String email, String password, String nickname, String gender, String profileImg) {
		this.email = email;
		this.password = password;
		this.nickname = nickname;
		this.gender = gender;

	}
	
	public Member(int memId, String email, String password, String nickname, String gender, String profileImg) {
		this.memId = memId;
		this.email = email;
		this.password = password;
		this.nickname = nickname;
		this.gender = gender;
		this.profileImg = profileImg;
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

	public List<Account> getAccounts() {
		return accounts;
	}

	public void setAccounts(List<Account> accounts) {
		this.accounts = accounts;
	}

	public List<Health> getHealths() {
		return healths;
	}

	public void setHealths(List<Health> healths) {
		this.healths = healths;
	}

	public List<Todo> getTodos() {
		return Todos;
	}

	public void setTodos(List<Todo> todos) {
		Todos = todos;
	}

	public List<Note> getNotes() {
		return notes;
	}

	public void setNotes(List<Note> notes) {
		this.notes = notes;
	}

	@Override
	public String toString() {
		return "Member [memId=" + memId + ", email=" + email + ", password=" + password + ", nickname=" + nickname
				+ ", gender=" + gender + ", profileImg=" + profileImg + ", goal=" + goal + ", accounts=" + accounts
				+ ", healths=" + healths + ", Todos=" + Todos + ", notes=" + notes + "]";
	}
	
	
	
}
