package com.service.spring;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.service.spring.domain.Book;
import com.service.spring.domain.User;

@SpringBootTest
public class BookUnitTest {
	
	@Autowired
	SqlSession sqlSession;
	
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
	
//	@Test
//	public void getIsbnTest() {
//		
//	}
	
	@Test
	public void updateTest() {
		System.out.println(sqlSession.update("ns.sql.BookMapper.update", 
				new Book("1233-111-444", "테스트123", "프로그래밍", "국내도서", "2025-07-16", "테스트", "테스트123", 2500, "테스트123")) 
				+ "권 수정 완료");
	}
}
