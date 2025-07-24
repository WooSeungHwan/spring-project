package com.service.spring;

import java.time.LocalDate;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.service.spring.domain.Account;
// import com.service.spring.domain.User;

@SpringBootTest
public class AccountUnitTest {
	
	@Autowired
	SqlSession sqlSession;
	
	
	@Test
	public void insertAccTest() {
		System.out.println(sqlSession.insert("ns.sql.AccountMapper.addAcc", 
				new Account(LocalDate.of(2025, 7, 24), false, "카페", 4500, "커피", "카드", "", 4)) + "개 가계부 추가됨");
	}
	
	@Test
	public void getAccTest() {
		sqlSession.selectList("ns.sql.AccountMapper.getMonthAcc", new Account(LocalDate.now(), false, null, 0, null, null, null, 4)).forEach((a) -> {
			System.out.println(a);
		});
	}
	
//	@Test
//	public void searchByTitleTest() {
//		sqlSession.selectList("ns.sql.BookMapper.searchByTitle", "스").forEach((b) -> {
//			System.out.println(b);
//		});
//	}
//	
//	@Test
//	public void searchByPublisherTest() {
//		sqlSession.selectList("ns.sql.BookMapper.searchByPublisher", "스").forEach((b) -> {
//			System.out.println(b);
//		});
//	}
//	
//	@Test
//	public void searchByPriceTest() {
//		sqlSession.selectList("ns.sql.BookMapper.searchByPrice", 4000).forEach((b) -> {
//			System.out.println(b);
//		});
//	}
//	
//	@Test
//	public void searchByIsbnTest() {
//		System.out.println((Book)sqlSession.selectOne("ns.sql.BookMapper.searchByIsbn", "1233-111-333"));
//	}
//	
//	@Test
//	public void deleteTest() {
//		System.out.println(sqlSession.delete("ns.sql.BookMapper.delete", "1233-111-444") + "권 삭제 완료");
//	}
//	
////	@Test
////	public void getIsbnTest() {
////		
////	}
//	
//	@Test
//	public void updateTest() {
//		System.out.println(sqlSession.update("ns.sql.BookMapper.update", 
//				new Book("1233-111-444", "테스트123", "프로그래밍", "국내도서", "2025-07-16", "테스트", "테스트123", 2500, "테스트123")) 
//				+ "권 수정 완료");
//	}
}
