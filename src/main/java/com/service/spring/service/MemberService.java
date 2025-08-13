package com.service.spring.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import com.service.spring.domain.Goal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.MemberDAO;
import com.service.spring.domain.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	public Member login(Member member) throws SQLException {
		return memberDAO.login(member);
	}

    // 이메일 중복여부 확인
    public Member checkEmail(String email) throws SQLException {
        Member member = new Member();
        member.setEmail(email);

        return memberDAO.checkEmail(member);
    }
	
	public List<Member> searchMember(String nickname) throws SQLException {
		return memberDAO.searchMember(nickname);
	}
	
	public int addMember(Member member) throws SQLException {
		return memberDAO.addMember(member);
	}
	
	public int changeMember(Member member) throws SQLException {
		return memberDAO.changeMember(member);
	}
	
	public int deleteMember(int memId) throws SQLException {
		return memberDAO.deleteMember(memId);
	}

	// Friend 도메인 관련
	public int addFriend(HashMap<String, Integer> map) throws SQLException {
		return memberDAO.addFriend(map);
	}
	
	public int deleteFriend(HashMap<String, Integer> map) throws SQLException {
		return memberDAO.deleteFriend(map);
	}
		
	public List<Member> getFriend(int memId) throws SQLException {
		return memberDAO.getFriend(memId);
	}

    // Goal 도메인
    public Goal getGoal(int memId) throws SQLException {
        return memberDAO.getGoal(memId);
    }

    public int updateGoal(int memId, Goal goal) throws SQLException {
        Member member = new Member();

        member.setMemId(memId);
        member.setGoal(goal);

        return memberDAO.updateGoal(member);
    }
}
