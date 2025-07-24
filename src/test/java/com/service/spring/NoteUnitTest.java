package com.service.spring;


import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.service.spring.domain.Note;

@SpringBootTest
public class NoteUnitTest {
	
	@Autowired
	SqlSession sqlSession;
/*	
	@Test
	public void addNoteTest() {
		System.out.println(sqlSession.insert("ns.sql.NoteMapper.addNote",
			new Note("테스트입니당", "텍스트테스트입니당", true ,1)));
	}

	@Test
	public void deleteText() {
		System.out.println(sqlSession.delete("ns.sql.NoteMapper.deleteNote", 408));
	}
	
	
	@Test
	public void changeNoteText() {
		System.out.println(sqlSession.update("ns.sql.NoteMapper.changeNote",
				new Note(409, "새로운","변경됨", true)));
	}

	@Test
	public void isImpNoteText() {
		System.out.println(sqlSession.update("ns.sql.NoteMapper.isImpNote",
				new Note(409,false)));
	}
		
	@Test
	public void getAllNoteTest() {
		int memId = 1; // 예: 해당 사용자의 mem_id
		sqlSession.selectList("ns.sql.NoteMapper.getAllNote", memId).forEach(b -> {
			System.out.println(b);
		});
	}
*/
	@Test
	public void getImpNoteTest() {
		int memId = 1; // 테스트할 사용자 ID
		sqlSession.selectList("ns.sql.NoteMapper.getImpNote", memId).forEach(b -> {
			System.out.println(b);
		});
	}

	/*
	@Test
	public void insertBookTest() {
		System.out.println(sqlSession.insert("ns.sql.BookMapper.insertBook", 
				new Book("1233-111-444", "테스트", "프로그래밍", "국내도서", "2025-07-16", "테스트", "테스트", 2500, "테스트")));
	}
	
	@Test
	public void getBooksTest() {
		sqlSession.selectList("ns.sql.BookMapper.getBooks").forEach((b) -> {
			System.out.println(b);
		});
	}
	
	@Test
	public void searchByTitleTest() {
		sqlSession.selectList("ns.sql.BookMapper.searchByTitle", "스").forEach((b) -> {
			System.out.println(b);
		});
	}
	
	@Test
	public void searchByPublisherTest() {
		sqlSession.selectList("ns.sql.BookMapper.searchByPublisher", "스").forEach((b) -> {
			System.out.println(b);
		});
	}
	
	@Test
	public void searchByPriceTest() {
		sqlSession.selectList("ns.sql.BookMapper.searchByPrice", 4000).forEach((b) -> {
			System.out.println(b);
		});
	}
	
	@Test
	public void searchByIsbnTest() {
		System.out.println((Book)sqlSession.selectOne("ns.sql.BookMapper.searchByIsbn", "1233-111-333"));
	}
	
	@Test
	public void deleteTest() {
		System.out.println(sqlSession.delete("ns.sql.BookMapper.delete", "1233-111-444") + "권 삭제 완료");
	}
	
	
	@Test
	public void updateTest() {
		System.out.println(sqlSession.update("ns.sql.BookMapper.update", 
				new Book("1233-111-444", "테스트123", "프로그래밍", "국내도서", "2025-07-16", "테스트", "테스트123", 2500, "테스트123")) 
				+ "권 수정 완료");
	}
	*/
}
