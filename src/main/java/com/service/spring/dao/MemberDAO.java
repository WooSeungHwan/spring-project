package com.service.spring.dao;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import com.service.spring.domain.Goal;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.dao.MemberDAO;
import com.service.spring.domain.Account;
import com.service.spring.domain.Member;

@Repository
public class MemberDAO {	
	public static final String NS = "ns.sql.MemberMapper.";
	public static final String NS2 = "";
	
	@Autowired
	private SqlSession sqlSession;
	
	public Member login(Member member) throws SQLException {
		return sqlSession.selectOne(NS + "getMember", member);
	}

    // 이메일 중복여부 확인
    public Member checkEmail(Member member) throws SQLException {
        return sqlSession.selectOne(NS + "getMember", member);
    }
	
	public List<Member> searchMember(String nickname) throws SQLException {
		return sqlSession.selectList(NS + "searchMember", nickname);
	}
	
	public Member searchMember(int memId) throws SQLException {
		return sqlSession.selectOne(NS + "searchMemberById", memId);
	}
	
	public int addMember(Member member) throws SQLException {
		return sqlSession.insert(NS + "addMember", member);
	}
	
	public int changeMember(Member member) throws SQLException {
		return sqlSession.update(NS + "changeMember", member);
	}
	
	public int deleteMember(int memId) throws SQLException {
		return sqlSession.delete(NS + "deleteMember", memId);
	}	
	
	public int addFriend(HashMap<String, Integer> map) throws SQLException {
		return sqlSession.insert(NS2 + "addFriend", map);
	}
		
	public int deleteFriend(HashMap<String, Integer> map) throws SQLException {
		return sqlSession.delete(NS2 + "deleteFriend", map);
	}
		
	public List<Member> getFriend(int memId) throws SQLException {
		return sqlSession.selectList(NS2 + "getFriend", memId);
	}
    
    // Goal 도메인
    public Goal getGoal(int memId) throws SQLException {
        return sqlSession.selectOne(NS + "getGoal", memId);
    }

    public int updateGoal(Member member) throws SQLException {
        return sqlSession.update(NS + "updateGoal", member);
    }
}
