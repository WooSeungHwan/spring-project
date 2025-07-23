package com.service.spring;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.service.spring.domain.User;

@SpringBootTest
public class UserUnitTest {

	@Autowired
	SqlSession sqlSession;

	// 로그인 테스트
	@Test
	public void loginTest() {
		User user = sqlSession.selectOne("ns.sql.UserMapper.login", new User("admin", "admin", null, null));
		
		System.out.println(user);
	}
	
	// 유저 등록 테스트
	@Test
	public void addUserTest() {
		System.out.println(sqlSession.insert("ns.sql.UserMapper.addUser", new User("test", "test", "test", "test@test.com")));
	}
	
}
