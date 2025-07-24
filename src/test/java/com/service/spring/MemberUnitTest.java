package com.service.spring;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.service.spring.domain.Goal;
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
		Member member = sqlSession.selectOne(NS + "getMember", new Member("alice@example.com", "alice1234", null, null, null, null));
		System.out.println(member.equals(null) ? "사용자 존재하지 않음" : member);
		
		//로그인 실패 시
		member = sqlSession.selectOne(NS + "getMember", new Member("fail@example.com", "fail1234", null, null, null, null));
		System.out.println(member == null ? "사용자 존재하지 않음" : member);
	}
	
	// 사용자 검색 테스트
	@Test
	public void searchMemberTest() {
		//로그인 성공 시
		sqlSession.selectList(NS + "searchMember", "Diana").forEach((m) -> {
			System.out.println(m);
		});
	}
	
	// 사용자 등록 테스트
	@Test
	public void addMemberTest() {
		System.out.println(sqlSession.insert(NS + "addMember", new Member("test1234@example.com", "test1234", "테스트", "M", null, null))
				+ "명 등록 완료");
	}
	
	// 사용자 수정 테스트
	@Test
	public void updateMemberTest() {
		System.out.println(sqlSession.update(NS + "changeMember", new Member(9, "test5678@example.com", "test5678", "테스트5678", "F", "img/profile.png", null))
				+ "명 수정 완료");
	}
	
	// 사용자 삭제 테스트
	@Test
	public void deleteMemberTest() {
		System.out.println(sqlSession.delete(NS + "deleteMember", 9)
				+ "명 삭제 완료");
	}
		
	// 사용자의 목표 가져오기 테스트
	@Test
	public void getGoalTest() {
		Goal goal = sqlSession.selectOne(NS + "getGoal", 10);
				
		System.out.println(goal);
	}
	
	// 사용자의 목표 수정 테스트
	@Test
	public void updateGoalTest() {
		Goal goal = new Goal(11, "Lv 1", 2);
		
		System.out.println(goal);
		
		System.out.println(sqlSession.update(NS + "updateGoal", new Member(10, null, null, null, null, null, goal))
				+ "명 수정 완료");
	}
}
