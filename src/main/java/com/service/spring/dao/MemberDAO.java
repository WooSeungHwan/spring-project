package com.service.spring.dao;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.dao.MemberDAO;
import com.service.spring.domain.Account;
import com.service.spring.domain.Member;

@Repository
public class MemberDAO {
	public static final String NS2 = "ns.sql.FriendMapper.";
	
	@Autowired	
	private SqlSession sqlSession;
	
	public int addFriend(HashMap<String, Integer> map) throws SQLException {
		return sqlSession.insert(NS2 + "addFriend", map);
	}
	
	public int deleteFriend(HashMap<String, Integer> map) throws SQLException {
		return sqlSession.delete(NS2 + "deleteFriend", map);
	}
	
	public List<Member> getFriend(int memId) throws SQLException {
		return sqlSession.selectList(NS2 + "getFriend", memId);
	}
}
