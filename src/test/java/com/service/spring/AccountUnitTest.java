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
	
	// 가계부 이번 달 조회 테스트
	@Test
	public void getAccTest() {
		sqlSession.selectList("ns.sql.AccountMapper.getMonthAcc", new Account(LocalDate.now(), false, null, 0, null, null, null, 4)).forEach((a) -> {
			System.out.println(a);
		});
	}
	
	@Test
	public void insertAccTest() {
		System.out.println(sqlSession.insert("ns.sql.AccountMapper.addAcc", 
				new Account(LocalDate.of(2025, 7, 24), false, "중국집", 6000, "짜장면", "카드", "", 4)) + "개 가계부 추가됨");
	}
	
	@Test
	public void updateAccTest() {
		System.out.println(sqlSession.update("ns.sql.AccountMapper.changeAcc", 
				new Account(208, LocalDate.of(2025, 7, 10), true, "월급", 100000, "회사", "계좌", "", 4)) 
				+ "개 가계부 수정됨");
	}

	@Test
	public void deleteTest() {
		System.out.println(sqlSession.delete("ns.sql.AccountMapper.deleteAcc", 208) + "개 삭제 완료");
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

//	
////	@Test
////	public void getIsbnTest() {
////		
////	}
//	

}
