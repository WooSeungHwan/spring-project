package com.service.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.NoteDAO;
import com.service.spring.domain.Note;

@Service
public class NoteService {
	
	@Autowired
	private NoteDAO noteDAO;
	
	public Note addNote(Note note) throws Exception {
		return noteDAO.addNote(note);
	}
	
	public int deleteNote(int noteId) throws Exception {
		return noteDAO.deleteNote(noteId);
	}
	
	public Note changeNote(Note note) throws Exception{
		return noteDAO.changeNote(note);
	}
	
	public int isImpNote(Note note) throws Exception{
		return noteDAO.isImpNote(note);
	}
	
	public List<Note> getAllNote(int memId) throws Exception{
		return noteDAO.getAllNote(memId);
	}
	
	public List<Note> getImpNote(int memId) throws Exception{
		return noteDAO.getImpNote(memId);
	}
}
