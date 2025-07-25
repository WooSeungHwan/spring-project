package com.service.spring;

import java.time.LocalDate;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.service.spring.domain.Account;
import com.service.spring.domain.TargetAccount;
// import com.service.spring.domain.User;

@SpringBootTest
public class TargetAccountUnitTest {
	
	@Autowired
	SqlSession sqlSession;
	
	private String NS = "ns.sql.TargetAccountMapper.";
	
	// 이번 달 지출 목표 조회
	@Test
	public void getTargetTest() {
		sqlSession.selectList("ns.sql.TargetAccountMapper.getTarget", new Account(LocalDate.of(2025, 7, 24), false, null, 0, null, null, null, 2))
			.forEach((a) -> {
				System.out.println(a);
			});
	}
	
	// 이번 달 지출 목표 조회
	@Test
	public void getAllTargetTest() {
		sqlSession.selectList(NS + "getAllTarget", new Account(LocalDate.of(2025, 7, 24), false, null, 0, null, null, null, 2))
			.forEach((a) -> {
				System.out.println(a);
			});
	}	
	
	// 지출 목표 추가
	@Test
	public void insertTargetAccTest() {
		System.out.println(sqlSession.insert(NS + "setTarget", new TargetAccount(2, 2025, 6, 1000000)) + "개 가계부 추가됨");
	}
	
	// 지출 목표 수정
	@Test
	public void updateTargetAccTest() {
		System.out.println(sqlSession.update(NS + "changeTarget", new TargetAccount(2, 2025, 6, 650000)) + "개 가계부 수정됨");
	}

}
