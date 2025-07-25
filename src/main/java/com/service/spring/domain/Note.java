package com.service.spring.domain;

public class Note {
	private int noteId;
	private String noteName;
	private String noteContent;
	private boolean noteImportant;

	private int memId;            // 회원 ID (외래키)

	public Note() {}
	
	public Note(int noteId, String noteName, String noteContent, boolean noteImportant) {
		this.noteId = noteId;
		this.noteName = noteName;
		this.noteContent = noteContent;
		this.noteImportant = noteImportant;
	}

	public Note(int noteId, boolean noteImportant) {
    this.noteId = noteId;
		this.noteImportant = noteImportant;
	}

	public Note(int noteId, String noteName, String noteContent, boolean noteImportant, int memId) {
    this.noteId = noteId;
		this.noteName = noteName;
		this.noteContent = noteContent;
		this.noteImportant = noteImportant;
		this.memId = memId;
	}

	public int getNoteId() {
		return noteId;
	}

	public void setNoteId(int noteId) {
		this.noteId = noteId;
	}

	public String getNoteName() {
		return noteName;
	}

	public void setNoteName(String noteName) {
		this.noteName = noteName;
	}

	public String getNoteContent() {
		return noteContent;
	}

	public void setNoteContent(String noteContent) {
		this.noteContent = noteContent;
	}

	public boolean isNoteImportant() {
		return noteImportant;
	}

	public void setNoteImportant(boolean noteImportant) {
		this.noteImportant = noteImportant;
	}

	public int getMemId() {
		return memId;
	}

	public void setMemId(int memId) {
		this.memId = memId;
	}

	@Override
	public String toString() {
		return "Note [noteId=" + noteId + ", noteName=" + noteName + ", noteContent=" + noteContent + ", noteImportant="
				+ noteImportant + ", memId=" + memId + "]";
	}
}
