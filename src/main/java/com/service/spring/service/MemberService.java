package com.service.spring.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

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

    public Member checkEmail(String email) throws SQLException {
        Member member = new Member();
        member.setEmail(email);

        return memberDAO.checkEmail(member);
    }
	
	public List<Member> searchMember(String nickname) throws SQLException {
		return memberDAO.searchMember(nickname);
	}
	
	public Member searchMember(int memId) throws SQLException {
		return memberDAO.searchMember(memId);
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

}
