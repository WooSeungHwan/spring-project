package com.service.spring.domain;

public class Note {
	private int noteId;
	private String noteName;
	private String noteContent;
	private boolean noteImportant;
	
	public Note() {}

	public Note(String noteName, String noteContent, boolean noteImportant) {
		this.noteId = noteId;
		this.noteName = noteName;
		this.noteContent = noteContent;
		this.noteImportant = noteImportant;
	}
	
	public Note(int noteId, String noteName, String noteContent, boolean noteImportant) {
		this.noteId = noteId;
		this.noteName = noteName;
		this.noteContent = noteContent;
		this.noteImportant = noteImportant;
	}

	@Override
	public String toString() {
		return "Note [noteId=" + noteId + ", noteName=" + noteName + ", noteContent=" + noteContent + ", noteImportant="
				+ noteImportant + "]";
	}
	
	
}
