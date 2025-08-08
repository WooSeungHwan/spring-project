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

	// 노트 추가
	public Note addNote(Note vo) throws Exception {
		sqlSession.insert(NS + "addNote", vo);
		return vo;
	}

	// 노트 수정
	public Note changeNote(Note vo) throws Exception {
		sqlSession.update(NS + "changeNote", vo);
		return vo;
	}

	// 노트 삭제
	public int deleteNote(int noteId) throws Exception {
		return sqlSession.delete(NS + "deleteNote", noteId);
	}

	// 중요 여부 수정
	public int isImpNote(Note vo) throws Exception {
		return sqlSession.update(NS + "isImpNote", vo);
	}

	// 전체 노트 조회
	public List<Note> getAllNote(int memId) throws Exception {
		List<Note> list = sqlSession.selectList(NS+"getAllNote", memId);
		return list;
	}

	// 중요 노트만 조회
	public List<Note> getImpNote(int memId) throws Exception {
		return sqlSession.selectList(NS + "getImpNote", memId);
	}
}
