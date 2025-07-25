package com.service.spring.domain;

import java.sql.Date;

public class Todo {
	private int todoId;
	private boolean todoDone;
	private String todoContent;
	private Date todoDate;
	private boolean todoImportant;

	private int memId;            // 회원 ID (외래키)

	public Todo() {}

	public Todo(boolean todoDone, String todoContent, Date todoDate, boolean todoImportant, int memId) {
		this.todoDone = todoDone;
		this.todoContent = todoContent;
		this.todoDate = todoDate;
		this.todoImportant = todoImportant;
		this.memId = memId;
	}
	
	public Todo(int todoId, boolean todoDone, String todoContent, Date todoDate, boolean todoImportant, int memId) {
		this.todoId = todoId;
		this.todoDone = todoDone;
		this.todoContent = todoContent;
		this.todoDate = todoDate;
		this.todoImportant = todoImportant;
		this.memId = memId;
	}
	public Todo(int todoId, boolean todoDone) {
		this.todoId = todoId;
		this.todoDone = todoDone;
	}

	public int getTodoId() {
		return todoId;
	}

	public void setTodoId(int todoId) {
		this.todoId = todoId;
	}

	public boolean isTodoDone() {
		return todoDone;
	}

	public void setTodoDone(boolean todoDone) {
		this.todoDone = todoDone;
	}

	public String getTodoContent() {
		return todoContent;
	}

	public void setTodoContent(String todoContent) {
		this.todoContent = todoContent;
	}

	public Date getTodoDate() {
		return todoDate;
	}

	public void setTodoDate(Date todoDate) {
		this.todoDate = todoDate;
	}

	public boolean isTodoImportant() {
		return todoImportant;
	}

	public void setTodoImportant(boolean todoImportant) {
		this.todoImportant = todoImportant;
	}

	public int getMemId() {
		return memId;
	}

	public void setMemId(int memId) {
		this.memId = memId;
	}

	@Override
	public String toString() {
		return "Todo [todoId=" + todoId + ", todoDone=" + todoDone + ", todoContent=" + todoContent + ", todoDate="
				+ todoDate + ", todoImportant=" + todoImportant + ", memId=" + memId + "]";
	}
	
}
