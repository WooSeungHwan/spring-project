package com.service.spring;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.service.spring.domain.Member;

@SpringBootTest
public class MemberUnitTest {

	@Autowired
	SqlSession sqlSession;
	
	private static final String NS = "ns.sql.MemberMapper.";

	// 로그인 테스트
	@Test
	public void loginTest() {
		//로그인 성공 시
		Member member = sqlSession.selectOne(NS + "getMember", new Member("alice@example.com", "alice1234", null, null, null));
		System.out.println(member.equals(null) ? "사용자 존재하지 않음" : member);
		
		//로그인 실패 시
		member = sqlSession.selectOne(NS + "getMember", new Member("fail@example.com", "fail1234", null, null, null));
		System.out.println(member == null ? "사용자 존재하지 않음" : member);
	}
	
	// 유저 등록 테스트
	@Test
	public void addUserTest() {
		System.out.println(sqlSession.insert("ns.sql.UserMapper.addUser", new User("test", "test", "test", "test@test.com")));
	}
	
}
