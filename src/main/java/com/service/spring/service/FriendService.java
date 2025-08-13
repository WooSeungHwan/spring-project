package com.service.spring.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.service.spring.dao.FriendDAO;
import com.service.spring.dao.HealthDAO;
import com.service.spring.domain.Friend;
import com.service.spring.domain.Health;
import com.service.spring.domain.Member;

@Service
public class FriendService {
	
	@Autowired
	private FriendDAO friendDAO;
	
	public List<Member> getFriendList(int memId)throws SQLException {
		return friendDAO.getFriendList(memId);
	}
	
	public List<Member> getPendingFriendList(int memId) throws SQLException{
		
		return friendDAO.getPendingFriendList(memId);
	}
	
	public Friend getFriend(HashMap<String, Integer> map)throws SQLException {
		return friendDAO.getFriend(map);
	}
	
	
	public int addFriend(Friend friend) throws SQLException {
		int mem1 = friend.getMem1Id();
	    int mem2 = friend.getMem2Id();

	    friend.setMemberIdMin(Math.min(mem1, mem2));
	    friend.setMemberIdMax(Math.max(mem1, mem2));
	    friend.setStatus("pending");

	    return friendDAO.addFriend(friend);
	}
	
	public int updateFriendStatus(Friend friend)throws SQLException {
		int mem1 = friend.getMem1Id();
	    int mem2 = friend.getMem2Id();
	    
		friend.setMemberIdMin(Math.min(mem1, mem2));
        friend.setMemberIdMax(Math.max(mem1, mem2));
        friend.setStatus("accepted");
		return friendDAO.updateFriendStatus(friend);
	}
	
	public int deleteFriend(Friend friend)throws SQLException {
		int mem1 = friend.getMem1Id();
	    int mem2 = friend.getMem2Id();
	    
		friend.setMemberIdMin(Math.min(mem1, mem2));
        friend.setMemberIdMax(Math.max(mem1, mem2));
		return friendDAO.deleteFriend(friend);
	}
}
