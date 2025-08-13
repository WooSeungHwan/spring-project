
package com.service.spring.dao;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.service.spring.dao.FriendDAO;
import com.service.spring.domain.Friend;
import com.service.spring.domain.Member;

@Repository
public class FriendDAO{	
	public static final String NS = "ns.sql.FriendMapper.";

	@Autowired
	private SqlSession sqlSession;
	
	public List<Member> getFriendList(int memId) throws SQLException{
		return sqlSession.selectList(NS + "getFriendList", memId);
	}
	
	public Friend getFriend(HashMap<String, Integer> map) throws SQLException {
		return sqlSession.selectOne(NS + "getFriend", map);
	}
	
	public int addFriend(Friend friend) throws SQLException {
		return sqlSession.insert(NS + "addFriend", friend);
	}
	
	public int updateFriendStatus(Friend friend) throws SQLException {
		return sqlSession.update(NS + "updateFriendStatus", friend);
	}
	
	public int deleteFriend(HashMap<String,Integer> map) throws SQLException {
		return sqlSession.delete(NS + "deleteFriend", map);
	}
}







