package com.service.spring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.domain.Note;

@Repository
public class NoteDAO {
	public static final String NS = "ns.sql.NoteMapper.";
	
	@Autowired	
	private SqlSession sqlSession;
	
	public void addNote(Note vo) {
		sqlSession.insert(NS+"addNote", vo);
	}
	
	public void changeNote(Note vo) {
		sqlSession.update(NS+"changeNote", vo);
	}
	
	public void deleteNote(int noteId) {
		sqlSession.delete(NS+"deleteNote", noteId);
	}
	
	public void isImpNote(Note vo) {
		sqlSession.update(NS+"isImpNote", vo);
	}
	
	public List<Note> getAllNote(int memId) {
		List<Note> list = sqlSession.selectList(NS+"getAllNote", memId);
		return list;
	}
	
	public List<Note> getImpNote(int memId) {
		List<Note> list = sqlSession.selectList(NS+"getImpNote", memId);
		return list;
		}
	
}
